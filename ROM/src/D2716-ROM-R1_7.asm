; disasm1802 -- CDP1802 ROM disassembly
; File   : /mnt/user-data/uploads/D2716-ROM-lable-First-Fixture-R1_7.BIN  (2048 bytes)
; Range  : 0000H - 07FFH (file offsets)
; Origin : 0000H
; Filler threshold: 4 bytes
;
        .ORG   00000H

0000  E0          SEX R0                 ; X <- 0
0001  71          DIS                    ; Disable interrupts; IE=0
0002  90          GHI R0                 ; D <- R0.hi
0003  F0          LDX                    ; D <- M(R(X))
0004  10          INC R0                 ; R0 <- R0+1
0005  B1          PHI R1                 ; R1.hi <- D
0006  F0          LDX                    ; D <- M(R(X))
0007  31 A2       BQ  000A2H             ; Branch if Q=1
0009  F0          LDX                    ; D <- M(R(X))
000A  01          LDN R1                 ; Load D <- M(R1)
000B  B0          PHI R0                 ; R0.hi <- D
000C  F8 01       LDI  001H              ; D <- immediate
000E  B1          PHI R1                 ; R1.hi <- D
000F  F0          LDX                    ; D <- M(R(X))
0010  87          GLO R7                 ; D <- R7.lo
0011  A3          PLO R3                 ; R3.lo <- D
0012  F8 01       LDI  001H              ; D <- immediate
0014  B2          PHI R2                 ; R2.hi <- D
0015  F8 47       LDI  047H              ; D <- immediate
0017  A2          PLO R2                 ; R2.lo <- D
0018  F8 01       LDI  001H              ; D <- immediate
001A  BB          PHI RB                 ; RB.hi <- D
001B  F8 5D       LDI  05DH              ; D <- immediate
001D  AB          PLO RB                 ; RB.lo <- D
001E  F0          LDX                    ; D <- M(R(X))
001F  01          LDN R1                 ; Load D <- M(R1)
0020  B7          PHI R7                 ; R7.hi <- D
0021  D0          SEP R0                 ; P <- 0  (set PC to R0)
0022  C7          LSNF  ; (skips 2 bytes) ; Long skip if DF=0
0023  A5          PLO R5                 ; R5.lo <- D
0024  05          LDN R5                 ; Load D <- M(R5)
0025  01          LDN R1                 ; Load D <- M(R1)
0026  34 24       B1  00024H             ; Branch if EF1=1
0028  C0 00 C1    LBR  000C1H            ; Long branch unconditional
002B  F0          LDX                    ; D <- M(R(X))
002C  F7          SM                     ; D,DF <- D - M(R(X))
002D  A0          PLO R0                 ; R0.lo <- D
002E  20          DEC R0                 ; R0 <- R0-1
002F  80          GLO R0                 ; D <- R0.lo

; --- ASCII data region (6 bytes) ---
0030              .ASCII "2&=$54"

