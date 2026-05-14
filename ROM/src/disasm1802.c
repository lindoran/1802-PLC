/*
 * disasm1802.c  --  RCA CDP1802 disassembler
 *
 * Handles ROM images that contain filler bytes (0xFF, 0x00) and embedded
 * ASCII text by emitting .DB / .ASCII directives instead of garbage mnemonics.
 *
 * Usage:
 *   disasm1802 [options] romfile.bin > output.asm
 *
 * Options:
 *   -b XXXX   begin address (hex, default 0000)
 *   -e XXXX   end   address (hex, default = file size - 1)
 *   -o XXXX   origin: ROM load address in target memory (hex, default 0000)
 *   -w N      run-length threshold for filler detection (decimal, default 4)
 *
 * Build:
 *   cc -Wall -o disasm1802 disasm1802.c
 *
 * Based on the 1998 Herman Robers disasm, rewritten for correctness and
 * binary ROM support with whitespace detection.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* ------------------------------------------------------------------ */
/* Addressing / operand types                                          */
/* ------------------------------------------------------------------ */
#define T_NONE     0   /* no operand                                   */
#define T_IMM1     1   /* 1 immediate byte  (e.g. LDI, ADI)           */
#define T_IMM2     2   /* 2 immediate bytes (e.g. LBR, RLDI)          */
#define T_SHORTBR  3   /* 1-byte short branch target (page-local)     */
#define T_SKIP1    4   /* SKP: 1-byte instruction, runtime skips +1   */
#define T_LSKIP    5   /* long-skip: 1-byte instruction, runtime +2   */
#define T_END      6   /* flow ends here (IDL, RET, DIS)              */

struct opcode {
    unsigned char code;
    char          mnem[12];
    int           argc;   /* extra bytes consumed by instruction       */
    int           argt;   /* argument type (T_*)                       */
    char          desc[56];
};

