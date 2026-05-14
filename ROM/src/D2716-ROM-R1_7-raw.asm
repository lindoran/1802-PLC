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
0030  32 26       BZ  00026H             ; Branch if D=0
0032  3D 24       BN2  00024H            ; Branch if EF2=0
0034  35 34       B2  00034H             ; Branch if EF2=1
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
0158  61          OUT 1                  ; Out bus=M(R(X)); R(X)++; N=1
0159  62          OUT 2                  ; Out bus=M(R(X)); R(X)++; N=2
015A  30 4E       BR  0014EH             ; Branch unconditional
015C  D0          SEP R0                 ; P <- 0  (set PC to R0)
015D  0F          LDN RF                 ; Load D <- M(RF)
015E  FB FF       XRI  0FFH              ; D <- D ^ immediate
0160  32 6B       BZ  0016BH             ; Branch if D=0
0162  4F          LDA RF                 ; D <- M(RF); RF++
0163  B7          PHI R7                 ; R7.hi <- D
0164  4F          LDA RF                 ; D <- M(RF); RF++
0165  A7          PLO R7                 ; R7.lo <- D
0166  E7          SEX R7                 ; X <- 7
0167  61          OUT 1                  ; Out bus=M(R(X)); R(X)++; N=1
0168  62          OUT 2                  ; Out bus=M(R(X)); R(X)++; N=2
0169  30 5C       BR  0015CH             ; Branch unconditional
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
0182  64          OUT 4                  ; Out bus=M(R(X)); R(X)++; N=4
0183  65          OUT 5                  ; Out bus=M(R(X)); R(X)++; N=5
0184  65          OUT 5                  ; Out bus=M(R(X)); R(X)++; N=5
0185  7A          REQ                    ; Q <- 0
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

01D4  46          LDA R6                 ; D <- M(R6); R6++
01D5  4F          LDA RF                 ; D <- M(RF); RF++
01D6  20          DEC R0                 ; R0 <- R0-1
01D7  20          DEC R0                 ; R0 <- R0-1
01D8  30 41       BR  00141H             ; Branch unconditional
01DA  31 41       BQ  00141H             ; Branch if Q=1
01DC  32 33       BZ  00133H             ; Branch if D=0
01DE  34 54       B1  00154H             ; Branch if EF1=1
01E0  4F          LDA RF                 ; D <- M(RF); RF++
01E1  43          LDA R3                 ; D <- M(R3); R3++

; --- filler region: 9 x 0x20 ---
01E2              .DS  9, 020H

01EB  48          LDA R8                 ; D <- M(R8); R8++
01EC  20          DEC R0                 ; R0 <- R0-1
01ED  2D          DEC RD                 ; RD <- RD-1

; --- filler region: 4 x 0x20 ---
01EE              .DS  4, 020H