0036  E6          SEX R6                 ; X <- 6
0037  63          OUT 3                  ; Out bus=M(R(X)); R(X)++; N=3
0038  64          OUT 4                  ; Out bus=M(R(X)); R(X)++; N=4
0039  65          OUT 5                  ; Out bus=M(R(X)); R(X)++; N=5
003A  F8 20       LDI  020H              ; D <- immediate
003C  51          STR R1                 ; M(R1) <- D
003D  D2          SEP R2                 ; P <- 2
003E  65          OUT 5                  ; Out bus=M(R(X)); R(X)++; N=5
003F  73          STXD                   ; M(R(X)) <- D; R(X)--
0040  F0          LDX                    ; D <- M(R(X))
0041  91          GHI R1                 ; D <- R1.hi
0042  B1          PHI R1                 ; R1.hi <- D
0043  C0 01 80    LBR  00180H            ; Long branch unconditional
0046  10          INC R0                 ; R0 <- R0+1
0047  32 46       BZ  00046H             ; Branch if D=0
0049  21          DEC R1                 ; R1 <- R1-1
004A  91          GHI R1                 ; D <- R1.hi
004B  38 43       SKP  ; (skips 1 byte)  ; Skip next byte
004D  D3          SEP R3                 ; P <- 3
004E  F0          LDX                    ; D <- M(R(X))
004F  60          IRX                    ; R(X) <- R(X)+1
0050  51          STR R1                 ; M(R1) <- D
0051  65          OUT 5                  ; Out bus=M(R(X)); R(X)++; N=5
0052  F8 1C       LDI  01CH              ; D <- immediate
0054  B4          PHI R4                 ; R4.hi <- D
0055  F8 2C       LDI  02CH              ; D <- immediate
0057  B5          PHI R5                 ; R5.hi <- D
0058  F0          LDX                    ; D <- M(R(X))
0059  3C B6       BN1  000B6H            ; Branch if EF1=0
005B  90          GHI R0                 ; D <- R0.hi
005C  A4          PLO R4                 ; R4.lo <- D
005D  A5          PLO R5                 ; R5.lo <- D
005E  A6          PLO R6                 ; R6.lo <- D
005F  F0          LDX                    ; D <- M(R(X))
0060  0A          LDN RA                 ; Load D <- M(RA)
0061  A0          PLO R0                 ; R0.lo <- D
0062  DA          SEP RA                 ; P <- A
0063  D8          SEP R8                 ; P <- 8
0064  D0          SEP R0                 ; P <- 0  (set PC to R0)
0065  20          DEC R0                 ; R0 <- R0-1
0066  80          GLO R0                 ; D <- R0.lo
0067  3A 62       BNZ  00062H            ; Branch if D!=0
0069  F0          LDX                    ; D <- M(R(X))
006A  40          LDA R0                 ; D <- M(R0); R0++
006B  51          STR R1                 ; M(R1) <- D
006C  F8 0C       LDI  00CH              ; D <- immediate
006E  A8          PLO R8                 ; R8.lo <- D
006F  C4          NOP                    ; No operation (C4 NOP)
0070  D3          SEP R3                 ; P <- 3
0071  20          DEC R0                 ; R0 <- R0-1
0072  80          GLO R0                 ; D <- R0.lo
0073  30 47       BR  00047H             ; Branch unconditional
0075  86          GLO R6                 ; D <- R6.lo
0076  45          LDA R5                 ; D <- M(R5); R5++
0077  D0          SEP R0                 ; P <- 0  (set PC to R0)
0078  40          LDA R0                 ; D <- M(R0); R0++
0079  51          STR R1                 ; M(R1) <- D
007A  D0          SEP R0                 ; P <- 0  (set PC to R0)
007B  12          INC R2                 ; R2 <- R2+1
007C  80          GLO R0                 ; D <- R0.lo
007D  D2          SEP R2                 ; P <- 2
007E  D2          SEP R2                 ; P <- 2
007F  D2          SEP R2                 ; P <- 2
0080  28          DEC R8                 ; R8 <- R8-1
0081  88          GLO R8                 ; D <- R8.lo
0082  3A 75       BNZ  00075H            ; Branch if D!=0
0084  F0          LDX                    ; D <- M(R(X))
0085  04          LDN R4                 ; Load D <- M(R4)
0086  A0          PLO R0                 ; R0.lo <- D
0087  F8 40       LDI  040H              ; D <- immediate
0089  51          STR R1                 ; M(R1) <- D
008A  D2          SEP R2                 ; P <- 2
008B  D3          SEP R3                 ; P <- 3
008C  28          DEC R8                 ; R8 <- R8-1
008D  88          GLO R8                 ; D <- R8.lo
008E  3A 8A       BNZ  0008AH            ; Branch if D!=0
0090  D0          SEP R0                 ; P <- 0  (set PC to R0)
0091  14          INC R4                 ; R4 <- R4+1
0092  A0          PLO R0                 ; R0.lo <- D
0093  F0          LDX                    ; D <- M(R(X))
0094  40          LDA R0                 ; D <- M(R0); R0++
0095  01          LDN R1                 ; Load D <- M(R1)
0096  D2          SEP R2                 ; P <- 2
0097  D2          SEP R2                 ; P <- 2
0098  DA          SEP RA                 ; P <- A
0099  84          GLO R4                 ; D <- R4.lo
009A  D3          SEP R3                 ; P <- 3
009B  04          LDN R4                 ; Load D <- M(R4)
009C  32 94       BZ  00094H             ; Branch if D=0
009E  94          GHI R4                 ; D <- R4.hi
009F  D3          SEP R3                 ; P <- 3
00A0  00          IDL                    ; Idle / wait DMA or interrupt
00A1  02          LDN R2                 ; Load D <- M(R2)
00A2  A1          PLO R1                 ; R1.lo <- D
00A3  20          DEC R0                 ; R0 <- R0-1
00A4  80          GLO R0                 ; D <- R0.lo
00A5  10          INC R0                 ; R0 <- R0+1
00A6  96          GHI R6                 ; D <- R6.hi
00A7  10          INC R0                 ; R0 <- R0+1
00A8  84          GLO R4                 ; D <- R4.lo
00A9  D0          SEP R0                 ; P <- 0  (set PC to R0)
00AA  10          INC R0                 ; R0 <- R0+1
00AB  A4          PLO R4                 ; R4.lo <- D
00AC  F0          LDX                    ; D <- M(R(X))
00AD  20          DEC R0                 ; R0 <- R0-1
00AE  95          GHI R5                 ; D <- R5.hi
00AF  D0          SEP R0                 ; P <- 0  (set PC to R0)
00B0  30 B6       BR  000B6H             ; Branch unconditional
00B2  30 A3       BR  000A3H             ; Branch unconditional
00B4  84          GLO R4                 ; D <- R4.lo
00B5  F9 02       ORI  002H              ; D <- D | immediate
00B7  32 A3       BZ  000A3H             ; Branch if D=0
00B9  F8 1C       LDI  01CH              ; D <- immediate
00BB  B4          PHI R4                 ; R4.hi <- D
00BC  F8 2C       LDI  02CH              ; D <- immediate
00BE  B5          PHI R5                 ; R5.hi <- D
00BF  F8 1C       LDI  01CH              ; D <- immediate
00C1  86          GLO R6                 ; D <- R6.lo
00C2  F0          LDX                    ; D <- M(R(X))
00C3  00          IDL                    ; Idle / wait DMA or interrupt
00C4  84          GLO R4                 ; D <- R4.lo
00C5  85          GLO R5                 ; D <- R5.lo
00C6  86          GLO R6                 ; D <- R6.lo
00C7  10          INC R0                 ; R0 <- R0+1
00C8  83          GLO R3                 ; D <- R3.lo
00C9  D0          SEP R0                 ; P <- 0  (set PC to R0)
00CA  E7          SEX R7                 ; X <- 7
00CB  88          GLO R8                 ; D <- R8.lo
00CC  00          IDL                    ; Idle / wait DMA or interrupt
00CD  88          GLO R8                 ; D <- R8.lo
00CE  02          LDN R2                 ; Load D <- M(R2)
00CF  C4          NOP                    ; No operation (C4 NOP)
00D0  34 D5       B1  000D5H             ; Branch if EF1=1
00D2  C0 00 24    LBR  00024H            ; Long branch unconditional
00D5  34 D5       B1  000D5H             ; Branch if EF1=1
00D7  F0          LDX                    ; D <- M(R(X))
00D8  40          LDA R0                 ; D <- M(R0); R0++
00D9  51          STR R1                 ; M(R1) <- D
00DA  7B          SEQ                    ; Q <- 1
00DB  F8 20       LDI  020H              ; D <- immediate
00DD  B7          PHI R7                 ; R7.hi <- D
00DE  A7          PLO R7                 ; R7.lo <- D
00DF  E7          SEX R7                 ; X <- 7
00E0  61          OUT 1                  ; Out bus=M(R(X)); R(X)++; N=1
00E1  62          OUT 2                  ; Out bus=M(R(X)); R(X)++; N=2
00E2  F8 32       LDI  032H              ; D <- immediate
00E4  A8          PLO R8                 ; R8.lo <- D
00E5  B1          PHI R1                 ; R1.hi <- D
00E6  F8 60       LDI  060H              ; D <- immediate
00E8  51          STR R1                 ; M(R1) <- D
00E9  F0          LDX                    ; D <- M(R(X))
00EA  32 A4       BZ  000A4H             ; Branch if D=0
00EC  A5          PLO R5                 ; R5.lo <- D
00ED  A6          PLO R6                 ; R6.lo <- D
00EE  F8 13       LDI  013H              ; D <- immediate
00F0  94          GHI R4                 ; D <- R4.hi
00F1  80          GLO R0                 ; D <- R0.lo
00F2  23          DEC R3                 ; R3 <- R3-1
00F3  95          GHI R5                 ; D <- R5.hi
00F4  D0          SEP R0                 ; P <- 0  (set PC to R0)
00F5  01          LDN R1                 ; Load D <- M(R1)
00F6  96          GHI R6                 ; D <- R6.hi
00F7  D2          SEP R2                 ; P <- 2
00F8  D2          SEP R2                 ; P <- 2
00F9  C0 00 80    LBR  00080H            ; Long branch unconditional
00FC  C2 00 C1    LBZ  000C1H            ; Long branch if D=0
00FF  D0          SEP R0                 ; P <- 0  (set PC to R0)
0100  C8          LSKP  ; (skips 2 bytes) ; Long skip unconditional
0101  A8          PLO R8                 ; R8.lo <- D
0102  F8 00       LDI  000H              ; D <- immediate
0104  A4          PLO R4                 ; R4.lo <- D
0105  A5          PLO R5                 ; R5.lo <- D
0106  A6          PLO R6                 ; R6.lo <- D
0107  F0          LDX                    ; D <- M(R(X))
0108  10          INC R0                 ; R0 <- R0+1
0109  B4          PHI R4                 ; R4.hi <- D
010A  F8 20       LDI  020H              ; D <- immediate
010C  B5          PHI R5                 ; R5.hi <- D
010D  F8 30       LDI  030H              ; D <- immediate
010F  B6          PHI R6                 ; R6.hi <- D
0110  D2          SEP R2                 ; P <- 2
0111  D2          SEP R2                 ; P <- 2
0112  C8          LSKP  ; (skips 2 bytes) ; Long skip unconditional
0113  00          IDL                    ; Idle / wait DMA or interrupt
0114  80          GLO R0                 ; D <- R0.lo
0115  30 02       BR  00102H             ; Branch unconditional
0117  81          GLO R1                 ; D <- R1.lo
0118  B3          PHI R3                 ; R3.hi <- D
0119  02          LDN R2                 ; Load D <- M(R2)
011A  C2 00 C2    LBZ  000C2H            ; Long branch if D=0
011D  D8          SEP R8                 ; P <- 8
011E  22          DEC R2                 ; R2 <- R2-1
011F  80          GLO R0                 ; D <- R0.lo
0120  F0          LDX                    ; D <- M(R(X))
0121  C6          LSNZ  ; (skips 2 bytes) ; Long skip if D!=0
0122  A4          PLO R4                 ; R4.lo <- D
0123  A5          PLO R5                 ; R5.lo <- D
0124  A6          PLO R6                 ; R6.lo <- D
0125  99          GHI R9                 ; D <- R9.hi
0126  D8          SEP R8                 ; P <- 8
0127  14          INC R4                 ; R4 <- R4+1
0128  94          GHI R4                 ; D <- R4.hi
0129  F8 2C       LDI  02CH              ; D <- immediate
012B  95          GHI R5                 ; D <- R5.hi
012C  F8 3C       LDI  03CH              ; D <- immediate
012E  B6          PHI R6                 ; R6.hi <- D
012F  C0 DA D2    LBR  0DAD2H            ; Long branch unconditional
0132  28          DEC R8                 ; R8 <- R8-1
0133  88          GLO R8                 ; D <- R8.lo
0134  32 20       BZ  00120H             ; Branch if D=0
0136  30 02       BR  00102H             ; Branch unconditional
0138  D0          SEP R0                 ; P <- 0  (set PC to R0)
0139  F0          LDX                    ; D <- M(R(X))
013A  05          LDN R5                 ; Load D <- M(R5)
013B  BC          PHI RC                 ; RC.hi <- D
013C  AC          PLO RC                 ; RC.lo <- D
013D  01          LDN R1                 ; Load D <- M(R1)
013E  FA 20       ANI  020H              ; D <- D & immediate
0140  FB 00       XRI  000H              ; D <- D ^ immediate
0142  32 87       BZ  00187H             ; Branch if D=0
0144  01          LDN R1                 ; Load D <- M(R1)
0145  D2          SEP R2                 ; P <- 2
0146  01          LDN R1                 ; Load D <- M(R1)
0147  32 10       BZ  00110H             ; Branch if D=0
0149  24          DEC R4                 ; R4 <- R4-1
014A  94          GHI R4                 ; D <- R4.hi
014B  32 3D       BZ  0013DH             ; Branch if D=0
014D  D3          SEP R3                 ; P <- 3
014E  D2          SEP R2                 ; P <- 2
014F  E4          SEX R4                 ; X <- 4
0150  61          OUT 1                  ; Out bus=M(R(X)); R(X)++; N=1
0151  62          OUT 2                  ; Out bus=M(R(X)); R(X)++; N=2
0152  D2          SEP R2                 ; P <- 2
0153  E5          SEX R5                 ; X <- 5
0154  61          OUT 1                  ; Out bus=M(R(X)); R(X)++; N=1
0155  62          OUT 2                  ; Out bus=M(R(X)); R(X)++; N=2
0156  D2          SEP R2                 ; P <- 2
0157  E6          SEX R6                 ; X <- 6