/* ------------------------------------------------------------------ */
/* Standard 1802 opcode table (256 entries)                           */
/* ------------------------------------------------------------------ */
static const struct opcode ops[256] = {
/* 00 */  {0x00,"IDL",    0,T_END,    "Idle / wait DMA or interrupt"},
/* 01-0F  LDN Rn */
          {0x01,"LDN R1", 0,T_NONE,  "Load D <- M(R1)"},
          {0x02,"LDN R2", 0,T_NONE,  "Load D <- M(R2)"},
          {0x03,"LDN R3", 0,T_NONE,  "Load D <- M(R3)"},
          {0x04,"LDN R4", 0,T_NONE,  "Load D <- M(R4)"},
          {0x05,"LDN R5", 0,T_NONE,  "Load D <- M(R5)"},
          {0x06,"LDN R6", 0,T_NONE,  "Load D <- M(R6)"},
          {0x07,"LDN R7", 0,T_NONE,  "Load D <- M(R7)"},
          {0x08,"LDN R8", 0,T_NONE,  "Load D <- M(R8)"},
          {0x09,"LDN R9", 0,T_NONE,  "Load D <- M(R9)"},
          {0x0A,"LDN RA", 0,T_NONE,  "Load D <- M(RA)"},
          {0x0B,"LDN RB", 0,T_NONE,  "Load D <- M(RB)"},
          {0x0C,"LDN RC", 0,T_NONE,  "Load D <- M(RC)"},
          {0x0D,"LDN RD", 0,T_NONE,  "Load D <- M(RD)"},
          {0x0E,"LDN RE", 0,T_NONE,  "Load D <- M(RE)"},
          {0x0F,"LDN RF", 0,T_NONE,  "Load D <- M(RF)"},
/* 10-1F  INC Rn */
          {0x10,"INC R0", 0,T_NONE,  "R0 <- R0+1"},
          {0x11,"INC R1", 0,T_NONE,  "R1 <- R1+1"},
          {0x12,"INC R2", 0,T_NONE,  "R2 <- R2+1"},
          {0x13,"INC R3", 0,T_NONE,  "R3 <- R3+1"},
          {0x14,"INC R4", 0,T_NONE,  "R4 <- R4+1"},
          {0x15,"INC R5", 0,T_NONE,  "R5 <- R5+1"},
          {0x16,"INC R6", 0,T_NONE,  "R6 <- R6+1"},
          {0x17,"INC R7", 0,T_NONE,  "R7 <- R7+1"},
          {0x18,"INC R8", 0,T_NONE,  "R8 <- R8+1"},
          {0x19,"INC R9", 0,T_NONE,  "R9 <- R9+1"},
          {0x1A,"INC RA", 0,T_NONE,  "RA <- RA+1"},
          {0x1B,"INC RB", 0,T_NONE,  "RB <- RB+1"},
          {0x1C,"INC RC", 0,T_NONE,  "RC <- RC+1"},
          {0x1D,"INC RD", 0,T_NONE,  "RD <- RD+1"},
          {0x1E,"INC RE", 0,T_NONE,  "RE <- RE+1"},
          {0x1F,"INC RF", 0,T_NONE,  "RF <- RF+1"},
/* 20-2F  DEC Rn */
          {0x20,"DEC R0", 0,T_NONE,  "R0 <- R0-1"},
          {0x21,"DEC R1", 0,T_NONE,  "R1 <- R1-1"},
          {0x22,"DEC R2", 0,T_NONE,  "R2 <- R2-1"},
          {0x23,"DEC R3", 0,T_NONE,  "R3 <- R3-1"},
          {0x24,"DEC R4", 0,T_NONE,  "R4 <- R4-1"},
          {0x25,"DEC R5", 0,T_NONE,  "R5 <- R5-1"},
          {0x26,"DEC R6", 0,T_NONE,  "R6 <- R6-1"},
          {0x27,"DEC R7", 0,T_NONE,  "R7 <- R7-1"},
          {0x28,"DEC R8", 0,T_NONE,  "R8 <- R8-1"},
          {0x29,"DEC R9", 0,T_NONE,  "R9 <- R9-1"},
          {0x2A,"DEC RA", 0,T_NONE,  "RA <- RA-1"},
          {0x2B,"DEC RB", 0,T_NONE,  "RB <- RB-1"},
          {0x2C,"DEC RC", 0,T_NONE,  "RC <- RC-1"},
          {0x2D,"DEC RD", 0,T_NONE,  "RD <- RD-1"},
          {0x2E,"DEC RE", 0,T_NONE,  "RE <- RE-1"},
          {0x2F,"DEC RF", 0,T_NONE,  "RF <- RF-1"},
/* 30-3F  Short branches */
          {0x30,"BR",     1,T_SHORTBR,"Branch unconditional"},
          {0x31,"BQ",     1,T_SHORTBR,"Branch if Q=1"},
          {0x32,"BZ",     1,T_SHORTBR,"Branch if D=0"},
          {0x33,"BDF",    1,T_SHORTBR,"Branch if DF=1"},
          {0x34,"B1",     1,T_SHORTBR,"Branch if EF1=1"},
          {0x35,"B2",     1,T_SHORTBR,"Branch if EF2=1"},
          {0x36,"B3",     1,T_SHORTBR,"Branch if EF3=1"},
          {0x37,"B4",     1,T_SHORTBR,"Branch if EF4=1"},
          {0x38,"SKP",    1,T_SKIP1,  "Skip next byte"},
          {0x39,"BNQ",    1,T_SHORTBR,"Branch if Q=0"},
          {0x3A,"BNZ",    1,T_SHORTBR,"Branch if D!=0"},
          {0x3B,"BNF",    1,T_SHORTBR,"Branch if DF=0"},
          {0x3C,"BN1",    1,T_SHORTBR,"Branch if EF1=0"},
          {0x3D,"BN2",    1,T_SHORTBR,"Branch if EF2=0"},
          {0x3E,"BN3",    1,T_SHORTBR,"Branch if EF3=0"},
          {0x3F,"BN4",    1,T_SHORTBR,"Branch if EF4=0"},
/* 40-4F  LDA Rn */
          {0x40,"LDA R0", 0,T_NONE,  "D <- M(R0); R0++"},
          {0x41,"LDA R1", 0,T_NONE,  "D <- M(R1); R1++"},
          {0x42,"LDA R2", 0,T_NONE,  "D <- M(R2); R2++"},
          {0x43,"LDA R3", 0,T_NONE,  "D <- M(R3); R3++"},
          {0x44,"LDA R4", 0,T_NONE,  "D <- M(R4); R4++"},
          {0x45,"LDA R5", 0,T_NONE,  "D <- M(R5); R5++"},
          {0x46,"LDA R6", 0,T_NONE,  "D <- M(R6); R6++"},
          {0x47,"LDA R7", 0,T_NONE,  "D <- M(R7); R7++"},
          {0x48,"LDA R8", 0,T_NONE,  "D <- M(R8); R8++"},
          {0x49,"LDA R9", 0,T_NONE,  "D <- M(R9); R9++"},
          {0x4A,"LDA RA", 0,T_NONE,  "D <- M(RA); RA++"},
          {0x4B,"LDA RB", 0,T_NONE,  "D <- M(RB); RB++"},
          {0x4C,"LDA RC", 0,T_NONE,  "D <- M(RC); RC++"},
          {0x4D,"LDA RD", 0,T_NONE,  "D <- M(RD); RD++"},
          {0x4E,"LDA RE", 0,T_NONE,  "D <- M(RE); RE++"},
          {0x4F,"LDA RF", 0,T_NONE,  "D <- M(RF); RF++"},
/* 50-5F  STR Rn */
          {0x50,"STR R0", 0,T_NONE,  "M(R0) <- D"},
          {0x51,"STR R1", 0,T_NONE,  "M(R1) <- D"},
          {0x52,"STR R2", 0,T_NONE,  "M(R2) <- D"},
          {0x53,"STR R3", 0,T_NONE,  "M(R3) <- D"},
          {0x54,"STR R4", 0,T_NONE,  "M(R4) <- D"},
          {0x55,"STR R5", 0,T_NONE,  "M(R5) <- D"},
          {0x56,"STR R6", 0,T_NONE,  "M(R6) <- D"},
          {0x57,"STR R7", 0,T_NONE,  "M(R7) <- D"},
          {0x58,"STR R8", 0,T_NONE,  "M(R8) <- D"},
          {0x59,"STR R9", 0,T_NONE,  "M(R9) <- D"},
          {0x5A,"STR RA", 0,T_NONE,  "M(RA) <- D"},
          {0x5B,"STR RB", 0,T_NONE,  "M(RB) <- D"},
          {0x5C,"STR RC", 0,T_NONE,  "M(RC) <- D"},
          {0x5D,"STR RD", 0,T_NONE,  "M(RD) <- D"},
          {0x5E,"STR RE", 0,T_NONE,  "M(RE) <- D"},
          {0x5F,"STR RF", 0,T_NONE,  "M(RF) <- D"},
/* 60-6F  I/O */
          {0x60,"IRX",    0,T_NONE,  "R(X) <- R(X)+1"},
          {0x61,"OUT 1",  0,T_NONE,  "Out bus=M(R(X)); R(X)++; N=1"},
          {0x62,"OUT 2",  0,T_NONE,  "Out bus=M(R(X)); R(X)++; N=2"},
          {0x63,"OUT 3",  0,T_NONE,  "Out bus=M(R(X)); R(X)++; N=3"},
          {0x64,"OUT 4",  0,T_NONE,  "Out bus=M(R(X)); R(X)++; N=4"},
          {0x65,"OUT 5",  0,T_NONE,  "Out bus=M(R(X)); R(X)++; N=5"},
          {0x66,"OUT 6",  0,T_NONE,  "Out bus=M(R(X)); R(X)++; N=6"},
          {0x67,"OUT 7",  0,T_NONE,  "Out bus=M(R(X)); R(X)++; N=7"},
          {0x68,"DB",     0,T_NONE,  "Undefined (0x68)"},   /* not a real instr */
          {0x69,"INP 1",  0,T_NONE,  "D=M(R(X))=bus; N=1"},
          {0x6A,"INP 2",  0,T_NONE,  "D=M(R(X))=bus; N=2"},
          {0x6B,"INP 3",  0,T_NONE,  "D=M(R(X))=bus; N=3"},
          {0x6C,"INP 4",  0,T_NONE,  "D=M(R(X))=bus; N=4"},
          {0x6D,"INP 5",  0,T_NONE,  "D=M(R(X))=bus; N=5"},
          {0x6E,"INP 6",  0,T_NONE,  "D=M(R(X))=bus; N=6"},
          {0x6F,"INP 7",  0,T_NONE,  "D=M(R(X))=bus; N=7"},
/* 70-7F  Control / ALU */
          {0x70,"RET",    0,T_END,   "Return from interrupt; IE=1"},
          {0x71,"DIS",    0,T_END,   "Disable interrupts; IE=0"},
          {0x72,"LDXA",   0,T_NONE,  "D <- M(R(X)); R(X)++"},
          {0x73,"STXD",   0,T_NONE,  "M(R(X)) <- D; R(X)--"},
          {0x74,"ADC",    0,T_NONE,  "D,DF <- D+M(R(X))+DF"},
          {0x75,"SDB",    0,T_NONE,  "D,DF <- M(R(X))-D-DF'"},
          {0x76,"SHRC",   0,T_NONE,  "DF,D <- D>>1 (DF in MSB)"},
          {0x77,"SMB",    0,T_NONE,  "D,DF <- D-M(R(X))-DF'"},
          {0x78,"SAV",    0,T_NONE,  "M(R(X)) <- T"},
          {0x79,"MARK",   0,T_NONE,  "T <- X,P; M(R2) <- T; R2--"},
          {0x7A,"REQ",    0,T_NONE,  "Q <- 0"},
          {0x7B,"SEQ",    0,T_NONE,  "Q <- 1"},
          {0x7C,"ADCI",   1,T_IMM1,  "D,DF <- D+imm+DF"},
          {0x7D,"SDBI",   1,T_IMM1,  "D,DF <- imm-D-DF'"},
          {0x7E,"SHLC",   0,T_NONE,  "DF,D <- D<<1 (DF in LSB)"},
          {0x7F,"SMBI",   1,T_IMM1,  "D,DF <- D-imm-DF'"},
/* 80-8F  GLO Rn */
          {0x80,"GLO R0", 0,T_NONE,  "D <- R0.lo"},
          {0x81,"GLO R1", 0,T_NONE,  "D <- R1.lo"},
          {0x82,"GLO R2", 0,T_NONE,  "D <- R2.lo"},
          {0x83,"GLO R3", 0,T_NONE,  "D <- R3.lo"},
          {0x84,"GLO R4", 0,T_NONE,  "D <- R4.lo"},
          {0x85,"GLO R5", 0,T_NONE,  "D <- R5.lo"},
          {0x86,"GLO R6", 0,T_NONE,  "D <- R6.lo"},
          {0x87,"GLO R7", 0,T_NONE,  "D <- R7.lo"},
          {0x88,"GLO R8", 0,T_NONE,  "D <- R8.lo"},
          {0x89,"GLO R9", 0,T_NONE,  "D <- R9.lo"},
          {0x8A,"GLO RA", 0,T_NONE,  "D <- RA.lo"},
          {0x8B,"GLO RB", 0,T_NONE,  "D <- RB.lo"},
          {0x8C,"GLO RC", 0,T_NONE,  "D <- RC.lo"},
          {0x8D,"GLO RD", 0,T_NONE,  "D <- RD.lo"},
          {0x8E,"GLO RE", 0,T_NONE,  "D <- RE.lo"},
          {0x8F,"GLO RF", 0,T_NONE,  "D <- RF.lo"},
/* 90-9F  GHI Rn */
          {0x90,"GHI R0", 0,T_NONE,  "D <- R0.hi"},
          {0x91,"GHI R1", 0,T_NONE,  "D <- R1.hi"},
          {0x92,"GHI R2", 0,T_NONE,  "D <- R2.hi"},
          {0x93,"GHI R3", 0,T_NONE,  "D <- R3.hi"},
          {0x94,"GHI R4", 0,T_NONE,  "D <- R4.hi"},
          {0x95,"GHI R5", 0,T_NONE,  "D <- R5.hi"},
          {0x96,"GHI R6", 0,T_NONE,  "D <- R6.hi"},
          {0x97,"GHI R7", 0,T_NONE,  "D <- R7.hi"},
          {0x98,"GHI R8", 0,T_NONE,  "D <- R8.hi"},
          {0x99,"GHI R9", 0,T_NONE,  "D <- R9.hi"},
          {0x9A,"GHI RA", 0,T_NONE,  "D <- RA.hi"},
          {0x9B,"GHI RB", 0,T_NONE,  "D <- RB.hi"},
          {0x9C,"GHI RC", 0,T_NONE,  "D <- RC.hi"},
          {0x9D,"GHI RD", 0,T_NONE,  "D <- RD.hi"},
          {0x9E,"GHI RE", 0,T_NONE,  "D <- RE.hi"},
          {0x9F,"GHI RF", 0,T_NONE,  "D <- RF.hi"},
/* A0-AF  PLO Rn */
          {0xA0,"PLO R0", 0,T_NONE,  "R0.lo <- D"},
          {0xA1,"PLO R1", 0,T_NONE,  "R1.lo <- D"},
          {0xA2,"PLO R2", 0,T_NONE,  "R2.lo <- D"},
          {0xA3,"PLO R3", 0,T_NONE,  "R3.lo <- D"},
          {0xA4,"PLO R4", 0,T_NONE,  "R4.lo <- D"},
          {0xA5,"PLO R5", 0,T_NONE,  "R5.lo <- D"},
          {0xA6,"PLO R6", 0,T_NONE,  "R6.lo <- D"},
          {0xA7,"PLO R7", 0,T_NONE,  "R7.lo <- D"},
          {0xA8,"PLO R8", 0,T_NONE,  "R8.lo <- D"},
          {0xA9,"PLO R9", 0,T_NONE,  "R9.lo <- D"},
          {0xAA,"PLO RA", 0,T_NONE,  "RA.lo <- D"},
          {0xAB,"PLO RB", 0,T_NONE,  "RB.lo <- D"},
          {0xAC,"PLO RC", 0,T_NONE,  "RC.lo <- D"},
          {0xAD,"PLO RD", 0,T_NONE,  "RD.lo <- D"},
          {0xAE,"PLO RE", 0,T_NONE,  "RE.lo <- D"},
          {0xAF,"PLO RF", 0,T_NONE,  "RF.lo <- D"},
/* B0-BF  PHI Rn */
          {0xB0,"PHI R0", 0,T_NONE,  "R0.hi <- D"},
          {0xB1,"PHI R1", 0,T_NONE,  "R1.hi <- D"},
          {0xB2,"PHI R2", 0,T_NONE,  "R2.hi <- D"},
          {0xB3,"PHI R3", 0,T_NONE,  "R3.hi <- D"},
          {0xB4,"PHI R4", 0,T_NONE,  "R4.hi <- D"},
          {0xB5,"PHI R5", 0,T_NONE,  "R5.hi <- D"},
          {0xB6,"PHI R6", 0,T_NONE,  "R6.hi <- D"},
          {0xB7,"PHI R7", 0,T_NONE,  "R7.hi <- D"},
          {0xB8,"PHI R8", 0,T_NONE,  "R8.hi <- D"},
          {0xB9,"PHI R9", 0,T_NONE,  "R9.hi <- D"},
          {0xBA,"PHI RA", 0,T_NONE,  "RA.hi <- D"},
          {0xBB,"PHI RB", 0,T_NONE,  "RB.hi <- D"},
          {0xBC,"PHI RC", 0,T_NONE,  "RC.hi <- D"},
          {0xBD,"PHI RD", 0,T_NONE,  "RD.hi <- D"},
          {0xBE,"PHI RE", 0,T_NONE,  "RE.hi <- D"},
          {0xBF,"PHI RF", 0,T_NONE,  "RF.hi <- D"},
/* C0-CF  Long branches / skips */
          {0xC0,"LBR",    2,T_IMM2,  "Long branch unconditional"},
          {0xC1,"LBQ",    2,T_IMM2,  "Long branch if Q=1"},
          {0xC2,"LBZ",    2,T_IMM2,  "Long branch if D=0"},
          {0xC3,"LBDF",   2,T_IMM2,  "Long branch if DF=1"},
          {0xC4,"NOP",    0,T_NONE,  "No operation (C4 NOP)"},
          {0xC5,"LSNQ",   0,T_LSKIP, "Long skip if Q=0"},
          {0xC6,"LSNZ",   0,T_LSKIP, "Long skip if D!=0"},
          {0xC7,"LSNF",   0,T_LSKIP, "Long skip if DF=0"},
          {0xC8,"LSKP",   0,T_LSKIP, "Long skip unconditional"},
          {0xC9,"LBNQ",   2,T_IMM2,  "Long branch if Q=0"},
          {0xCA,"LBNZ",   2,T_IMM2,  "Long branch if D!=0"},
          {0xCB,"LBNF",   2,T_IMM2,  "Long branch if DF=0"},
          {0xCC,"LSIE",   0,T_LSKIP, "Long skip if IE=1"},
          {0xCD,"LSQ",    0,T_LSKIP, "Long skip if Q=1"},
          {0xCE,"LSZ",    0,T_LSKIP, "Long skip if D=0"},
          {0xCF,"LSDF",   0,T_LSKIP, "Long skip if DF=1"},
/* D0-DF  SEP Rn */
          {0xD0,"SEP R0", 0,T_END,   "P <- 0  (set PC to R0)"},
          {0xD1,"SEP R1", 0,T_NONE,  "P <- 1  (set PC to R1)"},
          {0xD2,"SEP R2", 0,T_NONE,  "P <- 2"},
          {0xD3,"SEP R3", 0,T_NONE,  "P <- 3"},
          {0xD4,"SEP R4", 0,T_NONE,  "P <- 4"},
          {0xD5,"SEP R5", 0,T_NONE,  "P <- 5"},
          {0xD6,"SEP R6", 0,T_NONE,  "P <- 6"},
          {0xD7,"SEP R7", 0,T_NONE,  "P <- 7"},
          {0xD8,"SEP R8", 0,T_NONE,  "P <- 8"},
          {0xD9,"SEP R9", 0,T_NONE,  "P <- 9"},
          {0xDA,"SEP RA", 0,T_NONE,  "P <- A"},
          {0xDB,"SEP RB", 0,T_NONE,  "P <- B"},
          {0xDC,"SEP RC", 0,T_NONE,  "P <- C"},
          {0xDD,"SEP RD", 0,T_NONE,  "P <- D"},
          {0xDE,"SEP RE", 0,T_NONE,  "P <- E"},
          {0xDF,"SEP RF", 0,T_NONE,  "P <- F"},
/* E0-EF  SEX Rn */
          {0xE0,"SEX R0", 0,T_NONE,  "X <- 0"},
          {0xE1,"SEX R1", 0,T_NONE,  "X <- 1"},
          {0xE2,"SEX R2", 0,T_NONE,  "X <- 2"},
          {0xE3,"SEX R3", 0,T_NONE,  "X <- 3"},
          {0xE4,"SEX R4", 0,T_NONE,  "X <- 4"},
          {0xE5,"SEX R5", 0,T_NONE,  "X <- 5"},
          {0xE6,"SEX R6", 0,T_NONE,  "X <- 6"},
          {0xE7,"SEX R7", 0,T_NONE,  "X <- 7"},
          {0xE8,"SEX R8", 0,T_NONE,  "X <- 8"},
          {0xE9,"SEX R9", 0,T_NONE,  "X <- 9"},
          {0xEA,"SEX RA", 0,T_NONE,  "X <- A"},
          {0xEB,"SEX RB", 0,T_NONE,  "X <- B"},
          {0xEC,"SEX RC", 0,T_NONE,  "X <- C"},
          {0xED,"SEX RD", 0,T_NONE,  "X <- D"},
          {0xEE,"SEX RE", 0,T_NONE,  "X <- E"},
          {0xEF,"SEX RF", 0,T_NONE,  "X <- F"},
/* F0-FF  ALU / Load-immediate */
          {0xF0,"LDX",    0,T_NONE,  "D <- M(R(X))"},
          {0xF1,"OR",     0,T_NONE,  "D <- D | M(R(X))"},
          {0xF2,"AND",    0,T_NONE,  "D <- D & M(R(X))"},
          {0xF3,"XOR",    0,T_NONE,  "D <- D ^ M(R(X))"},
          {0xF4,"ADD",    0,T_NONE,  "D,DF <- D + M(R(X))"},
          {0xF5,"SD",     0,T_NONE,  "D,DF <- M(R(X)) - D"},
          {0xF6,"SHR",    0,T_NONE,  "DF,D <- D>>1"},
          {0xF7,"SM",     0,T_NONE,  "D,DF <- D - M(R(X))"},
          {0xF8,"LDI",    1,T_IMM1,  "D <- immediate"},
          {0xF9,"ORI",    1,T_IMM1,  "D <- D | immediate"},
          {0xFA,"ANI",    1,T_IMM1,  "D <- D & immediate"},
          {0xFB,"XRI",    1,T_IMM1,  "D <- D ^ immediate"},
          {0xFC,"ADI",    1,T_IMM1,  "D,DF <- D + immediate"},
          {0xFD,"SDI",    1,T_IMM1,  "D,DF <- immediate - D"},
          {0xFE,"SHL",    0,T_NONE,  "DF,D <- D<<1"},
          {0xFF,"SMI",    1,T_IMM1,  "D,DF <- D - immediate"},
};