01F2  02          LDN R2                 ; Load D <- M(R2)
01F3  2E          DEC RE                 ; RE <- RE-1
01F4  46          LDA R6                 ; D <- M(R6); R6++
01F5  00          IDL                    ; Idle / wait DMA or interrupt
01F6  4E          LDA RE                 ; D <- M(RE); RE++
01F7  45          LDA R5                 ; D <- M(R5); R5++
01F8  43          LDA R3                 ; D <- M(R3); R3++
01F9  30 50       BR  00150H             ; Branch unconditional
01FB  20          DEC R0                 ; R0 <- R0-1
01FC  20          DEC R0                 ; R0 <- R0-1
01FD  20          DEC R0                 ; R0 <- R0-1
01FE  0A          LDN RA                 ; Load D <- M(RA)
01FF  20          DEC R0                 ; R0 <- R0-1
0200  4F          LDA RF                 ; D <- M(RF); RF++
0201  20          DEC R0                 ; R0 <- R0-1
0202  4F          LDA RF                 ; D <- M(RF); RF++
0203  20          DEC R0                 ; R0 <- R0-1
0204  45          LDA R5                 ; D <- M(R5); R5++
0205  33 52       BDF  00252H            ; Branch if DF=1
0207  20          DEC R0                 ; R0 <- R0-1
0208  49          LDA R9                 ; D <- M(R9); R9++
0209  46          LDA R6                 ; D <- M(R6); R6++
020A  2A          DEC RA                 ; RA <- RA-1
020B  20          DEC R0                 ; R0 <- R0-1
020C  52          STR R2                 ; M(R2) <- D
020D  20          DEC R0                 ; R0 <- R0-1
020E  52          STR R2                 ; M(R2) <- D
020F  20          DEC R0                 ; R0 <- R0-1
0210  46          LDA R6                 ; D <- M(R6); R6++
0211  20          DEC R0                 ; R0 <- R0-1
0212  45          LDA R5                 ; D <- M(R5); R5++
0213  20          DEC R0                 ; R0 <- R0-1
0214  42          LDA R2                 ; D <- M(R2); R2++
0215  4F          LDA RF                 ; D <- M(RF); RF++
0216  2A          DEC RA                 ; RA <- RA-1
0217  20          DEC R0                 ; R0 <- R0-1
0218  45          LDA R5                 ; D <- M(R5); R5++
0219  57          STR R7                 ; M(R7) <- D
021A  4D          LDA RD                 ; D <- M(RD); RD++
021B  42          LDA R2                 ; D <- M(R2); R2++
021C  53          STR R3                 ; M(R3) <- D
021D  48          LDA R8                 ; D <- M(R8); R8++
021E  25          DEC R5                 ; R5 <- R5-1
021F  20          DEC R0                 ; R0 <- R0-1
0220  4D          LDA RD                 ; D <- M(RD); RD++
0221  52          STR R2                 ; M(R2) <- D
0222  2A          DEC RA                 ; RA <- RA-1
0223  20          DEC R0                 ; R0 <- R0-1
0224  41          LDA R1                 ; D <- M(R1); R1++
0225  09          LDN R9                 ; Load D <- M(R9)
0226  41          LDA R1                 ; D <- M(R1); R1++
0227  55          STR R5                 ; M(R5) <- D
0228  55          STR R5                 ; M(R5) <- D
0229  54          STR R4                 ; M(R4) <- D
022A  50          STR R0                 ; M(R0) <- D
022B  20          DEC R0                 ; R0 <- R0-1
022C  45          LDA R5                 ; D <- M(R5); R5++
022D  20          DEC R0                 ; R0 <- R0-1
022E  22          DEC R2                 ; R2 <- R2-1
022F  20          DEC R0                 ; R0 <- R0-1
0230  44          LDA R4                 ; D <- M(R4); R4++
0231  54          STR R4                 ; M(R4) <- D
0232  4C          LDA RC                 ; D <- M(RC); RC++
0233  52          STR R2                 ; M(R2) <- D
0234  53          STR R3                 ; M(R3) <- D
0235  2D          DEC RD                 ; RD <- RD-1
0236  52          STR R2                 ; M(R2) <- D
0237  20          DEC R0                 ; R0 <- R0-1
0238  43          LDA R3                 ; D <- M(R3); R3++
0239  50          STR R0                 ; M(R0) <- D
023A  2A          DEC RA                 ; RA <- RA-1
023B  20          DEC R0                 ; R0 <- R0-1
023C  20          DEC R0                 ; R0 <- R0-1
023D  48          LDA R8                 ; D <- M(R8); R8++
023E  20          DEC R0                 ; R0 <- R0-1
023F  44          LDA R4                 ; D <- M(R4); R4++
0240  20          DEC R0                 ; R0 <- R0-1
0241  33 47       BDF  00247H            ; Branch if DF=1
0243  20          DEC R0                 ; R0 <- R0-1
0244  47          LDA R7                 ; D <- M(R7); R7++
0245  41          LDA R1                 ; D <- M(R1); R1++
0246  22          DEC R2                 ; R2 <- R2-1
0247  20          DEC R0                 ; R0 <- R0-1
0248  53          STR R3                 ; M(R3) <- D
0249  00          IDL                    ; Idle / wait DMA or interrupt
024A  45          LDA R5                 ; D <- M(R5); R5++
024B  49          LDA R9                 ; D <- M(R9); R9++
024C  46          LDA R6                 ; D <- M(R6); R6++
024D  32 43       BZ  00243H             ; Branch if D=0
024F  20          DEC R0                 ; R0 <- R0-1
0250  41          LDA R1                 ; D <- M(R1); R1++
0251  54          STR R4                 ; M(R4) <- D
0252  2A          DEC RA                 ; RA <- RA-1
0253  20          DEC R0                 ; R0 <- R0-1
0254  49          LDA R9                 ; D <- M(R9); R9++
0255  41          LDA R1                 ; D <- M(R1); R1++
0256  43          LDA R3                 ; D <- M(R3); R3++
0257  43          LDA R3                 ; D <- M(R3); R3++
0258  4F          LDA RF                 ; D <- M(RF); RF++
0259  3A 45       BNZ  00245H            ; Branch if D!=0
025B  20          DEC R0                 ; R0 <- R0-1
025C  50          STR R0                 ; M(R0) <- D
025D  49          LDA R9                 ; D <- M(R9); R9++
025E  2A          DEC RA                 ; RA <- RA-1
025F  20          DEC R0                 ; R0 <- R0-1
0260  46          LDA R6                 ; D <- M(R6); R6++
0261  20          DEC R0                 ; R0 <- R0-1
0262  47          LDA R7                 ; D <- M(R7); R7++
0263  4B          LDA RB                 ; D <- M(RB); RB++
0264  55          STR R5                 ; M(R5) <- D
0265  33 44       BDF  00244H            ; Branch if DF=1
0267  20          DEC R0                 ; R0 <- R0-1
0268  20          DEC R0                 ; R0 <- R0-1
0269  45          LDA R5                 ; D <- M(R5); R5++
026A  2A          DEC RA                 ; RA <- RA-1
026B  20          DEC R0                 ; R0 <- R0-1
026C  55          STR R5                 ; M(R5) <- D
026D  56          STR R6                 ; M(R6) <- D
026E  20          DEC R0                 ; R0 <- R0-1
026F  20          DEC R0                 ; R0 <- R0-1
0270  46          LDA R6                 ; D <- M(R6); R6++
0271  30 55       BR  00255H             ; Branch unconditional
0273  20          DEC R0                 ; R0 <- R0-1
0274  56          STR R6                 ; M(R6) <- D
0275  4E          LDA RE                 ; D <- M(RE); RE++
0276  02          LDN R2                 ; Load D <- M(R2)
0277  20          DEC R0                 ; R0 <- R0-1
0278  53          STR R3                 ; M(R3) <- D
0279  45          LDA R5                 ; D <- M(R5); R5++
027A  20          DEC R0                 ; R0 <- R0-1
027B  20          DEC R0                 ; R0 <- R0-1
027C  44          LDA R4                 ; D <- M(R4); R4++
027D  20          DEC R0                 ; R0 <- R0-1
027E  52          STR R2                 ; M(R2) <- D
027F  20          DEC R0                 ; R0 <- R0-1
0280  32 54       BZ  00254H             ; Branch if D=0
0282  2A          DEC RA                 ; RA <- RA-1
0283  20          DEC R0                 ; R0 <- R0-1
0284  20          DEC R0                 ; R0 <- R0-1
0285  4E          LDA RE                 ; D <- M(RE); RE++
0286  20          DEC R0                 ; R0 <- R0-1
0287  43          LDA R3                 ; D <- M(R3); R3++
0288  3A 57       BNZ  00257H            ; Branch if D!=0
028A  41          LDA R1                 ; D <- M(R1); R1++
028B  20          DEC R0                 ; R0 <- R0-1
028C  4D          LDA RD                 ; D <- M(RD); RD++
028D  20          DEC R0                 ; R0 <- R0-1
028E  2A          DEC RA                 ; RA <- RA-1
028F  20          DEC R0                 ; R0 <- R0-1
0290  52          STR R2                 ; M(R2) <- D
0291  54          STR R4                 ; M(R4) <- D
0292  20          DEC R0                 ; R0 <- R0-1
0293  4F          LDA RF                 ; D <- M(RF); RF++
0294  20          DEC R0                 ; R0 <- R0-1
0295  54          STR R4                 ; M(R4) <- D
0296  44          LDA R4                 ; D <- M(R4); R4++
0297  20          DEC R0                 ; R0 <- R0-1
0298  30 4E       BR  0024EH             ; Branch unconditional
029A  2A          DEC RA                 ; RA <- RA-1
029B  20          DEC R0                 ; R0 <- R0-1
029C  48          LDA R8                 ; D <- M(R8); R8++
029D  52          STR R2                 ; M(R2) <- D
029E  20          DEC R0                 ; R0 <- R0-1
029F  52          STR R2                 ; M(R2) <- D
02A0  30 25       BR  00225H             ; Branch unconditional
02A2  20          DEC R0                 ; R0 <- R0-1
02A3  20          DEC R0                 ; R0 <- R0-1
02A4  52          STR R2                 ; M(R2) <- D
02A5  4F          LDA RF                 ; D <- M(RF); RF++
02A6  2A          DEC RA                 ; RA <- RA-1
02A7  20          DEC R0                 ; R0 <- R0-1
02A8  59          STR R9                 ; M(R9) <- D
02A9  49          LDA R9                 ; D <- M(R9); R9++
02AA  20          DEC R0                 ; R0 <- R0-1
02AB  50          STR R0                 ; M(R0) <- D
02AC  38 36       SKP  ; (skips 1 byte)  ; Skip next byte
02AE  54          STR R4                 ; M(R4) <- D
02AF  20          DEC R0                 ; R0 <- R0-1
02B0  30 2E       BR  0022EH             ; Branch unconditional
02B2  2A          DEC RA                 ; RA <- RA-1
02B3  20          DEC R0                 ; R0 <- R0-1
02B4  54          STR R4                 ; M(R4) <- D
02B5  43          LDA R3                 ; D <- M(R3); R3++
02B6  20          DEC R0                 ; R0 <- R0-1
02B7  2E          DEC RE                 ; RE <- RE-1
02B8  31 37       BQ  00237H             ; Branch if Q=1
02BA  45          LDA R5                 ; D <- M(R5); R5++
02BB  20          DEC R0                 ; R0 <- R0-1
02BC  37 20       B4  00220H             ; Branch if EF4=1
02BE  2A          DEC RA                 ; RA <- RA-1
02BF  20          DEC R0                 ; R0 <- R0-1
02C0  48          LDA R8                 ; D <- M(R8); R8++
02C1  55          STR R5                 ; M(R5) <- D
02C2  20          DEC R0                 ; R0 <- R0-1
02C3  20          DEC R0                 ; R0 <- R0-1
02C4  34 20       B1  00220H             ; Branch if EF1=1
02C6  53          STR R3                 ; M(R3) <- D
02C7  20          DEC R0                 ; R0 <- R0-1
02C8  20          DEC R0                 ; R0 <- R0-1
02C9  30 2A       BR  0022AH             ; Branch unconditional
02CB  20          DEC R0                 ; R0 <- R0-1
02CC  4D          LDA RD                 ; D <- M(RD); RD++
02CD  4C          LDA RC                 ; D <- M(RC); RC++
02CE  20          DEC R0                 ; R0 <- R0-1
02CF  20          DEC R0                 ; R0 <- R0-1
02D0  33 20       BDF  00220H            ; Branch if DF=1
02D2  54          STR R4                 ; M(R4) <- D
02D3  20          DEC R0                 ; R0 <- R0-1
02D4  50          STR R0                 ; M(R0) <- D
02D5  38 2A       SKP  ; (skips 1 byte)  ; Skip next byte
02D7  20          DEC R0                 ; R0 <- R0-1
02D8  2C          DEC RC                 ; RC <- RC-1
02D9  41          LDA R1                 ; D <- M(R1); R1++
02DA  20          DEC R0                 ; R0 <- R0-1
02DB  31 32       BQ  00232H             ; Branch if Q=1
02DD  41          LDA R1                 ; D <- M(R1); R1++
02DE  49          LDA R9                 ; D <- M(R9); R9++
02DF  20          DEC R0                 ; R0 <- R0-1
02E0  45          LDA R5                 ; D <- M(R5); R5++
02E1  31 2A       BQ  0022AH             ; Branch if Q=1
02E3  20          DEC R0                 ; R0 <- R0-1
02E4  20          DEC R0                 ; R0 <- R0-1
02E5  52          STR R2                 ; M(R2) <- D
02E6  20          DEC R0                 ; R0 <- R0-1
02E7  35 32       B2  00232H             ; Branch if EF2=1
02E9  47          LDA R7                 ; D <- M(R7); R7++
02EA  4E          LDA RE                 ; D <- M(RE); RE++
02EB  20          DEC R0                 ; R0 <- R0-1
02EC  52          STR R2                 ; M(R2) <- D
02ED  34 2A       B1  0022AH             ; Branch if EF1=1
02EF  20          DEC R0                 ; R0 <- R0-1
02F0  52          STR R2                 ; M(R2) <- D
02F1  20          DEC R0                 ; R0 <- R0-1
02F2  20          DEC R0                 ; R0 <- R0-1
02F3  20          DEC R0                 ; R0 <- R0-1
02F4  10          INC R0                 ; R0 <- R0+1
02F5  45          LDA R5                 ; D <- M(R5); R5++
02F6  47          LDA R7                 ; D <- M(R7); R7++
02F7  20          DEC R0                 ; R0 <- R0-1
02F8  46          LDA R6                 ; D <- M(R6); R6++
02F9  33 2A       BDF  0022AH            ; Branch if DF=1
02FB  20          DEC R0                 ; R0 <- R0-1
02FC  41          LDA R1                 ; D <- M(R1); R1++
02FD  50          STR R0                 ; M(R0) <- D
02FE  20          DEC R0                 ; R0 <- R0-1
02FF  50          STR R0                 ; M(R0) <- D
0300  36 2D       B3  0032DH             ; Branch if EF3=1
0302  2D          DEC RD                 ; RD <- RD-1
0303  20          DEC R0                 ; R0 <- R0-1
0304  4F          LDA RF                 ; D <- M(RF); RF++
0305  32 2A       BZ  0032AH             ; Branch if D=0
0307  20          DEC R0                 ; R0 <- R0-1
0308  54          STR R4                 ; M(R4) <- D
0309  52          STR R2                 ; M(R2) <- D
030A  20          DEC R0                 ; R0 <- R0-1
030B  4C          LDA RC                 ; D <- M(RC); RC++
030C  20          DEC R0                 ; R0 <- R0-1
030D  34 20       B1  00320H             ; Branch if EF1=1
030F  2D          DEC RD                 ; RD <- RD-1
0310  52          STR R2                 ; M(R2) <- D
0311  32 2A       BZ  0032AH             ; Branch if D=0
0313  20          DEC R0                 ; R0 <- R0-1
0314  45          LDA R5                 ; D <- M(R5); R5++
0315  45          LDA R5                 ; D <- M(R5); R5++
0316  20          DEC R0                 ; R0 <- R0-1
0317  55          STR R5                 ; M(R5) <- D
0318  20          DEC R0                 ; R0 <- R0-1
0319  30 52       BR  00352H             ; Branch unconditional
031B  20          DEC R0                 ; R0 <- R0-1
031C  4D          LDA RD                 ; D <- M(RD); RD++
031D  30 22       BR  00322H             ; Branch unconditional
031F  20          DEC R0                 ; R0 <- R0-1
0320  20          DEC R0                 ; R0 <- R0-1
0321  45          LDA R5                 ; D <- M(R5); R5++
0322  20          DEC R0                 ; R0 <- R0-1
0323  4D          LDA RD                 ; D <- M(RD); RD++
0324  20          DEC R0                 ; R0 <- R0-1
0325  20          DEC R0                 ; R0 <- R0-1
0326  50          STR R0                 ; M(R0) <- D
0327  2D          DEC RD                 ; RD <- RD-1
0328  45          LDA R5                 ; D <- M(R5); R5++
0329  36 2A       B3  0032AH             ; Branch if EF3=1
032B  20          DEC R0                 ; R0 <- R0-1
032C  36 41       B3  00341H             ; Branch if EF3=1
032E  20          DEC R0                 ; R0 <- R0-1
032F  42          LDA R2                 ; D <- M(R2); R2++
0330  52          STR R2                 ; M(R2) <- D
0331  28          DEC R8                 ; R8 <- R8-1
0332  53          STR R3                 ; M(R3) <- D
0333  20          DEC R0                 ; R0 <- R0-1
0334  44          LDA R4                 ; D <- M(R4); R4++
0335  20          DEC R0                 ; R0 <- R0-1
0336  2A          DEC RA                 ; RA <- RA-1
0337  20          DEC R0                 ; R0 <- R0-1
0338  34 54       B1  00354H             ; Branch if EF1=1
033A  20          DEC R0                 ; R0 <- R0-1
033B  20          DEC R0                 ; R0 <- R0-1
033C  4D          LDA RD                 ; D <- M(RD); RD++
033D  4D          LDA RD                 ; D <- M(RD); RD++
033E  4C          LDA RC                 ; D <- M(RC); RC++
033F  50          STR R0                 ; M(R0) <- D
0340  20          DEC R0                 ; R0 <- R0-1
0341  41          LDA R1                 ; D <- M(R1); R1++
0342  2A          DEC RA                 ; RA <- RA-1
0343  20          DEC R0                 ; R0 <- R0-1
0344  20          DEC R0                 ; R0 <- R0-1
0345  55          STR R5                 ; M(R5) <- D