; --- ASCII data region (4 bytes) ---
0158              .ASCII "ab0N"

015C  D0          SEP R0                 ; P <- 0  (set PC to R0)
015D  0F          LDN RF                 ; Load D <- M(RF)
015E  FB FF       XRI  0FFH              ; D <- D ^ immediate
0160  32 6B       BZ  0016BH             ; Branch if D=0
0162  4F          LDA RF                 ; D <- M(RF); RF++
0163  B7          PHI R7                 ; R7.hi <- D
0164  4F          LDA RF                 ; D <- M(RF); RF++
0165  A7          PLO R7                 ; R7.lo <- D
0166  E7          SEX R7                 ; X <- 7

; --- ASCII data region (4 bytes) ---
0167              .ASCII "ab0\\"

016B  F8 72       LDI  072H              ; D <- immediate
016D  A0          PLO R0                 ; R0.lo <- D
016E  F0          LDX                    ; D <- M(R(X))
016F  01          LDN R1                 ; Load D <- M(R1)
0170  B0          PHI R0                 ; R0.hi <- D
0171  D0          SEP R0                 ; P <- 0  (set PC to R0)
0172  F8 03       LDI  003H              ; D <- immediate
0174  91          GHI R1                 ; D <- R1.hi
0175  01          LDN R1                 ; Load D <- M(R1)
0176  FA 06       ANI  006H              ; D <- D & immediate
0178  22          DEC R2                 ; R2 <- R2-1
0179  80          GLO R0                 ; D <- R0.lo
017A  D2          SEP R2                 ; P <- 2
017B  01          LDN R1                 ; Load D <- M(R1)
017C  91          GHI R1                 ; D <- R1.hi
017D  12          INC R2                 ; R2 <- R2+1
017E  75          SDB                    ; D,DF <- M(R(X))-D-DF'
017F  C1 EE 63    LBQ  0EE63H            ; Long branch if Q=1