/* ------------------------------------------------------------------ */
/* Filler / data-region detection                                     */
/* ------------------------------------------------------------------ */

/* Count how many bytes starting at pos match byte b (up to limit).   */
static unsigned run_len(const unsigned char *buf, unsigned pos,
                        unsigned limit, unsigned char b)
{
    unsigned n = 0;
    while (pos + n < limit && buf[pos + n] == b)
        n++;
    return n;
}

/* Count printable ASCII bytes starting at pos.                       */
static unsigned ascii_run(const unsigned char *buf, unsigned pos,
                           unsigned limit)
{
    unsigned n = 0;
    while (pos + n < limit && buf[pos + n] >= 0x20 && buf[pos + n] <= 0x7E)
        n++;
    return n;
}

/* ------------------------------------------------------------------ */
/* Hex string parser for -b / -e / -o arguments                       */
/* ------------------------------------------------------------------ */
static unsigned parse_hex(const char *s)
{
    unsigned v = 0;
    for (; *s; s++) {
        int c = (unsigned char)*s;
        if      (c >= '0' && c <= '9') v = v * 16 + (c - '0');
        else if (c >= 'a' && c <= 'f') v = v * 16 + (c - 'a' + 10);
        else if (c >= 'A' && c <= 'F') v = v * 16 + (c - 'A' + 10);
        else break;
    }
    return v;
}