; --- filler region: 4 x 0x20 ---
0346              .DS  4, 020H

034A  4D          LDA RD                 ; D <- M(RD); RD++
034B  52          STR R2                 ; M(R2) <- D
034C  41          LDA R1                 ; D <- M(R1); R1++
034D  43          LDA R3                 ; D <- M(R3); R3++
034E  2A          DEC RA                 ; RA <- RA-1
034F  20          DEC R0                 ; R0 <- R0-1
0350  20          DEC R0                 ; R0 <- R0-1
0351  52          STR R2                 ; M(R2) <- D
0352  20          DEC R0                 ; R0 <- R0-1
0353  53          STR R3                 ; M(R3) <- D
0354  55          STR R5                 ; M(R5) <- D
0355  43          LDA R3                 ; D <- M(R3); R3++
0356  43          LDA R3                 ; D <- M(R3); R3++
0357  45          LDA R5                 ; D <- M(R5); R5++
0358  54          STR R4                 ; M(R4) <- D
0359  51          STR R1                 ; M(R1) <- D
035A  2A          DEC RA                 ; RA <- RA-1
035B  20          DEC R0                 ; R0 <- R0-1
035C  20          DEC R0                 ; R0 <- R0-1
035D  45          LDA R5                 ; D <- M(R5); R5++
035E  20          DEC R0                 ; R0 <- R0-1
035F  54          STR R4                 ; M(R4) <- D
0360  4E          LDA RE                 ; D <- M(RE); RE++
0361  41          LDA R1                 ; D <- M(R1); R1++
0362  20          DEC R0                 ; R0 <- R0-1
0363  4C          LDA RC                 ; D <- M(RC); RC++
0364  20          DEC R0                 ; R0 <- R0-1
0365  55          STR R5                 ; M(R5) <- D
0366  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 4 x 0x20 ---
0367              .DS  4, 020H