; --- ASCII data region (4 bytes) ---
0182              .ASCII "deez"

0186  D3          SEP R3                 ; P <- 3
0187  F8 60       LDI  060H              ; D <- immediate
0189  51          STR R1                 ; M(R1) <- D
018A  F8 00       LDI  000H              ; D <- immediate
018C  A1          PLO R1                 ; R1.lo <- D
018D  01          LDN R1                 ; Load D <- M(R1)
018E  BD          PHI RD                 ; RD.hi <- D
018F  F8 40       LDI  040H              ; D <- immediate
0191  51          STR R1                 ; M(R1) <- D
0192  01          LDN R1                 ; Load D <- M(R1)
0193  8D          GLO RD                 ; D <- RD.lo
0194  C4          NOP                    ; No operation (C4 NOP)
0195  03          LDN R3                 ; Load D <- M(R3)
0196  64          OUT 4                  ; Out bus=M(R(X)); R(X)++; N=4
0197  52          STR R2                 ; M(R2) <- D
0198  F2          AND                    ; D <- D & M(R(X))
0199  01          LDN R1                 ; Load D <- M(R1)
019A  12          INC R2                 ; R2 <- R2+1
019B  97          GHI R7                 ; D <- R7.hi
019C  D8          SEP R8                 ; P <- 8
019D  02          LDN R2                 ; Load D <- M(R2)
019E  81          GLO R1                 ; D <- R1.lo
019F  95          GHI R5                 ; D <- R5.hi
01A0  DA          SEP RA                 ; P <- A
01A1  01          LDN R1                 ; Load D <- M(R1)
01A2  32 88       BZ  00188H             ; Branch if D=0
01A4  81          GLO R1                 ; D <- R1.lo
01A5  D1          SEP R1                 ; P <- 1  (set PC to R1)
01A6  01          LDN R1                 ; Load D <- M(R1)
01A7  81          GLO R1                 ; D <- R1.lo
01A8  95          GHI R5                 ; D <- R5.hi
01A9  D2          SEP R2                 ; P <- 2
01AA  02          LDN R2                 ; Load D <- M(R2)
01AB  12          INC R2                 ; R2 <- R2+1
01AC  B1          PHI R1                 ; R1.hi <- D
01AD  81          GLO R1                 ; D <- R1.lo
01AE  99          GHI R9                 ; D <- R9.hi
01AF  00          IDL                    ; Idle / wait DMA or interrupt
01B0  A1          PLO R1                 ; R1.lo <- D
01B1  9D          GHI RD                 ; D <- RD.hi
01B2  FA 04       ANI  004H              ; D <- D & immediate
01B4  32 BA       BZ  001BAH             ; Branch if D=0
01B6  81          GLO R1                 ; D <- R1.lo
01B7  F9 04       ORI  004H              ; D <- D | immediate
01B9  A1          PLO R1                 ; R1.lo <- D
01BA  9D          GHI RD                 ; D <- RD.hi
01BB  FA 10       ANI  010H              ; D <- D & immediate
01BD  32 C3       BZ  001C3H             ; Branch if D=0
01BF  81          GLO R1                 ; D <- R1.lo
01C0  F1          OR                     ; D <- D | M(R(X))
01C1  10          INC R0                 ; R0 <- R0+1
01C2  A1          PLO R1                 ; R1.lo <- D
01C3  81          GLO R1                 ; D <- R1.lo
01C4  51          STR R1                 ; M(R1) <- D
01C5  30 C5       BR  001C5H             ; Branch unconditional
01C7  22          DEC R2                 ; R2 <- R2-1
01C8  2A          DEC RA                 ; RA <- RA-1
01C9  4C          LDA RC                 ; D <- M(RC); RC++