/* ------------------------------------------------------------------ */
/* Emit a .ASCII / .DB block for a printable-text region              */
/* ------------------------------------------------------------------ */
static void emit_ascii_region(unsigned org, const unsigned char *buf,
                               unsigned pos, unsigned len)
{
    /* Print in lines of up to 16 chars */
    unsigned done = 0;
    while (done < len) {
        unsigned chunk = len - done;
        unsigned i;
        if (chunk > 16) chunk = 16;
        printf("%04X              .ASCII \"", org + pos + done);
        for (i = 0; i < chunk; i++) {
            unsigned char c = buf[pos + done + i];
            if (c == '"' || c == '\\') putchar('\\');
            putchar(c);
        }
        printf("\"\n");
        done += chunk;
    }
}

/* ------------------------------------------------------------------ */
/* Emit a filler run as a compact comment block                        */
/* ------------------------------------------------------------------ */
static void emit_filler(unsigned org, unsigned pos, unsigned len,
                        unsigned char fill)
{
    printf("%04X              .DS  %u, 0%02XH",
           org + pos, len, fill);
    if (fill == 0xFF) printf("   ; [unprogrammed EPROM]");
    else if (fill == 0x00) printf("   ; [cleared region]");
    printf("\n");
}

/* ------------------------------------------------------------------ */
/* Main disassembly loop                                               */
/* ------------------------------------------------------------------ */
int main(int argc, char *argv[])
{
    unsigned char  rom[65536];
    unsigned       romsize = 0;
    unsigned       begin   = 0;
    unsigned       end     = 0;     /* 0 = use romsize */
    unsigned       org     = 0;     /* load address */
    unsigned       wthresh = 4;     /* filler run threshold */
    const char    *infile  = NULL;
    FILE          *f;
    unsigned       pos;
    int            i;

    /* --- parse arguments --- */
    for (i = 1; i < argc; i++) {
        if (argv[i][0] == '-') {
            switch (argv[i][1]) {
            case 'b': begin   = parse_hex(argv[i] + 2); break;
            case 'e': end     = parse_hex(argv[i] + 2); break;
            case 'o': org     = parse_hex(argv[i] + 2); break;
            case 'w': wthresh = (unsigned)atoi(argv[i] + 2); break;
            default:
                fprintf(stderr, "Unknown option: %s\n", argv[i]);
                break;
            }
        } else {
            infile = argv[i];
        }
    }

    if (!infile) {
        fprintf(stderr,
            "disasm1802 -- RCA CDP1802 binary ROM disassembler\n"
            "Usage: disasm1802 [options] romfile.bin > output.asm\n"
            "  -bXXXX  begin offset in file (hex, default 0000)\n"
            "  -eXXXX  end   offset in file (hex, default = file size)\n"
            "  -oXXXX  origin (load address in target, hex, default 0000)\n"
            "  -wN     filler-run threshold (decimal bytes, default 4)\n");
        return 1;
    }

    /* --- read binary file --- */
    f = fopen(infile, "rb");
    if (!f) { perror(infile); return 1; }
    romsize = (unsigned)fread(rom, 1, sizeof(rom), f);
    fclose(f);

    if (end == 0 || end > romsize)
        end = romsize;
    if (begin >= end) {
        fprintf(stderr, "Error: begin (%04X) >= end (%04X)\n", begin, end);
        return 1;
    }

    /* --- header --- */
    printf("; disasm1802 -- CDP1802 ROM disassembly\n");
    printf("; File   : %s  (%u bytes)\n", infile, romsize);
    printf("; Range  : %04XH - %04XH (file offsets)\n", begin, end - 1);
    printf("; Origin : %04XH\n", org);
    printf("; Filler threshold: %u bytes\n", wthresh);
    printf(";\n");
    printf("        .ORG   0%04XH\n\n", org + begin);

    /* --- main pass --- */
    pos = begin;
    while (pos < end) {
        unsigned char b = rom[pos];
        unsigned      rlen;
        unsigned      alen;

        /* ---- filler detection: run of identical bytes >= wthresh ---- */
        rlen = run_len(rom, pos, end, b);
        if (rlen >= wthresh) {
            /* Could be unprogrammed (0xFF), zeroed (0x00), or data  */
            printf("\n; --- filler region: %u x 0x%02X ---\n", rlen, b);
            emit_filler(org, pos, rlen, b);
            printf("\n");
            pos += rlen;
            continue;
        }

        /* ---- printable ASCII run detection >= wthresh --------------- */
        alen = ascii_run(rom, pos, end);
        if (alen >= wthresh) {
            printf("\n; --- ASCII data region (%u bytes) ---\n", alen);
            emit_ascii_region(org, rom, pos, alen);
            printf("\n");
            pos += alen;
            continue;
        }

        /* ---- normal instruction ------------------------------------ */
        {
            const struct opcode *op = &ops[b];
            char  hexbuf[24]  = "";
            char  opbuf[32]   = "";
            unsigned arg = 0;
            int   j;

            /* build hex bytes string */
            for (j = 0; j <= op->argc; j++) {
                char tmp[8];
                sprintf(tmp, "%02X ", (pos + j < end) ? rom[pos + j] : 0xFF);
                strcat(hexbuf, tmp);
            }

            /* mnemonic + operand */
            strcpy(opbuf, op->mnem);

            if (op->argc >= 1) arg = rom[pos + 1];
            if (op->argc >= 2) arg = (arg << 8) | rom[pos + 2];

            switch (op->argt) {
            case T_SHORTBR:
                /* branch target is in same 256-byte page               */
                sprintf(opbuf + strlen(opbuf), "  0%04XH",
                        ((org + pos) & 0xFF00u) | arg);
                break;
            case T_IMM1:
                sprintf(opbuf + strlen(opbuf), "  0%02XH", arg);
                break;
            case T_IMM2:
                /* long branch / RLDI: 16-bit absolute address          */
                sprintf(opbuf + strlen(opbuf), "  0%04XH", arg);
                break;
            case T_SKIP1:
                sprintf(opbuf + strlen(opbuf), "  ; (skips 1 byte)");
                break;
            case T_LSKIP:
                sprintf(opbuf + strlen(opbuf), "  ; (skips 2 bytes)");
                break;
            default:
                break;
            }

            printf("%04X  %-10s  %-22s ; %s\n",
                   org + pos, hexbuf, opbuf, op->desc);

            /* guard against running off the end of ROM */
            if (pos + op->argc + 1 > end) {
                fprintf(stderr,
                    "; Warning: instruction at %04X extends past end\n",
                    org + pos);
                break;
            }
            pos += op->argc + 1;
        }
    }

    printf("\n; --- end of disassembly ---\n");
    return 0;
}