036B  52          STR R2                 ; M(R2) <- D
036C  4B          LDA RB                 ; D <- M(RB); RB++
036D  55          STR R5                 ; M(R5) <- D
036E  20          DEC R0                 ; R0 <- R0-1
036F  49          LDA R9                 ; D <- M(R9); R9++
0370  32 41       BZ  00341H             ; Branch if D=0
0372  2A          DEC RA                 ; RA <- RA-1
0373  20          DEC R0                 ; R0 <- R0-1
0374  20          DEC R0                 ; R0 <- R0-1
0375  43          LDA R3                 ; D <- M(R3); R3++
0376  20          DEC R0                 ; R0 <- R0-1
0377  45          LDA R5                 ; D <- M(R5); R5++
0378  4E          LDA RE                 ; D <- M(RE); RE++
0379  20          DEC R0                 ; R0 <- R0-1
037A  20          DEC R0                 ; R0 <- R0-1
037B  4D          LDA RD                 ; D <- M(RD); RD++
037C  33 52       BDF  00352H            ; Branch if DF=1
037E  2A          DEC RA                 ; RA <- RA-1
037F  20          DEC R0                 ; R0 <- R0-1
0380  20          DEC R0                 ; R0 <- R0-1
0381  4F          LDA RF                 ; D <- M(RF); RF++
0382  20          DEC R0                 ; R0 <- R0-1
0383  45          LDA R5                 ; D <- M(R5); R5++
0384  4F          LDA RF                 ; D <- M(RF); RF++
0385  20          DEC R0                 ; R0 <- R0-1
0386  20          DEC R0                 ; R0 <- R0-1
0387  49          LDA R9                 ; D <- M(R9); R9++
0388  20          DEC R0                 ; R0 <- R0-1
0389  45          LDA R5                 ; D <- M(R5); R5++
038A  2A          DEC RA                 ; RA <- RA-1
038B  20          DEC R0                 ; R0 <- R0-1
038C  20          DEC R0                 ; R0 <- R0-1
038D  4D          LDA RD                 ; D <- M(RD); RD++
038E  20          DEC R0                 ; R0 <- R0-1
038F  54          STR R4                 ; M(R4) <- D
0390  57          STR R7                 ; M(R7) <- D
0391  20          DEC R0                 ; R0 <- R0-1
0392  20          DEC R0                 ; R0 <- R0-1
0393  4E          LDA RE                 ; D <- M(RE); RE++
0394  41          LDA R1                 ; D <- M(R1); R1++
0395  44          LDA R4                 ; D <- M(R4); R4++
0396  2A          DEC RA                 ; RA <- RA-1
0397  20          DEC R0                 ; R0 <- R0-1
0398  20          DEC R0                 ; R0 <- R0-1
0399  50          STR R0                 ; M(R0) <- D
039A  20          DEC R0                 ; R0 <- R0-1
039B  20          DEC R0                 ; R0 <- R0-1
039C  4E          LDA RE                 ; D <- M(RE); RE++
039D  29          DEC R9                 ; R9 <- R9-1
039E  20          DEC R0                 ; R0 <- R0-1
039F  41          LDA R1                 ; D <- M(R1); R1++
03A0  55          STR R5                 ; M(R5) <- D
03A1  20          DEC R0                 ; R0 <- R0-1
03A2  2A          DEC RA                 ; RA <- RA-1
03A3  20          DEC R0                 ; R0 <- R0-1
03A4  00          IDL                    ; Idle / wait DMA or interrupt
03A5  4C          LDA RC                 ; D <- M(RC); RC++
03A6  20          DEC R0                 ; R0 <- R0-1
03A7  20          DEC R0                 ; R0 <- R0-1
03A8  20          DEC R0                 ; R0 <- R0-1
03A9  54          STR R4                 ; M(R4) <- D
03AA  20          DEC R0                 ; R0 <- R0-1
03AB  52          STR R2                 ; M(R2) <- D
03AC  47          LDA R7                 ; D <- M(R7); R7++
03AD  41          LDA R1                 ; D <- M(R1); R1++
03AE  2A          DEC RA                 ; RA <- RA-1
03AF  20          DEC R0                 ; R0 <- R0-1
03B0  20          DEC R0                 ; R0 <- R0-1
03B1  45          LDA R5                 ; D <- M(R5); R5++
03B2  20          DEC R0                 ; R0 <- R0-1
03B3  20          DEC R0                 ; R0 <- R0-1
03B4  00          IDL                    ; Idle / wait DMA or interrupt
03B5  45          LDA R5                 ; D <- M(R5); R5++
03B6  45          LDA R5                 ; D <- M(R5); R5++
03B7  59          STR R9                 ; M(R9) <- D
03B8  20          DEC R0                 ; R0 <- R0-1
03B9  54          STR R4                 ; M(R4) <- D
03BA  2A          DEC RA                 ; RA <- RA-1
03BB  20          DEC R0                 ; R0 <- R0-1
03BC  20          DEC R0                 ; R0 <- R0-1
03BD  58          STR R8                 ; M(R8) <- D
03BE  20          DEC R0                 ; R0 <- R0-1
03BF  4D          LDA RD                 ; D <- M(RD); RD++
03C0  20          DEC R0                 ; R0 <- R0-1
03C1  43          LDA R3                 ; D <- M(R3); R3++
03C2  43          LDA R3                 ; D <- M(R3); R3++
03C3  20          DEC R0                 ; R0 <- R0-1
03C4  37 20       B4  00320H             ; Branch if EF4=1
03C6  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 4 x 0x20 ---
03C7              .DS  4, 020H