; --- filler region: 4 x 0x00 ---
01CA              .DS  4, 000H   ; [cleared region]


; --- filler region: 6 x 0x20 ---
01CE              .DS  6, 020H


; --- ASCII data region (30 bytes) ---
01D4              .ASCII "FO  0A1A234TOC  "
01E4              .ASCII "       H -    "

01F2  02          LDN R2                 ; Load D <- M(R2)
01F3  2E          DEC RE                 ; RE <- RE-1
01F4  46          LDA R6                 ; D <- M(R6); R6++
01F5  00          IDL                    ; Idle / wait DMA or interrupt

; --- ASCII data region (8 bytes) ---
01F6              .ASCII "NEC0P   "

01FE  0A          LDN RA                 ; Load D <- M(RA)

; --- ASCII data region (38 bytes) ---
01FF              .ASCII " O O E3R IF* R R"
020F              .ASCII " F E BO* EWMBSH%"
021F              .ASCII " MR* A"

0225  09          LDN R9                 ; Load D <- M(R9)

; --- ASCII data region (35 bytes) ---
0226              .ASCII "AUUTP E \" DTLRS-"
0236              .ASCII "R CP*  H D 3G GA"
0246              .ASCII "\" S"

0249  00          IDL                    ; Idle / wait DMA or interrupt