03CB  49          LDA R9                 ; D <- M(R9); R9++
03CC  20          DEC R0                 ; R0 <- R0-1
03CD  48          LDA R8                 ; D <- M(R8); R8++
03CE  47          LDA R7                 ; D <- M(R7); R7++
03CF  52          STR R2                 ; M(R2) <- D
03D0  39 32       BNQ  00332H            ; Branch if Q=0
03D2  2A          DEC RA                 ; RA <- RA-1
03D3  20          DEC R0                 ; R0 <- R0-1
03D4  20          DEC R0                 ; R0 <- R0-1
03D5  20          DEC R0                 ; R0 <- R0-1
03D6  2A          DEC RA                 ; RA <- RA-1
03D7  4C          LDA RC                 ; D <- M(RC); RC++
03D8  20          DEC R0                 ; R0 <- R0-1
03D9  20          DEC R0                 ; R0 <- R0-1
03DA  41          LDA R1                 ; D <- M(R1); R1++
03DB  45          LDA R5                 ; D <- M(R5); R5++
03DC  20          DEC R0                 ; R0 <- R0-1
03DD  33 2A       BDF  0032AH            ; Branch if DF=1

; --- filler region: 4 x 0x20 ---
03DF              .DS  4, 020H

03E3  54          STR R4                 ; M(R4) <- D
03E4  53          STR R3                 ; M(R3) <- D
03E5  20          DEC R0                 ; R0 <- R0-1
03E6  50          STR R0                 ; M(R0) <- D
03E7  50          STR R0                 ; M(R0) <- D
03E8  30 20       BR  00320H             ; Branch unconditional
03EA  2A          DEC RA                 ; RA <- RA-1
03EB  20          DEC R0                 ; R0 <- R0-1
03EC  20          DEC R0                 ; R0 <- R0-1
03ED  20          DEC R0                 ; R0 <- R0-1
03EE  41          LDA R1                 ; D <- M(R1); R1++
03EF  4F          LDA RF                 ; D <- M(RF); RF++
03F0  45          LDA R5                 ; D <- M(R5); R5++
03F1  34 00       B1  00300H             ; Branch if EF1=1
03F3  4F          LDA RF                 ; D <- M(RF); RF++
03F4  11          INC R1                 ; R1 <- R1+1
03F5  4D          LDA RD                 ; D <- M(RD); RD++
03F6  2A          DEC RA                 ; RA <- RA-1
03F7  20          DEC R0                 ; R0 <- R0-1
03F8  20          DEC R0                 ; R0 <- R0-1
03F9  20          DEC R0                 ; R0 <- R0-1
03FA  4E          LDA RE                 ; D <- M(RE); RE++
03FB  4E          LDA RE                 ; D <- M(RE); RE++
03FC  51          STR R1                 ; M(R1) <- D
03FD  36 56       B3  00356H             ; Branch if EF3=1
03FF  52          STR R2                 ; M(R2) <- D
0400  3A 41       BNZ  00441H            ; Branch if D!=0
0402  2A          DEC RA                 ; RA <- RA-1
0403  20          DEC R0                 ; R0 <- R0-1
0404  20          DEC R0                 ; R0 <- R0-1
0405  20          DEC R0                 ; R0 <- R0-1
0406  43          LDA R3                 ; D <- M(R3); R3++
0407  2C          DEC RC                 ; RC <- RC-1
0408  41          LDA R1                 ; D <- M(R1); R1++
0409  20          DEC R0                 ; R0 <- R0-1
040A  32 54       BZ  00454H             ; Branch if D=0
040C  35 59       B2  00459H             ; Branch if EF2=1
040E  2A          DEC RA                 ; RA <- RA-1
040F  20          DEC R0                 ; R0 <- R0-1
0410  20          DEC R0                 ; R0 <- R0-1
0411  20          DEC R0                 ; R0 <- R0-1
0412  52          STR R2                 ; M(R2) <- D
0413  20          DEC R0                 ; R0 <- R0-1
0414  43          LDA R3                 ; D <- M(R3); R3++
0415  20          DEC R0                 ; R0 <- R0-1
0416  4D          LDA RD                 ; D <- M(RD); RD++
0417  20          DEC R0                 ; R0 <- R0-1
0418  39 20       BNQ  00420H            ; Branch if Q=0
041A  2A          DEC RA                 ; RA <- RA-1
041B  20          DEC R0                 ; R0 <- R0-1
041C  00          IDL                    ; Idle / wait DMA or interrupt
041D  20          DEC R0                 ; R0 <- R0-1
041E  20          DEC R0                 ; R0 <- R0-1
041F  20          DEC R0                 ; R0 <- R0-1
0420  41          LDA R1                 ; D <- M(R1); R1++
0421  20          DEC R0                 ; R0 <- R0-1
0422  30 2D       BR  0042DH             ; Branch unconditional
0424  1A          INC RA                 ; RA <- RA+1
0425  37 2A       B4  0042AH             ; Branch if EF4=1

; --- filler region: 5 x 0x20 ---
0427              .DS  5, 020H

042C  31 20       BQ  00420H             ; Branch if Q=1
042E  52          STR R2                 ; M(R2) <- D
042F  20          DEC R0                 ; R0 <- R0-1
0430  32 38       BZ  00438H             ; Branch if D=0
0432  2A          DEC RA                 ; RA <- RA-1
0433  20          DEC R0                 ; R0 <- R0-1
0434  20          DEC R0                 ; R0 <- R0-1
0435  20          DEC R0                 ; R0 <- R0-1
0436  54          STR R4                 ; M(R4) <- D
0437  57          STR R7                 ; M(R7) <- D
0438  31 20       BQ  00420H             ; Branch if Q=1
043A  30 2D       BR  0042DH             ; Branch unconditional
043C  39 20       BNQ  00420H            ; Branch if Q=0
043E  2A          DEC RA                 ; RA <- RA-1
043F  20          DEC R0                 ; R0 <- R0-1
0440  20          DEC R0                 ; R0 <- R0-1
0441  20          DEC R0                 ; R0 <- R0-1
0442  45          LDA R5                 ; D <- M(R5); R5++
0443  49          LDA R9                 ; D <- M(R9); R9++
0444  20          DEC R0                 ; R0 <- R0-1
0445  20          DEC R0                 ; R0 <- R0-1
0446  39 20       BNQ  00420H            ; Branch if Q=0
0448  20          DEC R0                 ; R0 <- R0-1
0449  30 2A       BR  0042AH             ; Branch unconditional
044B  20          DEC R0                 ; R0 <- R0-1
044C  20          DEC R0                 ; R0 <- R0-1
044D  20          DEC R0                 ; R0 <- R0-1
044E  53          STR R3                 ; M(R3) <- D
044F  53          STR R3                 ; M(R3) <- D