; --- ASCII data region (44 bytes) ---
024A              .ASCII "EIF2C AT* IACCO:"
025A              .ASCII "E PI* F GKU3D  E"
026A              .ASCII "* UV  F0U VN"

0276  02          LDN R2                 ; Load D <- M(R2)

; --- ASCII data region (125 bytes) ---
0277              .ASCII " SE  D R 2T*  N "
0287              .ASCII "C:WA M * RT O TD"
0297              .ASCII " 0N* HR R0%  RO*"
02A7              .ASCII " YI P86T 0.* TC "
02B7              .ASCII ".17E 7 * HU  4 S"
02C7              .ASCII "  0* ML  3 T P8*"
02D7              .ASCII " ,A 12AI E1*  R "
02E7              .ASCII "52GN R4* R   "

02F4  10          INC R0                 ; R0 <- R0+1

; --- ASCII data region (175 bytes) ---
02F5              .ASCII "EG F3* AP P6-- O"
0305              .ASCII "2* TR L 4 -R2* E"
0315              .ASCII "E U 0R M0\"  E M "
0325              .ASCII " P-E6* 6A BR(S D"
0335              .ASCII " * 4T  MMLP A*  "
0345              .ASCII "U    MRAC*  R SU"
0355              .ASCII "CCETQ*  E TNA L "
0365              .ASCII "U*    RKU I2A*  "
0375              .ASCII "C EN  M3R*  O EO"
0385              .ASCII "  I E*  M TW  NA"
0395              .ASCII "D*  P  N) AU * "