; --- filler region: 5 x 0x20 ---
0450              .DS  5, 020H

0455  39 2A       BNQ  0042AH            ; Branch if Q=0
0457  20          DEC R0                 ; R0 <- R0-1
0458  20          DEC R0                 ; R0 <- R0-1
0459  20          DEC R0                 ; R0 <- R0-1
045A  54          STR R4                 ; M(R4) <- D
045B  43          LDA R3                 ; D <- M(R3); R3++
045C  20          DEC R0                 ; R0 <- R0-1
045D  20          DEC R0                 ; R0 <- R0-1
045E  32 20       BZ  00420H             ; Branch if D=0
0460  20          DEC R0                 ; R0 <- R0-1
0461  3A 2A       BNZ  0042AH            ; Branch if D!=0

; --- filler region: 4 x 0x20 ---
0463              .DS  4, 020H

0467  4F          LDA RF                 ; D <- M(RF); RF++
0468  20          DEC R0                 ; R0 <- R0-1
0469  20          DEC R0                 ; R0 <- R0-1
046A  33 20       BDF  00420H            ; Branch if DF=1
046C  20          DEC R0                 ; R0 <- R0-1
046D  35 2A       B2  0042AH             ; Branch if EF2=1

; --- filler region: 4 x 0x20 ---
046F              .DS  4, 020H

0473  4E          LDA RE                 ; D <- M(RE); RE++

; --- filler region: 5 x 0x20 ---
0474              .DS  5, 020H

0479  36 2A       B3  0042AH             ; Branch if EF3=1
047B  20          DEC R0                 ; R0 <- R0-1
047C  20          DEC R0                 ; R0 <- R0-1
047D  20          DEC R0                 ; R0 <- R0-1
047E  50          STR R0                 ; M(R0) <- D
047F  53          STR R3                 ; M(R3) <- D
0480  50          STR R0                 ; M(R0) <- D
0481  20          DEC R0                 ; R0 <- R0-1
0482  4D          LDA RD                 ; D <- M(RD); RD++
0483  20          DEC R0                 ; R0 <- R0-1
0484  20          DEC R0                 ; R0 <- R0-1
0485  3A 2A       BNZ  0042AH            ; Branch if D!=0
0487  20          DEC R0                 ; R0 <- R0-1
0488  20          DEC R0                 ; R0 <- R0-1
0489  20          DEC R0                 ; R0 <- R0-1
048A  41          LDA R1                 ; D <- M(R1); R1++
048B  49          LDA R9                 ; D <- M(R9); R9++
048C  49          LDA R9                 ; D <- M(R9); R9++
048D  20          DEC R0                 ; R0 <- R0-1
048E  41          LDA R1                 ; D <- M(R1); R1++
048F  20          DEC R0                 ; R0 <- R0-1
0490  20          DEC R0                 ; R0 <- R0-1
0491  34 2A       B1  0042AH             ; Branch if EF1=1
0493  20          DEC R0                 ; R0 <- R0-1
0494  20          DEC R0                 ; R0 <- R0-1
0495  20          DEC R0                 ; R0 <- R0-1
0496  54          STR R4                 ; M(R4) <- D
0497  4E          LDA RE                 ; D <- M(RE); RE++
0498  44          LDA R4                 ; D <- M(R4); R4++
0499  20          DEC R0                 ; R0 <- R0-1
049A  59          STR R9                 ; M(R9) <- D
049B  20          DEC R0                 ; R0 <- R0-1
049C  20          DEC R0                 ; R0 <- R0-1
049D  31 2A       BQ  0042AH             ; Branch if Q=1
049F  20          DEC R0                 ; R0 <- R0-1
04A0  20          DEC R0                 ; R0 <- R0-1
04A1  20          DEC R0                 ; R0 <- R0-1
04A2  54          STR R4                 ; M(R4) <- D
04A3  20          DEC R0                 ; R0 <- R0-1
04A4  3A 20       BNZ  00420H            ; Branch if D!=0

; --- filler region: 4 x 0x20 ---
04A6              .DS  4, 020H

04AA  2A          DEC RA                 ; RA <- RA-1
04AB  20          DEC R0                 ; R0 <- R0-1
04AC  20          DEC R0                 ; R0 <- R0-1
04AD  20          DEC R0                 ; R0 <- R0-1
04AE  45          LDA R5                 ; D <- M(R5); R5++
04AF  20          DEC R0                 ; R0 <- R0-1
04B0  20          DEC R0                 ; R0 <- R0-1
04B1  20          DEC R0                 ; R0 <- R0-1
04B2  37 20       B4  00420H             ; Branch if EF4=1
04B4  20          DEC R0                 ; R0 <- R0-1
04B5  20          DEC R0                 ; R0 <- R0-1
04B6  2A          DEC RA                 ; RA <- RA-1
04B7  20          DEC R0                 ; R0 <- R0-1
04B8  20          DEC R0                 ; R0 <- R0-1
04B9  20          DEC R0                 ; R0 <- R0-1
04BA  52          STR R2                 ; M(R2) <- D
04BB  20          DEC R0                 ; R0 <- R0-1
04BC  30 20       BR  00420H             ; Branch unconditional
04BE  38 20       SKP  ; (skips 1 byte)  ; Skip next byte
04C0  20          DEC R0                 ; R0 <- R0-1
04C1  20          DEC R0                 ; R0 <- R0-1
04C2  2A          DEC RA                 ; RA <- RA-1
04C3  20          DEC R0                 ; R0 <- R0-1
04C4  20          DEC R0                 ; R0 <- R0-1
04C5  20          DEC R0                 ; R0 <- R0-1
04C6  4E          LDA RE                 ; D <- M(RE); RE++
04C7  35 38       B2  00438H             ; Branch if EF2=1

; --- filler region: 5 x 0x20 ---
04C9              .DS  5, 020H

04CE  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 4 x 0x20 ---
04CF              .DS  4, 020H

04D3  33 31       BDF  00431H            ; Branch if DF=1
04D5  20          DEC R0                 ; R0 <- R0-1
04D6  30 20       BR  00420H             ; Branch unconditional
04D8  20          DEC R0                 ; R0 <- R0-1
04D9  20          DEC R0                 ; R0 <- R0-1
04DA  2A          DEC RA                 ; RA <- RA-1
04DB  20          DEC R0                 ; R0 <- R0-1
04DC  20          DEC R0                 ; R0 <- R0-1
04DD  20          DEC R0                 ; R0 <- R0-1
04DE  2A          DEC RA                 ; RA <- RA-1
04DF  35 34       B2  00434H             ; Branch if EF2=1
04E1  53          STR R3                 ; M(R3) <- D
04E2  39 20       BNQ  00420H            ; Branch if Q=0
04E4  20          DEC R0                 ; R0 <- R0-1
04E5  20          DEC R0                 ; R0 <- R0-1
04E6  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 4 x 0x20 ---
04E7              .DS  4, 020H

04EB  36 33       B3  00433H             ; Branch if EF3=1
04ED  54          STR R4                 ; M(R4) <- D
04EE  3A 20       BNZ  00420H            ; Branch if D!=0
04F0  20          DEC R0                 ; R0 <- R0-1
04F1  20          DEC R0                 ; R0 <- R0-1
04F2  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 4 x 0x20 ---
04F3              .DS  4, 020H

04F7  33 32       BDF  00432H            ; Branch if DF=1
04F9  41          LDA R1                 ; D <- M(R1); R1++
04FA  35 20       B2  00420H             ; Branch if EF2=1
04FC  20          DEC R0                 ; R0 <- R0-1
04FD  20          DEC R0                 ; R0 <- R0-1
04FE  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 5 x 0x20 ---
04FF              .DS  5, 020H

0504  32 54       BZ  00554H             ; Branch if D=0
0506  36 20       B3  00520H             ; Branch if EF3=1
0508  20          DEC R0                 ; R0 <- R0-1
0509  20          DEC R0                 ; R0 <- R0-1
050A  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 5 x 0x20 ---
050B              .DS  5, 020H

0510  30 2F       BR  0052FH             ; Branch unconditional
0512  3A 20       BNZ  00520H            ; Branch if D!=0
0514  20          DEC R0                 ; R0 <- R0-1
0515  20          DEC R0                 ; R0 <- R0-1
0516  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 4 x 0x20 ---
0517              .DS  4, 020H

051B  2A          DEC RA                 ; RA <- RA-1
051C  36 50       B3  00550H             ; Branch if EF3=1
051E  34 20       B1  00520H             ; Branch if EF1=1
0520  20          DEC R0                 ; R0 <- R0-1
0521  20          DEC R0                 ; R0 <- R0-1
0522  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 6 x 0x20 ---
0523              .DS  6, 020H

0529  52          STR R2                 ; M(R2) <- D
052A  31 20       BQ  00520H             ; Branch if Q=1
052C  20          DEC R0                 ; R0 <- R0-1
052D  20          DEC R0                 ; R0 <- R0-1
052E  2A          DEC RA                 ; RA <- RA-1

; --- filler region: 4 x 0x20 ---
052F              .DS  4, 020H

0533  50          STR R0                 ; M(R0) <- D
0534  20          DEC R0                 ; R0 <- R0-1
0535  45          LDA R5                 ; D <- M(R5); R5++

; --- filler region: 9 x 0x20 ---
0536              .DS  9, 020H

053F  41          LDA R1                 ; D <- M(R1); R1++
0540  4F          LDA RF                 ; D <- M(RF); RF++
0541  2D          DEC RD                 ; RD <- RD-1

; --- filler region: 9 x 0x20 ---
0542              .DS  9, 020H

054B  47          LDA R7                 ; D <- M(R7); R7++
054C  46          LDA R6                 ; D <- M(R6); R6++
054D  4F          LDA RF                 ; D <- M(RF); RF++

; --- filler region: 9 x 0x20 ---
054E              .DS  9, 020H

0557  45          LDA R5                 ; D <- M(R5); R5++
0558  20          DEC R0                 ; R0 <- R0-1
0559  50          STR R0                 ; M(R0) <- D

; --- filler region: 10 x 0x20 ---
055A              .DS  10, 020H

0564  31 20       BQ  00520H             ; Branch if Q=1

; --- filler region: 9 x 0x20 ---
0566              .DS  9, 020H

056F  31 20       BQ  00520H             ; Branch if Q=1

; --- filler region: 46 x 0x20 ---
0571              .DS  46, 020H


; --- filler region: 609 x 0xFF ---
059F              .DS  609, 0FFH   ; [unprogrammed EPROM]


; --- end of disassembly ---