03A4  00          IDL                    ; Idle / wait DMA or interrupt

; --- ASCII data region (15 bytes) ---
03A5              .ASCII "L   T RGA*  E  "

03B4  00          IDL                    ; Idle / wait DMA or interrupt

; --- ASCII data region (61 bytes) ---
03B5              .ASCII "EEY T*  X M CC 7"
03C5              .ASCII " *    I HGR92*  "
03D5              .ASCII " *L  AE 3*    TS"
03E5              .ASCII " PP0 *   AOE4"

03F2  00          IDL                    ; Idle / wait DMA or interrupt
03F3  4F          LDA RF                 ; D <- M(RF); RF++
03F4  11          INC R1                 ; R1 <- R1+1

; --- ASCII data region (39 bytes) ---
03F5              .ASCII "M*   NNQ6VR:A*  "
0405              .ASCII " C,A 2T5Y*   R C"
0415              .ASCII " M 9 * "

041C  00          IDL                    ; Idle / wait DMA or interrupt

; --- ASCII data region (7 bytes) ---
041D              .ASCII "   A 0-"

0424  1A          INC RA                 ; RA <- RA+1

; --- ASCII data region (378 bytes) ---
0425              .ASCII "7*     1 R 28*  "
0435              .ASCII " TW1 0-9 *   EI "
0445              .ASCII " 9  0*   SS     "
0455              .ASCII "9*   TC  2  :*  "
0465              .ASCII "  O  3  5*    N "
0475              .ASCII "    6*   PSP M  "
0485              .ASCII ":*   AII A  4*  "
0495              .ASCII " TND Y  1*   T :"
04A5              .ASCII "     *   E   7  "
04B5              .ASCII " *   R 0 8   *  "
04C5              .ASCII " N58     *    31"
04D5              .ASCII " 0   *   *54S9  "
04E5              .ASCII " *    63T:   *  "
04F5              .ASCII "  32A5   *     2"
0505              .ASCII "T6   *     0/:  "
0515              .ASCII " *    *6P4   *  "
0525              .ASCII "    R1   *    P "
0535              .ASCII "E         AO-   "
0545              .ASCII "      GFO       "
0555              .ASCII "  E P          1"
0565              .ASCII "          1     "
0575              .ASCII "                "
0585              .ASCII "                "
0595              .ASCII "          "


; --- filler region: 609 x 0xFF ---
059F              .DS  609, 0FFH   ; [unprogrammed EPROM]


; --- end of disassembly ---
