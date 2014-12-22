; r1 = camera x + offset (288 right or 48 left)
; r2 = camera y - 32
; r3 = camera y + offset (272 down or 32 up)
; r4 = camera x - 48
0009:8000 02           cache
0009:8001 B1 96        asr              ;\
0009:8003 96           asr              ; |
0009:8004 96           asr              ; |
0009:8005 11 96        asr              ; |
0009:8007 B2 96        asr              ; |
0009:8009 96           asr              ; |
0009:800A 96           asr              ; |
0009:800B 12 96        asr              ; | divide camera positions by 16
0009:800D B3 96        asr              ; |
0009:800F 96           asr              ; |
0009:8010 96           asr              ; |
0009:8011 13 96        asr              ; |
0009:8013 B4 96        asr              ; |
0009:8015 96           asr              ; |
0009:8016 96           asr              ; |
0009:8017 14 96        asr              ;/
0009:8019 A5 FF        ibt   r5,#FFFF   ;
0009:801B F6 FF 01     iwt   r6,#01FF   ;
0009:801E A7 16        ibt   r7,#0016   ;
0009:8020 AD 14        ibt   r13,#0014  ;
0009:8022 A8 00        ibt   r8,#0000   ;
0009:8024 F9 CA 28     iwt   r9,#28CA   ;
0009:8027 FA CE 27     iwt   r10,#27CE  ; #$27CE into r10 (first word is sprite ID)
0009:802A 3D F0 02 26  lm    r0,(2602)  ;\ set the value in $702602 as the ROM data bank
0009:802E 3F DF        romb             ;/
0009:8030 3D FE 00 26  lm    r14,(2600) ; r14 = ROM address

; loop begins here
0009:8034 3D 49        ldb   (r9)       ;\
0009:8036 E0           dec   r0         ; |
0009:8037 0B 08        bmi   8041       ; |
0009:8039 EF           getb             ; | loop until <= 0
0009:803A 2E 3E 53     add   #03        ; | in 7028CA table
0009:803D D8           inc   r8         ; |
0009:803E 05 F4        bra   8034       ; |

0009:8040 D9           inc   r9         ;/

0009:8041 DE           inc   r14
0009:8042 1C 3D EF     getbh            ;
0009:8045 BC 65        sub   r5         ; r12 - r5 -> r0
0009:8047 09 37        beq   8080       ;
0009:8049 DE           inc   r14        ;
0009:804A BC 76        and   r6         ;\ sprite ID -> $7027CE
0009:804C 3A           stw   (r10)      ;/
0009:804D 1B EF        getb             ; r11 = passed in table,x
0009:804F DE           inc   r14        ; inc r14
0009:8050 BC C0        hib              ; load high byte of r12 to r0
0009:8052 03           lsr              ; multiply r0 by 2
0009:8053 20 1C        move  r12,r0     ; move r0 into r12
0009:8055 63           sub   r3         ; r0 - ((camera y + offset)/16) -> r0
0009:8056 08 08        bne   8060       ;\
0009:8058 BB 64        sub   r4         ;/ r11 - ((camera x - 48)/16) -> r0
0009:805A 0B 03        bmi   805F       ;\
0009:805C 67           sub   r7         ;/ r0 - r7 -> r0
0009:805D 0B 0C        bmi   806B       ;\
0009:805F BB 61        sub   r1         ;/ r11 - ((camera x + offset)/16) -> r0
0009:8061 08 19        bne   807C       ;\
0009:8063 BC 62        sub   r2         ;/ r12 - ((camera y - 32)/16) -> r0
0009:8065 0B 15        bmi   807C       ;\
0009:8067 6D           sub   r13        ;/ r0 - r13 -> r0
0009:8068 0A 12        bpl   807C       ;\
0009:806A 01           nop              ;/
0009:806B DA           inc   r10        ;\ \
0009:806C DA           inc   r10        ; | | x tile position -> $7027D0
0009:806D BB 3A        stw   (r10)      ; |/
0009:806F DA           inc   r10        ; |\
0009:8070 DA           inc   r10        ; | | y tile position -> $7027D2
0009:8071 BC 3A        stw   (r10)      ; |/
0009:8073 DA           inc   r10        ; |\
0009:8074 DA           inc   r10        ; | | y tile position -> $7027D4
0009:8075 B8 3A        stw   (r10)      ; |/
0009:8077 DA           inc   r10        ; |\
0009:8078 DA           inc   r10        ; | | r5 -> $7028CA + r8
0009:8079 B5 3D 39     stb   (r9)       ;/ /
0009:807C D8           inc   r8         ;
0009:807D 05 B5        bra   8034       ;\ loop back up

0009:807F D9           inc   r9         ;/

0009:8080 B5 3A        stw   (r10)      ; r5 -> r10
0009:8082 00           stop
0009:8083 01           nop

0009:8084 F1 E2 10     iwt   r1,#10E2
0009:8087 F2 82 11     iwt   r2,#1182
0009:808A F3 56 1B     iwt   r3,#1B56
0009:808D F4 00 0F     iwt   r4,#0F00
0009:8090 F5 D6 1C     iwt   r5,#1CD6
0009:8093 02           cache
0009:8094 AC 18        ibt   r12,#0018
0009:8096 2F 1D        move  r13,r15
0009:8098 3D 44        ldb   (r4)
0009:809A 24 3E 54     add   #04
0009:809D E0           dec   r0
0009:809E 0A 14        bpl   80B4
0009:80A0 D0           inc   r0
0009:80A1 2C 16        move  r6,r12
0009:80A3 3D 36        stb   (r6)
0009:80A5 A0 04        ibt   r0,#0004
0009:80A7 21 50        add   r0
0009:80A9 22 50        add   r0
0009:80AB 23 50        add   r0
0009:80AD 25 50        add   r0
0009:80AF 3C           loop
0009:80B0 01           nop
0009:80B1 05 24        bra   80D7

0009:80B3 01           nop

0009:80B4 3E 6E        sub   #0E
0009:80B6 0D 02        bcs   80BA
0009:80B8 D0           inc   r0
0009:80B9 60           sub   r0
0009:80BA 2C 16        move  r6,r12
0009:80BC 3D 36        stb   (r6)
0009:80BE 16 41        ldw   (r1)
0009:80C0 21 3E 54     add   #04
0009:80C3 43           ldw   (r3)
0009:80C4 D3           inc   r3
0009:80C5 D3           inc   r3
0009:80C6 56           add   r6
0009:80C7 35           stw   (r5)
0009:80C8 D5           inc   r5
0009:80C9 D5           inc   r5
0009:80CA 16 42        ldw   (r2)
0009:80CC 22 3E 54     add   #04
0009:80CF 43           ldw   (r3)
0009:80D0 D3           inc   r3
0009:80D1 D3           inc   r3
0009:80D2 56           add   r6
0009:80D3 35           stw   (r5)
0009:80D4 D5           inc   r5
0009:80D5 3C           loop
0009:80D6 D5           inc   r5
0009:80D7 3D AE 8E     lms   r14,(011C)
0009:80DA 3D A2 8F     lms   r2,(011E)
0009:80DD 3D A3 90     lms   r3,(0120)
0009:80E0 3D A4 91     lms   r4,(0122)
0009:80E3 F5 D6 1C     iwt   r5,#1CD6
0009:80E6 F6 B6 1B     iwt   r6,#1BB6
0009:80E9 F7 16 1C     iwt   r7,#1C16
0009:80EC F8 C2 17     iwt   r8,#17C2
0009:80EF F0 36 1D     iwt   r0,#1D36
0009:80F2 3E A0 1F     sms   (003E),r0
0009:80F5 AC 18        ibt   r12,#0018
0009:80F7 2F 1D        move  r13,r15
0009:80F9 2C 10        move  r0,r12
0009:80FB 3D 40        ldb   (r0)
0009:80FD 3E 63        sub   #03
0009:80FF 0D 0D        bcs   810E
0009:8101 01           nop
0009:8102 A0 04        ibt   r0,#0004
0009:8104 25 50        add   r0
0009:8106 26 50        add   r0
0009:8108 27 50        add   r0
0009:810A D8           inc   r8
0009:810B 05 4E        bra   815B

0009:810D D8           inc   r8

0009:810E 19 46        ldw   (r6)
0009:8110 D6           inc   r6
0009:8111 D6           inc   r6
0009:8112 1A 46        ldw   (r6)
0009:8114 D6           inc   r6
0009:8115 D6           inc   r6
0009:8116 45           ldw   (r5)
0009:8117 D5           inc   r5
0009:8118 D5           inc   r5
0009:8119 6E           sub   r14
0009:811A 37           stw   (r7)
0009:811B D7           inc   r7
0009:811C D7           inc   r7
0009:811D 2B B0        moves r11,r0
0009:811F 0A 03        bpl   8124
0009:8121 60           sub   r0
0009:8122 D0           inc   r0
0009:8123 D0           inc   r0
0009:8124 3D 38        stb   (r8)
0009:8126 D8           inc   r8
0009:8127 45           ldw   (r5)
0009:8128 D5           inc   r5
0009:8129 D5           inc   r5
0009:812A 62           sub   r2
0009:812B 37           stw   (r7)
0009:812C D7           inc   r7
0009:812D D7           inc   r7
0009:812E 21 B0        moves r1,r0
0009:8130 0A 03        bpl   8135
0009:8132 60           sub   r0
0009:8133 D0           inc   r0
0009:8134 D0           inc   r0
0009:8135 3D 38        stb   (r8)
0009:8137 B1 5A        add   r10
0009:8139 54           add   r4
0009:813A 0B 1F        bmi   815B
0009:813C D8           inc   r8
0009:813D 6A           sub   r10
0009:813E 6A           sub   r10
0009:813F 64           sub   r4
0009:8140 64           sub   r4
0009:8141 0A 19        bpl   815C
0009:8143 60           sub   r0
0009:8144 BB 59        add   r9
0009:8146 53           add   r3
0009:8147 0B 12        bmi   815B
0009:8149 69           sub   r9
0009:814A 69           sub   r9
0009:814B 63           sub   r3
0009:814C 63           sub   r3
0009:814D 0A 0D        bpl   815C
0009:814F 60           sub   r0
0009:8150 3D A0 56     lms   r0,(00AC)
0009:8153 3E 66        sub   #06
0009:8155 0D 05        bcs   815C
0009:8157 60           sub   r0
0009:8158 05 02        bra   815C

0009:815A E0           dec   r0

0009:815B 60           sub   r0
0009:815C 3D A1 1F     lms   r1,(003E)
0009:815F 3D 31        stb   (r1)
0009:8161 D8           inc   r8
0009:8162 21 3E 54     add   #04
0009:8165 3E A1 1F     sms   (003E),r1
0009:8168 3C           loop
0009:8169 D8           inc   r8
0009:816A F1 A1 0F     iwt   r1,#0FA1
0009:816D F5 D6 1C     iwt   r5,#1CD6
0009:8170 F6 B6 1B     iwt   r6,#1BB6
0009:8173 F7 76 1C     iwt   r7,#1C76
0009:8176 F9 36 1D     iwt   r9,#1D36
0009:8179 FA 37 1D     iwt   r10,#1D37
0009:817C AC 18        ibt   r12,#0018
0009:817E 2C 10        move  r0,r12
0009:8180 3D 40        ldb   (r0)
0009:8182 E0           dec   r0
0009:8183 0B 0E        bmi   8193
0009:8185 01           nop
0009:8186 3D 49        ldb   (r9)
0009:8188 3E 60        sub   #00
0009:818A 08 07        bne   8193
0009:818C 01           nop
0009:818D 41           ldw   (r1)
0009:818E 3E 74        and   #04
0009:8190 08 0D        bne   819F
0009:8192 01           nop
0009:8193 A0 04        ibt   r0,#0004
0009:8195 25 50        add   r0
0009:8197 26 50        add   r0
0009:8199 27 50        add   r0
0009:819B FF 63 82     iwt   r15,#8263
0009:819E 01           nop
0009:819F 1E 45        ldw   (r5)
0009:81A1 D5           inc   r5
0009:81A2 D5           inc   r5
0009:81A3 12 45        ldw   (r5)
0009:81A5 D5           inc   r5
0009:81A6 D5           inc   r5
0009:81A7 13 46        ldw   (r6)
0009:81A9 D6           inc   r6
0009:81AA D6           inc   r6
0009:81AB 14 46        ldw   (r6)
0009:81AD D6           inc   r6
0009:81AE D6           inc   r6
0009:81AF 3E A1 21     sms   (0042),r1
0009:81B2 3E A5 25     sms   (004A),r5
0009:81B5 3E A6 26     sms   (004C),r6
0009:81B8 3E A7 27     sms   (004E),r7
0009:81BB 3E A9 29     sms   (0052),r9
0009:81BE 3E AA 2A     sms   (0054),r10
0009:81C1 3E AC 2C     sms   (0058),r12
0009:81C4 F1 A1 0F     iwt   r1,#0FA1
0009:81C7 1B 3D 4A     ldb   (r10)
0009:81CA DB           inc   r11
0009:81CB 2C 1A        move  r10,r12
0009:81CD AC 18        ibt   r12,#0018
0009:81CF FD D3 81     iwt   r13,#81D3
0009:81D2 BA 6B        sub   r11
0009:81D4 09 6B        beq   8241
0009:81D6 01           nop
0009:81D7 3D 4B        ldb   (r11)
0009:81D9 E0           dec   r0
0009:81DA 0B 65        bmi   8241
0009:81DC 01           nop
0009:81DD A0 18        ibt   r0,#0018
0009:81DF 6B           sub   r11
0009:81E0 50           add   r0
0009:81E1 50           add   r0
0009:81E2 20 18        move  r8,r0
0009:81E4 51           add   r1
0009:81E5 40           ldw   (r0)
0009:81E6 3E 72        and   #02
0009:81E8 09 57        beq   8241
0009:81EA 01           nop
0009:81EB F0 D6 1C     iwt   r0,#1CD6
0009:81EE 15 58        add   r8
0009:81F0 F0 B6 1B     iwt   r0,#1BB6
0009:81F3 16 58        add   r8
0009:81F5 19 46        ldw   (r6)
0009:81F7 45           ldw   (r5)
0009:81F8 6E           sub   r14
0009:81F9 20 17        move  r7,r0
0009:81FB 53           add   r3
0009:81FC 59           add   r9
0009:81FD 0B 42        bmi   8241
0009:81FF 69           sub   r9
0009:8200 69           sub   r9
0009:8201 63           sub   r3
0009:8202 63           sub   r3
0009:8203 E0           dec   r0
0009:8204 0A 3B        bpl   8241
0009:8206 D5           inc   r5
0009:8207 D5           inc   r5
0009:8208 D6           inc   r6
0009:8209 D6           inc   r6
0009:820A 19 46        ldw   (r6)
0009:820C 45           ldw   (r5)
0009:820D 62           sub   r2
0009:820E 20 15        move  r5,r0
0009:8210 54           add   r4
0009:8211 59           add   r9
0009:8212 0B 2D        bmi   8241
0009:8214 69           sub   r9
0009:8215 69           sub   r9
0009:8216 64           sub   r4
0009:8217 64           sub   r4
0009:8218 E0           dec   r0
0009:8219 0A 26        bpl   8241
0009:821B 01           nop
0009:821C 3D A0 27     lms   r0,(004E)
0009:821F B7 30        stw   (r0)
0009:8221 D0           inc   r0
0009:8222 D0           inc   r0
0009:8223 B5 30        stw   (r0)
0009:8225 17 3E 52     add   #02
0009:8228 3D A9 29     lms   r9,(0052)
0009:822B D8           inc   r8
0009:822C B8 3D 39     stb   (r9)
0009:822F EB           dec   r11
0009:8230 08 03        bne   8235
0009:8232 EB           dec   r11
0009:8233 AB 17        ibt   r11,#0017
0009:8235 3D AA 2A     lms   r10,(0054)
0009:8238 2B 10        move  r0,r11
0009:823A 3D 3A        stb   (r10)
0009:823C 05 18        bra   8256

0009:823E 3D A1 21     lms   r1,(0042)
0009:8241 EB           dec   r11
0009:8242 08 03        bne   8247
0009:8244 01           nop
0009:8245 AB 18        ibt   r11,#0018
0009:8247 3C           loop
0009:8248 BA 3D A0 27  lms   r0,(004E)
0009:824C 17 3E 54     add   #04
0009:824F 3D A9 29     lms   r9,(0052)
0009:8252 3D AA 2A     lms   r10,(0054)
0009:8255 3D A1 21     lms   r1,(0042)
0009:8258 3D A5 25     lms   r5,(004A)
0009:825B 3D A6 26     lms   r6,(004C)
0009:825E 3D AC 2C     lms   r12,(0058)
0009:8261 A0 04        ibt   r0,#0004
0009:8263 21 50        add   r0
0009:8265 29 50        add   r0
0009:8267 2A 50        add   r0
0009:8269 FD 7F 81     iwt   r13,#817F
0009:826C 3C           loop
0009:826D 2C 10        move  r0,r12
0009:826F 3D A0 D7     lms   r0,(01AE)
0009:8272 3E 60        sub   #00
0009:8274 08 63        bne   82D9
0009:8276 02           cache
0009:8277 3D A1 AD     lms   r1,(015A)
0009:827A 3D A2 AE     lms   r2,(015C)
0009:827D F5 D6 1C     iwt   r5,#1CD6
0009:8280 F6 B6 1B     iwt   r6,#1BB6
0009:8283 F7 A0 0F     iwt   r7,#0FA0
0009:8286 F8 40 10     iwt   r8,#1040
0009:8289 FB 38 1D     iwt   r11,#1D38
0009:828C AE 40        ibt   r14,#0040
0009:828E AC 18        ibt   r12,#0018
0009:8290 FD 94 82     iwt   r13,#8294
0009:8293 2C 10        move  r0,r12
0009:8295 3D 40        ldb   (r0)
0009:8297 3E 63        sub   #03
0009:8299 0C 06        bcc   82A1
0009:829B 01           nop
0009:829C 47           ldw   (r7)
0009:829D 7E           and   r14
0009:829E 09 09        beq   82A9
0009:82A0 01           nop
0009:82A1 A0 04        ibt   r0,#0004
0009:82A3 25 50        add   r0
0009:82A5 26           with  r6
0009:82A6 05 28        bra   82D0

0009:82A8 50           add   r0
0009:82A9 4B           ldw   (r11)
0009:82AA 03           lsr
0009:82AB 08 F4        bne   82A1
0009:82AD 19 46        ldw   (r6)
0009:82AF D6           inc   r6
0009:82B0 D6           inc   r6
0009:82B1 1A 46        ldw   (r6)
0009:82B3 D6           inc   r6
0009:82B4 D6           inc   r6
0009:82B5 45           ldw   (r5)
0009:82B6 D5           inc   r5
0009:82B7 D5           inc   r5
0009:82B8 13 61        sub   r1
0009:82BA 45           ldw   (r5)
0009:82BB D5           inc   r5
0009:82BC D5           inc   r5
0009:82BD 14 62        sub   r2
0009:82BF B4 5A        add   r10
0009:82C1 3E 5C        add   #0C
0009:82C3 0B 09        bmi   82CE
0009:82C5 6A           sub   r10
0009:82C6 6A           sub   r10
0009:82C7 3E 6C        sub   #0C
0009:82C9 3E 6C        sub   #0C
0009:82CB 0B 0E        bmi   82DB
0009:82CD B3 A0 04     ibt   r0,#0004
0009:82D0 27 50        add   r0
0009:82D2 28 50        add   r0
0009:82D4 2B 50        add   r0
0009:82D6 3C           loop
0009:82D7 2C 10        move  r0,r12
0009:82D9 00           stop
0009:82DA 01           nop

0009:82DB 59           add   r9
0009:82DC 3E 5C        add   #0C
0009:82DE 0B EE        bmi   82CE
0009:82E0 69           sub   r9
0009:82E1 69           sub   r9
0009:82E2 3E 6C        sub   #0C
0009:82E4 3E 6C        sub   #0C
0009:82E6 0A E7        bpl   82CF
0009:82E8 A0 18        ibt   r0,#0018
0009:82EA 6C           sub   r12
0009:82EB 50           add   r0
0009:82EC 11 50        add   r0
0009:82EE D1           inc   r1
0009:82EF 3D A0 B1     lms   r0,(0162)
0009:82F2 3D A5 B4     lms   r5,(0168)
0009:82F5 C5           or    r5
0009:82F6 08 E1        bne   82D9
0009:82F8 01           nop
0009:82F9 3D A6 A8     lms   r6,(0150)
0009:82FC E6           dec   r6
0009:82FD 0B DA        bmi   82D9
0009:82FF D6           inc   r6
0009:8300 3D A0 AF     lms   r0,(015E)
0009:8303 E0           dec   r0
0009:8304 0A 57        bpl   835D
0009:8306 01           nop
0009:8307 F0 FF 0E     iwt   r0,#0EFF
0009:830A 15 51        add   r1
0009:830C 3D A0 A9     lms   r0,(0152)
0009:830F 3D A2 AA     lms   r2,(0154)
0009:8312 C2           or    r2
0009:8313 09 48        beq   835D
0009:8315 01           nop
0009:8316 B6 03        lsr
0009:8318 0C 04        bcc   831E
0009:831A D6           inc   r6
0009:831B 3E A6 A8     sms   (0150),r6
0009:831E 3E A1 B1     sms   (0162),r1
0009:8321 47           ldw   (r7)
0009:8322 95           sex
0009:8323 0A 11        bpl   8336
0009:8325 60           sub   r0
0009:8326 D0           inc   r0
0009:8327 3E A0 AF     sms   (015E),r0
0009:832A A0 14        ibt   r0,#0014
0009:832C 3E A0 B0     sms   (0160),r0
0009:832F A0 3C        ibt   r0,#003C
0009:8331 3E A0 3D     sms   (007A),r0
0009:8334 00           stop
0009:8335 01           nop

0009:8336 3E A3 B2     sms   (0164),r3
0009:8339 3E A4 B3     sms   (0166),r4
0009:833C A0 08        ibt   r0,#0008
0009:833E 35           stw   (r5)
0009:833F D7           inc   r7
0009:8340 D7           inc   r7
0009:8341 47           ldw   (r7)
0009:8342 50           add   r0
0009:8343 0D 18        bcs   835D
0009:8345 50           add   r0
0009:8346 50           add   r0
0009:8347 F2 00 80     iwt   r2,#8000
0009:834A 72           and   r2
0009:834B C1           or    r1
0009:834C 3E A0 B4     sms   (0168),r0
0009:834F 48           ldw   (r8)
0009:8350 3F 7C        bic   #0C
0009:8352 90           sbk
0009:8353 4D           swap
0009:8354 0B 04        bmi   835A
0009:8356 60           sub   r0
0009:8357 F0 B0 04     iwt   r0,#04B0
0009:835A 3E A0 F7     sms   (01EE),r0
0009:835D 00           stop
0009:835E 01           nop

; copy yoshi to OAM buff
0009:835F A0 4C        ibt   r0,#004C
0009:8361 3F DF        romb
0009:8363 2E 1E        move  r14,r14
0009:8365 3D A4 93     lms   r4,(0126)
0009:8368 3D A5 8C     lms   r5,(0118)
0009:836B A0 60        ibt   r0,#0060
0009:836D 15 55        add   r5
0009:836F F9 28 01     iwt   r9,#0128
0009:8372 A7 00        ibt   r7,#0000
0009:8374 02           cache
0009:8375 2F 1D        move  r13,r15
0009:8377 16 EF        getb
0009:8379 DE           inc   r14
0009:837A B6 03        lsr
0009:837C 03           lsr
0009:837D 03           lsr
0009:837E 03           lsr
0009:837F 1B 3E 72     and   #02
0009:8382 EF           getb
0009:8383 DE           inc   r14
0009:8384 95           sex
0009:8385 A8 00        ibt   r8,#0000
0009:8387 E3           dec   r3
0009:8388 0A 0B        bpl   8395
0009:838A D3           inc   r3
0009:838B 4F           not
0009:838C D0           inc   r0
0009:838D A8 40        ibt   r8,#0040
0009:838F EB           dec   r11
0009:8390 0A 03        bpl   8395
0009:8392 DB           inc   r11
0009:8393 3E 58        add   #08
0009:8395 51           add   r1
0009:8396 35           stw   (r5)
0009:8397 D5           inc   r5
0009:8398 D5           inc   r5
0009:8399 EF           getb
0009:839A DE           inc   r14
0009:839B 95           sex
0009:839C 52           add   r2
0009:839D 35           stw   (r5)
0009:839E D5           inc   r5
0009:839F D5           inc   r5
0009:83A0 F0 C0 00     iwt   r0,#00C0
0009:83A3 76           and   r6
0009:83A4 3D C8        xor   r8
0009:83A6 C4           or    r4
0009:83A7 3D AA 92     lms   r10,(0124)
0009:83AA CA           or    r10
0009:83AB 4D           swap
0009:83AC C7           or    r7
0009:83AD D7           inc   r7
0009:83AE D7           inc   r7
0009:83AF 35           stw   (r5)
0009:83B0 D5           inc   r5
0009:83B1 D5           inc   r5
0009:83B2 BB 35        stw   (r5)
0009:83B4 D5           inc   r5
0009:83B5 D5           inc   r5
0009:83B6 B6 3E 7F     and   #0F
0009:83B9 4D           swap
0009:83BA 3E EF        getbl
0009:83BC DE           inc   r14
0009:83BD 2B 3E 72     and   #02
0009:83C0 09 18        beq   83DA
0009:83C2 01           nop
0009:83C3 FA 90 00     iwt   r10,#0090
0009:83C6 3F 6A        cmp   r10
0009:83C8 0D 10        bcs   83DA
0009:83CA 01           nop
0009:83CB 3D AA B4     lms   r10,(0168)
0009:83CE 3D AB B1     lms   r11,(0162)
0009:83D1 2A CB        or    r11
0009:83D3 08 05        bne   83DA
0009:83D5 01           nop
0009:83D6 FA 00 01     iwt   r10,#0100
0009:83D9 5A           add   r10
0009:83DA FA FF 07     iwt   r10,#07FF
0009:83DD 7A           and   r10
0009:83DE 26 3E 78     and   #08
0009:83E1 A6 52        ibt   r6,#0052
0009:83E3 09 07        beq   83EC
0009:83E5 01           nop
0009:83E6 F6 00 83     iwt   r6,#8300
0009:83E9 56           add   r6
0009:83EA A6 70        ibt   r6,#0070
0009:83EC 50           add   r0
0009:83ED 50           add   r0
0009:83EE 50           add   r0
0009:83EF 50           add   r0
0009:83F0 50           add   r0
0009:83F1 39           stw   (r9)
0009:83F2 D9           inc   r9
0009:83F3 D9           inc   r9
0009:83F4 1A C0        hib
0009:83F6 B6 3D 39     stb   (r9)
0009:83F9 D9           inc   r9
0009:83FA BA 3E 52     add   #02
0009:83FD 3D 39        stb   (r9)
0009:83FF 3C           loop
0009:8400 D9           inc   r9
0009:8401 3D A0 57     lms   r0,(00AE)
0009:8404 50           add   r0
0009:8405 D0           inc   r0
0009:8406 1F 5F        add   r15
0009:8408 FF 31 84     iwt   r15,#8431
0009:840B 01           nop

DATA_09840C:         db $01, $1D, $86, $01, $01, $2D, $87, $01
DATA_098414:         db $01, $87, $87, $01, $01, $89, $87, $01
DATA_09841C:         db $01, $E1, $87, $01, $01, $E3, $87, $01
DATA_098424:         db $01, $E5, $87, $01, $01, $E7, $87, $01
DATA_09842C:         db $01, $E5, $87, $01, $01

0009:8431 F0 09 00     iwt   r0,#0009
0009:8434 3F DF        romb
0009:8436 3D A0 AF     lms   r0,(015E)
0009:8439 FE 3D 85     iwt   r14,#853D
0009:843C 1E 5E        add   r14
0009:843E 1A EF        getb
0009:8440 3D A5 8C     lms   r5,(0118)
0009:8443 24 4D        swap
0009:8445 3D AB A8     lms   r11,(0150)
0009:8448 EB           dec   r11
0009:8449 0B 28        bmi   8473
0009:844B 01           nop
0009:844C BB 3E 67     sub   #07
0009:844F 0D 22        bcs   8473
0009:8451 01           nop
0009:8452 3D A0 AA     lms   r0,(0154)
0009:8455 3E 60        sub   #00
0009:8457 0A 03        bpl   845C
0009:8459 01           nop
0009:845A 4F           not
0009:845B D0           inc   r0
0009:845C 03           lsr
0009:845D 03           lsr
0009:845E 17 03        lsr
0009:8460 3D A0 A9     lms   r0,(0152)
0009:8463 3E 60        sub   #00
0009:8465 0A 03        bpl   846A
0009:8467 01           nop
0009:8468 4F           not
0009:8469 D0           inc   r0
0009:846A 03           lsr
0009:846B 03           lsr
0009:846C 16 03        lsr
0009:846E B6 C7        or    r7
0009:8470 08 03        bne   8475
0009:8472 01           nop
0009:8473 00           stop
0009:8474 01           nop

0009:8475 3D A1 AB     lms   r1,(0156)
0009:8478 3D A2 AC     lms   r2,(0158)
0009:847B BB 03        lsr
0009:847D 09 05        beq   8484
0009:847F 01           nop
0009:8480 FF DE 84     iwt   r15,#84DE
0009:8483 01           nop
0009:8484 A9 08        ibt   r9,#0008
0009:8486 A8 00        ibt   r8,#0000
0009:8488 A7 00        ibt   r7,#0000
0009:848A E3           dec   r3
0009:848B 0A 08        bpl   8495
0009:848D D3           inc   r3
0009:848E A7 08        ibt   r7,#0008
0009:8490 A9 F8        ibt   r9,#FFF8
0009:8492 F8 00 40     iwt   r8,#4000
0009:8495 B1 57        add   r7
0009:8497 35           stw   (r5)
0009:8498 D5           inc   r5
0009:8499 D5           inc   r5
0009:849A B2 35        stw   (r5)
0009:849C D5           inc   r5
0009:849D D5           inc   r5
0009:849E F0 20 0A     iwt   r0,#0A20
0009:84A1 C4           or    r4
0009:84A2 C8           or    r8
0009:84A3 35           stw   (r5)
0009:84A4 D5           inc   r5
0009:84A5 D5           inc   r5
0009:84A6 60           sub   r0
0009:84A7 35           stw   (r5)
0009:84A8 D5           inc   r5
0009:84A9 D5           inc   r5
0009:84AA 02           cache
0009:84AB F0 4D 85     iwt   r0,#854D
0009:84AE 1E 5A        add   r10
0009:84B0 EF           getb
0009:84B1 DE           inc   r14
0009:84B2 3D EF        getbh
0009:84B4 20 1E        move  r14,r0
0009:84B6 E6           dec   r6
0009:84B7 09 23        beq   84DC
0009:84B9 01           nop
0009:84BA 26 1C        move  r12,r6
0009:84BC 2F 1D        move  r13,r15
0009:84BE 21 59        add   r9
0009:84C0 B1 57        add   r7
0009:84C2 35           stw   (r5)
0009:84C3 D5           inc   r5
0009:84C4 D5           inc   r5
0009:84C5 3F EF        getbs
0009:84C7 DE           inc   r14
0009:84C8 52           add   r2
0009:84C9 35           stw   (r5)
0009:84CA D5           inc   r5
0009:84CB D5           inc   r5
0009:84CC EF           getb
0009:84CD DE           inc   r14
0009:84CE 3D EF        getbh
0009:84D0 DE           inc   r14
0009:84D1 C4           or    r4
0009:84D2 3D C8        xor   r8
0009:84D4 35           stw   (r5)
0009:84D5 D5           inc   r5
0009:84D6 D5           inc   r5
0009:84D7 60           sub   r0
0009:84D8 35           stw   (r5)
0009:84D9 D5           inc   r5
0009:84DA 3C           loop
0009:84DB D5           inc   r5
0009:84DC 00           stop
0009:84DD 01           nop

0009:84DE 27 16        move  r6,r7
0009:84E0 A8 00        ibt   r8,#0000
0009:84E2 A7 08        ibt   r7,#0008
0009:84E4 E3           dec   r3
0009:84E5 0A 06        bpl   84ED
0009:84E7 D3           inc   r3
0009:84E8 A7 00        ibt   r7,#0000
0009:84EA F8 00 40     iwt   r8,#4000
0009:84ED B1 57        add   r7
0009:84EF 35           stw   (r5)
0009:84F0 D5           inc   r5
0009:84F1 D5           inc   r5
0009:84F2 B2 35        stw   (r5)
0009:84F4 D5           inc   r5
0009:84F5 D5           inc   r5
0009:84F6 F0 22 0A     iwt   r0,#0A22
0009:84F9 C4           or    r4
0009:84FA C8           or    r8
0009:84FB 35           stw   (r5)
0009:84FC D5           inc   r5
0009:84FD D5           inc   r5
0009:84FE 60           sub   r0
0009:84FF 35           stw   (r5)
0009:8500 D5           inc   r5
0009:8501 D5           inc   r5
0009:8502 02           cache
0009:8503 F0 B5 85     iwt   r0,#85B5
0009:8506 1E 5A        add   r10
0009:8508 EF           getb
0009:8509 DE           inc   r14
0009:850A 3D EF        getbh
0009:850C 20 1E        move  r14,r0
0009:850E E6           dec   r6
0009:850F 09 2A        beq   853B
0009:8511 01           nop
0009:8512 26 1C        move  r12,r6
0009:8514 2F 1D        move  r13,r15
0009:8516 22 3E 58     add   #08
0009:8519 3F EF        getbs
0009:851B DE           inc   r14
0009:851C E3           dec   r3
0009:851D 0A 03        bpl   8522
0009:851F D3           inc   r3
0009:8520 4F           not
0009:8521 D0           inc   r0
0009:8522 51           add   r1
0009:8523 57           add   r7
0009:8524 35           stw   (r5)
0009:8525 D5           inc   r5
0009:8526 D5           inc   r5
0009:8527 B2 35        stw   (r5)
0009:8529 D5           inc   r5
0009:852A D5           inc   r5
0009:852B EF           getb
0009:852C DE           inc   r14
0009:852D 3D EF        getbh
0009:852F DE           inc   r14
0009:8530 C4           or    r4
0009:8531 3D C8        xor   r8
0009:8533 35           stw   (r5)
0009:8534 D5           inc   r5
0009:8535 D5           inc   r5
0009:8536 60           sub   r0
0009:8537 35           stw   (r5)
0009:8538 D5           inc   r5
0009:8539 3C           loop
0009:853A D5           inc   r5
0009:853B 00           stop
0009:853C 01           nop

DATA_09853D:         db $00, $02, $02, $02, $04, $04, $04, $06
DATA_098545:         db $06, $06, $04, $04, $04, $02, $02, $02

DATA_09854D:         dw $8555, $856D, $8585, $859D

DATA_098555:         dw $2100, $000A, $0A21, $2100
DATA_09855D:         dw $000A, $0A21, $2100, $000A
DATA_098565:         dw $0A21, $2100, $000A, $0A21
DATA_09856D:         dw $3000, $FF0A, $8A30, $3000
DATA_098575:         dw $FF0A, $8A30, $3000, $FF0A
DATA_09857D:         dw $8A30, $3000, $FF0A, $8A30
DATA_098585:         dw $3100, $FF0A, $8A31, $3100
DATA_09858D:         dw $FF0A, $8A31, $3100, $FF0A
DATA_098595:         dw $8A31, $3100, $FF0A, $8A31
DATA_09859D:         dw $3100, $018A, $0A31, $3100
DATA_0985A5:         dw $018A, $0A31, $3100, $018A
DATA_0985AD:         dw $0A31, $3100, $018A, $0A31

DATA_0985B5:         dw $85BD, $85D5, $85ED, $8605

DATA_0985BD:         dw $3200, $000A, $0A32, $3200
DATA_0985C5:         dw $000A, $0A32, $3200, $000A
DATA_0985CD:         dw $0A32, $3200, $000A, $0A32
DATA_0985D5:         dw $23FF, $000A, $4A23, $23FF
DATA_0985DD:         dw $000A, $4A23, $23FF, $000A
DATA_0985E5:         dw $4A23, $23FF, $000A, $4A23
DATA_0985ED:         dw $33FF, $000A, $4A33, $33FF
DATA_0985F5:         dw $000A, $4A33, $33FF, $000A
DATA_0985FD:         dw $4A33, $33FF, $000A, $4A33
DATA_098605:         dw $3300, $FF4A, $0A33, $3300
DATA_09860D:         dw $FF4A, $0A33, $3300, $FF4A
DATA_098615:         dw $0A33, $3300, $FF4A, $0A33
DATA_09861D:         dw $A03D, $9E89, $0308, $0001
DATA_098625:         dw $3D01, $8CA6, $60A0, $5615
DATA_09862D:         dw $10A0, $5026, $00F2, $AC80
DATA_098635:         dw $0204, $1D2F, $B245, $3690
DATA_09863D:         dw $D5D5, $D6D6, $3645, $D5D5
DATA_098645:         dw $D6D6, $3645, $D5D5, $D6D6
DATA_09864D:         dw $3645, $D5D5, $3CD6, $B2D6
DATA_098655:         dw $2535, $543E, $2545, $543E
DATA_09865D:         dw $35B2, $FFF9, $3D01, $A979
DATA_098665:         dw $1908, $3DC9, $62A0, $5050
DATA_09866D:         dw $3E1E, $F164, $017E, $84F2
DATA_098675:         dw $3D01, $4AA3, $A43D, $A54E
DATA_09867D:         dw $3D10, $89A0, $3D65, $48A5
DATA_098685:         dw $3D55, $CCA5, $1465, $3D64
DATA_09868D:         dw $8CA5, $30A0, $5516, $02FA
DATA_098695:         dw $AC40, $0202, $1D2F, $3E41
DATA_09869D:         dw $6368, $6E35, $D536, $D6D5
DATA_0986A5:         dw $42D6, $3554, $D536, $D6D5
DATA_0986AD:         dw $B9D6, $B935, $D536, $D6D5
DATA_0986B5:         dw $BAD6, $359E, $36BA, $D5D5
DATA_0986BD:         dw $21D6, $543E, $3E22, $3C54
DATA_0986C5:         dw $3DD6, $89AB, $3E2B, $0A68
DATA_0986CD:         dw $0103, $0100, $1FA7, $3DB9
DATA_0986D5:         dw $1977, $CA3E, $3F2A, $3D72
DATA_0986DD:         dw $62A0, $23E0, $2650, $A015
DATA_0986E5:         dw $2630, $2450, $543E, $3E24
DATA_0986ED:         dw $F168, $017E, $84F2, $AC01
DATA_0986F5:         dw $2F02, $411D, $643E, $3563
DATA_0986FD:         dw $366E, $D5D5, $D6D6, $5442
DATA_098705:         dw $3635, $D5D5, $D6D6, $1029
DATA_09870D:         dw $3635, $D5D5, $D6D6, $3560
DATA_098715:         dw $36BA, $D5D5, $21D6, $543E
DATA_09871D:         dw $3E22, $3C54, $2BD6, $683E
DATA_098725:         dw $3EBB, $0A61, $24C2, $0100
DATA_09872D:         dw $A03D, $F15F, $0198, $0961
DATA_098735:         dw $514F, $08A0, $DF3F, $A03D
DATA_09873D:         dw $C0BF, $18FE, $1EAE, $165E
DATA_098745:         dw $EF3F, $00F1, $B1F4, $9F18
DATA_09874D:         dw $00F2, $B2DC, $9F1A, $B323
DATA_098755:         dw $0608, $4F28, $2AD8, $DA4F
DATA_09875D:         dw $40A0, $5E1E, $3F16, $B1EF
DATA_098765:         dw $9F17, $19B2, $3D9F, $8CA5
DATA_09876D:         dw $60A0, $5515, $5845, $D590
DATA_098775:         dw $45D5, $9057, $26A0, $5515
DATA_09877D:         dw $5A45, $D590, $45D5, $9059
DATA_098785:         dw $0100, $0100, $A03D, $F15F
DATA_09878D:         dw $0186, $0861, $014D, $08A0
DATA_098795:         dw $DF3F, $A03D, $C0BF, $1620
DATA_09879D:         dw $40A7, $9557, $080A, $A001
DATA_0987A5:         dw $3D7F, $D0C6, $9E16, $18F0
DATA_0987AD:         dw $1EAE, $3F56, $F6EF, $F000
DATA_0987B5:         dw $9F17, $40A0, $5E1E, $EF3F
DATA_0987BD:         dw $9F18, $B323, $0309, $4F28
DATA_0987C5:         dw $3DD8, $8CA5, $60A0, $5515
DATA_0987CD:         dw $06A6, $AC02, $2F04, $451D
DATA_0987D5:         dw $9058, $D5D5, $5745, $5625
DATA_0987DD:         dw $903C, $0100, $0100, $0100
DATA_0987E5:         dw $0100, $08A0, $DF3F, $A03D
DATA_0987ED:         dw $FE5F, $0124, $096E, $0144
DATA_0987F5:         dw $A03D, $E0C0, $3B0B, $3D01
DATA_0987FD:         dw $BFA0, $18FE, $1EAE, $3F5E
DATA_098805:         dw $F6EF, $D000, $A79F, $170E
DATA_09880D:         dw $A057, $1E40, $3F5E, $18EF
DATA_098815:         dw $239F, $09B3, $2803, $D84F
DATA_09881D:         dw $A53D, $A08C, $1560, $A655
DATA_098825:         dw $0206, $04AC, $1D2F, $5845
DATA_09882D:         dw $D590, $45D5, $2557, $3C56
DATA_098835:         dw $0090, $3D01, $BFA0, $18FE
DATA_09883D:         dw $1EAE, $3F5E, $F6EF, $3000
DATA_098845:         dw $A79F, $170A, $C305, $A067
DATA_09884D:         dw $3F08, $F1DF, $11E0, $80F2
DATA_098855:         dw $F312, $10A0, $40F9, $F711
DATA_09885D:         dw $0EC0, $A0F8, $FA15, $1500
DATA_098865:         dw $22F5, $0218, $28AC, $1D2F
DATA_09886D:         dw $473D, $D7D7, $6C3E, $150D
DATA_098875:         dw $A016, $1104, $1251, $1352
DATA_09887D:         dw $1953, $1859, $1558, $1A55
DATA_098885:         dw $FF5A, $8921, $41D7, $2047
DATA_09888D:         dw $C014, $883E, $501B, $9EB4
DATA_098895:         dw $58FE, $1EAE, $485E, $0A66
DATA_09889D:         dw $4A03, $D04F, $3156, $505B
DATA_0988A5:         dw $5016, $A4EF, $2E40, $4D64
DATA_0988AD:         dw $9F1B, $4DEF, $9F16, $00FE
DATA_0988B5:         dw $4501, $4DE0, $050B, $D04D
DATA_0988BD:         dw $C01E, $BEDE, $9F3D, $C024
DATA_0988C5:         dw $4D9E, $20C4, $0916, $9E0B
DATA_0988CD:         dw $4D14, $5443, $B690, $95C0
DATA_0988D5:         dw $503F, $D332, $16D3, $5643
DATA_0988DD:         dw $D190, $D2D1, $D8D2, $DAD8
DATA_0988E5:         dw $48DA, $4116, $0A66, $4A03
DATA_0988ED:         dw $D04F, $3156, $5B16, $3DBE
DATA_0988F5:         dw $249F, $9EC0, $C44D, $1620
DATA_0988FD:         dw $0B09, $149E, $494D, $9054
DATA_098905:         dw $C0B6, $3F95, $3250, $D9D9
DATA_09890D:         dw $4916, $9056, $D1D1, $D2D2
DATA_098915:         dw $D8D8, $D3D3, $D9D9, $DADA
DATA_09891D:         dw $3E25, $D754, $D73C, $0100

; gsu routine
0009:8925 3D A0 56     lms   r0,(00AC)
0009:8928 3D F1 2A 1E  lm    r1,(1E2A)
0009:892C C1           or    r1
0009:892D 09 05        beq   8934
0009:892F 01           nop
0009:8930 FF C1 89     iwt   r15,#89C1
0009:8933 01           nop
0009:8934 3D A0 46     lms   r0,(008C)   ; yoshi x
0009:8937 3D A1 4A     lms   r1,(0094)   ; camera x
0009:893A 61           sub   r1          ; yoshi - camera x
0009:893B A2 60        ibt   r2,#0060  
0009:893D A4 08        ibt   r4,#0008    ; test if yoshi is to the left
0009:893F 16 64        sub   r4          ; of left edge of screen
0009:8941 0B 20        bmi   8963        ;
0009:8943 01           nop  
0009:8944 F2 80 01     iwt   r2,#0180    ;
0009:8947 F4 E8 00     iwt   r4,#00E8    ; test if yoshi is to the left
0009:894A 16 64        sub   r4          ; of right edge of screen
0009:894C E6           dec   r6          ;
0009:894D 0B 72        bmi   89C1        ;
0009:894F D6           inc   r6
0009:8950 23 B3        moves r3,r3
0009:8952 09 0F        beq   8963
0009:8954 01           nop
0009:8955 F4 F8 00     iwt   r4,#00F8
0009:8958 64           sub   r4
0009:8959 0B 66        bmi   89C1
0009:895B 01           nop
0009:895C A0 16        ibt   r0,#0016
0009:895E 00           stop
0009:895F 01           nop

0009:8960 05 5F        bra   89C1

0009:8962 01           nop

0009:8963 3D F5 28 1E  lm    r5,(1E28)
0009:8967 B6 3D C5     xor   r5
0009:896A 0A 1B        bpl   8987
0009:896C 01           nop
0009:896D 3D A0 7E     lms   r0,(00FC)
0009:8970 72           and   r2
0009:8971 09 14        beq   8987
0009:8973 01           nop
0009:8974 20 B6        moves r0,r6
0009:8976 0A 03        bpl   897B
0009:8978 01           nop
0009:8979 4F           not
0009:897A D0           inc   r0
0009:897B 3E 6F        sub   #0F
0009:897D 0C 42        bcc   89C1
0009:897F 01           nop
0009:8980 A0 12        ibt   r0,#0012
0009:8982 00           stop
0009:8983 01           nop

0009:8984 05 3B        bra   89C1

0009:8986 01           nop

0009:8987 3D A7 54     lms   r7,(00A8)
0009:898A B7 65        sub   r5
0009:898C 3D C7        xor   r7
0009:898E 0B 0D        bmi   899D
0009:8990 01           nop
0009:8991 B5 90        sbk
0009:8993 3E A5 5A     sms   (00B4),r5
0009:8996 3D F0 26 1E  lm    r0,(1E26)
0009:899A 3E A0 45     sms   (008A),r0
0009:899D B6 3E 54     add   #04
0009:89A0 0B 06        bmi   89A8
0009:89A2 01           nop
0009:89A3 3E 68        sub   #08
0009:89A5 0C 05        bcc   89AC
0009:89A7 01           nop
0009:89A8 4F           not
0009:89A9 D0           inc   r0
0009:89AA 16 56        add   r6
0009:89AC 3D A0 46     lms   r0,(008C)
0009:89AF 66           sub   r6
0009:89B0 90           sbk
0009:89B1 3D F5 48 1E  lm    r5,(1E48)
0009:89B5 25 B5        moves r5,r5
0009:89B7 0B 08        bmi   89C1
0009:89B9 01           nop
0009:89BA F0 E2 10     iwt   r0,#10E2
0009:89BD 55           add   r5
0009:89BE 40           ldw   (r0)
0009:89BF 66           sub   r6
0009:89C0 90           sbk

0009:89C1 A0 09        ibt   r0,#0009
0009:89C3 3F DF        romb
0009:89C5 F1 61 14     iwt   r1,#1461    ; 
0009:89C8 F2 A2 10     iwt   r2,#10A2    ; x coord
0009:89CB F3 42 11     iwt   r3,#1142    ; y coord
0009:89CE F4 40 16     iwt   r4,#1640    ; OAM x & y
0009:89D1 F6 C0 0E     iwt   r6,#0EC0    ; sprite state
0009:89D4 F9 00 10     iwt   r9,#1000    ; 
0009:89D7 FA 60 14     iwt   r10,#1460   ; 
0009:89DA 02           cache  
0009:89DB AC 28        ibt   r12,#0028   ;
0009:89DD 2F 1D        move  r13,r15     ; loop begin through sprite tables
0009:89DF 3D 46        ldb   (r6)        ;
0009:89E1 E0           dec   r0          ; test for > 0
0009:89E2 0A 06        bpl   89EA        ; any state besides 00
0009:89E4 01           nop               ;
0009:89E5 D4           inc   r4          ;
0009:89E6 FF 6A 8A     iwt   r15,#8A6A   ; if free slot, skip processing
0009:89E9 D4           inc   r4          ;
0009:89EA 3D 41        ldb   (r1)        ; select the X camera to use
0009:89EC F7 94 00     iwt   r7,#0094    ; (layer?)
0009:89EF 17 57        add   r7          ;
0009:89F1 17 47        ldw   (r7)        ;
0009:89F3 F8 9C 00     iwt   r8,#009C    ; select layer Y camera
0009:89F6 58           add   r8          ;
0009:89F7 18 40        ldw   (r0)  
0009:89F9 42           ldw   (r2)        ; x coord
0009:89FA 67           sub   r7          ; - layer camera X
0009:89FB 34           stw   (r4)        ; -> 1640,x
0009:89FC 20 17        move  r7,r0       ; cache in r7
0009:89FE 43           ldw   (r3)        ; y coord
0009:89FF 68           sub   r8          ; - layer camera Y
0009:8A00 D4           inc   r4          ; 
0009:8A01 D4           inc   r4          ;
0009:8A02 34           stw   (r4)        ; -> 1642,x
0009:8A03 20 18        move  r8,r0       ; cache in r8
0009:8A05 49           ldw   (r9)        ; 1000,x bits 2 & 3
0009:8A06 3E 7C        and   #0C         ; get index into 8C83 table
0009:8A08 09 60        beq   8A6A        ; if 0, go to next sprite
0009:8A0A 01           nop               ;
0009:8A0B FE 83 8C     iwt   r14,#8C83   ; get first word: x threshold
0009:8A0E 1E 5E        add   r14         ; in entry in table
0009:8A10 EF           getb              ;
0009:8A11 DE           inc   r14         ;
0009:8A12 FB F0 00     iwt   r11,#00F0   ;
0009:8A15 3D EF        getbh             ;
0009:8A17 DE           inc   r14         ;
0009:8A18 15 57        add   r7          ; if x threshold + #F0
0009:8A1A 50           add   r0          ; < 1640,x (OAM x coord)
0009:8A1B 5B           add   r11         ; offscreen on right side check
0009:8A1C 65           sub   r5          ; w/ threshold
0009:8A1D 0C 10        bcc   8A2F        ; 
0009:8A1F 60           sub   r0          ; 
0009:8A20 EF           getb              ; get next word: y threshold
0009:8A21 DE           inc   r14         ;
0009:8A22 FB C8 00     iwt   r11,#00C8   ;
0009:8A25 3D EF        getbh  
0009:8A27 15 58        add   r8  
0009:8A29 50           add   r0          ; if y threshold + #C8 
0009:8A2A 5B           add   r11         ; > 1642,x (OAM y coord)
0009:8A2B 65           sub   r5          ; offscreen on bottom check
0009:8A2C 0D 3C        bcs   8A6A        ; (w/ threshold)
0009:8A2E 60           sub   r0          ; 
0009:8A2F 36           stw   (r6)        ; kill sprite (#00 -> state)
0009:8A30 E0           dec   r0
0009:8A31 D1           inc   r1          ;
0009:8A32 3D 31        stb   (r1)        ; 
0009:8A34 E1           dec   r1          ;
0009:8A35 A0 18        ibt   r0,#0018
0009:8A37 6C           sub   r12
0009:8A38 50           add   r0
0009:8A39 18 50        add   r0
0009:8A3B A0 40        ibt   r0,#0040
0009:8A3D 58           add   r8
0009:8A3E F8 E2 16     iwt   r8,#16E2
0009:8A41 58           add   r8
0009:8A42 40           ldw   (r0)
0009:8A43 3E 60        sub   #00
0009:8A45 0B 0D        bmi   8A54
0009:8A47 01           nop
0009:8A48 F8 CE 1E     iwt   r8,#1ECE
0009:8A4B 58           add   r8
0009:8A4C 40           ldw   (r0)
0009:8A4D 4F           not
0009:8A4E 3D F8 CC 1E  lm    r8,(1ECC)
0009:8A52 78           and   r8
0009:8A53 90           sbk
0009:8A54 3D 4A        ldb   (r10)
0009:8A56 F8 CA 28     iwt   r8,#28CA
0009:8A59 18 58        add   r8
0009:8A5B 60           sub   r0          ;
0009:8A5C 3D 38        stb   (r8)        ; store #00 in (28CA + (1460))
0009:8A5E 3D F0 B6 01  lm    r0,(01B6)
0009:8A62 6C           sub   r12
0009:8A63 08 05        bne   8A6A
0009:8A65 01           nop
0009:8A66 3E F0 B6 01  sm    (01B6),r0
0009:8A6A A0 04        ibt   r0,#0004    ; next sprite slot
0009:8A6C 12 52        add   r2          ; in all tables
0009:8A6E 13 53        add   r3          ;
0009:8A70 16 56        add   r6          ;
0009:8A72 19 59        add   r9          ;
0009:8A74 1A 5A        add   r10         ;
0009:8A76 11 51        add   r1          ;
0009:8A78 D4           inc   r4          ;
0009:8A79 3C           loop              ;
0009:8A7A D4           inc   r4          ;
0009:8A7B A0 4D        ibt   r0,#004D    ; begin nested loop
0009:8A7D 3F DF        romb              ; through table 1462
0009:8A7F AB 00        ibt   r11,#0000   ; i, outer loop counter
0009:8A81 FD 8F 8A     iwt   r13,#8A8F   ; go through table
0009:8A84 F1 62 14     iwt   r1,#1462    ; 8 times, i++ each time
0009:8A87 F2 00 10     iwt   r2,#1000  
0009:8A8A 02           cache             ; outer loop starts:
0009:8A8B AC 28        ibt   r12,#0028   ; j, inner loop counter
0009:8A8D AA 00        ibt   r10,#0000  
0009:8A8F B1 5A        add   r10         ; inner loop starts here
0009:8A91 40           ldw   (r0)  
0009:8A92 6B           sub   r11         ; 1462,x - i
0009:8A93 09 05        beq   8A9A
0009:8A95 01           nop
0009:8A96 FF E5 8A     iwt   r15,#8AE5   ; next sprite if not zero ^
0009:8A99 DA           inc   r10  
0009:8A9A F0 C2 13     iwt   r0,#13C2    ; 13C2,x
0009:8A9D 5A           add   r10         ; is animation frame
0009:8A9E 40           ldw   (r0)        ;
0009:8A9F 20 19        move  r9,r0  
0009:8AA1 C0           hib               ; animation frame being $00xx
0009:8AA2 09 1E        beq   8AC2        ;
0009:8AA4 E0           dec   r0          ;
0009:8AA5 08 0B        bne   8AB2        ; animation frame being $01xx
0009:8AA7 19 60        sub   r0          ; performs this table read
0009:8AA9 3E A9 00     sms   (0000),r9   ;
0009:8AAC FE 14 09     iwt   r14,#0914   ;
0009:8AAF 05 65        bra   8B16        ;

0009:8AB1 EF           getb

0009:8AB2 60           sub   r0          ; animation frame: anything else
0009:8AB3 3E A9 00     sms   (0000),r9   ;
0009:8AB6 3E AC 2C     sms   (0058),r12
0009:8AB9 AC 04        ibt   r12,#0004
0009:8ABB FE 18 09     iwt   r14,#0918
0009:8ABE FF AE 8B     iwt   r15,#8BAE
                       ; alt2
0009:8AC1              db $3E

0009:8AC2 F0 40 11     iwt   r0,#$1140   ; y coord
0009:8AC5 5A           add   r10         ;
0009:8AC6 3D 40        ldb   (r0)        ; subpixel only
0009:8AC8 3E 88        mult  #08         ; << 3
0009:8ACA 3E A0 00     sms   (0000),r0   ; cache in 0000
0009:8ACD B2 5A        add   r10
0009:8ACF 40           ldw   (r0)        ; 1000,x
0009:8AD0 3E 73        and   #03         ; bits 0 & 1
0009:8AD2 3E 83        mult  #03         ; * 3
0009:8AD4 D0           inc   r0          ; + 1
0009:8AD5 1F 5F        add   r15         ; increment PC by ^

; weird style of pointer table: this is 00 index
0009:8AD7 FF 0B 8B     iwt   r15,#8B0B
                       ; iwt   r0,#xxxx
0009:8ADA F0           db $F0

; 01 index
                       ; iwt   r15,#8B85
0009:8ADB 85 8B        dw $8B85
                       ; alt2
0009:8ADD 3E           db $3E

; 02 index
                       ; iwt   r15,#8C70
0009:8ADE 70 8C        dw $8C70
                       ; iwt   r0,#xxxx
0009:8AE0 F0           db $F0

; 03 index
                       ; iwt   r15,#8C93
0009:8AE1 93 8C        dw $8C93
                       ; alt2
0009:8AE3 3E           db $3E

0009:8AE4 DA           inc   r10         ;
0009:8AE5 DA           inc   r10         ; next sprite
0009:8AE6 DA           inc   r10         ;
0009:8AE7 3C           loop              ;
0009:8AE8 DA           inc   r10         ;
0009:8AE9 DB           inc   r11         ; i++
0009:8AEA 3D A0 8D     lms   r0,(011A)  
0009:8AED 6B           sub   r11  
0009:8AEE 09 0C        beq   8AFC        ; if i == (011A)
0009:8AF0 BB 3E 68     sub   #08         ;
0009:8AF3 0D 05        bcs   8AFA        ; if i >= 8, completely done
0009:8AF5 01           nop
0009:8AF6 FF 8C 8A     iwt   r15,#8A8C
                       ; ibt   r12,#00xx
0009:8AF9              db $AC

0009:8AFA 00           stop
0009:8AFB 01           nop

0009:8AFC 3D A8 49     lms   r8,(0092)
0009:8AFF F0 A0 00     iwt   r0,#00A0
0009:8B02 58           add   r8
0009:8B03 90           sbk
0009:8B04 3E A8 8C     sms   (0118),r8
0009:8B07 FF 8C 8A     iwt   r15,#8A8C   ; continue outer loop
                       ; ibt   r12,#00xx
0009:8B0A              db $AC

; 00 drawing method
0009:8B0B              db $20, $13
                       ; iwt r0, #1320
0009:8B0D 5A           add   r10         ; sprite state
0009:8B0E 40           ldw   (r0)        ;
0009:8B0F 50           add   r0          ; * 2
0009:8B10 FE 00 00     iwt   r14,#0000   ;
0009:8B13 1E 5E        add   r14         ; 1A8000,ID
0009:8B15 EF           getb
0009:8B16 DE           inc   r14
0009:8B17 F6 02 10     iwt   r6,#1002    ; 
0009:8B1A 26 5A        add   r10         ; r6 = 1002,x
0009:8B1C 16 46        ldw   (r6)        ; OAM bytes 3 & 4
0009:8B1E 3D EF        getbh             ;
0009:8B20 59           add   r9          ; r14 = 1A8000,ID +
0009:8B21 1E 59        add   r9          ; anim frame * 2
0009:8B23 F0 C0 13     iwt   r0,#13C0    ;
0009:8B26 5A           add   r10         ; facing dir
0009:8B27 3D 40        ldb   (r0)        ;
0009:8B29 50           add   r0          ;
0009:8B2A 50           add   r0          ; << 5
0009:8B2B 3E 88        mult  #08         ; to shift into 7th bit (x flip)
0009:8B2D 3D C6        xor   r6          ; ^ 1002,x
0009:8B2F 16 4D        swap              ;
0009:8B31 26 3E EF     getbl             ; r6 = oam 3 & 4
0009:8B34 DE           inc   r14         ; t[0] = tile number
0009:8B35 F0 A0 10     iwt   r0,#10A0    ;
0009:8B38 5A           add   r10         ;
0009:8B39 3D 40        ldb   (r0)        ;
0009:8B3B 17 4D        swap              ; r7 = low x coord byte
0009:8B3D EF           getb              ; t[1] = byte 4 OAM
0009:8B3E 20 14        move  r4,r0       ; r4 = high table (size)
0009:8B40 F9 F1 00     iwt   r9,#00F1    ; mask away priority
0009:8B43 79           and   r9          ; this is for yxpp---t
0009:8B44 4D           swap              ;
0009:8B45 16 3D C6     xor   r6          ;
0009:8B48 A9 00        ibt   r9,#0000    ;
0009:8B4A B4 3E 72     and   #02         ; this time, mask size
0009:8B4D 08 03        bne   8B52        ;
0009:8B4F 01           nop               ;
0009:8B50 A9 04        ibt   r9,#0004    ;
0009:8B52 17 3D C7     xor   r7          ; r7 = size ^ MSB x
0009:8B55 F0 40 16     iwt   r0,#1640    ; (high table)
0009:8B58 18 5A        add   r10         ;
0009:8B5A 48           ldw   (r8)        ; OAM x
0009:8B5B 14 59        add   r9          ; add size correction 
0009:8B5D D8           inc   r8          ; (0 or 4)
0009:8B5E D8           inc   r8          ;
0009:8B5F 48           ldw   (r8)        ; OAM y
0009:8B60 15 59        add   r9          ; add size correction
0009:8B62 3D A8 49     lms   r8,(0092)   ; (0 or 4)
0009:8B65 F0 22 13     iwt   r0,#1322    ;
0009:8B68 5A           add   r10         ;
0009:8B69 B8 30        stw   (r0)        ; set OAM buffer entry
0009:8B6B B4 38        stw   (r8)        ; store OAM x
0009:8B6D D8           inc   r8          ;
0009:8B6E D8           inc   r8          ;
0009:8B6F B5 38        stw   (r8)        ; store OAM y
0009:8B71 D8           inc   r8          ;
0009:8B72 D8           inc   r8          ;
0009:8B73 3D A0 00     lms   r0,(0000)   ;
0009:8B76 56           add   r6          ;
0009:8B77 38           stw   (r8)        ; store OAM 3 & 4
0009:8B78 D8           inc   r8          ;
0009:8B79 D8           inc   r8          ;
0009:8B7A B7 38        stw   (r8)        ; store OAM high
0009:8B7C D8           inc   r8          ;
0009:8B7D D8           inc   r8          ;
0009:8B7E 3E A8 49     sms   (0092),r8   ; update next free slot
0009:8B81 FF E5 8A     iwt   r15,#8AE5   ; return
0009:8B84 DA           inc   r10         ;

; 01 drawing method
                       ; sms   (0058),r12 
0009:8B85              db $AC, $2C       ; preserve outer loop counter
0009:8B87 F0 20 13     iwt   r0,#1320    ;
0009:8B8A 5A           add   r10         ; sprite ID
0009:8B8B 40           ldw   (r0)        ;
0009:8B8C 50           add   r0          ; * 2
0009:8B8D FE 8A 04     iwt   r14,#048A   ; $1A848A,ID
0009:8B90 1E 5E        add   r14         ;
0009:8B92 F0 01 10     iwt   r0,#1001    ;
0009:8B95 5A           add   r10         ; OAM buffer byte count
0009:8B96 3D 40        ldb   (r0)        ;
0009:8B98 F8 F8 00     iwt   r8,#00F8    ;
0009:8B9B 78           and   r8          ;
0009:8B9C 03           lsr               ; / 8, so:
0009:8B9D 03           lsr               ; OAM entry count
0009:8B9E 03           lsr               ;
0009:8B9F 20 1C        move  r12,r0      ; loop through sprite's OAM entries
0009:8BA1 18 EF        getb              ; 
0009:8BA3 DE           inc   r14         ;
0009:8BA4 3F 85        umult #05         ;
0009:8BA6 3D 89        umult r9          ; r14 = word($1A848A,ID) +
0009:8BA8 28 3D EF     getbh             ; entry count * 5 * anim frame
0009:8BAB 1E 58        add   r8          ;
0009:8BAD 3E A1 21     sms   (0042),r1   ;
0009:8BB0 3E A2 22     sms   (0044),r2   ; preserve some registers
0009:8BB3 3E AA 2A     sms   (0054),r10  ;
0009:8BB6 3E AD 2D     sms   (005A),r13  ;
0009:8BB9 F0 E4 8A     iwt   r0,#8AE4    ; return address
0009:8BBC 3E A0 30     sms   (0060),r0   ;
0009:8BBF F0 02 10     iwt   r0,#1002    ;
0009:8BC2 5A           add   r10         ; 1002,x
0009:8BC3 13 3D 40     ldb   (r0)        ;
0009:8BC6 F0 C0 13     iwt   r0,#13C0    ;
0009:8BC9 5A           add   r10         ; face dir
0009:8BCA 3D 40        ldb   (r0)        ;
0009:8BCC 50           add   r0          ;
0009:8BCD 50           add   r0          ; << 5
0009:8BCE 3E 88        mult  #08         ; to shift into 7th bit (x flip)
0009:8BD0 3D C3        xor   r3          ; ^ 1002,x
0009:8BD2 13 4D        swap              ; -> r3 high byte
0009:8BD4 3D A4 49     lms   r4,(0092)   ; last (free) OAM buffer entry
0009:8BD7 F0 22 13     iwt   r0,#1322    ; 
0009:8BDA 5A           add   r10         ; occupy the space and claim it
0009:8BDB B4 30        stw   (r0)        ; in 1322,x
0009:8BDD F0 A0 10     iwt   r0,#10A0    ;
0009:8BE0 5A           add   r10         ; lowest byte of x coord
0009:8BE1 3D 40        ldb   (r0)        ;
0009:8BE3 1D 4D        swap              ; r13 = low byte << 8
0009:8BE5 A0 3C        ibt   r0,#003C    ;
0009:8BE7 6A           sub   r10         ; if sprite slot <= 3C
0009:8BE8 0D 0D        bcs   8BF7        ; aka first 16 sprites
0009:8BEA 60           sub   r0          ;
0009:8BEB F0 56 1D     iwt   r0,#1D56    ; or
0009:8BEE 5A           add   r10         ; if 1D56,x - 1 < 0
0009:8BEF 40           ldw   (r0)        ;
0009:8BF0 E0           dec   r0          ; then make r0 FFFF
0009:8BF1 0B 04        bmi   8BF7        ;
0009:8BF3 60           sub   r0          ; otherwise r0 = F1FF
0009:8BF4 F0 00 F2     iwt   r0,#F200    ; this is for bitmasking
0009:8BF7 E0           dec   r0          ; the OAM priority
0009:8BF8 3E A0 27     sms   (004E),r0   ; store either one in (004E)
0009:8BFB F0 40 16     iwt   r0,#1640    ;
0009:8BFE 5A           add   r10         ; r1 = OAM x
0009:8BFF 11 40        ldw   (r0)        ; 
0009:8C01 D0           inc   r0
0009:8C02 D0           inc   r0
0009:8C03 12 40        ldw   (r0)        ; r2 = OAM y
0009:8C05 2D 1A        move  r10,r13     ; preserve low x coord byte
0009:8C07 2F 1D        move  r13,r15     ; begin loop here
0009:8C09 3F EF        getbs             ; t[0] = byte 1 of ROM table
0009:8C0B DE           inc   r14         ; for current anim frame
0009:8C0C F9 00 40     iwt   r9,#4000    ; t[0] = x drawing offset
0009:8C0F 29 73        and   r3          ;
0009:8C11 09 05        beq   8C18        ; test x flip
0009:8C13 01           nop               ; negate if needed
0009:8C14 4F           not               ;
0009:8C15 D0           inc   r0          ;
0009:8C16 A9 08        ibt   r9,#0008
0009:8C18 15 51        add   r1          ; r5 = OAM x +/- t[0]
0009:8C1A 3F EF        getbs             ; t[1] = y drawing offset
0009:8C1C DE           inc   r14         ;
0009:8C1D A8 00        ibt   r8,#0000
0009:8C1F 23 B3        moves r3,r3       ; test y flip
0009:8C21 0A 05        bpl   8C28        ; negate if needed
0009:8C23 01           nop
0009:8C24 4F           not
0009:8C25 D0           inc   r0
0009:8C26 A8 08        ibt   r8,#0008
0009:8C28 16 52        add   r2          ; r6 = OAM y +/- t[1]
0009:8C2A EF           getb              ;
0009:8C2B DE           inc   r14         ;
0009:8C2C 3D A7 27     lms   r7,(004E)   ; F1FF or FFFF
0009:8C2F 3D EF        getbh             ;
0009:8C31 DE           inc   r14         ; word t[2] (includes t[3])
0009:8C32 77           and   r7          ;
0009:8C33 17 3D C3     xor   r3          ; r7 = oam low bytes 3 & 4
0009:8C36 EF           getb
0009:8C37 3E 72        and   #02         ; mask for size flag
0009:8C39 08 05        bne   8C40        ;
0009:8C3B 01           nop
0009:8C3C 25 59        add   r9          ; size corrections to X/Y if
0009:8C3E 26 58        add   r8          ; size flag not set
0009:8C40 3D EF        getbh             ; t[4] = OAM high table
0009:8C42 DE           inc   r14         ; just for size
0009:8C43 B5 34        stw   (r4)        ; store OAM x coord
0009:8C45 D4           inc   r4          ;
0009:8C46 D4           inc   r4          ;
0009:8C47 15 3D CA     xor   r10         ; r5 = size ^ low x byte
0009:8C4A B6 34        stw   (r4)        ; store OAM y coord
0009:8C4C D4           inc   r4          ;
0009:8C4D D4           inc   r4          ;
0009:8C4E 3D A0 00     lms   r0,(0000)   ;
0009:8C51 57           add   r7          ;
0009:8C52 34           stw   (r4)        ; store OAM 3 & 4
0009:8C53 D4           inc   r4          ;
0009:8C54 D4           inc   r4          ;
0009:8C55 B5 34        stw   (r4)        ; store high table info
0009:8C57 D4           inc   r4          ; size & ms x byte together
0009:8C58 3C           loop
0009:8C59 D4           inc   r4
0009:8C5A 3E A4 49     sms   (0092),r4   ; store next free OAM slot
0009:8C5D 3D A1 21     lms   r1,(0042)   ;
0009:8C60 3D A2 22     lms   r2,(0044)   ;
0009:8C63 3D AA 2A     lms   r10,(0054)  ; restore registers
0009:8C66 3D AC 2C     lms   r12,(0058)  ; to get back to more sprites!
0009:8C69 3D AD 2D     lms   r13,(005A)  ;
0009:8C6C 3D AF 30     lms   r15,(0060)  ;
0009:8C6F 01           nop

; 02 drawing method
; this seems to not really do anything?
; used for not drawing a sprite?
                       ; iwt r0,#1001
0009:8C70 01 10        dw $1001          ;
0009:8C72 5A           add   r10         ; OAM buffer byte count
0009:8C73 40           ldw   (r0)        ;
0009:8C74 F7 F8 00     iwt   r7,#00F8    ;
0009:8C77 77           and   r7          ;
0009:8C78 3D A8 49     lms   r8,(0092)   ; next free slot
0009:8C7B 58           add   r8          ; add the byte count
0009:8C7C 90           sbk               ; update
0009:8C7D F0 22 13     iwt   r0,#1322    ;
0009:8C80 5A           add   r10         ; set 1322,x with
0009:8C81 B8 30        stw   (r0)        ; buffer entry
0009:8C83 FF E5 8A     iwt   r15,#8AE5   ; go to next sprite
0009:8C86 DA           inc   r10         ;

; 8C83 in code (indexed by 4's, pairs of words)
; x, y thresholds for despawning sprites
DATA_098C87:         dw $0060, $0060
DATA_098C8B:         dw $0090, $0060
DATA_098C8F:         dw $0090, $00A0

; 03 drawing method
; this is the same as 01 except OAM byte count
; MSB flagged on - if it's greater than a byte
; use this index
                       ; sms   (0058),r12 
0009:8C93 AC 2C        db $AC, $2C       ; preserve outer loop counter
0009:8C95 F0 20 13     iwt   r0,#1320    ;
0009:8C98 5A           add   r10         ; sprite ID
0009:8C99 40           ldw   (r0)        ;
0009:8C9A 50           add   r0          ; * 2
0009:8C9B FE 8A 04     iwt   r14,#048A   ;
0009:8C9E 1E 5E        add   r14         ; $1A848A[ID]
0009:8CA0 F0 01 10     iwt   r0,#1001    ; OAM byte count
0009:8CA3 5A           add   r10         ;
0009:8CA4 3D 40        ldb   (r0)        ;
0009:8CA6 F8 F8 00     iwt   r8,#00F8    ;
0009:8CA9 78           and   r8          ;
0009:8CAA F8 00 01     iwt   r8,#0100    ; adds 256 to OAM byte count
0009:8CAD FF 9C 8B     iwt   r15,#8B9C   ; giving it 32 more entries
0009:8CB0 58           add   r8          ; then jump to OAM processing

; gsu routine
0009:8CB1 3F DF        romb
0009:8CB3 F0 22 13     iwt   r0,#1322
0009:8CB6 5A           add   r10
0009:8CB7 40           ldw   (r0)
0009:8CB8 24 B0        moves r4,r0
0009:8CBA 0A 03        bpl   8CBF
0009:8CBC 01           nop
0009:8CBD 00           stop
0009:8CBE 01           nop
;
0009:8CBF F0 C2 13     iwt   r0,#13C2
0009:8CC2 5A           add   r10
0009:8CC3 3D 40        ldb   (r0)
0009:8CC5 50           add   r0
0009:8CC6 1E 5E        add   r14
0009:8CC8 EF           getb
0009:8CC9 DE           inc   r14
0009:8CCA 1E 3D EF     getbh
0009:8CCD F0 02 10     iwt   r0,#1002
0009:8CD0 5A           add   r10
0009:8CD1 13 3D 40     ldb   (r0)
0009:8CD4 F0 C0 13     iwt   r0,#13C0
0009:8CD7 5A           add   r10
0009:8CD8 3D 40        ldb   (r0)
0009:8CDA 50           add   r0
0009:8CDB 50           add   r0
0009:8CDC 3E 88        mult  #08
0009:8CDE 3D C3        xor   r3
0009:8CE0 13 4D        swap
0009:8CE2 F0 40 16     iwt   r0,#1640
0009:8CE5 5A           add   r10
0009:8CE6 11 40        ldw   (r0)
0009:8CE8 D0           inc   r0
0009:8CE9 D0           inc   r0
0009:8CEA 12 40        ldw   (r0)
0009:8CEC F0 40 11     iwt   r0,#1140
0009:8CEF 5A           add   r10
0009:8CF0 3D 40        ldb   (r0)
0009:8CF2 3E 88        mult  #08
0009:8CF4 3E A0 00     sms   (0000),r0
0009:8CF7 F0 01 10     iwt   r0,#1001
0009:8CFA 5A           add   r10
0009:8CFB 40           ldw   (r0)
0009:8CFC F8 F8 00     iwt   r8,#00F8
0009:8CFF 78           and   r8
0009:8D00 03           lsr
0009:8D01 03           lsr
0009:8D02 1C 03        lsr
0009:8D04 F0 A0 10     iwt   r0,#10A0
0009:8D07 5A           add   r10
0009:8D08 3D 40        ldb   (r0)
0009:8D0A 1A 4D        swap
0009:8D0C 02           cache
0009:8D0D 2F 1D        move  r13,r15       ; loop start
0009:8D0F 3F EF        getbs               ;
0009:8D11 DE           inc   r14
0009:8D12 F9 00 40     iwt   r9,#4000
0009:8D15 29 73        and   r3
0009:8D17 09 05        beq   8D1E
0009:8D19 01           nop
0009:8D1A 4F           not
0009:8D1B D0           inc   r0
0009:8D1C A9 08        ibt   r9,#0008
0009:8D1E 15 51        add   r1
0009:8D20 3F EF        getbs
0009:8D22 DE           inc   r14
0009:8D23 A8 00        ibt   r8,#0000
0009:8D25 23 B3        moves r3,r3
0009:8D27 0A 05        bpl   8D2E
0009:8D29 01           nop
0009:8D2A 4F           not
0009:8D2B D0           inc   r0
0009:8D2C A8 08        ibt   r8,#0008
0009:8D2E 16 52        add   r2
0009:8D30 EF           getb
0009:8D31 DE           inc   r14
0009:8D32 3D EF        getbh
0009:8D34 DE           inc   r14
0009:8D35 17 3D C3     xor   r3
0009:8D38 EF           getb
0009:8D39 3E 72        and   #02
0009:8D3B 08 05        bne   8D42
0009:8D3D 01           nop
0009:8D3E 25 59        add   r9
0009:8D40 26 58        add   r8
0009:8D42 3D EF        getbh
0009:8D44 DE           inc   r14
0009:8D45 B5 34        stw   (r4)
0009:8D47 D4           inc   r4
0009:8D48 D4           inc   r4
0009:8D49 15 3D CA     xor   r10
0009:8D4C B6 34        stw   (r4)
0009:8D4E D4           inc   r4
0009:8D4F D4           inc   r4
0009:8D50 3D A0 00     lms   r0,(0000)
0009:8D53 57           add   r7
0009:8D54 34           stw   (r4)
0009:8D55 D4           inc   r4
0009:8D56 D4           inc   r4
0009:8D57 B5 34        stw   (r4)
0009:8D59 D4           inc   r4
0009:8D5A 3C           loop
0009:8D5B D4           inc   r4
0009:8D5C 00           stop
0009:8D5D 01           nop

0009:8D5E AC 18        ibt   r12,#0018
0009:8D60 3D A2 00     lms   r2,(0000)
0009:8D63 B2 03        lsr
0009:8D65 03           lsr
0009:8D66 BC 11 60     sub   r0
0009:8D69 F4 D6 1C     iwt   r4,#1CD6
0009:8D6C B2 54        add   r4
0009:8D6E 12 40        ldw   (r0)
0009:8D70 3E 52        add   #02
0009:8D72 13 40        ldw   (r0)
0009:8D74 F5 00 0F     iwt   r5,#0F00
0009:8D77 A6 10        ibt   r6,#0010
0009:8D79 F7 A2 0F     iwt   r7,#0FA2
0009:8D7C F8 00 60     iwt   r8,#6000
0009:8D7F A9 FF        ibt   r9,#FFFF
0009:8D81 3E A9 00     sms   (0000),r9
0009:8D84 02           cache
0009:8D85 FD 89 8D     iwt   r13,#8D89
0009:8D88 B1 6C        sub   r12
0009:8D8A 09 33        beq   8DBF
0009:8D8C 01           nop
0009:8D8D 3D 45        ldb   (r5)
0009:8D8F 66           sub   r6
0009:8D90 08 2D        bne   8DBF
0009:8D92 01           nop
0009:8D93 47           ldw   (r7)
0009:8D94 78           and   r8
0009:8D95 08 28        bne   8DBF
0009:8D97 01           nop
0009:8D98 44           ldw   (r4)
0009:8D99 62           sub   r2
0009:8D9A 20 1B        move  r11,r0
0009:8D9C 0A 03        bpl   8DA1
0009:8D9E 01           nop
0009:8D9F 4F           not
0009:8DA0 D0           inc   r0
0009:8DA1 20 1A        move  r10,r0
0009:8DA3 B4 3E 52     add   #02
0009:8DA6 40           ldw   (r0)
0009:8DA7 63           sub   r3
0009:8DA8 20 1E        move  r14,r0
0009:8DAA 0A 03        bpl   8DAF
0009:8DAC 01           nop
0009:8DAD 4F           not
0009:8DAE D0           inc   r0
0009:8DAF 5A           add   r10
0009:8DB0 69           sub   r9
0009:8DB1 0D 0C        bcs   8DBF
0009:8DB3 59           add   r9
0009:8DB4 20 19        move  r9,r0
0009:8DB6 3E AC 00     sms   (0000),r12
0009:8DB9 3E AB 01     sms   (0002),r11
0009:8DBC 3E AE 02     sms   (0004),r14
0009:8DBF A0 04        ibt   r0,#0004
0009:8DC1 15 55        add   r5
0009:8DC3 17 57        add   r7
0009:8DC5 14 54        add   r4
0009:8DC7 3C           loop
0009:8DC8 B1 3D A1 00  lms   r1,(0000)
0009:8DCC D1           inc   r1
0009:8DCD 09 09        beq   8DD8
0009:8DCF E1           dec   r1
0009:8DD0 A0 18        ibt   r0,#0018
0009:8DD2 61           sub   r1
0009:8DD3 50           add   r0
0009:8DD4 50           add   r0
0009:8DD5 3E A0 00     sms   (0000),r0
0009:8DD8 00           stop
0009:8DD9 01           nop

0009:8DDA F2 00 0F     iwt   r2,#0F00
0009:8DDD F3 D6 1C     iwt   r3,#1CD6
0009:8DE0 F4 D8 1C     iwt   r4,#1CD8
0009:8DE3 F5 A2 0F     iwt   r5,#0FA2
0009:8DE6 B3 51        add   r1
0009:8DE8 16 40        ldw   (r0)
0009:8DEA B4 51        add   r1
0009:8DEC 17 40        ldw   (r0)
0009:8DEE A8 FF        ibt   r8,#FFFF
0009:8DF0 28 19        move  r9,r8
0009:8DF2 FB 00 60     iwt   r11,#6000
0009:8DF5 B1 03        lsr
0009:8DF7 03           lsr
0009:8DF8 AC 18        ibt   r12,#0018
0009:8DFA BC 11 60     sub   r0
0009:8DFD 02           cache
0009:8DFE 2F 1D        move  r13,r15
0009:8E00 BC 61        sub   r1
0009:8E02 09 27        beq   8E2B
0009:8E04 01           nop
0009:8E05 3D 42        ldb   (r2)
0009:8E07 3E 6E        sub   #0E
0009:8E09 0C 20        bcc   8E2B
0009:8E0B 01           nop
0009:8E0C 45           ldw   (r5)
0009:8E0D 7B           and   r11
0009:8E0E 6B           sub   r11
0009:8E0F 08 1A        bne   8E2B
0009:8E11 01           nop
0009:8E12 43           ldw   (r3)
0009:8E13 66           sub   r6
0009:8E14 0A 03        bpl   8E19
0009:8E16 01           nop
0009:8E17 4F           not
0009:8E18 D0           inc   r0
0009:8E19 20 1A        move  r10,r0
0009:8E1B 44           ldw   (r4)
0009:8E1C 67           sub   r7
0009:8E1D 0A 03        bpl   8E22
0009:8E1F 01           nop
0009:8E20 4F           not
0009:8E21 D0           inc   r0
0009:8E22 5A           add   r10
0009:8E23 68           sub   r8
0009:8E24 0D 05        bcs   8E2B
0009:8E26 58           add   r8
0009:8E27 20 18        move  r8,r0
0009:8E29 2C 19        move  r9,r12
0009:8E2B A0 04        ibt   r0,#0004
0009:8E2D 12 52        add   r2
0009:8E2F 13 53        add   r3
0009:8E31 14 54        add   r4
0009:8E33 15 55        add   r5
0009:8E35 3C           loop
0009:8E36 BC 21 B9     moves r1,r9
0009:8E39 0B 07        bmi   8E42
0009:8E3B 01           nop
0009:8E3C A0 18        ibt   r0,#0018
0009:8E3E 69           sub   r9
0009:8E3F 50           add   r0
0009:8E40 11 50        add   r0
0009:8E42 00           stop
0009:8E43 01           nop

0009:8E44 FE A1 00     iwt   r14,#00A1
0009:8E47 F2 00 0F     iwt   r2,#0F00
0009:8E4A F3 D6 1C     iwt   r3,#1CD6
0009:8E4D F4 D8 1C     iwt   r4,#1CD8
0009:8E50 F5 60 13     iwt   r5,#1360
0009:8E53 FB 38 1A     iwt   r11,#1A38
0009:8E56 B3 51        add   r1
0009:8E58 16 40        ldw   (r0)
0009:8E5A B4 51        add   r1
0009:8E5C 17 40        ldw   (r0)
0009:8E5E A8 FF        ibt   r8,#FFFF
0009:8E60 28 19        move  r9,r8
0009:8E62 B1 03        lsr
0009:8E64 03           lsr
0009:8E65 AC 18        ibt   r12,#0018
0009:8E67 BC 11 60     sub   r0
0009:8E6A 02           cache
0009:8E6B 2F 1D        move  r13,r15
0009:8E6D BC 61        sub   r1
0009:8E6F 09 33        beq   8EA4
0009:8E71 01           nop
0009:8E72 3D 42        ldb   (r2)
0009:8E74 3E 68        sub   #08
0009:8E76 09 06        beq   8E7E
0009:8E78 01           nop
0009:8E79 3E 67        sub   #07
0009:8E7B 0B 27        bmi   8EA4
0009:8E7D 01           nop
0009:8E7E 45           ldw   (r5)
0009:8E7F 3F 6E        cmp   r14
0009:8E81 08 21        bne   8EA4
0009:8E83 01           nop
0009:8E84 3D 4B        ldb   (r11)
0009:8E86 20 B0        moves r0,r0
0009:8E88 08 1A        bne   8EA4
0009:8E8A 01           nop
0009:8E8B 43           ldw   (r3)
0009:8E8C 66           sub   r6
0009:8E8D 0A 03        bpl   8E92
0009:8E8F 01           nop
0009:8E90 4F           not
0009:8E91 D0           inc   r0
0009:8E92 20 1A        move  r10,r0
0009:8E94 44           ldw   (r4)
0009:8E95 67           sub   r7
0009:8E96 0A 03        bpl   8E9B
0009:8E98 01           nop
0009:8E99 4F           not
0009:8E9A D0           inc   r0
0009:8E9B 5A           add   r10
0009:8E9C 68           sub   r8
0009:8E9D 0D 05        bcs   8EA4
0009:8E9F 58           add   r8
0009:8EA0 20 18        move  r8,r0
0009:8EA2 2C 19        move  r9,r12
0009:8EA4 A0 04        ibt   r0,#0004
0009:8EA6 12 52        add   r2
0009:8EA8 13 53        add   r3
0009:8EAA 14 54        add   r4
0009:8EAC 15 55        add   r5
0009:8EAE 1B 5B        add   r11
0009:8EB0 3C           loop
0009:8EB1 BC 21 B9     moves r1,r9
0009:8EB4 0B 07        bmi   8EBD
0009:8EB6 01           nop
0009:8EB7 A0 18        ibt   r0,#0018
0009:8EB9 69           sub   r9
0009:8EBA 50           add   r0
0009:8EBB 11 50        add   r0
0009:8EBD 00           stop
0009:8EBE 01           nop
0009:8EBF 2E 1B        move  r11,r14
0009:8EC1 DB           inc   r11
0009:8EC2 F2 00 0F     iwt   r2,#0F00
0009:8EC5 F3 D6 1C     iwt   r3,#1CD6
0009:8EC8 F4 D8 1C     iwt   r4,#1CD8
0009:8ECB F5 60 13     iwt   r5,#1360
0009:8ECE B3 51        add   r1
0009:8ED0 16 40        ldw   (r0)
0009:8ED2 B4 51        add   r1
0009:8ED4 17 40        ldw   (r0)
0009:8ED6 A8 FF        ibt   r8,#FFFF
0009:8ED8 28 19        move  r9,r8
0009:8EDA B1 03        lsr
0009:8EDC 03           lsr
0009:8EDD AC 18        ibt   r12,#0018
0009:8EDF BC 11 60     sub   r0
0009:8EE2 02           cache
0009:8EE3 2F 1D        move  r13,r15
0009:8EE5 BC 61        sub   r1
0009:8EE7 09 31        beq   8F1A
0009:8EE9 01           nop
0009:8EEA 3D 42        ldb   (r2)
0009:8EEC 3E 68        sub   #08
0009:8EEE 09 06        beq   8EF6
0009:8EF0 01           nop
0009:8EF1 3E 67        sub   #07
0009:8EF3 0B 25        bmi   8F1A
0009:8EF5 01           nop
0009:8EF6 45           ldw   (r5)
0009:8EF7 3F 6E        cmp   r14
0009:8EF9 0B 1F        bmi   8F1A
0009:8EFB 01           nop
0009:8EFC 3F 6B        cmp   r11
0009:8EFE 0A 1A        bpl   8F1A
0009:8F00 01           nop
0009:8F01 43           ldw   (r3)
0009:8F02 66           sub   r6
0009:8F03 0A 03        bpl   8F08
0009:8F05 01           nop
0009:8F06 4F           not
0009:8F07 D0           inc   r0
0009:8F08 20 1A        move  r10,r0
0009:8F0A 44           ldw   (r4)
0009:8F0B 67           sub   r7
0009:8F0C 0A 03        bpl   8F11
0009:8F0E 01           nop
0009:8F0F 4F           not
0009:8F10 D0           inc   r0
0009:8F11 5A           add   r10
0009:8F12 68           sub   r8
0009:8F13 0D 05        bcs   8F1A
0009:8F15 58           add   r8
0009:8F16 20 18        move  r8,r0
0009:8F18 2C 19        move  r9,r12
0009:8F1A A0 04        ibt   r0,#0004
0009:8F1C 12 52        add   r2
0009:8F1E 13 53        add   r3
0009:8F20 14 54        add   r4
0009:8F22 15 55        add   r5
0009:8F24 3C           loop
0009:8F25 BC 21 B9     moves r1,r9
0009:8F28 0B 07        bmi   8F31
0009:8F2A 01           nop
0009:8F2B A0 18        ibt   r0,#0018
0009:8F2D 69           sub   r9
0009:8F2E 50           add   r0
0009:8F2F 11 50        add   r0
0009:8F31 00           stop
0009:8F32 01           nop

0009:8F33 F2 00 0F     iwt   r2,#0F00
0009:8F36 F3 D6 1C     iwt   r3,#1CD6
0009:8F39 F4 D8 1C     iwt   r4,#1CD8
0009:8F3C F5 38 1D     iwt   r5,#1D38
0009:8F3F B3 51        add   r1
0009:8F41 16 40        ldw   (r0)
0009:8F43 B4 51        add   r1
0009:8F45 17 40        ldw   (r0)
0009:8F47 A8 FF        ibt   r8,#FFFF
0009:8F49 28 19        move  r9,r8
0009:8F4B B1 03        lsr
0009:8F4D 03           lsr
0009:8F4E AC 18        ibt   r12,#0018
0009:8F50 BC 11 60     sub   r0
0009:8F53 02           cache
0009:8F54 EC           dec   r12
0009:8F55 2F 1D        move  r13,r15
0009:8F57 A0 04        ibt   r0,#0004
0009:8F59 12 52        add   r2
0009:8F5B 13 53        add   r3
0009:8F5D 14 54        add   r4
0009:8F5F 15 55        add   r5
0009:8F61 BC 61        sub   r1
0009:8F63 09 28        beq   8F8D
0009:8F65 01           nop
0009:8F66 3D 42        ldb   (r2)
0009:8F68 3E 6E        sub   #0E
0009:8F6A 0C 21        bcc   8F8D
0009:8F6C 01           nop
0009:8F6D 45           ldw   (r5)
0009:8F6E 3E 60        sub   #00
0009:8F70 09 1B        beq   8F8D
0009:8F72 01           nop
0009:8F73 43           ldw   (r3)
0009:8F74 66           sub   r6
0009:8F75 0A 03        bpl   8F7A
0009:8F77 01           nop
0009:8F78 4F           not
0009:8F79 D0           inc   r0
0009:8F7A 20 1A        move  r10,r0
0009:8F7C 44           ldw   (r4)
0009:8F7D 67           sub   r7
0009:8F7E 0A 03        bpl   8F83
0009:8F80 01           nop
0009:8F81 4F           not
0009:8F82 D0           inc   r0
0009:8F83 5A           add   r10
0009:8F84 3F 68        cmp   r8
0009:8F86 0D 05        bcs   8F8D
0009:8F88 01           nop
0009:8F89 20 18        move  r8,r0
0009:8F8B 2C 19        move  r9,r12
0009:8F8D 3C           loop
0009:8F8E BC 21 B9     moves r1,r9
0009:8F91 0B 07        bmi   8F9A
0009:8F93 01           nop
0009:8F94 A0 18        ibt   r0,#0018
0009:8F96 69           sub   r9
0009:8F97 50           add   r0
0009:8F98 11 50        add   r0
0009:8F9A 00           stop
0009:8F9B 01           nop

0009:8F9C F9 5C 0F     iwt   r9,#0F5C
0009:8F9F FA FF 0F     iwt   r10,#0FFF
0009:8FA2 FB 32 1D     iwt   r11,#1D32
0009:8FA5 F8 12 1C     iwt   r8,#1C12
0009:8FA8 A2 04        ibt   r2,#0004
0009:8FAA AE 5C        ibt   r14,#005C
0009:8FAC BE 17 61     sub   r1
0009:8FAF BB 67        sub   r7
0009:8FB1 13 40        ldw   (r0)
0009:8FB3 3E 52        add   #02
0009:8FB5 14 40        ldw   (r0)
0009:8FB7 B8 67        sub   r7
0009:8FB9 15 40        ldw   (r0)
0009:8FBB 3E 52        add   #02
0009:8FBD 16 40        ldw   (r0)
0009:8FBF AC 18        ibt   r12,#0018
0009:8FC1 02           cache
0009:8FC2 2F 1D        move  r13,r15
0009:8FC4 BE 61        sub   r1
0009:8FC6 09 3B        beq   9003
0009:8FC8 01           nop
0009:8FC9 3D 49        ldb   (r9)
0009:8FCB 3E 6E        sub   #0E
0009:8FCD 0C 34        bcc   9003
0009:8FCF 01           nop
0009:8FD0 3D 4A        ldb   (r10)
0009:8FD2 3E 78        and   #08
0009:8FD4 09 2D        beq   9003
0009:8FD6 17 48        ldw   (r8)
0009:8FD8 4B           ldw   (r11)
0009:8FD9 63           sub   r3
0009:8FDA 3E A8 00     sms   (0000),r8
0009:8FDD 55           add   r5
0009:8FDE 57           add   r7
0009:8FDF 0B 22        bmi   9003
0009:8FE1 67           sub   r7
0009:8FE2 67           sub   r7
0009:8FE3 65           sub   r5
0009:8FE4 65           sub   r5
0009:8FE5 0A 1B        bpl   9002
0009:8FE7 DB           inc   r11
0009:8FE8 DB           inc   r11
0009:8FE9 D8           inc   r8
0009:8FEA D8           inc   r8
0009:8FEB 17 48        ldw   (r8)
0009:8FED 4B           ldw   (r11)
0009:8FEE 64           sub   r4
0009:8FEF 3E A0 01     sms   (0002),r0
0009:8FF2 56           add   r6
0009:8FF3 57           add   r7
0009:8FF4 0B 09        bmi   8FFF
0009:8FF6 67           sub   r7
0009:8FF7 67           sub   r7
0009:8FF8 66           sub   r6
0009:8FF9 66           sub   r6
0009:8FFA 0A 03        bpl   8FFF
0009:8FFC 01           nop
0009:8FFD 00           stop
0009:8FFE 01           nop

0009:8FFF E8           dec   r8
0009:9000 E8           dec   r8
0009:9001 EB           dec   r11
0009:9002 EB           dec   r11
0009:9003 2B 62        sub   r2
0009:9005 28 62        sub   r2
0009:9007 29 62        sub   r2
0009:9009 2A 62        sub   r2
0009:900B 2E 62        sub   r2
0009:900D 3C           loop
0009:900E BE 00        stop
0009:9010 01           nop

0009:9011 F9 5C 0F     iwt   r9,#0F5C
0009:9014 FB 32 1D     iwt   r11,#1D32
0009:9017 F8 12 1C     iwt   r8,#1C12
0009:901A A2 04        ibt   r2,#0004
0009:901C AE 5C        ibt   r14,#005C
0009:901E BE 17 61     sub   r1
0009:9021 BB 67        sub   r7
0009:9023 13 40        ldw   (r0)
0009:9025 3E 52        add   #02
0009:9027 14 40        ldw   (r0)
0009:9029 B8 67        sub   r7
0009:902B 15 40        ldw   (r0)
0009:902D 3E 52        add   #02
0009:902F 16 40        ldw   (r0)
0009:9031 AC 18        ibt   r12,#0018
0009:9033 02           cache
0009:9034 2F 1D        move  r13,r15
0009:9036 BE 61        sub   r1
0009:9038 09 36        beq   9070
0009:903A 01           nop
0009:903B 3D 49        ldb   (r9)
0009:903D 3E 6E        sub   #0E
0009:903F 0C 2F        bcc   9070
0009:9041 17 48        ldw   (r8)
0009:9043 B7 55        add   r5
0009:9045 1A 50        add   r0
0009:9047 DA           inc   r10
0009:9048 4B           ldw   (r11)
0009:9049 63           sub   r3
0009:904A 3E A0 00     sms   (0000),r0
0009:904D 55           add   r5
0009:904E 57           add   r7
0009:904F 3F 6A        cmp   r10
0009:9051 0D 1C        bcs   906F
0009:9053 DB           inc   r11
0009:9054 DB           inc   r11
0009:9055 D8           inc   r8
0009:9056 D8           inc   r8
0009:9057 17 48        ldw   (r8)
0009:9059 B7 56        add   r6
0009:905B 1A 50        add   r0
0009:905D DA           inc   r10
0009:905E 4B           ldw   (r11)
0009:905F 64           sub   r4
0009:9060 3E A0 01     sms   (0002),r0
0009:9063 56           add   r6
0009:9064 57           add   r7
0009:9065 3F 6A        cmp   r10
0009:9067 0D 03        bcs   906C
0009:9069 01           nop
0009:906A 00           stop
0009:906B 01           nop

0009:906C E8           dec   r8
0009:906D E8           dec   r8
0009:906E EB           dec   r11
0009:906F EB           dec   r11
0009:9070 2B 62        sub   r2
0009:9072 28 62        sub   r2
0009:9074 29 62        sub   r2
0009:9076 2E 62        sub   r2
0009:9078 3C           loop
0009:9079 BE 00        stop
0009:907B 01           nop

0009:907C B1 63        sub   r3
0009:907E 20 15        move  r5,r0
0009:9080 0A 03        bpl   9085
0009:9082 01           nop
0009:9083 4F           not
0009:9084 D0           inc   r0
0009:9085 20 17        move  r7,r0
0009:9087 B2 64        sub   r4
0009:9089 20 18        move  r8,r0
0009:908B 0A 03        bpl   9090
0009:908D 01           nop
0009:908E 4F           not
0009:908F D0           inc   r0
0009:9090 20 19        move  r9,r0
0009:9092 67           sub   r7
0009:9093 0D 07        bcs   909C
0009:9095 97           ror
0009:9096 27 10        move  r0,r7
0009:9098 29 17        move  r7,r9
0009:909A 20 19        move  r9,r0
0009:909C 20 1A        move  r10,r0
0009:909E 27 3D 9F     lmult
0009:90A1 60           sub   r0
0009:90A2 20 12        move  r2,r0
0009:90A4 AC 20        ibt   r12,#0020
0009:90A6 FD AB 90     iwt   r13,#90AB
0009:90A9 02           cache
0009:90AA 22 52        add   r2
0009:90AC 24 54        add   r4
0009:90AE 27 04        rol
0009:90B0 04           rol
0009:90B1 69           sub   r9
0009:90B2 0C 03        bcc   90B7
0009:90B4 59           add   r9
0009:90B5 69           sub   r9
0009:90B6 D2           inc   r2
0009:90B7 3C           loop
0009:90B8 22 2A BA     moves r10,r10
0009:90BB 0A 07        bpl   90C4
0009:90BD 01           nop
0009:90BE 26 10        move  r0,r6
0009:90C0 22 16        move  r6,r2
0009:90C2 20 12        move  r2,r0
0009:90C4 26 11        move  r1,r6
0009:90C6 25 B5        moves r5,r5
0009:90C8 0A 03        bpl   90CD
0009:90CA 21 4F        not
0009:90CC D1           inc   r1
0009:90CD 28 B8        moves r8,r8
0009:90CF 0A 03        bpl   90D4
0009:90D1 22 4F        not
0009:90D3 D2           inc   r2
0009:90D4 00           stop
0009:90D5 01           nop

0009:90D6 A0 08        ibt   r0,#0008
0009:90D8 3F DF        romb
0009:90DA A2 06        ibt   r2,#0006
0009:90DC A9 55        ibt   r9,#0055
0009:90DE AA 40        ibt   r10,#0040
0009:90E0 FB 18 AE     iwt   r11,#AE18
0009:90E3 BB 1E 57     add   r7
0009:90E6 02           cache
0009:90E7 FC 03 00     iwt   r12,#0003
0009:90EA FD EE 90     iwt   r13,#90EE
0009:90ED EF           getb
0009:90EE 2E 5A        add   r10
0009:90F0 88           mult  r8
0009:90F1 C0           hib
0009:90F2 95           sex
0009:90F3 E6           dec   r6
0009:90F4 0B 03        bmi   90F9
0009:90F6 D6           inc   r6
0009:90F7 4F           not
0009:90F8 D0           inc   r0
0009:90F9 54           add   r4
0009:90FA 31           stw   (r1)
0009:90FB D1           inc   r1
0009:90FC D1           inc   r1
0009:90FD EF           getb
0009:90FE 27 59        add   r9
0009:9100 27 9E        lob
0009:9102 BB 1E 57     add   r7
0009:9105 88           mult  r8
0009:9106 C0           hib
0009:9107 95           sex
0009:9108 55           add   r5
0009:9109 31           stw   (r1)
0009:910A 21 52        add   r2
0009:910C 3C           loop
0009:910D EF           getb
0009:910E 00           stop
0009:910F 01           nop

DATA_099110:         dw $2A22, $2E2C, $2600, $0000
DATA_099118:         dw $0028, $0000, $0402, $0E0C
DATA_099120:         dw $0620, $0A08

0009:9126 A7 10        ibt r7,#0010
0009:9128 B4 67        sub   r7
0009:912A 03           lsr
0009:912B 22 60        sub   r0
0009:912D B5 67        sub   r7
0009:912F 03           lsr
0009:9130 23 60        sub   r0
0009:9132 A0 09        ibt   r0,#0009
0009:9134 3F DF        romb
0009:9136 B5 67        sub   r7
0009:9138 08 10        bne   914A
0009:913A B4 67        sub   r7
0009:913C 08 07        bne   9145
0009:913E FE 10 91     iwt   r14,#9110
0009:9141 05 13        bra   9156

0009:9143 01           nop
0009:9144 FE 11 91     iwt   r14,#9111
0009:9147 05 0D        bra   9156

0009:9149 01           nop
0009:914A 67           sub   r7
0009:914B 08 07        bne   9154
0009:914D FE 14 91     iwt   r14,#9114
0009:9150 05 04        bra   9156

0009:9152 01           nop

0009:9153 FE 1D 91     iwt   r14,#911D
0009:9156 A9 02        ibt   r9,#0002
0009:9158 FD 00 80     iwt   r13,#8000
0009:915B 02           cache
0009:915C 94           link  #04
0009:915D FF 88 91     iwt   r15,#9188
0009:9160 01           nop
0009:9161 25 67        sub   r7
0009:9163 09 21        beq   9186
0009:9165 01           nop
0009:9166 23 57        add   r7
0009:9168 25 67        sub   r7
0009:916A 09 0F        beq   917B
0009:916C 01           nop
0009:916D 94           link  #04
0009:916E FF 88 91     iwt   r15,#9188
0009:9171 01           nop
0009:9172 2E 3E 63     sub   #03
0009:9175 26 3D CD     xor   r13
0009:9178 05 ED        bra   9167

0009:917A 23 2E 3E 53  add   #03
0009:917E 26 3D 7D     bic   r13
0009:9181 94           link  #04
0009:9182 FF 88 91     iwt   r15,#9188
0009:9185 01           nop
0009:9186 00           stop
0009:9187 01           nop

0009:9188 22 18        move  r8,r2
0009:918A 24 1A        move  r10,r4
0009:918C B8 31        stw   (r1)
0009:918E D1           inc   r1
0009:918F D1           inc   r1
0009:9190 B3 31        stw   (r1)
0009:9192 D1           inc   r1
0009:9193 D1           inc   r1
0009:9194 EF           getb
0009:9195 DE           inc   r14
0009:9196 56           add   r6
0009:9197 31           stw   (r1)
0009:9198 D1           inc   r1
0009:9199 D1           inc   r1
0009:919A B9 31        stw   (r1)
0009:919C 2A 67        sub   r7
0009:919E 09 31        beq   91D1
0009:91A0 D1           inc   r1
0009:91A1 D1           inc   r1
0009:91A2 EF           getb
0009:91A3 DE           inc   r14
0009:91A4 1C 56        add   r6
0009:91A6 28 57        add   r7
0009:91A8 2A 67        sub   r7
0009:91AA 09 12        beq   91BE
0009:91AC B8 31        stw   (r1)
0009:91AE D1           inc   r1
0009:91AF D1           inc   r1
0009:91B0 B3 31        stw   (r1)
0009:91B2 D1           inc   r1
0009:91B3 D1           inc   r1
0009:91B4 BC 31        stw   (r1)
0009:91B6 D1           inc   r1
0009:91B7 D1           inc   r1
0009:91B8 B9 31        stw   (r1)
0009:91BA D1           inc   r1
0009:91BB 05 E9        bra   91A6

0009:91BD D1           inc   r1

0009:91BE B8 31        stw   (r1)
0009:91C0 D1           inc   r1
0009:91C1 D1           inc   r1
0009:91C2 B3 31        stw   (r1)
0009:91C4 D1           inc   r1
0009:91C5 D1           inc   r1
0009:91C6 EF           getb
0009:91C7 DE           inc   r14
0009:91C8 56           add   r6
0009:91C9 31           stw   (r1)
0009:91CA D1           inc   r1
0009:91CB D1           inc   r1
0009:91CC B9 31        stw   (r1)
0009:91CE D1           inc   r1
0009:91CF 9B           jmp   r11
0009:91D0 D1           inc   r1

0009:91D1 DE           inc   r14
0009:91D2 DE           inc   r14
0009:91D3 9B           jmp   r11
0009:91D4 D1           inc   r1

0009:91D5 F4 22 00     iwt   r4,#0022
0009:91D8 F5 2C 00     iwt   r5,#002C
0009:91DB A1 04        ibt   r1,#0004
0009:91DD F2 00 0F     iwt   r2,#0F00
0009:91E0 F3 60 13     iwt   r3,#1360
0009:91E3 A6 00        ibt   r6,#0000
0009:91E5 02           cache
0009:91E6 AC 18        ibt   r12,#0018
0009:91E8 2F 1D        move  r13,r15
0009:91EA 42           ldw   (r2)
0009:91EB 3E 60        sub   #00
0009:91ED 09 0D        beq   91FC
0009:91EF 01           nop
0009:91F0 43           ldw   (r3)
0009:91F1 3F 64        cmp   r4
0009:91F3 0C 07        bcc   91FC
0009:91F5 01           nop
0009:91F6 3F 65        cmp   r5
0009:91F8 0D 02        bcs   91FC
0009:91FA 01           nop
0009:91FB D6           inc   r6
0009:91FC 22 51        add   r1
0009:91FE 23 51        add   r1
0009:9200 3C           loop
0009:9201 01           nop
0009:9202 00           stop
0009:9203 01           nop

0009:9204 F4 22 00     iwt   r4,#0022
0009:9207 F5 2C 00     iwt   r5,#002C
0009:920A F7 1E 00     iwt   r7,#001E
0009:920D F8 33 01     iwt   r8,#0133
0009:9210 F9 9A 01     iwt   r9,#019A
0009:9213 FB F3 00     iwt   r11,#00F3
0009:9216 A1 04        ibt   r1,#0004
0009:9218 F2 00 0F     iwt   r2,#0F00
0009:921B F3 60 13     iwt   r3,#1360
0009:921E A6 00        ibt   r6,#0000
0009:9220 02           cache
0009:9221 AC 18        ibt   r12,#0018
0009:9223 2F 1D        move  r13,r15
0009:9225 42           ldw   (r2)
0009:9226 3E 60        sub   #00
0009:9228 09 21        beq   924B
0009:922A 01           nop
0009:922B 43           ldw   (r3)
0009:922C 3F 64        cmp   r4
0009:922E 0C 06        bcc   9236
0009:9230 01           nop
0009:9231 3F 65        cmp   r5
0009:9233 0C 15        bcc   924A
0009:9235 01           nop
0009:9236 3F 67        cmp   r7
0009:9238 09 10        beq   924A
0009:923A 01           nop
0009:923B 3F 68        cmp   r8
0009:923D 09 0B        beq   924A
0009:923F 01           nop
0009:9240 3F 69        cmp   r9
0009:9242 09 06        beq   924A
0009:9244 01           nop
0009:9245 3F 6B        cmp   r11
0009:9247 08 02        bne   924B
0009:9249 01           nop
0009:924A D6           inc   r6
0009:924B 22 51        add   r1
0009:924D 23 51        add   r1
0009:924F 3C           loop
0009:9250 01           nop
0009:9251 00           stop
0009:9252 01           nop

0009:9253 F5 BC 13     iwt   r5,#13BC
0009:9256 F6 5C 0F     iwt   r6,#0F5C
0009:9259 F7 32 1D     iwt   r7,#1D32
0009:925C F8 34 1D     iwt   r8,#1D34
0009:925F F9 FF 0F     iwt   r9,#0FFF
0009:9262 BA 1E 5A     add   r10
0009:9265 02           cache
0009:9266 AC 18        ibt   r12,#0018
0009:9268 2F 1D        move  r13,r15
0009:926A 3D 46        ldb   (r6)
0009:926C 3E 6F        sub   #0F
0009:926E 0B 0F        bmi   927F
0009:9270 01           nop
0009:9271 47           ldw   (r7)
0009:9272 61           sub   r1
0009:9273 5A           add   r10
0009:9274 6E           sub   r14
0009:9275 0D 08        bcs   927F
0009:9277 01           nop
0009:9278 48           ldw   (r8)
0009:9279 62           sub   r2
0009:927A 5A           add   r10
0009:927B 6E           sub   r14
0009:927C 0C 06        bcc   9284
0009:927E BC FF 2B 93  iwt   r15,#932B
0009:9282 A0 04        ibt   r0,#0004
0009:9284 3E 61        sub   #01
0009:9286 50           add   r0
0009:9287 3E A6 26     sms   (004C),r6
0009:928A 16 50        add   r0
0009:928C F3 08 01     iwt   r3,#0108
0009:928F 45           ldw   (r5)
0009:9290 3F 63        cmp   r3
0009:9292 09 11        beq   92A5
0009:9294 01           nop
0009:9295 F3 20 92     iwt   r3,#9220
0009:9298 3F 63        cmp   r3
0009:929A 09 09        beq   92A5
0009:929C 01           nop
0009:929D F3 20 92     iwt   r3,#9220
0009:92A0 3F 63        cmp   r3
0009:92A2 08 1A        bne   92BE
0009:92A4 01           nop
0009:92A5 F0 D6 19     iwt   r0,#19D6
0009:92A8 56           add   r6
0009:92A9 40           ldw   (r0)
0009:92AA 3E 60        sub   #00
0009:92AC 08 79        bne   9327
0009:92AE 01           nop
0009:92AF F0 40 10     iwt   r0,#1040
0009:92B2 56           add   r6
0009:92B3 1B 40        ldw   (r0)
0009:92B5 F0 00 19     iwt   r0,#1900
0009:92B8 56           add   r6
0009:92B9 BB 30        stw   (r0)
0009:92BB 05 23        bra   92E0

0009:92BD 01           nop

0009:92BE F3 32 01     iwt   r3,#0132
0009:92C1 3F 63        cmp   r3
0009:92C3 08 14        bne   92D9
0009:92C5 01           nop
0009:92C6 F0 D6 19     iwt   r0,#19D6
0009:92C9 56           add   r6
0009:92CA 40           ldw   (r0)
0009:92CB 3E 63        sub   #03
0009:92CD 09 58        beq   9327
0009:92CF 01           nop
0009:92D0 E0           dec   r0
0009:92D1 08 0D        bne   92E0
0009:92D3 01           nop
0009:92D4 05 52        bra   9328

0009:92D6 3D A6 26     lms   r6,(004C)
0009:92D9 3D 49        ldb   (r9)
0009:92DB 3E 78        and   #08
0009:92DD 09 48        beq   9327
0009:92DF 01           nop
0009:92E0 3D A4 00     lms   r4,(0000)
0009:92E3 47           ldw   (r7)
0009:92E4 61           sub   r1
0009:92E5 0A 04        bpl   92EB
0009:92E7 01           nop
0009:92E8 24 4F        not
0009:92EA D4           inc   r4
0009:92EB F0 20 12     iwt   r0,#1220
0009:92EE 56           add   r6
0009:92EF B4 30        stw   (r0)
0009:92F1 3D A4 01     lms   r4,(0002)
0009:92F4 F0 22 12     iwt   r0,#1222
0009:92F7 56           add   r6
0009:92F8 B4 30        stw   (r0)
0009:92FA 24 64        sub   r4
0009:92FC F0 78 19     iwt   r0,#1978
0009:92FF 56           add   r6
0009:9300 B4 30        stw   (r0)
0009:9302 F0 40 15     iwt   r0,#1540
0009:9305 56           add   r6
0009:9306 B4 30        stw   (r0)
0009:9308 D4           inc   r4
0009:9309 F0 38 1D     iwt   r0,#1D38
0009:930C 56           add   r6
0009:930D B4 30        stw   (r0)
0009:930F A4 40        ibt   r4,#0040
0009:9311 F0 42 15     iwt   r0,#1542
0009:9314 56           add   r6
0009:9315 B4 30        stw   (r0)
0009:9317 F4 FC FF     iwt   r4,#FFFC
0009:931A 49           ldw   (r9)
0009:931B 74           and   r4
0009:931C 90           sbk
0009:931D F4 FF F9     iwt   r4,#F9FF
0009:9320 F0 A0 0F     iwt   r0,#0FA0
0009:9323 56           add   r6
0009:9324 40           ldw   (r0)
0009:9325 74           and   r4
0009:9326 90           sbk
0009:9327 3D A6 26     lms   r6,(004C)
0009:932A A0 04        ibt   r0,#0004
0009:932C 25 60        sub   r0
0009:932E 26 60        sub   r0
0009:9330 27 60        sub   r0
0009:9332 28 60        sub   r0
0009:9334 29 60        sub   r0
0009:9336 3C           loop
0009:9337 01           nop
0009:9338 00           stop
0009:9339 01           nop

0009:933A 02           cache
0009:933B AC 18        ibt   r12,#0018
0009:933D 2F 1D        move  r13,r15
0009:933F F2 10 00     iwt   r2,#0010
0009:9342 BC 3E 61     sub   #01
0009:9345 50           add   r0
0009:9346 11 50        add   r0
0009:9348 F0 00 0F     iwt   r0,#0F00
0009:934B 51           add   r1
0009:934C 40           ldw   (r0)
0009:934D 62           sub   r2
0009:934E 08 4E        bne   939E
0009:9350 01           nop
0009:9351 F3 07 00     iwt   r3,#0007
0009:9354 A0 09        ibt   r0,#0009
0009:9356 3F DF        romb
0009:9358 FE A5 93     iwt   r14,#93A5
0009:935B EF           getb
0009:935C DE           inc   r14
0009:935D 12 3D EF     getbh
0009:9360 F0 60 13     iwt   r0,#1360
0009:9363 51           add   r1
0009:9364 40           ldw   (r0)
0009:9365 62           sub   r2
0009:9366 09 07        beq   936F
0009:9368 E3           dec   r3
0009:9369 08 F0        bne   935B
0009:936B DE           inc   r14
0009:936C 05 30        bra   939E

0009:936E 01           nop

0009:936F F0 D6 1C     iwt   r0,#1CD6
0009:9372 51           add   r1
0009:9373 40           ldw   (r0)
0009:9374 12 65        sub   r5
0009:9376 0A 03        bpl   937B
0009:9378 22 4F        not
0009:937A D2           inc   r2
0009:937B F0 B6 1B     iwt   r0,#1BB6
0009:937E 51           add   r1
0009:937F 40           ldw   (r0)
0009:9380 57           add   r7
0009:9381 62           sub   r2
0009:9382 0B 1A        bmi   939E
0009:9384 01           nop
0009:9385 F0 D8 1C     iwt   r0,#1CD8
0009:9388 51           add   r1
0009:9389 40           ldw   (r0)
0009:938A 12 66        sub   r6
0009:938C 0A 03        bpl   9391
0009:938E 22 4F        not
0009:9390 D2           inc   r2
0009:9391 F0 B8 1B     iwt   r0,#1BB8
0009:9394 51           add   r1
0009:9395 40           ldw   (r0)
0009:9396 57           add   r7
0009:9397 62           sub   r2
0009:9398 0B 04        bmi   939E
0009:939A 01           nop
0009:939B 05 06        bra   93A3

0009:939D 01           nop

0009:939E 3C           loop
0009:939F 01           nop
0009:93A0 F1 FF FF     iwt   r1,#FFFF
0009:93A3 00           stop
0009:93A4 01           nop

DATA_0993A5:         dw $00DE, $0089, $008A, $0185
DATA_0993AD:         dw $0186, $0189, $018A

0009:93B3 3D A1 4A     lms   r1,(0094)
0009:93B6 3D F0 0C 1E  lm    r0,(1E0C)
0009:93BA 12 9E        lob
0009:93BC 26 B8        moves r6,r8
0009:93BE 09 18        beq   93D8
0009:93C0 B2 3D 9F     lmult
0009:93C3 24 C0        hib
0009:93C5 9E           lob
0009:93C6 4D           swap
0009:93C7 13 C4        or    r4
0009:93C9 B1 3D 9F     lmult
0009:93CC 24 53        add   r3
0009:93CE 24 C0        hib
0009:93D0 3F 50        adc   #00
0009:93D2 9E           lob
0009:93D3 4D           swap
0009:93D4 C4           or    r4
0009:93D5 3E A0 4B     sms   (0096),r0
0009:93D8 26 BA        moves r6,r10
0009:93DA 09 18        beq   93F4
0009:93DC B2 3D 9F     lmult
0009:93DF 24 C0        hib
0009:93E1 9E           lob
0009:93E2 4D           swap
0009:93E3 13 C4        or    r4
0009:93E5 B1 3D 9F     lmult
0009:93E8 24 53        add   r3
0009:93EA 24 C0        hib
0009:93EC 3F 50        adc   #00
0009:93EE 9E           lob
0009:93EF 4D           swap
0009:93F0 C4           or    r4
0009:93F1 3E A0 4C     sms   (0098),r0
0009:93F4 26 BC        moves r6,r12
0009:93F6 09 18        beq   9410
0009:93F8 B2 3D 9F     lmult
0009:93FB 24 C0        hib
0009:93FD 9E           lob
0009:93FE 4D           swap
0009:93FF 13 C4        or    r4
0009:9401 B1 3D 9F     lmult
0009:9404 24 53        add   r3
0009:9406 24 C0        hib
0009:9408 3F 50        adc   #00
0009:940A 9E           lob
0009:940B 4D           swap
0009:940C C4           or    r4
0009:940D 3E A0 4D     sms   (009A),r0
0009:9410 F0 0C 07     iwt   r0,#070C
0009:9413 3D A5 4E     lms   r5,(009C)
0009:9416 11 65        sub   r5
0009:9418 3D F0 0E 1E  lm    r0,(1E0E)
0009:941C 12 9E        lob
0009:941E 26 B9        moves r6,r9
0009:9420 09 29        beq   944B
0009:9422 01           nop
0009:9423 0A 06        bpl   942B
0009:9425 B2 25 10     move  r0,r5
0009:9428 05 1E        bra   9448

0009:942A 01           nop

0009:942B 3D 9F        lmult
0009:942D 24 C0        hib
0009:942F 9E           lob
0009:9430 4D           swap
0009:9431 13 C4        or    r4
0009:9433 B1 3D 9F     lmult
0009:9436 24 53        add   r3
0009:9438 24 C0        hib
0009:943A 3F 50        adc   #00
0009:943C 9E           lob
0009:943D 4D           swap
0009:943E 13 C4        or    r4
0009:9440 F0 26 03     iwt   r0,#0326
0009:9443 63           sub   r3
0009:9444 0A 02        bpl   9448
0009:9446 01           nop
0009:9447 60           sub   r0
0009:9448 3E A0 4F     sms   (009E),r0
0009:944B 26 BB        moves r6,r11
0009:944D 09 29        beq   9478
0009:944F 01           nop
0009:9450 0A 06        bpl   9458
0009:9452 B2 25 10     move  r0,r5
0009:9455 05 1E        bra   9475

0009:9457 01           nop

0009:9458 3D 9F        lmult
0009:945A 24 C0        hib
0009:945C 9E           lob
0009:945D 4D           swap
0009:945E 13 C4        or    r4
0009:9460 B1 3D 9F     lmult
0009:9463 24 53        add   r3
0009:9465 24 C0        hib
0009:9467 3F 50        adc   #00
0009:9469 9E           lob
0009:946A 4D           swap
0009:946B 13 C4        or    r4
0009:946D F0 26 01     iwt   r0,#0126
0009:9470 63           sub   r3
0009:9471 0A 02        bpl   9475
0009:9473 01           nop
0009:9474 60           sub   r0
0009:9475 3E A0 50     sms   (00A0),r0
0009:9478 26 BD        moves r6,r13
0009:947A 09 29        beq   94A5
0009:947C 01           nop
0009:947D 0A 06        bpl   9485
0009:947F B2 25 10     move  r0,r5
0009:9482 05 1E        bra   94A2

0009:9484 01           nop

0009:9485 3D 9F        lmult
0009:9487 24 C0        hib
0009:9489 9E           lob
0009:948A 4D           swap
0009:948B 13 C4        or    r4
0009:948D B1 3D 9F     lmult
0009:9490 24 53        add   r3
0009:9492 24 C0        hib
0009:9494 3F 50        adc   #00
0009:9496 9E           lob
0009:9497 4D           swap
0009:9498 13 C4        or    r4
0009:949A F0 26 01     iwt   r0,#0126
0009:949D 63           sub   r3
0009:949E 0A 02        bpl   94A2
0009:94A0 01           nop
0009:94A1 60           sub   r0
0009:94A2 3E A0 51     sms   (00A2),r0
0009:94A5 00           stop
0009:94A6 01           nop

DATA_0994A7:         db $00, $00, $00, $06, $00, $00, $06, $00
DATA_0994AF:         db $00, $04, $00, $00, $06, $00, $00, $02
DATA_0994B7:         db $00, $00, $06, $00, $00, $01, $00, $00
DATA_0994BF:         db $06, $00, $00, $06, $00, $00, $02, $00
DATA_0994C7:         db $00, $01, $01, $00, $04, $00, $00, $01
DATA_0994CF:         db $00, $01, $01, $01, $01, $00, $00, $00

; update camera
0009:94D7 3D F0 2A 1E  lm    r0,(1E2A)
0009:94DB 3E 60        sub   #00
0009:94DD 09 1A        beq   94F9
0009:94DF 01           nop
0009:94E0 0B 11        bmi   94F3
0009:94E2 60           sub   r0
0009:94E3 3D F0 36 1E  lm    r0,(1E36)
0009:94E7 11 50        add   r0
0009:94E9 FD 00 00     iwt   r13,#0000
0009:94EC 3D F0 2E 1E  lm    r0,(1E2E)
0009:94F0 05 29        bra   951B

0009:94F2 01           nop
0009:94F3 A1 00        ibt   r1,#0000
0009:94F5 FF 8A 95     iwt   r15,#958A
0009:94F8 01           nop
0009:94F9 3D F0 10 1E  lm    r0,(1E10)
0009:94FD 11 9E        lob
0009:94FF 3D F0 12 1E  lm    r0,(1E12)
0009:9503 9E           lob
0009:9504 4D           swap
0009:9505 11 C1        or    r1
0009:9507 3D A0 45     lms   r0,(008A)
0009:950A 13 9E        lob
0009:950C 3D A0 46     lms   r0,(008C)
0009:950F 9E           lob
0009:9510 4D           swap
0009:9511 C3           or    r3
0009:9512 61           sub   r1
0009:9513 11 50        add   r0
0009:9515 FD 00 01     iwt   r13,#0100
0009:9518 3D A0 46     lms   r0,(008C)
0009:951B 3D A3 4A     lms   r3,(0094)
0009:951E 63           sub   r3
0009:951F 3D F4 20 1E  lm    r4,(1E20)
0009:9523 64           sub   r4
0009:9524 0B 29        bmi   954F
0009:9526 01           nop
0009:9527 A3 18        ibt   r3,#0018
0009:9529 63           sub   r3
0009:952A E0           dec   r0
0009:952B 0A 22        bpl   954F
0009:952D D0           inc   r0
0009:952E A0 30        ibt   r0,#0030
0009:9530 3D A3 62     lms   r3,(00C4)
0009:9533 E3           dec   r3
0009:9534 0B 04        bmi   953A
0009:9536 01           nop
0009:9537 F0 A8 00     iwt   r0,#00A8
0009:953A 64           sub   r4
0009:953B A3 50        ibt   r3,#0050
0009:953D 53           add   r3
0009:953E 0B 07        bmi   9547
0009:9540 01           nop
0009:9541 F3 A0 00     iwt   r3,#00A0
0009:9544 63           sub   r3
0009:9545 0C 05        bcc   954C
0009:9547 54           add   r4
0009:9548 3E F0 20 1E  sm    (1E20),r0
0009:954C 05 3C        bra   958A

0009:954E 60           sub   r0
0009:954F 21 B1        moves r1,r1
0009:9551 08 0B        bne   955E
0009:9553 01           nop
0009:9554 2D 11        move  r1,r13
0009:9556 3E 60        sub   #00
0009:9558 0A 04        bpl   955E
0009:955A 01           nop
0009:955B 21 4F        not
0009:955D D1           inc   r1
0009:955E 13 3D C1     xor   r1
0009:9561 0A 04        bpl   9567
0009:9563 14           to    r4
0009:9564 05 22        bra   9588

0009:9566 54           add   r4
0009:9567 20 13        move  r3,r0
0009:9569 2D 14        move  r4,r13
0009:956B 21 B1        moves r1,r1
0009:956D 0A 04        bpl   9573
0009:956F 01           nop
0009:9570 24 4F        not
0009:9572 D4           inc   r4
0009:9573 B1 64        sub   r4
0009:9575 3D C1        xor   r1
0009:9577 0A 03        bpl   957C
0009:9579 01           nop
0009:957A 24 11        move  r1,r4
0009:957C 23 10        move  r0,r3
0009:957E A4 30        ibt   r4,#0030
0009:9580 21 B1        moves r1,r1
0009:9582 0A 05        bpl   9589
0009:9584 B4 F4 A8 00  iwt   r4,#00A8
0009:9588 B4 90        sbk
0009:958A 13 3E 5A     add   #0A
0009:958D 0B 07        bmi   9596
0009:958F 01           nop
0009:9590 13 3E 6A     sub   #0A
0009:9593 0B 02        bmi   9597
0009:9595 01           nop
0009:9596 63           sub   r3
0009:9597 9E           lob
0009:9598 4D           swap
0009:9599 3D C1        xor   r1
0009:959B 0A 02        bpl   959F
0009:959D 01           nop
0009:959E B1 3D C1     xor   r1
0009:95A1 61           sub   r1
0009:95A2 13 3D C1     xor   r1
0009:95A5 0A 03        bpl   95AA
0009:95A7 51           add   r1
0009:95A8 20 11        move  r1,r0
0009:95AA 3D F0 0C 1E  lm    r0,(1E0C)
0009:95AE 9E           lob
0009:95AF 51           add   r1
0009:95B0 90           sbk
0009:95B1 C0           hib
0009:95B2 95           sex
0009:95B3 3D A1 4A     lms   r1,(0094)
0009:95B6 51           add   r1
0009:95B7 3D F1 18 1E  lm    r1,(1E18)
0009:95BB 61           sub   r1
0009:95BC 0A 08        bpl   95C6
0009:95BE 51           add   r1
0009:95BF 60           sub   r0
0009:95C0 3E F0 0C 1E  sm    (1E0C),r0
0009:95C4 21 10        move  r0,r1
0009:95C6 3D F1 1A 1E  lm    r1,(1E1A)
0009:95CA 61           sub   r1
0009:95CB 0B 08        bmi   95D5
0009:95CD 51           add   r1
0009:95CE 60           sub   r0
0009:95CF 3E F0 0C 1E  sm    (1E0C),r0
0009:95D3 21 10        move  r0,r1
0009:95D5 20 11        move  r1,r0
0009:95D7 3D F0 2A 1E  lm    r0,(1E2A)
0009:95DB 3E 60        sub   #00
0009:95DD 09 21        beq   9600
0009:95DF 01           nop
0009:95E0 0B 16        bmi   95F8
0009:95E2 01           nop
0009:95E3 3D F2 38 1E  lm    r2,(1E38)
0009:95E7 B2 3D 96     div2
0009:95EA 3D 96        div2
0009:95EC 12 52        add   r2
0009:95EE FD 00 00     iwt   r13,#0000
0009:95F1 3D F0 30 1E  lm    r0,(1E30)
0009:95F5 05 31        bra   9628

0009:95F7 01           nop
0009:95F8 A3 00        ibt   r3,#0000
0009:95FA A2 00        ibt   r2,#0000
0009:95FC FF 0D 97     iwt   r15,#970D
0009:95FF 01           nop
0009:9600 3D F0 14 1E  lm    r0,(1E14)
0009:9604 12 9E        lob
0009:9606 3D F0 16 1E  lm    r0,(1E16)
0009:960A 9E           lob
0009:960B 4D           swap
0009:960C 12 C2        or    r2
0009:960E 3D A0 47     lms   r0,(008E)
0009:9611 13 9E        lob
0009:9613 3D A0 48     lms   r0,(0090)
0009:9616 9E           lob
0009:9617 4D           swap
0009:9618 C3           or    r3
0009:9619 62           sub   r2
0009:961A 20 12        move  r2,r0
0009:961C 3D 96        div2
0009:961E 3D 96        div2
0009:9620 12 52        add   r2
0009:9622 FD 00 02     iwt   r13,#0200
0009:9625 3D A0 48     lms   r0,(0090)
0009:9628 3D A3 4E     lms   r3,(009C)
0009:962B 63           sub   r3
0009:962C 3D F4 22 1E  lm    r4,(1E22)
0009:9630 13 64        sub   r4
0009:9632 0B 07        bmi   963B
0009:9634 23 3E 68     sub   #08
0009:9637 0A 02        bpl   963B
0009:9639 13 60        sub   r0
0009:963B 3D F0 2A 1E  lm    r0,(1E2A)
0009:963F 3E 60        sub   #00
0009:9641 09 05        beq   9648
0009:9643 01           nop
0009:9644 FF 0D 97     iwt   r15,#970D
0009:9647 01           nop
0009:9648 3D F5 71 00  lm    r5,(0071)
0009:964C B5 3F 7C     bic   #0C
0009:964F 3D AE 54     lms   r14,(00A8)
0009:9652 CE           or    r14
0009:9653 3D AE 60     lms   r14,(00C0)
0009:9656 CE           or    r14
0009:9657 08 31        bne   968A
0009:9659 60           sub   r0
0009:965A 3D A0 57     lms   r0,(00AE)
0009:965D 3E 64        sub   #04
0009:965F 09 29        beq   968A
0009:9661 B5 3E 7C     and   #0C
0009:9664 09 1D        beq   9683
0009:9666 60           sub   r0
0009:9667 3D F0 24 1E  lm    r0,(1E24)
0009:966B D0           inc   r0
0009:966C A4 10        ibt   r4,#0010
0009:966E 64           sub   r4
0009:966F 0C 12        bcc   9683
0009:9671 54           add   r4
0009:9672 F4 A0 00     iwt   r4,#00A0
0009:9675 B5 3E 78     and   #08
0009:9678 08 03        bne   967D
0009:967A 01           nop
0009:967B A4 64        ibt   r4,#0064
0009:967D 60           sub   r0
0009:967E 90           sbk
0009:967F 24           with  r4
0009:9680 05 1A        bra   969C

0009:9682 10 3E F0 24+ sm    (1E24),r0
0009:9687 05 17        bra   96A0

0009:9689 01           nop
0009:968A 3E F0 24 1E  sm    (1E24),r0
0009:968E 23 B3        moves r3,r3
0009:9690 09 68        beq   96FA
0009:9692 01           nop
0009:9693 A0 64        ibt   r0,#0064
0009:9695 64           sub   r4
0009:9696 15 3D C3     xor   r3
0009:9699 0A 05        bpl   96A0
0009:969B 54           add   r4
0009:969C 3E F0 22 1E  sm    (1E22),r0
0009:96A0 23 B3        moves r3,r3
0009:96A2 0A 56        bpl   96FA
0009:96A4 01           nop
0009:96A5 3D A0 60     lms   r0,(00C0)
0009:96A8 3E 60        sub   #00
0009:96AA 09 23        beq   96CF
0009:96AC D0           inc   r0
0009:96AD 3D A0 6A     lms   r0,(00D4)
0009:96B0 E0           dec   r0
0009:96B1 0A 1C        bpl   96CF
0009:96B3 D0           inc   r0
0009:96B4 3D F0 22 1E  lm    r0,(1E22)
0009:96B8 A4 50        ibt   r4,#0050
0009:96BA 64           sub   r4
0009:96BB 14 53        add   r3
0009:96BD 0A 1C        bpl   96DB
0009:96BF 01           nop
0009:96C0 3D A0 69     lms   r0,(00D2)
0009:96C3 F5 02 80     iwt   r5,#8002
0009:96C6 65           sub   r5
0009:96C7 0C 12        bcc   96DB
0009:96C9 01           nop
0009:96CA 24 13        move  r3,r4
0009:96CC 05 40        bra   970E

0009:96CE B3 3E F0 0A+ sm    (1E0A),r0
0009:96D3 BD 4F        not
0009:96D5 D0           inc   r0
0009:96D6 62           sub   r2
0009:96D7 0A 02        bpl   96DB
0009:96D9 12 52        add   r2
0009:96DB 3D F0 0A 1E  lm    r0,(1E0A)
0009:96DF 3D A4 63     lms   r4,(00C6)
0009:96E2 C4           or    r4
0009:96E3 3D A4 A7     lms   r4,(014E)
0009:96E6 C4           or    r4
0009:96E7 3D A4 6D     lms   r4,(00DA)
0009:96EA C4           or    r4
0009:96EB 08 20        bne   970D
0009:96ED 01           nop
0009:96EE 3D A0 57     lms   r0,(00AE)
0009:96F1 3E 66        sub   #06
0009:96F3 09 18        beq   970D
0009:96F5 01           nop
0009:96F6 13           to    r3
0009:96F7 05 14        bra   970D

0009:96F9 60           sub   r0
0009:96FA 3D A0 60     lms   r0,(00C0)
0009:96FD 3E 60        sub   #00
0009:96FF 08 0C        bne   970D
0009:9701 60           sub   r0
0009:9702 3E F0 0A 1E  sm    (1E0A),r0
0009:9706 BD 62        sub   r2
0009:9708 0B 03        bmi   970D
0009:970A 52           add   r2
0009:970B 20 12        move  r2,r0
0009:970D B3 3E 5A     add   #0A
0009:9710 0B 06        bmi   9718
0009:9712 B3 3E 6A     sub   #0A
0009:9715 0B 03        bmi   971A
0009:9717 01           nop
0009:9718 23 60        sub   r0
0009:971A B3 9E        lob
0009:971C 3D F3 2A 1E  lm    r3,(1E2A)
0009:9720 23 B3        moves r3,r3
0009:9722 4D           swap
0009:9723 3D C2        xor   r2
0009:9725 0A 02        bpl   9729
0009:9727 01           nop
0009:9728 B2 3D C2     xor   r2
0009:972B 62           sub   r2
0009:972C 13 3D C2     xor   r2
0009:972F 0A 03        bpl   9734
0009:9731 52           add   r2
0009:9732 20 12        move  r2,r0
0009:9734 3D F0 0E 1E  lm    r0,(1E0E)
0009:9738 9E           lob
0009:9739 52           add   r2
0009:973A 90           sbk
0009:973B C0           hib
0009:973C 95           sex
0009:973D 3D A2 4E     lms   r2,(009C)
0009:9740 52           add   r2
0009:9741 3D F2 1C 1E  lm    r2,(1E1C)
0009:9745 62           sub   r2
0009:9746 0A 08        bpl   9750
0009:9748 52           add   r2
0009:9749 60           sub   r0
0009:974A 3E F0 0E 1E  sm    (1E0E),r0
0009:974E 22 10        move  r0,r2
0009:9750 3D F2 1E 1E  lm    r2,(1E1E)
0009:9754 62           sub   r2
0009:9755 0B 08        bmi   975F
0009:9757 52           add   r2
0009:9758 60           sub   r0
0009:9759 3E F0 0E 1E  sm    (1E0E),r0
0009:975D 22 10        move  r0,r2
0009:975F A2 0C        ibt   r2,#000C
0009:9761 12 62        sub   r2
0009:9763 A5 00        ibt   r5,#0000
0009:9765 F6 AA 0C     iwt   r6,#0CAA
0009:9768 F0 FF 00     iwt   r0,#00FF
0009:976B 13 51        add   r1
0009:976D 14 52        add   r2
0009:976F 20 B2        moves r0,r2
0009:9771 0A 02        bpl   9775
0009:9773 C0           hib
0009:9774 60           sub   r0
0009:9775 50           add   r0
0009:9776 50           add   r0
0009:9777 50           add   r0
0009:9778 17 50        add   r0
0009:977A B1 C0        hib
0009:977C C7           or    r7
0009:977D 56           add   r6
0009:977E 3D 40        ldb   (r0)
0009:9780 95           sex
0009:9781 0B 03        bmi   9786
0009:9783 01           nop
0009:9784 A5 02        ibt   r5,#0002
0009:9786 B3 C0        hib
0009:9788 C7           or    r7
0009:9789 56           add   r6
0009:978A 3D 40        ldb   (r0)
0009:978C 95           sex
0009:978D 0B 02        bmi   9791
0009:978F 01           nop
0009:9790 D5           inc   r5
0009:9791 25 55        add   r5
0009:9793 B4 C0        hib
0009:9795 50           add   r0
0009:9796 50           add   r0
0009:9797 50           add   r0
0009:9798 17 50        add   r0
0009:979A B1 C0        hib
0009:979C C7           or    r7
0009:979D 56           add   r6
0009:979E 3D 40        ldb   (r0)
0009:97A0 95           sex
0009:97A1 0B 02        bmi   97A5
0009:97A3 01           nop
0009:97A4 D5           inc   r5
0009:97A5 25 55        add   r5
0009:97A7 B3 C0        hib
0009:97A9 C7           or    r7
0009:97AA 56           add   r6
0009:97AB 3D 40        ldb   (r0)
0009:97AD 95           sex
0009:97AE 0B 02        bmi   97B2
0009:97B0 01           nop
0009:97B1 D5           inc   r5
0009:97B2 A0 09        ibt   r0,#0009
0009:97B4 3F DF        romb
0009:97B6 F0 A7 94     iwt   r0,#94A7
0009:97B9 55           add   r5
0009:97BA 55           add   r5
0009:97BB 1E 55        add   r5
0009:97BD EF           getb
0009:97BE DE           inc   r14
0009:97BF E0           dec   r0
0009:97C0 0A 05        bpl   97C7
0009:97C2 D0           inc   r0
0009:97C3 FF 4E 98     iwt   r15,#984E
0009:97C6 01           nop
0009:97C7 03           lsr
0009:97C8 0D 24        bcs   97EE
0009:97CA 03           lsr
0009:97CB 0C 13        bcc   97E0
0009:97CD 01           nop
0009:97CE 20 16        move  r6,r0
0009:97D0 60           sub   r0
0009:97D1 3E F0 0C 1E  sm    (1E0C),r0
0009:97D5 F0 80 00     iwt   r0,#0080
0009:97D8 51           add   r1
0009:97D9 C0           hib
0009:97DA 11 4D        swap
0009:97DC E6           dec   r6
0009:97DD 0B 6F        bmi   984E
0009:97DF 01           nop
0009:97E0 60           sub   r0
0009:97E1 3E F0 0E 1E  sm    (1E0E),r0
0009:97E5 F0 80 00     iwt   r0,#0080
0009:97E8 52           add   r2
0009:97E9 C0           hib
0009:97EA 12           to    r2
0009:97EB 05 61        bra   984E

0009:97ED 4D           swap
0009:97EE 13 EF        getb
0009:97F0 DE           inc   r14
0009:97F1 21 10        move  r0,r1
0009:97F3 E3           dec   r3
0009:97F4 0B 02        bmi   97F8
0009:97F6 D3           inc   r3
0009:97F7 4F           not
0009:97F8 17 9E        lob
0009:97FA 15 EF        getb
0009:97FC 22 10        move  r0,r2
0009:97FE E5           dec   r5
0009:97FF 0B 02        bmi   9803
0009:9801 D5           inc   r5
0009:9802 4F           not
0009:9803 9E           lob
0009:9804 20 18        move  r8,r0
0009:9806 57           add   r7
0009:9807 F6 00 01     iwt   r6,#0100
0009:980A 66           sub   r6
0009:980B 0D 41        bcs   984E
0009:980D 56           add   r6
0009:980E 50           add   r0
0009:980F F6 00 22     iwt   r6,#2200
0009:9812 56           add   r6
0009:9813 40           ldw   (r0)
0009:9814 F6 80 7F     iwt   r6,#7F80
0009:9817 3D 9F        lmult
0009:9819 24 54        add   r4
0009:981B 04           rol
0009:981C 24 54        add   r4
0009:981E 16 3F 50     adc   #00
0009:9821 B7 3D 9F     lmult
0009:9824 F0 80 00     iwt   r0,#0080
0009:9827 E3           dec   r3
0009:9828 0B 02        bmi   982C
0009:982A 54           add   r4
0009:982B 4F           not
0009:982C 17 C0        hib
0009:982E B1 C0        hib
0009:9830 4D           swap
0009:9831 11 C7        or    r7
0009:9833 B8 3D 9F     lmult
0009:9836 F0 80 00     iwt   r0,#0080
0009:9839 E5           dec   r5
0009:983A 0B 02        bmi   983E
0009:983C 54           add   r4
0009:983D 4F           not
0009:983E 18 C0        hib
0009:9840 B2 C0        hib
0009:9842 4D           swap
0009:9843 12 C8        or    r8
0009:9845 60           sub   r0
0009:9846 3E F0 0C 1E  sm    (1E0C),r0
0009:984A 3E F0 0E 1E  sm    (1E0E),r0
0009:984E 3E A1 4A     sms   (0094),r1
0009:9851 3E A2 4E     sms   (009C),r2
0009:9854 00           stop
0009:9855 01           nop

0009:9856 F1 67 01     iwt   r1,#0167
0009:9859 F2 69 01     iwt   r2,#0169
0009:985C A5 00        ibt   r5,#0000
0009:985E A6 10        ibt   r6,#0010
0009:9860 A8 FF        ibt   r8,#FFFF
0009:9862 A9 FF        ibt   r9,#FFFF
0009:9864 02           cache
0009:9865 AC 18        ibt   r12,#0018
0009:9867 2F 1D        move  r13,r15
0009:9869 F0 00 0F     iwt   r0,#0F00
0009:986C 55           add   r5
0009:986D 40           ldw   (r0)
0009:986E 66           sub   r6
0009:986F 08 3E        bne   98AF
0009:9871 01           nop
0009:9872 F0 60 13     iwt   r0,#1360
0009:9875 55           add   r5
0009:9876 40           ldw   (r0)
0009:9877 3F 61        cmp   r1
0009:9879 0C 34        bcc   98AF
0009:987B 01           nop
0009:987C 3F 62        cmp   r2
0009:987E 0D 2F        bcs   98AF
0009:9880 01           nop
0009:9881 F0 38 1D     iwt   r0,#1D38
0009:9884 55           add   r5
0009:9885 40           ldw   (r0)
0009:9886 3E 60        sub   #00
0009:9888 08 25        bne   98AF
0009:988A 01           nop
0009:988B F0 E2 10     iwt   r0,#10E2
0009:988E 55           add   r5
0009:988F 40           ldw   (r0)
0009:9890 B3 60        sub   r0
0009:9892 0A 03        bpl   9897
0009:9894 01           nop
0009:9895 4F           not
0009:9896 D0           inc   r0
0009:9897 20 17        move  r7,r0
0009:9899 F0 82 11     iwt   r0,#1182
0009:989C 55           add   r5
0009:989D 40           ldw   (r0)
0009:989E B4 60        sub   r0
0009:98A0 0A 03        bpl   98A5
0009:98A2 01           nop
0009:98A3 4F           not
0009:98A4 D0           inc   r0
0009:98A5 57           add   r7
0009:98A6 3F 68        cmp   r8
0009:98A8 0D 05        bcs   98AF
0009:98AA 01           nop
0009:98AB 20 18        move  r8,r0
0009:98AD 25 19        move  r9,r5
0009:98AF 25 3E 54     add   #04
0009:98B2 3C           loop
0009:98B3 01           nop
0009:98B4 00           stop
0009:98B5 01           nop

0009:98B6 F0 62 13     iwt   r0,#1362
0009:98B9 51           add   r1
0009:98BA 40           ldw   (r0)
0009:98BB A2 30        ibt   r2,#0030
0009:98BD 12 52        add   r2
0009:98BF F0 D6 19     iwt   r0,#19D6
0009:98C2 51           add   r1
0009:98C3 40           ldw   (r0)
0009:98C4 03           lsr
0009:98C5 13 03        lsr
0009:98C7 F0 D8 19     iwt   r0,#19D8
0009:98CA 51           add   r1
0009:98CB 14 40        ldw   (r0)
0009:98CD F0 36 1A     iwt   r0,#1A36
0009:98D0 51           add   r1
0009:98D1 15 40        ldw   (r0)
0009:98D3 F0 80 16     iwt   r0,#1680
0009:98D6 51           add   r1
0009:98D7 19 40        ldw   (r0)
0009:98D9 F0 82 16     iwt   r0,#1682
0009:98DC 51           add   r1
0009:98DD 1A 40        ldw   (r0)
0009:98DF AB 00        ibt   r11,#0000
0009:98E1 F0 80 11     iwt   r0,#1180
0009:98E4 51           add   r1
0009:98E5 3D 40        ldb   (r0)
0009:98E7 3E 88        mult  #08
0009:98E9 3E A0 00     sms   (0000),r0
0009:98EC A0 09        ibt   r0,#0009
0009:98EE 3F DF        romb
0009:98F0 02           cache
0009:98F1 25 55        add   r5
0009:98F3 24 04        rol
0009:98F5 04           rol
0009:98F6 25 55        add   r5
0009:98F8 24 04        rol
0009:98FA 04           rol
0009:98FB 25 55        add   r5
0009:98FD 24 04        rol
0009:98FF 04           rol
0009:9900 3E 77        and   #07
0009:9902 23 3E 68     sub   #08
0009:9905 0C 66        bcc   996D
0009:9907 01           nop
0009:9908 3E 53        add   #03
0009:990A 03           lsr
0009:990B 03           lsr
0009:990C FE D6 99     iwt   r14,#99D6
0009:990F 1E 5E        add   r14
0009:9911 1C EF        getb
0009:9913 3E A4 24     sms   (0048),r4
0009:9916 50           add   r0
0009:9917 FE D9 99     iwt   r14,#99D9
0009:991A 1E 5E        add   r14
0009:991C EF           getb
0009:991D DE           inc   r14
0009:991E 1E 3D EF     getbh
0009:9921 2F 1D        move  r13,r15
0009:9923 3F EF        getbs
0009:9925 DE           inc   r14
0009:9926 26 BB        moves r6,r11
0009:9928 09 05        beq   992F
0009:992A 01           nop
0009:992B 4F           not
0009:992C D0           inc   r0
0009:992D A6 08        ibt   r6,#0008
0009:992F 14 59        add   r9
0009:9931 3F EF        getbs
0009:9933 DE           inc   r14
0009:9934 17 5A        add   r10
0009:9936 EF           getb
0009:9937 DE           inc   r14
0009:9938 3D EF        getbh
0009:993A DE           inc   r14
0009:993B 18 3D CB     xor   r11
0009:993E EF           getb
0009:993F 3E 72        and   #02
0009:9941 08 03        bne   9946
0009:9943 01           nop
0009:9944 24 56        add   r6
0009:9946 B4 32        stw   (r2)
0009:9948 D2           inc   r2
0009:9949 D2           inc   r2
0009:994A B7 32        stw   (r2)
0009:994C D2           inc   r2
0009:994D D2           inc   r2
0009:994E 17 3D EF     getbh
0009:9951 DE           inc   r14
0009:9952 3D A0 00     lms   r0,(0000)
0009:9955 58           add   r8
0009:9956 32           stw   (r2)
0009:9957 D2           inc   r2
0009:9958 D2           inc   r2
0009:9959 B7 32        stw   (r2)
0009:995B D2           inc   r2
0009:995C 3C           loop
0009:995D D2           inc   r2
0009:995E 3D A4 24     lms   r4,(0048)
0009:9961 F0 00 40     iwt   r0,#4000
0009:9964 1B 3D CB     xor   r11
0009:9967 A0 20        ibt   r0,#0020
0009:9969 2A           with  r10
0009:996A 05 85        bra   98F1

0009:996C 60           sub   r0

0009:996D B3 3E 58     add   #08
0009:9970 08 0D        bne   997F
0009:9972 01           nop
0009:9973 F0 38 1A     iwt   r0,#1A38
0009:9976 51           add   r1
0009:9977 40           ldw   (r0)
0009:9978 03           lsr
0009:9979 03           lsr
0009:997A 09 03        beq   997F
0009:997C 01           nop
0009:997D 3E 57        add   #07
0009:997F FE DF 99     iwt   r14,#99DF
0009:9982 1E 5E        add   r14
0009:9984 1C EF        getb
0009:9986 50           add   r0
0009:9987 FE EA 99     iwt   r14,#99EA
0009:998A 1E 5E        add   r14
0009:998C EF           getb
0009:998D DE           inc   r14
0009:998E 1E 3D EF     getbh
0009:9991 F0 62 13     iwt   r0,#1362
0009:9994 51           add   r1
0009:9995 12 40        ldw   (r0)
0009:9997 2F 1D        move  r13,r15
0009:9999 3F EF        getbs
0009:999B DE           inc   r14
0009:999C 26 BB        moves r6,r11
0009:999E 09 05        beq   99A5
0009:99A0 01           nop
0009:99A1 4F           not
0009:99A2 D0           inc   r0
0009:99A3 A6 08        ibt   r6,#0008
0009:99A5 14 59        add   r9
0009:99A7 3F EF        getbs
0009:99A9 DE           inc   r14
0009:99AA 17 5A        add   r10
0009:99AC EF           getb
0009:99AD DE           inc   r14
0009:99AE 3D EF        getbh
0009:99B0 DE           inc   r14
0009:99B1 18 3D CB     xor   r11
0009:99B4 EF           getb
0009:99B5 3E 72        and   #02
0009:99B7 08 03        bne   99BC
0009:99B9 01           nop
0009:99BA 24 56        add   r6
0009:99BC B4 32        stw   (r2)
0009:99BE D2           inc   r2
0009:99BF D2           inc   r2
0009:99C0 B7 32        stw   (r2)
0009:99C2 D2           inc   r2
0009:99C3 D2           inc   r2
0009:99C4 17 3D EF     getbh
0009:99C7 DE           inc   r14
0009:99C8 3D A0 00     lms   r0,(0000)
0009:99CB 58           add   r8
0009:99CC 32           stw   (r2)
0009:99CD D2           inc   r2
0009:99CE D2           inc   r2
0009:99CF B7 32        stw   (r2)
0009:99D1 D2           inc   r2
0009:99D2 3C           loop
0009:99D3 D2           inc   r2
0009:99D4 00           stop
0009:99D5 01           nop

DATA_0999D6:         db $04, $04, $04

DATA_0999D9:         dw $9AC3, $9AD7, $9AEB

DATA_0999DF:         db $01, $02, $02, $02, $03, $04, $04, $05
DATA_0999E7:         db $04, $06, $06

DATA_0999EA:         dw $9A00, $9A05, $9A0F, $9A19
DATA_0999F2:         dw $9A23, $9A32, $9A46, $9A5A
DATA_0999FA:         dw $9A73, $9A87, $9AA5

DATA_099A00:         db $01, $00, $0C, $22, $02

DATA_099A05:         db $04, $FC, $0C, $22, $02, $03, $00, $00
DATA_099A0D:         db $A2, $02, $05, $F8

DATA_099A11:         db $0C, $22, $02, $03, $00, $00, $A2, $02

DATA_099A19:         db $06, $F4, $0C, $22, $02, $03, $00, $00
DATA_099A21:         db $A2, $02

DATA_099A23:         db $07, $F0, $0C, $22, $02, $04, $FC, $1A
DATA_099A2B:         db $22, $00, $03, $00, $00, $A2, $02

DATA_099A32:         db $04, $FC, $0A, $22, $00, $03, $00, $00
DATA_099A3A:         db $A2, $02, $05, $EC, $0C, $62, $02, $0B
DATA_099A42:         db $F8, $11, $22, $00

DATA_099A46:         db $FB, $F7, $08, $22, $02, $03, $00, $00
DATA_099A4E:         db $A2, $02, $03, $E8, $0C, $62, $02, $03
DATA_099A56:         db $F0, $00, $22, $02

DATA_099A5A:         db $F3, $F7, $06, $22, $02, $FB, $F7, $08
DATA_099A62:         db $22, $02, $03, $00, $00, $A2, $02, $01
DATA_099A6A:         db $E4, $0C, $62, $02, $03, $F0, $00, $22
DATA_099A72:         db $02

DATA_099A73:         db $05, $04, $0E, $A2, $02, $05, $FC, $0E
DATA_099A7B:         db $22, $02, $FD, $FC, $0E, $62, $02, $FD
DATA_099A83:         db $04, $0E, $E2, $02

DATA_099A87:         db $07, $07, $1B, $22, $00, $03, $07, $1B
DATA_099A8F:         db $62, $00, $07, $06, $0E, $A2, $02, $07
DATA_099A97:         db $FA, $0E, $22, $02, $FB, $FA, $0E, $62
DATA_099A9F:         db $02, $FB, $06, $0E, $E2, $02

DATA_099AA5:         db $09, $08, $1B, $22, $00, $01, $08, $1B
DATA_099AAD:         db $62, $00, $09, $08, $0E, $A2, $02, $09
DATA_099AB5:         db $F8, $0E, $22, $02, $F9, $F8, $0E, $62
DATA_099ABD:         db $02, $F9, $08, $0E, $E2, $02

DATA_099AC3:         db $EC, $F7, $02, $22, $02, $FC, $F7, $04
DATA_099ACB:         db $22, $02, $03, $00, $00, $A2, $02, $03
DATA_099AD3:         db $F0, $00, $22, $02

DATA_099AD7:         db $EC, $F9, $02, $22, $02, $FC, $F8, $04
DATA_099ADF:         db $22, $02, $03, $00, $00, $A2, $02, $03
DATA_099AE7:         db $F0, $00, $22, $02

DATA_099AEB:         db $FC, $F9, $04, $22, $02, $EC, $FA, $02
DATA_099AF3:         db $22, $02, $03, $00, $00, $A2, $02, $03
DATA_099AFB:         db $F0, $00, $22, $02

DATA_099AFF:         db $00, $10, $20, $30, $30, $40, $50, $50
DATA_099B07:         db $60, $60, $70, $70, $70, $80, $80, $80
DATA_099B0F:         db $80, $80, $80, $80, $80, $80, $80, $80
DATA_099B17:         db $80, $70, $70, $60, $60, $50, $50, $40
DATA_099B1F:         db $40, $30, $20, $10

0009:9B23 60           sub   r0
0009:9B24 3E A0 00     sms   (0000),r0
0009:9B27 F0 D6 19     iwt   r0,#19D6
0009:9B2A 51           add   r1
0009:9B2B 40           ldw   (r0)
0009:9B2C 03           lsr
0009:9B2D 03           lsr
0009:9B2E 03           lsr
0009:9B2F 03           lsr
0009:9B30 12 03        lsr
0009:9B32 F0 D8 19     iwt   r0,#19D8
0009:9B35 51           add   r1
0009:9B36 13 40        ldw   (r0)
0009:9B38 F0 36 1A     iwt   r0,#1A36
0009:9B3B 51           add   r1
0009:9B3C 14 40        ldw   (r0)
0009:9B3E F0 D6 1C     iwt   r0,#1CD6
0009:9B41 51           add   r1
0009:9B42 40           ldw   (r0)
0009:9B43 A5 20        ibt   r5,#0020
0009:9B45 15 65        sub   r5
0009:9B47 F0 82 11     iwt   r0,#1182
0009:9B4A 51           add   r1
0009:9B4B 40           ldw   (r0)
0009:9B4C 16 3E 54     add   #04
0009:9B4F A7 1C        ibt   r7,#001C
0009:9B51 AC 00        ibt   r12,#0000
0009:9B53 AD 01        ibt   r13,#0001
0009:9B55 A0 09        ibt   r0,#0009
0009:9B57 3F DF        romb
0009:9B59 02           cache
0009:9B5A 24 54        add   r4
0009:9B5C 23 04        rol
0009:9B5E 04           rol
0009:9B5F 24 54        add   r4
0009:9B61 23 04        rol
0009:9B63 04           rol
0009:9B64 24 54        add   r4
0009:9B66 23 04        rol
0009:9B68 04           rol
0009:9B69 1B 3E 77     and   #07
0009:9B6C A0 10        ibt   r0,#0010
0009:9B6E 18 6B        sub   r11
0009:9B70 3D A0 55     lms   r0,(00AA)
0009:9B73 3E 60        sub   #00
0009:9B75 0B 40        bmi   9BB7
0009:9B77 01           nop
0009:9B78 3D A0 8E     lms   r0,(011C)
0009:9B7B 65           sub   r5
0009:9B7C 0B 39        bmi   9BB7
0009:9B7E 01           nop
0009:9B7F A9 24        ibt   r9,#0024
0009:9B81 69           sub   r9
0009:9B82 0D 33        bcs   9BB7
0009:9B84 59           add   r9
0009:9B85 27 B7        moves r7,r7
0009:9B87 0B 03        bmi   9B8C
0009:9B89 B9 3D 60     sbc   r0
0009:9B8C FE FF 9A     iwt   r14,#9AFF
0009:9B8F 1E 5E        add   r14
0009:9B91 3D A9 48     lms   r9,(0090)
0009:9B94 A0 20        ibt   r0,#0020
0009:9B96 1A 59        add   r9
0009:9B98 EF           getb
0009:9B99 3D 88        umult r8
0009:9B9B C0           hib
0009:9B9C B6 60        sub   r0
0009:9B9E 6A           sub   r10
0009:9B9F 0A 16        bpl   9BB7
0009:9BA1 01           nop
0009:9BA2 3E 59        add   #09
0009:9BA4 0B 11        bmi   9BB7
0009:9BA6 01           nop
0009:9BA7 3E 68        sub   #08
0009:9BA9 59           add   r9
0009:9BAA 90           sbk
0009:9BAB F0 00 01     iwt   r0,#0100
0009:9BAE 3E A0 55     sms   (00AA),r0
0009:9BB1 3E A0 DA     sms   (01B4),r0
0009:9BB4 2B 3E C8     or    #08
0009:9BB7 BB 3E 77     and   #07
0009:9BBA 6B           sub   r11
0009:9BBB 08 07        bne   9BC4
0009:9BBD 5B           add   r11
0009:9BBE 09 14        beq   9BD4
0009:9BC0 01           nop
0009:9BC1 05 11        bra   9BD4

0009:9BC3 E0           dec   r0
0009:9BC4 19 3E 67     sub   #07
0009:9BC7 0D 0B        bcs   9BD4
0009:9BC9 01           nop
0009:9BCA E0           dec   r0
0009:9BCB 0A 06        bpl   9BD3
0009:9BCD D0           inc   r0
0009:9BCE A9 1D        ibt   r9,#001D
0009:9BD0 3E A9 00     sms   (0000),r9
0009:9BD3 D0           inc   r0
0009:9BD4 3E 88        mult  #08
0009:9BD6 50           add   r0
0009:9BD7 50           add   r0
0009:9BD8 4D           swap
0009:9BD9 50           add   r0
0009:9BDA 2D 04        rol
0009:9BDC 2C 04        rol
0009:9BDE 50           add   r0
0009:9BDF 2D 04        rol
0009:9BE1 2C 04        rol
0009:9BE3 50           add   r0
0009:9BE4 2D 04        rol
0009:9BE6 2C 04        rol
0009:9BE8 25 57        add   r7
0009:9BEA A0 E0        ibt   r0,#FFE0
0009:9BEC 16 56        add   r6
0009:9BEE 27 4F        not
0009:9BF0 E2           dec   r2
0009:9BF1 09 05        beq   9BF8
0009:9BF3 D7           inc   r7
0009:9BF4 FF 5B 9B     iwt   r15,#9B5B
0009:9BF7 24 2D 5D     add   r13
0009:9BFA 2C 04        rol
0009:9BFC 0C FB        bcc   9BF9
0009:9BFE 2D F0 D8 19  iwt   r0,#19D8
0009:9C02 51           add   r1
0009:9C03 BC 30        stw   (r0)
0009:9C05 F0 36 1A     iwt   r0,#1A36
0009:9C08 51           add   r1
0009:9C09 BD 30        stw   (r0)
0009:9C0B 00           stop
0009:9C0C 01           nop

0009:9C0D A0 08        ibt   r0,#0008
0009:9C0F 3F DF        romb
0009:9C11 3D F1 72 19  lm    r1,(1972)
0009:9C15 3D A0 1F     lms   r0,(003E)
0009:9C18 15 C0        hib
0009:9C1A F0 18 AE     iwt   r0,#AE18
0009:9C1D 1E 55        add   r5
0009:9C1F F0 B6 1B     iwt   r0,#1BB6
0009:9C22 51           add   r1
0009:9C23 12 40        ldw   (r0)
0009:9C25 B2 4F        not
0009:9C27 13 3E 51     add   #01
0009:9C2A F0 B8 1B     iwt   r0,#1BB8
0009:9C2D 51           add   r1
0009:9C2E 14 40        ldw   (r0)
0009:9C30 16 EF        getb
0009:9C32 F0 58 AE     iwt   r0,#AE58
0009:9C35 1E 55        add   r5
0009:9C37 17 EF        getb
0009:9C39 B4 18 86     mult  r6
0009:9C3C B4 19 87     mult  r7
0009:9C3F FB 80 00     iwt   r11,#0080
0009:9C42 B3 86        mult  r6
0009:9C44 59           add   r9
0009:9C45 50           add   r0
0009:9C46 50           add   r0
0009:9C47 5B           add   r11
0009:9C48 C0           hib
0009:9C49 1A 95        sex
0009:9C4B F0 E2 10     iwt   r0,#10E2
0009:9C4E 51           add   r1
0009:9C4F 40           ldw   (r0)
0009:9C50 5A           add   r10
0009:9C51 3E A0 00     sms   (0000),r0
0009:9C54 B3 87        mult  r7
0009:9C56 B8 60        sub   r0
0009:9C58 50           add   r0
0009:9C59 50           add   r0
0009:9C5A 5B           add   r11
0009:9C5B C0           hib
0009:9C5C 1A 95        sex
0009:9C5E F0 82 11     iwt   r0,#1182
0009:9C61 51           add   r1
0009:9C62 40           ldw   (r0)
0009:9C63 5A           add   r10
0009:9C64 3E A0 01     sms   (0002),r0
0009:9C67 B2 86        mult  r6
0009:9C69 59           add   r9
0009:9C6A 50           add   r0
0009:9C6B 50           add   r0
0009:9C6C 5B           add   r11
0009:9C6D C0           hib
0009:9C6E 1A 95        sex
0009:9C70 F0 E2 10     iwt   r0,#10E2
0009:9C73 51           add   r1
0009:9C74 40           ldw   (r0)
0009:9C75 5A           add   r10
0009:9C76 3E A0 02     sms   (0004),r0
0009:9C79 B2 87        mult  r7
0009:9C7B B8 60        sub   r0
0009:9C7D 50           add   r0
0009:9C7E 50           add   r0
0009:9C7F 5B           add   r11
0009:9C80 C0           hib
0009:9C81 1A 95        sex
0009:9C83 F0 82 11     iwt   r0,#1182
0009:9C86 51           add   r1
0009:9C87 40           ldw   (r0)
0009:9C88 5A           add   r10
0009:9C89 3E A0 03     sms   (0006),r0
0009:9C8C 3D A8 00     lms   r8,(0000)
0009:9C8F 3D A9 02     lms   r9,(0004)
0009:9C92 3D FA 1C 01  lm    r10,(011C)
0009:9C96 BA 17 68     sub   r8
0009:9C99 0B 7D        bmi   9D18
0009:9C9B BA 69        sub   r9
0009:9C9D 0A 79        bpl   9D18
0009:9C9F 01           nop
0009:9CA0 3D F0 AA 00  lm    r0,(00AA)
0009:9CA4 3E 60        sub   #00
0009:9CA6 0B 70        bmi   9D18
0009:9CA8 01           nop
0009:9CA9 B9 68        sub   r8
0009:9CAB 19 50        add   r0
0009:9CAD F0 00 22     iwt   r0,#2200
0009:9CB0 59           add   r9
0009:9CB1 16 40        ldw   (r0)
0009:9CB3 3D A8 01     lms   r8,(0002)
0009:9CB6 3D A0 03     lms   r0,(0006)
0009:9CB9 68           sub   r8
0009:9CBA 9E           lob
0009:9CBB 4D           swap
0009:9CBC 16 9F        fmult
0009:9CBE B7 9E        lob
0009:9CC0 4D           swap
0009:9CC1 9F           fmult
0009:9CC2 18 58        add   r8
0009:9CC4 A6 20        ibt   r6,#0020
0009:9CC6 3D F7 90 00  lm    r7,(0090)
0009:9CCA B7 56        add   r6
0009:9CCC 68           sub   r8
0009:9CCD 0B 49        bmi   9D18
0009:9CCF 01           nop
0009:9CD0 20 18        move  r8,r0
0009:9CD2 3E 69        sub   #09
0009:9CD4 0A 42        bpl   9D18
0009:9CD6 01           nop
0009:9CD7 B7 68        sub   r8
0009:9CD9 3E F0 90 00  sm    (0090),r0
0009:9CDD A0 01        ibt   r0,#0001
0009:9CDF 3E F0 B4 01  sm    (01B4),r0
0009:9CE3 F0 00 01     iwt   r0,#0100
0009:9CE6 3E F0 AA 00  sm    (00AA),r0
0009:9CEA F0 D8 19     iwt   r0,#19D8
0009:9CED 51           add   r1
0009:9CEE 16 40        ldw   (r0)
0009:9CF0 F0 78 19     iwt   r0,#1978
0009:9CF3 51           add   r1
0009:9CF4 17 40        ldw   (r0)
0009:9CF6 3D F0 1C 01  lm    r0,(011C)
0009:9CFA 67           sub   r7
0009:9CFB 3D 96        div2
0009:9CFD 3D 96        div2
0009:9CFF 01           nop
0009:9D00 01           nop
0009:9D01 26 50        add   r0
0009:9D03 F0 D8 19     iwt   r0,#19D8
0009:9D06 51           add   r1
0009:9D07 B6 30        stw   (r0)
0009:9D09 F0 76 19     iwt   r0,#1976
0009:9D0C 51           add   r1
0009:9D0D 40           ldw   (r0)
0009:9D0E C0           hib
0009:9D0F 3F 65        cmp   r5
0009:9D11 08 09        bne   9D1C
0009:9D13 01           nop
0009:9D14 A0 01        ibt   r0,#0001
0009:9D16 00           stop
0009:9D17 01           nop

0009:9D18 A0 00        ibt   r0,#0000
0009:9D1A 00           stop
0009:9D1B 01           nop

0009:9D1C B5 4F        not
0009:9D1E D0           inc   r0
0009:9D1F 15 9E        lob
0009:9D21 F0 18 AE     iwt   r0,#AE18
0009:9D24 1E 55        add   r5
0009:9D26 3D F8 8C 00  lm    r8,(008C)
0009:9D2A F0 E2 10     iwt   r0,#10E2
0009:9D2D 51           add   r1
0009:9D2E 1C 40        ldw   (r0)
0009:9D30 28 6C        sub   r12
0009:9D32 3D F9 90 00  lm    r9,(0090)
0009:9D36 F0 82 11     iwt   r0,#1182
0009:9D39 51           add   r1
0009:9D3A 1D 40        ldw   (r0)
0009:9D3C 29 6D        sub   r13
0009:9D3E 16 EF        getb
0009:9D40 F0 58 AE     iwt   r0,#AE58
0009:9D43 1E 55        add   r5
0009:9D45 B8 1A 86     mult  r6
0009:9D48 B9 1B 86     mult  r6
0009:9D4B 17 EF        getb
0009:9D4D F2 80 00     iwt   r2,#0080
0009:9D50 B9 87        mult  r7
0009:9D52 5A           add   r10
0009:9D53 50           add   r0
0009:9D54 50           add   r0
0009:9D55 52           add   r2
0009:9D56 C0           hib
0009:9D57 1A 95        sex
0009:9D59 B8 87        mult  r7
0009:9D5B BB 60        sub   r0
0009:9D5D 50           add   r0
0009:9D5E 50           add   r0
0009:9D5F 52           add   r2
0009:9D60 C0           hib
0009:9D61 1B 95        sex
0009:9D63 F0 76 19     iwt   r0,#1976
0009:9D66 51           add   r1
0009:9D67 40           ldw   (r0)
0009:9D68 15 C0        hib
0009:9D6A F0 18 AE     iwt   r0,#AE18
0009:9D6D 1E 55        add   r5
0009:9D6F 16 EF        getb
0009:9D71 F0 58 AE     iwt   r0,#AE58
0009:9D74 1E 55        add   r5
0009:9D76 BA 18 86     mult  r6
0009:9D79 BB 19 86     mult  r6
0009:9D7C 17 EF        getb
0009:9D7E BB 87        mult  r7
0009:9D80 58           add   r8
0009:9D81 50           add   r0
0009:9D82 50           add   r0
0009:9D83 52           add   r2
0009:9D84 C0           hib
0009:9D85 95           sex
0009:9D86 5C           add   r12
0009:9D87 3E F0 8C 00  sm    (008C),r0
0009:9D8B BA 87        mult  r7
0009:9D8D B9 60        sub   r0
0009:9D8F 50           add   r0
0009:9D90 50           add   r0
0009:9D91 52           add   r2
0009:9D92 C0           hib
0009:9D93 95           sex
0009:9D94 5D           add   r13
0009:9D95 3E F0 90 00  sm    (0090),r0
0009:9D99 A0 01        ibt   r0,#0001
0009:9D9B 00           stop
0009:9D9C 01           nop
0009:9D9D A0 08        ibt   r0,#0008
0009:9D9F 3F DF        romb
0009:9DA1 3D F1 72 19  lm    r1,(1972)
0009:9DA5 3D A0 1F     lms   r0,(003E)
0009:9DA8 15 C0        hib
0009:9DAA F0 18 AE     iwt   r0,#AE18
0009:9DAD 1E 55        add   r5
0009:9DAF F0 B6 1B     iwt   r0,#1BB6
0009:9DB2 51           add   r1
0009:9DB3 12 40        ldw   (r0)
0009:9DB5 B2 4F        not
0009:9DB7 13 3E 51     add   #01
0009:9DBA F0 B8 1B     iwt   r0,#1BB8
0009:9DBD 51           add   r1
0009:9DBE 14 40        ldw   (r0)
0009:9DC0 16 EF        getb
0009:9DC2 F0 58 AE     iwt   r0,#AE58
0009:9DC5 1E 55        add   r5
0009:9DC7 17 EF        getb
0009:9DC9 B4 18 86     mult  r6
0009:9DCC B4 19 87     mult  r7
0009:9DCF FB 80 00     iwt   r11,#0080
0009:9DD2 B3 86        mult  r6
0009:9DD4 59           add   r9
0009:9DD5 50           add   r0
0009:9DD6 50           add   r0
0009:9DD7 5B           add   r11
0009:9DD8 C0           hib
0009:9DD9 1A 95        sex
0009:9DDB F0 E2 10     iwt   r0,#10E2
0009:9DDE 51           add   r1
0009:9DDF 40           ldw   (r0)
0009:9DE0 5A           add   r10
0009:9DE1 3E A0 00     sms   (0000),r0
0009:9DE4 B3 87        mult  r7
0009:9DE6 B8 60        sub   r0
0009:9DE8 50           add   r0
0009:9DE9 50           add   r0
0009:9DEA 5B           add   r11
0009:9DEB C0           hib
0009:9DEC 1A 95        sex
0009:9DEE F0 82 11     iwt   r0,#1182
0009:9DF1 51           add   r1
0009:9DF2 40           ldw   (r0)
0009:9DF3 5A           add   r10
0009:9DF4 3E A0 01     sms   (0002),r0
0009:9DF7 B2 86        mult  r6
0009:9DF9 59           add   r9
0009:9DFA 50           add   r0
0009:9DFB 50           add   r0
0009:9DFC 5B           add   r11
0009:9DFD C0           hib
0009:9DFE 1A 95        sex
0009:9E00 F0 E2 10     iwt   r0,#10E2
0009:9E03 51           add   r1
0009:9E04 40           ldw   (r0)
0009:9E05 5A           add   r10
0009:9E06 3E A0 02     sms   (0004),r0
0009:9E09 B2 87        mult  r7
0009:9E0B B8 60        sub   r0
0009:9E0D 50           add   r0
0009:9E0E 50           add   r0
0009:9E0F 5B           add   r11
0009:9E10 C0           hib
0009:9E11 1A 95        sex
0009:9E13 F0 82 11     iwt   r0,#1182
0009:9E16 51           add   r1
0009:9E17 40           ldw   (r0)
0009:9E18 5A           add   r10
0009:9E19 3E A0 03     sms   (0006),r0
0009:9E1C 3D A8 00     lms   r8,(0000)
0009:9E1F 3D A9 02     lms   r9,(0004)
0009:9E22 3D FA D6 1C  lm    r10,(1CD6)
0009:9E26 BA 17 68     sub   r8
0009:9E29 0B 71        bmi   9E9C
0009:9E2B BA 69        sub   r9
0009:9E2D 0A 6D        bpl   9E9C
0009:9E2F 01           nop
0009:9E30 3D F0 22 12  lm    r0,(1222)
0009:9E34 3E 60        sub   #00
0009:9E36 0B 64        bmi   9E9C
0009:9E38 01           nop
0009:9E39 B9 68        sub   r8
0009:9E3B 19 50        add   r0
0009:9E3D F0 00 22     iwt   r0,#2200
0009:9E40 59           add   r9
0009:9E41 16 40        ldw   (r0)
0009:9E43 3D A8 01     lms   r8,(0002)
0009:9E46 3D A0 03     lms   r0,(0006)
0009:9E49 68           sub   r8
0009:9E4A 9E           lob
0009:9E4B 4D           swap
0009:9E4C 16 9F        fmult
0009:9E4E B7 9E        lob
0009:9E50 4D           swap
0009:9E51 9F           fmult
0009:9E52 18 58        add   r8
0009:9E54 A6 20        ibt   r6,#0020
0009:9E56 3D F7 82 11  lm    r7,(1182)
0009:9E5A B7 56        add   r6
0009:9E5C 68           sub   r8
0009:9E5D 0B 3D        bmi   9E9C
0009:9E5F 01           nop
0009:9E60 20 18        move  r8,r0
0009:9E62 3E 69        sub   #09
0009:9E64 0A 36        bpl   9E9C
0009:9E66 01           nop
0009:9E67 B7 68        sub   r8
0009:9E69 3E F0 82 11  sm    (1182),r0
0009:9E6D F0 00 01     iwt   r0,#0100
0009:9E70 3E F0 22 12  sm    (1222),r0
0009:9E74 F0 D8 19     iwt   r0,#19D8
0009:9E77 51           add   r1
0009:9E78 16 40        ldw   (r0)
0009:9E7A F0 78 19     iwt   r0,#1978
0009:9E7D 51           add   r1
0009:9E7E 17 40        ldw   (r0)
0009:9E80 3D F0 D6 1C  lm    r0,(1CD6)
0009:9E84 67           sub   r7
0009:9E85 26 50        add   r0
0009:9E87 F0 D8 19     iwt   r0,#19D8
0009:9E8A 51           add   r1
0009:9E8B B6 30        stw   (r0)
0009:9E8D F0 76 19     iwt   r0,#1976
0009:9E90 51           add   r1
0009:9E91 40           ldw   (r0)
0009:9E92 C0           hib
0009:9E93 3F 65        cmp   r5
0009:9E95 08 09        bne   9EA0
0009:9E97 01           nop
0009:9E98 A0 01        ibt   r0,#0001
0009:9E9A 00           stop
0009:9E9B 01           nop

0009:9E9C A0 00        ibt   r0,#0000
0009:9E9E 00           stop
0009:9E9F 01           nop

0009:9EA0 B5 4F        not
0009:9EA2 D0           inc   r0
0009:9EA3 15 9E        lob
0009:9EA5 F0 18 AE     iwt   r0,#AE18
0009:9EA8 1E 55        add   r5
0009:9EAA 3D F8 E2 10  lm    r8,(10E2)
0009:9EAE F0 E2 10     iwt   r0,#10E2
0009:9EB1 51           add   r1
0009:9EB2 1C 40        ldw   (r0)
0009:9EB4 28 6C        sub   r12
0009:9EB6 3D F9 82 11  lm    r9,(1182)
0009:9EBA F0 82 11     iwt   r0,#1182
0009:9EBD 51           add   r1
0009:9EBE 1D 40        ldw   (r0)
0009:9EC0 29 6D        sub   r13
0009:9EC2 16 EF        getb
0009:9EC4 F0 58 AE     iwt   r0,#AE58
0009:9EC7 1E 55        add   r5
0009:9EC9 B8 1A 86     mult  r6
0009:9ECC B9 1B 86     mult  r6
0009:9ECF 17 EF        getb
0009:9ED1 F2 80 00     iwt   r2,#0080
0009:9ED4 B9 87        mult  r7
0009:9ED6 5A           add   r10
0009:9ED7 50           add   r0
0009:9ED8 50           add   r0
0009:9ED9 52           add   r2
0009:9EDA C0           hib
0009:9EDB 1A 95        sex
0009:9EDD B8 87        mult  r7
0009:9EDF BB 60        sub   r0
0009:9EE1 50           add   r0
0009:9EE2 50           add   r0
0009:9EE3 52           add   r2
0009:9EE4 C0           hib
0009:9EE5 1B 95        sex
0009:9EE7 F0 76 19     iwt   r0,#1976
0009:9EEA 51           add   r1
0009:9EEB 40           ldw   (r0)
0009:9EEC 15 C0        hib
0009:9EEE F0 18 AE     iwt   r0,#AE18
0009:9EF1 1E 55        add   r5
0009:9EF3 16 EF        getb
0009:9EF5 F0 58 AE     iwt   r0,#AE58
0009:9EF8 1E 55        add   r5
0009:9EFA BA 18 86     mult  r6
0009:9EFD BB 19 86     mult  r6
0009:9F00 17 EF        getb
0009:9F02 BB 87        mult  r7
0009:9F04 58           add   r8
0009:9F05 50           add   r0
0009:9F06 50           add   r0
0009:9F07 52           add   r2
0009:9F08 C0           hib
0009:9F09 95           sex
0009:9F0A 5C           add   r12
0009:9F0B 3E F0 E2 10  sm    (10E2),r0
0009:9F0F BA 87        mult  r7
0009:9F11 B9 60        sub   r0
0009:9F13 50           add   r0
0009:9F14 50           add   r0
0009:9F15 52           add   r2
0009:9F16 C0           hib
0009:9F17 95           sex
0009:9F18 5D           add   r13
0009:9F19 3E F0 82 11  sm    (1182),r0
0009:9F1D A0 01        ibt   r0,#0001
0009:9F1F 00           stop
0009:9F20 01           nop

0009:9F21 A0 08        ibt   r0,#0008
0009:9F23 3F DF        romb
0009:9F25 3D F1 72 19  lm    r1,(1972)
0009:9F29 F0 76 19     iwt   r0,#1976
0009:9F2C 51           add   r1
0009:9F2D 40           ldw   (r0)
0009:9F2E 12 C0        hib
0009:9F30 F0 18 AE     iwt   r0,#AE18
0009:9F33 1E 52        add   r2
0009:9F35 F0 36 1A     iwt   r0,#1A36
0009:9F38 51           add   r1
0009:9F39 13 40        ldw   (r0)
0009:9F3B F0 78 19     iwt   r0,#1978
0009:9F3E 51           add   r1
0009:9F3F 1C 40        ldw   (r0)
0009:9F41 23 6C        sub   r12
0009:9F43 F0 38 1A     iwt   r0,#1A38
0009:9F46 51           add   r1
0009:9F47 14 40        ldw   (r0)
0009:9F49 F0 D6 19     iwt   r0,#19D6
0009:9F4C 51           add   r1
0009:9F4D 1D 40        ldw   (r0)
0009:9F4F 24 6D        sub   r13
0009:9F51 15 EF        getb
0009:9F53 F0 58 AE     iwt   r0,#AE58
0009:9F56 1E 52        add   r2
0009:9F58 B3 18 85     mult  r5
0009:9F5B B4 19 85     mult  r5
0009:9F5E 17 EF        getb
0009:9F60 FA 80 00     iwt   r10,#0080
0009:9F63 B4 87        mult  r7
0009:9F65 58           add   r8
0009:9F66 50           add   r0
0009:9F67 50           add   r0
0009:9F68 5A           add   r10
0009:9F69 C0           hib
0009:9F6A 95           sex
0009:9F6B 1A 5C        add   r12
0009:9F6D F0 E2 10     iwt   r0,#10E2
0009:9F70 51           add   r1
0009:9F71 40           ldw   (r0)
0009:9F72 BA 1B 60     sub   r0
0009:9F75 F0 C0 12     iwt   r0,#12C0
0009:9F78 51           add   r1
0009:9F79 BB 30        stw   (r0)
0009:9F7B F0 E2 10     iwt   r0,#10E2
0009:9F7E 51           add   r1
0009:9F7F BA 30        stw   (r0)
0009:9F81 FA 80 00     iwt   r10,#0080
0009:9F84 B3 87        mult  r7
0009:9F86 B9 60        sub   r0
0009:9F88 50           add   r0
0009:9F89 50           add   r0
0009:9F8A 5A           add   r10
0009:9F8B C0           hib
0009:9F8C 95           sex
0009:9F8D 1A 5D        add   r13
0009:9F8F F0 82 11     iwt   r0,#1182
0009:9F92 51           add   r1
0009:9F93 40           ldw   (r0)
0009:9F94 BA 1B 60     sub   r0
0009:9F97 F0 C2 12     iwt   r0,#12C2
0009:9F9A 51           add   r1
0009:9F9B BB 30        stw   (r0)
0009:9F9D F0 82 11     iwt   r0,#1182
0009:9FA0 51           add   r1
0009:9FA1 BA 30        stw   (r0)
0009:9FA3 00           stop
0009:9FA4 01           nop

0009:9FA5 A1 FF        ibt   r1,#FFFF
0009:9FA7 F2 00 0F     iwt   r2,#0F00
0009:9FAA F3 60 13     iwt   r3,#1360
0009:9FAD F4 10 00     iwt   r4,#0010
0009:9FB0 A5 FF        ibt   r5,#FFFF
0009:9FB2 A6 FF        ibt   r6,#FFFF
0009:9FB4 A7 00        ibt   r7,#0000
0009:9FB6 F0 D6 1C     iwt   r0,#1CD6
0009:9FB9 5A           add   r10
0009:9FBA 18 40        ldw   (r0)
0009:9FBC F0 D8 1C     iwt   r0,#1CD8
0009:9FBF 5A           add   r10
0009:9FC0 19 40        ldw   (r0)
0009:9FC2 02           cache
0009:9FC3 AC 18        ibt   r12,#0018
0009:9FC5 2F 1D        move  r13,r15
0009:9FC7 42           ldw   (r2)
0009:9FC8 64           sub   r4
0009:9FC9 08 52        bne   A01D
0009:9FCB 01           nop
0009:9FCC 43           ldw   (r3)
0009:9FCD 3F 6E        cmp   r14
0009:9FCF 0C 4C        bcc   A01D
0009:9FD1 01           nop
0009:9FD2 3F 6B        cmp   r11
0009:9FD4 0D 47        bcs   A01D
0009:9FD6 01           nop
0009:9FD7 F0 38 1D     iwt   r0,#1D38
0009:9FDA 57           add   r7
0009:9FDB 40           ldw   (r0)
0009:9FDC 3E 60        sub   #00
0009:9FDE 08 3D        bne   A01D
0009:9FE0 01           nop
0009:9FE1 F0 D8 19     iwt   r0,#19D8
0009:9FE4 57           add   r7
0009:9FE5 3D 40        ldb   (r0)
0009:9FE7 95           sex
0009:9FE8 0B 33        bmi   A01D
0009:9FEA 01           nop
0009:9FEB F0 36 1A     iwt   r0,#1A36
0009:9FEE 57           add   r7
0009:9FEF 40           ldw   (r0)
0009:9FF0 3E 60        sub   #00
0009:9FF2 08 29        bne   A01D
0009:9FF4 01           nop
0009:9FF5 F0 D6 1C     iwt   r0,#1CD6
0009:9FF8 57           add   r7
0009:9FF9 40           ldw   (r0)
0009:9FFA 1A 68        sub   r8
0009:9FFC 0A 04        bpl   A002
0009:9FFE 2A 4F        not
0009:A000 DA           inc   r10
0009:A001 BA 3F 65     cmp   r5
0009:A004 0D 17        bcs   A01D
0009:A006 01           nop
0009:A007 F0 D8 1C     iwt   r0,#1CD8
0009:A00A 57           add   r7
0009:A00B 40           ldw   (r0)
0009:A00C 69           sub   r9
0009:A00D 0A 03        bpl   A012
0009:A00F 01           nop
0009:A010 4F           not
0009:A011 D0           inc   r0
0009:A012 3F 66        cmp   r6
0009:A014 0D 07        bcs   A01D
0009:A016 01           nop
0009:A017 20 16        move  r6,r0
0009:A019 2A 15        move  r5,r10
0009:A01B 27 11        move  r1,r7
0009:A01D 22 3E 54     add   #04
0009:A020 23 3E 54     add   #04
0009:A023 27 3E 54     add   #04
0009:A026 3C           loop
0009:A027 01           nop
0009:A028 00           stop
0009:A029 01           nop

0009:A02A A4 06        ibt   r4,#0006
0009:A02C 02           cache
0009:A02D AC 1D        ibt   r12,#001D
0009:A02F 2F 1D        move  r13,r15
0009:A031 43           ldw   (r3)
0009:A032 51           add   r1
0009:A033 90           sbk
0009:A034 D3           inc   r3
0009:A035 D3           inc   r3
0009:A036 43           ldw   (r3)
0009:A037 52           add   r2
0009:A038 23 54        add   r4
0009:A03A 3C           loop
0009:A03B 90           sbk
0009:A03C 00           stop
0009:A03D 01           nop

DATA_09A03E:         db $04, $00, $F0, $F0, $00, $F0, $F0, $00
DATA_09A046:         db $00, $00, $00, $00, $F0, $00, $00, $F0
DATA_09A04E:         db $F0, $F0, $FC, $00, $00, $F0, $F0, $F0
DATA_09A056:         db $00, $00, $F0, $00, $F0, $00, $00, $00
DATA_09A05E:         db $F0, $F0, $00, $F0, $DB, $92, $0C, $00
DATA_09A066:         db $FC, $00, $0C, $F0, $FC, $F0, $E4, $F0
DATA_09A06E:         db $F4, $F0, $E4, $00, $F4, $00, $05, $8D
DATA_09A076:         db $F6, $8D, $19, $8D, $10, $9C, $F0, $F0
DATA_09A07E:         db $00, $F0, $F0, $00, $00, $00, $21, $C8
DATA_09A086:         db $F0, $F0, $2C, $00, $F0, $6E, $F0, $00
DATA_09A08E:         db $2C, $00, $00, $6E, $DE, $92, $0C, $00
DATA_09A096:         db $FC, $00, $0C, $F0, $FC, $F0, $E4, $F0
DATA_09A09E:         db $F4, $F0, $E4, $00, $F4, $00, $05, $8D
DATA_09A0A6:         db $F6, $8D, $14, $8D, $18, $9C, $F0, $F0
DATA_09A0AE:         db $00, $F0, $F0, $00, $00, $00, $28, $C8
DATA_09A0B6:         db $F0, $F0, $2C, $00, $F0, $6E, $F0, $00
DATA_09A0BE:         db $2C, $00, $00, $6E, $E4, $92, $0C, $00
DATA_09A0C6:         db $FC, $00, $0C, $F0, $FC, $F0, $E4, $F0
DATA_09A0CE:         db $F4, $F0, $E4, $00, $F4, $00, $06, $8D
DATA_09A0D6:         db $F7, $8D, $0B, $8D, $1E, $9C, $F0, $F0
DATA_09A0DE:         db $00, $F0, $F0, $00, $00, $00, $30, $C8
DATA_09A0E6:         db $F0, $F0, $2C, $00, $F0, $6E, $F0, $00
DATA_09A0EE:         db $2C, $00, $00, $6E, $EE, $92, $0C, $00
DATA_09A0F6:         db $FC, $00, $0C, $F0, $FC, $F0, $E4, $F0
DATA_09A0FE:         db $F4, $F0, $E4, $00, $F4, $00, $07, $8D
DATA_09A106:         db $F8, $8D, $FF, $8D, $22, $9C, $F0, $F0
DATA_09A10E:         db $00, $F0, $F0, $00, $00, $00, $36, $C8
DATA_09A116:         db $F0, $F0, $2C, $00, $F0, $6E, $F0, $00
DATA_09A11E:         db $2C, $00, $00, $6E

0009:A122 02           cache
0009:A123 3D F1 72 19  lm    r1,(1972)
0009:A127 3D AB 49     lms   r11,(0092)
0009:A12A A0 08        ibt   r0,#0008
0009:A12C 3F DF        romb
0009:A12E F0 76 19     iwt   r0,#1976
0009:A131 51           add   r1
0009:A132 40           ldw   (r0)
0009:A133 4F           not
0009:A134 D0           inc   r0
0009:A135 14 C0        hib
0009:A137 F0 18 AE     iwt   r0,#AE18
0009:A13A 1E 54        add   r4
0009:A13C F5 58 AE     iwt   r5,#AE58
0009:A13F 3F EF        getbs
0009:A141 B5 1E 54     add   r4
0009:A144 50           add   r0
0009:A145 12 50        add   r0
0009:A147 3F EF        getbs
0009:A149 50           add   r0
0009:A14A 13 50        add   r0
0009:A14C A0 09        ibt   r0,#0009
0009:A14E 3F DF        romb
0009:A150 FE 3E A0     iwt   r14,#A03E
0009:A153 F0 37 1A     iwt   r0,#1A37
0009:A156 51           add   r1
0009:A157 19 3D 40     ldb   (r0)
0009:A15A F0 78 19     iwt   r0,#1978
0009:A15D 51           add   r1
0009:A15E 16 40        ldw   (r0)
0009:A160 F0 80 16     iwt   r0,#1680
0009:A163 51           add   r1
0009:A164 14 40        ldw   (r0)
0009:A166 EF           getb
0009:A167 DE           inc   r14
0009:A168 4D           swap
0009:A169 9F           fmult
0009:A16A 14 54        add   r4
0009:A16C F0 D6 19     iwt   r0,#19D6
0009:A16F 51           add   r1
0009:A170 16 40        ldw   (r0)
0009:A172 F0 82 16     iwt   r0,#1682
0009:A175 51           add   r1
0009:A176 15 40        ldw   (r0)
0009:A178 EF           getb
0009:A179 DE           inc   r14
0009:A17A 4D           swap
0009:A17B 9F           fmult
0009:A17C 15 55        add   r5
0009:A17E F6 00 0C     iwt   r6,#0C00
0009:A181 E9           dec   r9
0009:A182 0B 0A        bmi   A18E
0009:A184 D9           inc   r9
0009:A185 F0 78 19     iwt   r0,#1978
0009:A188 51           add   r1
0009:A189 40           ldw   (r0)
0009:A18A 9F           fmult
0009:A18B 9E           lob
0009:A18C 16 4D        swap
0009:A18E B2 9F        fmult
0009:A190 17 54        add   r4
0009:A192 B3 9F        fmult
0009:A194 18 55        add   r5
0009:A196 FA 00 00     iwt   r10,#0000
0009:A199 AC 04        ibt   r12,#0004
0009:A19B 2F 1D        move  r13,r15
0009:A19D 3F EF        getbs
0009:A19F DE           inc   r14
0009:A1A0 57           add   r7
0009:A1A1 3B           stw   (r11)
0009:A1A2 DB           inc   r11
0009:A1A3 DB           inc   r11
0009:A1A4 3F EF        getbs
0009:A1A6 DE           inc   r14
0009:A1A7 58           add   r8
0009:A1A8 3B           stw   (r11)
0009:A1A9 DB           inc   r11
0009:A1AA DB           inc   r11
0009:A1AB 16 4A        ldw   (r10)
0009:A1AD DA           inc   r10
0009:A1AE DA           inc   r10
0009:A1AF F0 00 3E     iwt   r0,#3E00
0009:A1B2 C6           or    r6
0009:A1B3 3B           stw   (r11)
0009:A1B4 DB           inc   r11
0009:A1B5 DB           inc   r11
0009:A1B6 A0 02        ibt   r0,#0002
0009:A1B8 3B           stw   (r11)
0009:A1B9 DB           inc   r11
0009:A1BA 3C           loop
0009:A1BB DB           inc   r11
0009:A1BC F6 00 24     iwt   r6,#2400
0009:A1BF E9           dec   r9
0009:A1C0 0B 0A        bmi   A1CC
0009:A1C2 D9           inc   r9
0009:A1C3 F0 78 19     iwt   r0,#1978
0009:A1C6 51           add   r1
0009:A1C7 40           ldw   (r0)
0009:A1C8 9F           fmult
0009:A1C9 9E           lob
0009:A1CA 16 4D        swap
0009:A1CC B2 9F        fmult
0009:A1CE 17 54        add   r4
0009:A1D0 B3 9F        fmult
0009:A1D2 18 55        add   r5
0009:A1D4 FA 00 00     iwt   r10,#0000
0009:A1D7 AC 04        ibt   r12,#0004
0009:A1D9 2F 1D        move  r13,r15
0009:A1DB 3F EF        getbs
0009:A1DD DE           inc   r14
0009:A1DE 57           add   r7
0009:A1DF 3B           stw   (r11)
0009:A1E0 DB           inc   r11
0009:A1E1 DB           inc   r11
0009:A1E2 3F EF        getbs
0009:A1E4 DE           inc   r14
0009:A1E5 58           add   r8
0009:A1E6 3B           stw   (r11)
0009:A1E7 DB           inc   r11
0009:A1E8 DB           inc   r11
0009:A1E9 16 4A        ldw   (r10)
0009:A1EB DA           inc   r10
0009:A1EC DA           inc   r10
0009:A1ED F0 00 FC     iwt   r0,#FC00
0009:A1F0 C6           or    r6
0009:A1F1 3B           stw   (r11)
0009:A1F2 DB           inc   r11
0009:A1F3 DB           inc   r11
0009:A1F4 A0 02        ibt   r0,#0002
0009:A1F6 3B           stw   (r11)
0009:A1F7 DB           inc   r11
0009:A1F8 3C           loop
0009:A1F9 DB           inc   r11
0009:A1FA 22 4F        not
0009:A1FC D2           inc   r2
0009:A1FD F0 78 19     iwt   r0,#1978
0009:A200 51           add   r1
0009:A201 16 40        ldw   (r0)
0009:A203 F0 80 16     iwt   r0,#1680
0009:A206 51           add   r1
0009:A207 14 40        ldw   (r0)
0009:A209 EF           getb
0009:A20A DE           inc   r14
0009:A20B 4D           swap
0009:A20C 9F           fmult
0009:A20D 14 54        add   r4
0009:A20F F0 D6 19     iwt   r0,#19D6
0009:A212 51           add   r1
0009:A213 16 40        ldw   (r0)
0009:A215 F0 82 16     iwt   r0,#1682
0009:A218 51           add   r1
0009:A219 15 40        ldw   (r0)
0009:A21B EF           getb
0009:A21C DE           inc   r14
0009:A21D 4D           swap
0009:A21E 9F           fmult
0009:A21F 15 55        add   r5
0009:A221 F6 00 0C     iwt   r6,#0C00
0009:A224 E9           dec   r9
0009:A225 0B 0A        bmi   A231
0009:A227 D9           inc   r9
0009:A228 F0 78 19     iwt   r0,#1978
0009:A22B 51           add   r1
0009:A22C 40           ldw   (r0)
0009:A22D 9F           fmult
0009:A22E 9E           lob
0009:A22F 16 4D        swap
0009:A231 B2 9F        fmult
0009:A233 17 54        add   r4
0009:A235 B3 9F        fmult
0009:A237 18 55        add   r5
0009:A239 FA 00 00     iwt   r10,#0000
0009:A23C AC 04        ibt   r12,#0004
0009:A23E 2F 1D        move  r13,r15
0009:A240 3F EF        getbs
0009:A242 DE           inc   r14
0009:A243 57           add   r7
0009:A244 3B           stw   (r11)
0009:A245 DB           inc   r11
0009:A246 DB           inc   r11
0009:A247 3F EF        getbs
0009:A249 DE           inc   r14
0009:A24A 58           add   r8
0009:A24B 3B           stw   (r11)
0009:A24C DB           inc   r11
0009:A24D DB           inc   r11
0009:A24E 16 4A        ldw   (r10)
0009:A250 DA           inc   r10
0009:A251 DA           inc   r10
0009:A252 F0 00 7E     iwt   r0,#7E00
0009:A255 C6           or    r6
0009:A256 3B           stw   (r11)
0009:A257 DB           inc   r11
0009:A258 DB           inc   r11
0009:A259 A0 02        ibt   r0,#0002
0009:A25B 3B           stw   (r11)
0009:A25C DB           inc   r11
0009:A25D 3C           loop
0009:A25E DB           inc   r11
0009:A25F F6 00 24     iwt   r6,#2400
0009:A262 E9           dec   r9
0009:A263 0B 0A        bmi   A26F
0009:A265 D9           inc   r9
0009:A266 F0 78 19     iwt   r0,#1978
0009:A269 51           add   r1
0009:A26A 40           ldw   (r0)
0009:A26B 9F           fmult
0009:A26C 9E           lob
0009:A26D 16 4D        swap
0009:A26F B2 9F        fmult
0009:A271 17 54        add   r4
0009:A273 B3 9F        fmult
0009:A275 18 55        add   r5
0009:A277 FA 00 00     iwt   r10,#0000
0009:A27A AC 04        ibt   r12,#0004
0009:A27C 2F 1D        move  r13,r15
0009:A27E 3F EF        getbs
0009:A280 DE           inc   r14
0009:A281 57           add   r7
0009:A282 3B           stw   (r11)
0009:A283 DB           inc   r11
0009:A284 DB           inc   r11
0009:A285 3F EF        getbs
0009:A287 DE           inc   r14
0009:A288 58           add   r8
0009:A289 3B           stw   (r11)
0009:A28A DB           inc   r11
0009:A28B DB           inc   r11
0009:A28C 16 4A        ldw   (r10)
0009:A28E DA           inc   r10
0009:A28F DA           inc   r10
0009:A290 F0 00 BC     iwt   r0,#BC00
0009:A293 C6           or    r6
0009:A294 3B           stw   (r11)
0009:A295 DB           inc   r11
0009:A296 DB           inc   r11
0009:A297 A0 02        ibt   r0,#0002
0009:A299 3B           stw   (r11)
0009:A29A DB           inc   r11
0009:A29B 3C           loop
0009:A29C DB           inc   r11
0009:A29D F0 02 14     iwt   r0,#1402
0009:A2A0 51           add   r1
0009:A2A1 16 40        ldw   (r0)
0009:A2A3 F0 30 00     iwt   r0,#0030
0009:A2A6 86           mult  r6
0009:A2A7 1E 5E        add   r14
0009:A2A9 F0 00 14     iwt   r0,#1400
0009:A2AC 51           add   r1
0009:A2AD 12 40        ldw   (r0)
0009:A2AF F0 80 16     iwt   r0,#1680
0009:A2B2 51           add   r1
0009:A2B3 13 40        ldw   (r0)
0009:A2B5 F0 82 16     iwt   r0,#1682
0009:A2B8 51           add   r1
0009:A2B9 14 40        ldw   (r0)
0009:A2BB F0 78 19     iwt   r0,#1978
0009:A2BE 51           add   r1
0009:A2BF 16 40        ldw   (r0)
0009:A2C1 EF           getb
0009:A2C2 DE           inc   r14
0009:A2C3 4D           swap
0009:A2C4 E2           dec   r2
0009:A2C5 0B 03        bmi   A2CA
0009:A2C7 D2           inc   r2
0009:A2C8 4F           not
0009:A2C9 D0           inc   r0
0009:A2CA 17 9F        fmult
0009:A2CC F0 D6 19     iwt   r0,#19D6
0009:A2CF 51           add   r1
0009:A2D0 16 40        ldw   (r0)
0009:A2D2 EF           getb
0009:A2D3 DE           inc   r14
0009:A2D4 4D           swap
0009:A2D5 18 9F        fmult
0009:A2D7 FA 08 00     iwt   r10,#0008
0009:A2DA AC 04        ibt   r12,#0004
0009:A2DC 2F 1D        move  r13,r15
0009:A2DE 3F EF        getbs
0009:A2E0 DE           inc   r14
0009:A2E1 E2           dec   r2
0009:A2E2 0B 04        bmi   A2E8
0009:A2E4 D2           inc   r2
0009:A2E5 4F           not
0009:A2E6 3E 6F        sub   #0F
0009:A2E8 57           add   r7
0009:A2E9 53           add   r3
0009:A2EA 3B           stw   (r11)
0009:A2EB DB           inc   r11
0009:A2EC DB           inc   r11
0009:A2ED 3F EF        getbs
0009:A2EF DE           inc   r14
0009:A2F0 58           add   r8
0009:A2F1 54           add   r4
0009:A2F2 3B           stw   (r11)
0009:A2F3 DB           inc   r11
0009:A2F4 DB           inc   r11
0009:A2F5 16 4A        ldw   (r10)
0009:A2F7 DA           inc   r10
0009:A2F8 DA           inc   r10
0009:A2F9 F0 00 FE     iwt   r0,#FE00
0009:A2FC E2           dec   r2
0009:A2FD 0B 04        bmi   A303
0009:A2FF D2           inc   r2
0009:A300 F0 00 BE     iwt   r0,#BE00
0009:A303 C6           or    r6
0009:A304 3B           stw   (r11)
0009:A305 DB           inc   r11
0009:A306 DB           inc   r11
0009:A307 A0 02        ibt   r0,#0002
0009:A309 3B           stw   (r11)
0009:A30A DB           inc   r11
0009:A30B 3C           loop
0009:A30C DB           inc   r11
0009:A30D FA 08 00     iwt   r10,#0008
0009:A310 AC 04        ibt   r12,#0004
0009:A312 2F 1D        move  r13,r15
0009:A314 3F EF        getbs
0009:A316 DE           inc   r14
0009:A317 E2           dec   r2
0009:A318 0B 04        bmi   A31E
0009:A31A D2           inc   r2
0009:A31B 4F           not
0009:A31C 3E 6F        sub   #0F
0009:A31E 57           add   r7
0009:A31F 53           add   r3
0009:A320 3B           stw   (r11)
0009:A321 DB           inc   r11
0009:A322 DB           inc   r11
0009:A323 3F EF        getbs
0009:A325 DE           inc   r14
0009:A326 58           add   r8
0009:A327 54           add   r4
0009:A328 3B           stw   (r11)
0009:A329 DB           inc   r11
0009:A32A DB           inc   r11
0009:A32B 16 4A        ldw   (r10)
0009:A32D DA           inc   r10
0009:A32E DA           inc   r10
0009:A32F F0 00 3C     iwt   r0,#3C00
0009:A332 E2           dec   r2
0009:A333 0B 04        bmi   A339
0009:A335 D2           inc   r2
0009:A336 F0 00 7C     iwt   r0,#7C00
0009:A339 C6           or    r6
0009:A33A 3B           stw   (r11)
0009:A33B DB           inc   r11
0009:A33C DB           inc   r11
0009:A33D A0 02        ibt   r0,#0002
0009:A33F 3B           stw   (r11)
0009:A340 DB           inc   r11
0009:A341 3C           loop
0009:A342 DB           inc   r11
0009:A343 02           cache
0009:A344 F0 78 19     iwt   r0,#1978
0009:A347 51           add   r1
0009:A348 16 40        ldw   (r0)
0009:A34A EF           getb
0009:A34B DE           inc   r14
0009:A34C 4D           swap
0009:A34D E2           dec   r2
0009:A34E 0B 03        bmi   A353
0009:A350 D2           inc   r2
0009:A351 4F           not
0009:A352 D0           inc   r0
0009:A353 9F           fmult
0009:A354 3E 68        sub   #08
0009:A356 53           add   r3
0009:A357 3B           stw   (r11)
0009:A358 DB           inc   r11
0009:A359 DB           inc   r11
0009:A35A F0 D6 19     iwt   r0,#19D6
0009:A35D 51           add   r1
0009:A35E 16 40        ldw   (r0)
0009:A360 EF           getb
0009:A361 DE           inc   r14
0009:A362 4D           swap
0009:A363 9F           fmult
0009:A364 3E 6F        sub   #0F
0009:A366 54           add   r4
0009:A367 3B           stw   (r11)
0009:A368 DB           inc   r11
0009:A369 DB           inc   r11
0009:A36A 3D A6 08     lms   r6,(0010)
0009:A36D F0 00 3C     iwt   r0,#3C00
0009:A370 E2           dec   r2
0009:A371 0B 04        bmi   A377
0009:A373 D2           inc   r2
0009:A374 F0 00 7C     iwt   r0,#7C00
0009:A377 C6           or    r6
0009:A378 3B           stw   (r11)
0009:A379 DB           inc   r11
0009:A37A DB           inc   r11
0009:A37B A0 02        ibt   r0,#0002
0009:A37D 3B           stw   (r11)
0009:A37E DB           inc   r11
0009:A37F DB           inc   r11
0009:A380 F0 78 19     iwt   r0,#1978
0009:A383 51           add   r1
0009:A384 16 40        ldw   (r0)
0009:A386 EF           getb
0009:A387 DE           inc   r14
0009:A388 4D           swap
0009:A389 E2           dec   r2
0009:A38A 0B 03        bmi   A38F
0009:A38C D2           inc   r2
0009:A38D 4F           not
0009:A38E D0           inc   r0
0009:A38F 9F           fmult
0009:A390 3E 68        sub   #08
0009:A392 53           add   r3
0009:A393 3B           stw   (r11)
0009:A394 DB           inc   r11
0009:A395 DB           inc   r11
0009:A396 F0 D6 19     iwt   r0,#19D6
0009:A399 51           add   r1
0009:A39A 16 40        ldw   (r0)
0009:A39C EF           getb
0009:A39D DE           inc   r14
0009:A39E 4D           swap
0009:A39F 9F           fmult
0009:A3A0 3E 6F        sub   #0F
0009:A3A2 54           add   r4
0009:A3A3 3B           stw   (r11)
0009:A3A4 DB           inc   r11
0009:A3A5 DB           inc   r11
0009:A3A6 3D A6 08     lms   r6,(0010)
0009:A3A9 F0 00 3C     iwt   r0,#3C00
0009:A3AC E2           dec   r2
0009:A3AD 0B 04        bmi   A3B3
0009:A3AF D2           inc   r2
0009:A3B0 F0 00 7C     iwt   r0,#7C00
0009:A3B3 C6           or    r6
0009:A3B4 3B           stw   (r11)
0009:A3B5 DB           inc   r11
0009:A3B6 DB           inc   r11
0009:A3B7 A0 02        ibt   r0,#0002
0009:A3B9 3B           stw   (r11)
0009:A3BA DB           inc   r11
0009:A3BB DB           inc   r11
0009:A3BC F0 78 19     iwt   r0,#1978
0009:A3BF 51           add   r1
0009:A3C0 16 40        ldw   (r0)
0009:A3C2 EF           getb
0009:A3C3 DE           inc   r14
0009:A3C4 4D           swap
0009:A3C5 E2           dec   r2
0009:A3C6 0B 03        bmi   A3CB
0009:A3C8 D2           inc   r2
0009:A3C9 4F           not
0009:A3CA D0           inc   r0
0009:A3CB 9F           fmult
0009:A3CC 3E 68        sub   #08
0009:A3CE 53           add   r3
0009:A3CF 3B           stw   (r11)
0009:A3D0 DB           inc   r11
0009:A3D1 DB           inc   r11
0009:A3D2 F0 D6 19     iwt   r0,#19D6
0009:A3D5 51           add   r1
0009:A3D6 16 40        ldw   (r0)
0009:A3D8 EF           getb
0009:A3D9 DE           inc   r14
0009:A3DA 4D           swap
0009:A3DB 9F           fmult
0009:A3DC 3E 6F        sub   #0F
0009:A3DE 54           add   r4
0009:A3DF 3B           stw   (r11)
0009:A3E0 DB           inc   r11
0009:A3E1 DB           inc   r11
0009:A3E2 3D A6 09     lms   r6,(0012)
0009:A3E5 F0 00 1C     iwt   r0,#1C00
0009:A3E8 E2           dec   r2
0009:A3E9 0B 04        bmi   A3EF
0009:A3EB D2           inc   r2
0009:A3EC F0 00 5C     iwt   r0,#5C00
0009:A3EF C6           or    r6
0009:A3F0 3B           stw   (r11)
0009:A3F1 DB           inc   r11
0009:A3F2 DB           inc   r11
0009:A3F3 A0 02        ibt   r0,#0002
0009:A3F5 3B           stw   (r11)
0009:A3F6 DB           inc   r11
0009:A3F7 DB           inc   r11
0009:A3F8 F0 78 19     iwt   r0,#1978
0009:A3FB 51           add   r1
0009:A3FC 16 40        ldw   (r0)
0009:A3FE EF           getb
0009:A3FF DE           inc   r14
0009:A400 4D           swap
0009:A401 E2           dec   r2
0009:A402 0B 03        bmi   A407
0009:A404 D2           inc   r2
0009:A405 4F           not
0009:A406 D0           inc   r0
0009:A407 17 9F        fmult
0009:A409 F0 D6 19     iwt   r0,#19D6
0009:A40C 51           add   r1
0009:A40D 16 40        ldw   (r0)
0009:A40F EF           getb
0009:A410 DE           inc   r14
0009:A411 4D           swap
0009:A412 18 9F        fmult
0009:A414 FA 14 00     iwt   r10,#0014
0009:A417 AC 04        ibt   r12,#0004
0009:A419 2F 1D        move  r13,r15
0009:A41B 3F EF        getbs
0009:A41D DE           inc   r14
0009:A41E E2           dec   r2
0009:A41F 0B 04        bmi   A425
0009:A421 D2           inc   r2
0009:A422 4F           not
0009:A423 3E 6F        sub   #0F
0009:A425 57           add   r7
0009:A426 53           add   r3
0009:A427 3B           stw   (r11)
0009:A428 DB           inc   r11
0009:A429 DB           inc   r11
0009:A42A 3F EF        getbs
0009:A42C DE           inc   r14
0009:A42D 58           add   r8
0009:A42E 54           add   r4
0009:A42F 3B           stw   (r11)
0009:A430 DB           inc   r11
0009:A431 DB           inc   r11
0009:A432 16 4A        ldw   (r10)
0009:A434 DA           inc   r10
0009:A435 DA           inc   r10
0009:A436 F0 00 2C     iwt   r0,#2C00
0009:A439 E2           dec   r2
0009:A43A 0B 04        bmi   A440
0009:A43C D2           inc   r2
0009:A43D F0 00 6C     iwt   r0,#6C00
0009:A440 C6           or    r6
0009:A441 3B           stw   (r11)
0009:A442 DB           inc   r11
0009:A443 DB           inc   r11
0009:A444 A0 02        ibt   r0,#0002
0009:A446 3B           stw   (r11)
0009:A447 DB           inc   r11
0009:A448 3C           loop
0009:A449 DB           inc   r11
0009:A44A F0 78 19     iwt   r0,#1978
0009:A44D 51           add   r1
0009:A44E 16 40        ldw   (r0)
0009:A450 EF           getb
0009:A451 DE           inc   r14
0009:A452 4D           swap
0009:A453 E2           dec   r2
0009:A454 0B 03        bmi   A459
0009:A456 D2           inc   r2
0009:A457 4F           not
0009:A458 D0           inc   r0
0009:A459 17 9F        fmult
0009:A45B F0 D6 19     iwt   r0,#19D6
0009:A45E 51           add   r1
0009:A45F 16 40        ldw   (r0)
0009:A461 EF           getb
0009:A462 DE           inc   r14
0009:A463 4D           swap
0009:A464 18 9F        fmult
0009:A466 F9 00 40     iwt   r9,#4000
0009:A469 FA 1C 00     iwt   r10,#001C
0009:A46C AC 04        ibt   r12,#0004
0009:A46E 2F 1D        move  r13,r15
0009:A470 3F EF        getbs
0009:A472 DE           inc   r14
0009:A473 E2           dec   r2
0009:A474 0B 04        bmi   A47A
0009:A476 D2           inc   r2
0009:A477 4F           not
0009:A478 3E 6F        sub   #0F
0009:A47A 57           add   r7
0009:A47B 53           add   r3
0009:A47C 3B           stw   (r11)
0009:A47D DB           inc   r11
0009:A47E DB           inc   r11
0009:A47F 3F EF        getbs
0009:A481 DE           inc   r14
0009:A482 58           add   r8
0009:A483 54           add   r4
0009:A484 3B           stw   (r11)
0009:A485 DB           inc   r11
0009:A486 DB           inc   r11
0009:A487 16 4A        ldw   (r10)
0009:A489 DA           inc   r10
0009:A48A DA           inc   r10
0009:A48B EF           getb
0009:A48C DE           inc   r14
0009:A48D 4D           swap
0009:A48E E2           dec   r2
0009:A48F 0B 03        bmi   A494
0009:A491 D2           inc   r2
0009:A492 3D C9        xor   r9
0009:A494 C6           or    r6
0009:A495 3B           stw   (r11)
0009:A496 DB           inc   r11
0009:A497 DB           inc   r11
0009:A498 A0 02        ibt   r0,#0002
0009:A49A 3B           stw   (r11)
0009:A49B DB           inc   r11
0009:A49C 3C           loop
0009:A49D DB           inc   r11
0009:A49E 3E AB 49     sms   (0092),r11
0009:A4A1 02           cache
0009:A4A2 F1 03 10     iwt   r1,#1003
0009:A4A5 F2 00 30     iwt   r2,#3000
0009:A4A8 A3 04        ibt   r3,#0004
0009:A4AA FC 28 00     iwt   r12,#0028
0009:A4AD 2F 1D        move  r13,r15
0009:A4AF 41           ldw   (r1)
0009:A4B0 C2           or    r2
0009:A4B1 21 53        add   r3
0009:A4B3 3C           loop
0009:A4B4 90           sbk
0009:A4B5 00           stop
0009:A4B6 01           nop

DATA_09A4B7:         dw $F800, $9EFC, $002C, $FC00
DATA_09A4BF:         dw $6C9E, $F002, $C0E5, $022D
DATA_09A4C7:         dw $E500, $2DC2, $F002, $E0F5
DATA_09A4CF:         dw $022D, $F500, $2DE2, $F800
DATA_09A4D7:         dw $2EFD, $006C, $FD00, $2C2E
DATA_09A4DF:         dw $F002, $C0E5, $022D, $E500
DATA_09A4E7:         dw $2DC2, $F002, $E0F5, $022D
DATA_09A4EF:         dw $F500, $2DE2, $F800, $2F01
DATA_09A4F7:         dw $006C, $0100, $2C2F, $F002
DATA_09A4FF:         dw $C0E5, $022D, $E500, $2DC2
DATA_09A507:         dw $F002, $E0F5, $022D, $F500
DATA_09A50F:         dw $2DE2

0009:A511 A0 09        ibt   r0,#0009
0009:A513 3F DF        romb
0009:A515 02           cache
0009:A516 3D F1 72 19  lm    r1,(1972)
0009:A51A F0 02 14     iwt   r0,#1402
0009:A51D 51           add   r1
0009:A51E 16 40        ldw   (r0)
0009:A520 A0 1E        ibt   r0,#001E
0009:A522 86           mult  r6
0009:A523 F2 B7 A4     iwt   r2,#A4B7
0009:A526 1E 52        add   r2
0009:A528 F0 80 16     iwt   r0,#1680
0009:A52B 51           add   r1
0009:A52C 12 40        ldw   (r0)
0009:A52E F0 82 16     iwt   r0,#1682
0009:A531 51           add   r1
0009:A532 13 40        ldw   (r0)
0009:A534 F0 00 14     iwt   r0,#1400
0009:A537 51           add   r1
0009:A538 14 40        ldw   (r0)
0009:A53A F5 00 40     iwt   r5,#4000
0009:A53D 3D AB 49     lms   r11,(0092)
0009:A540 AC 06        ibt   r12,#0006
0009:A542 2F 1D        move  r13,r15
0009:A544 16 EF        getb
0009:A546 DE           inc   r14
0009:A547 3F EF        getbs
0009:A549 DE           inc   r14
0009:A54A E4           dec   r4
0009:A54B 0B 09        bmi   A556
0009:A54D D4           inc   r4
0009:A54E 4F           not
0009:A54F D0           inc   r0
0009:A550 E6           dec   r6
0009:A551 0A 03        bpl   A556
0009:A553 D6           inc   r6
0009:A554 3E 58        add   #08
0009:A556 52           add   r2
0009:A557 3B           stw   (r11)
0009:A558 DB           inc   r11
0009:A559 DB           inc   r11
0009:A55A 3F EF        getbs
0009:A55C DE           inc   r14
0009:A55D 53           add   r3
0009:A55E 3B           stw   (r11)
0009:A55F DB           inc   r11
0009:A560 DB           inc   r11
0009:A561 EF           getb
0009:A562 DE           inc   r14
0009:A563 3D EF        getbh
0009:A565 DE           inc   r14
0009:A566 E4           dec   r4
0009:A567 0B 03        bmi   A56C
0009:A569 D4           inc   r4
0009:A56A 3D C5        xor   r5
0009:A56C 3B           stw   (r11)
0009:A56D DB           inc   r11
0009:A56E DB           inc   r11
0009:A56F B6 3B        stw   (r11)
0009:A571 DB           inc   r11
0009:A572 3C           loop
0009:A573 DB           inc   r11
0009:A574 FF 9E A4     iwt   r15,#A49E
0009:A577 01           nop

0009:A578 02           cache
0009:A579 A0 08        ibt   r0,#0008
0009:A57B 3F DF        romb
0009:A57D F0 C0 00     iwt   r0,#00C0
0009:A580 51           add   r1
0009:A581 1B 9E        lob
0009:A583 F0 18 AE     iwt   r0,#AE18
0009:A586 1E 5B        add   r11
0009:A588 F3 58 AE     iwt   r3,#AE58
0009:A58B 3F EF        getbs
0009:A58D B3 1E 5B     add   r11
0009:A590 50           add   r0
0009:A591 12 50        add   r0
0009:A593 FB 18 AE     iwt   r11,#AE18
0009:A596 3F EF        getbs
0009:A598 BB 1E 51     add   r1
0009:A59B 50           add   r0
0009:A59C 13 50        add   r0
0009:A59E FB 58 AE     iwt   r11,#AE58
0009:A5A1 3F EF        getbs
0009:A5A3 BB 1E 51     add   r1
0009:A5A6 50           add   r0
0009:A5A7 50           add   r0
0009:A5A8 3E A0 06     sms   (000C),r0
0009:A5AB 3F EF        getbs
0009:A5AD 50           add   r0
0009:A5AE 50           add   r0
0009:A5AF 3E A0 07     sms   (000E),r0
0009:A5B2 B4 3F DF     romb
0009:A5B5 B7 3D 86     umult r6
0009:A5B8 1E 55        add   r5
0009:A5BA 3D F1 72 19  lm    r1,(1972)
0009:A5BE F0 00 14     iwt   r0,#1400
0009:A5C1 51           add   r1
0009:A5C2 17 40        ldw   (r0)
0009:A5C4 3D AB 49     lms   r11,(0092)
0009:A5C7 3D A6 00     lms   r6,(0000)
0009:A5CA B8 9F        fmult
0009:A5CC 9E           lob
0009:A5CD 4D           swap
0009:A5CE 22 16        move  r6,r2
0009:A5D0 19 9F        fmult
0009:A5D2 E7           dec   r7
0009:A5D3 0B 04        bmi   A5D9
0009:A5D5 D7           inc   r7
0009:A5D6 29 4F        not
0009:A5D8 D9           inc   r9
0009:A5D9 3D A6 01     lms   r6,(0002)
0009:A5DC B8 9F        fmult
0009:A5DE 9E           lob
0009:A5DF 20 15        move  r5,r0
0009:A5E1 4D           swap
0009:A5E2 23 16        move  r6,r3
0009:A5E4 9F           fmult
0009:A5E5 1A 65        sub   r5
0009:A5E7 3D A2 06     lms   r2,(000C)
0009:A5EA 3D A3 07     lms   r3,(000E)
0009:A5ED EF           getb
0009:A5EE DE           inc   r14
0009:A5EF 16 4D        swap
0009:A5F1 26 15        move  r5,r6
0009:A5F3 3D A8 02     lms   r8,(0004)
0009:A5F6 E8           dec   r8
0009:A5F7 0B 08        bmi   A601
0009:A5F9 D8           inc   r8
0009:A5FA 3D A0 00     lms   r0,(0000)
0009:A5FD 9F           fmult
0009:A5FE 9E           lob
0009:A5FF 16 4D        swap
0009:A601 B2 9F        fmult
0009:A603 20 14        move  r4,r0
0009:A605 E7           dec   r7
0009:A606 0B 04        bmi   A60C
0009:A608 D7           inc   r7
0009:A609 24 4F        not
0009:A60B D4           inc   r4
0009:A60C 25 16        move  r6,r5
0009:A60E E8           dec   r8
0009:A60F 0B 08        bmi   A619
0009:A611 D8           inc   r8
0009:A612 3D A0 01     lms   r0,(0002)
0009:A615 9F           fmult
0009:A616 9E           lob
0009:A617 16 4D        swap
0009:A619 B3 9F        fmult
0009:A61B 20 15        move  r5,r0
0009:A61D 3E A4 03     sms   (0006),r4
0009:A620 3E A5 04     sms   (0008),r5
0009:A623 3D A0 08     lms   r0,(0010)
0009:A626 59           add   r9
0009:A627 14 54        add   r4
0009:A629 3D A0 09     lms   r0,(0012)
0009:A62C 5A           add   r10
0009:A62D 15 55        add   r5
0009:A62F AC 04        ibt   r12,#0004
0009:A631 BF 3E 57     add   #07
0009:A634 3E A0 30     sms   (0060),r0
0009:A637 FF 69 A7     iwt   r15,#A769
0009:A63A 01           nop
0009:A63B EF           getb
0009:A63C DE           inc   r14
0009:A63D 16 4D        swap
0009:A63F 26 15        move  r5,r6
0009:A641 3D A8 02     lms   r8,(0004)
0009:A644 E8           dec   r8
0009:A645 0B 08        bmi   A64F
0009:A647 D8           inc   r8
0009:A648 3D A0 00     lms   r0,(0000)
0009:A64B 9F           fmult
0009:A64C 9E           lob
0009:A64D 16 4D        swap
0009:A64F B2 9F        fmult
0009:A651 20 14        move  r4,r0
0009:A653 E7           dec   r7
0009:A654 0B 04        bmi   A65A
0009:A656 D7           inc   r7
0009:A657 24 4F        not
0009:A659 D4           inc   r4
0009:A65A 25 16        move  r6,r5
0009:A65C E8           dec   r8
0009:A65D 0B 08        bmi   A667
0009:A65F D8           inc   r8
0009:A660 3D A0 01     lms   r0,(0002)
0009:A663 9F           fmult
0009:A664 9E           lob
0009:A665 16 4D        swap
0009:A667 B3 9F        fmult
0009:A669 20 15        move  r5,r0
0009:A66B 3E A4 05     sms   (000A),r4
0009:A66E 3E A5 06     sms   (000C),r5
0009:A671 3D A0 08     lms   r0,(0010)
0009:A674 59           add   r9
0009:A675 14 54        add   r4
0009:A677 3D A0 09     lms   r0,(0012)
0009:A67A 5A           add   r10
0009:A67B 15 55        add   r5
0009:A67D AC 04        ibt   r12,#0004
0009:A67F BF 3E 57     add   #07
0009:A682 3E A0 30     sms   (0060),r0
0009:A685 FF 69 A7     iwt   r15,#A769
0009:A688 01           nop
0009:A689 29 4F        not
0009:A68B D9           inc   r9
0009:A68C 3D A0 03     lms   r0,(0006)
0009:A68F 14 4F        not
0009:A691 D4           inc   r4
0009:A692 3D A5 04     lms   r5,(0008)
0009:A695 3D A0 08     lms   r0,(0010)
0009:A698 59           add   r9
0009:A699 14 54        add   r4
0009:A69B 3D A0 09     lms   r0,(0012)
0009:A69E 5A           add   r10
0009:A69F 15 55        add   r5
0009:A6A1 AC 04        ibt   r12,#0004
0009:A6A3 BF 3E 57     add   #07
0009:A6A6 3E A0 30     sms   (0060),r0
0009:A6A9 FF 69 A7     iwt   r15,#A769
0009:A6AC 01           nop
0009:A6AD 3D A0 05     lms   r0,(000A)
0009:A6B0 14 4F        not
0009:A6B2 D4           inc   r4
0009:A6B3 3D A5 06     lms   r5,(000C)
0009:A6B6 3D A0 08     lms   r0,(0010)
0009:A6B9 59           add   r9
0009:A6BA 14 54        add   r4
0009:A6BC 3D A0 09     lms   r0,(0012)
0009:A6BF 5A           add   r10
0009:A6C0 15 55        add   r5
0009:A6C2 AC 04        ibt   r12,#0004
0009:A6C4 BF 3E 57     add   #07
0009:A6C7 3E A0 30     sms   (0060),r0
0009:A6CA FF 69 A7     iwt   r15,#A769
0009:A6CD 01           nop
0009:A6CE F0 02 14     iwt   r0,#1402
0009:A6D1 51           add   r1
0009:A6D2 40           ldw   (r0)
0009:A6D3 3E 69        sub   #09
0009:A6D5 0D 60        bcs   A737
0009:A6D7 01           nop
0009:A6D8 EF           getb
0009:A6D9 DE           inc   r14
0009:A6DA 4D           swap
0009:A6DB 3D A6 00     lms   r6,(0000)
0009:A6DE 19 9F        fmult
0009:A6E0 E7           dec   r7
0009:A6E1 0B 04        bmi   A6E7
0009:A6E3 D7           inc   r7
0009:A6E4 29 4F        not
0009:A6E6 D9           inc   r9
0009:A6E7 EF           getb
0009:A6E8 DE           inc   r14
0009:A6E9 4D           swap
0009:A6EA 3D A6 01     lms   r6,(0002)
0009:A6ED 1A 9F        fmult
0009:A6EF 3D A0 08     lms   r0,(0010)
0009:A6F2 14 59        add   r9
0009:A6F4 3D A0 09     lms   r0,(0012)
0009:A6F7 15 5A        add   r10
0009:A6F9 AC 08        ibt   r12,#0008
0009:A6FB BF 3E 57     add   #07
0009:A6FE 3E A0 30     sms   (0060),r0
0009:A701 FF 69 A7     iwt   r15,#A769
0009:A704 01           nop
0009:A705 EF           getb
0009:A706 DE           inc   r14
0009:A707 4D           swap
0009:A708 3D A6 00     lms   r6,(0000)
0009:A70B 19 9F        fmult
0009:A70D E7           dec   r7
0009:A70E 0B 04        bmi   A714
0009:A710 D7           inc   r7
0009:A711 29 4F        not
0009:A713 D9           inc   r9
0009:A714 EF           getb
0009:A715 DE           inc   r14
0009:A716 4D           swap
0009:A717 3D A6 01     lms   r6,(0002)
0009:A71A 1A 9F        fmult
0009:A71C 3D A0 08     lms   r0,(0010)
0009:A71F 14 59        add   r9
0009:A721 3D A0 09     lms   r0,(0012)
0009:A724 15 5A        add   r10
0009:A726 AC 04        ibt   r12,#0004
0009:A728 BF 3E 57     add   #07
0009:A72B 3E A0 30     sms   (0060),r0
0009:A72E FF 69 A7     iwt   r15,#A769
0009:A731 01           nop
0009:A732 3E AB 49     sms   (0092),r11
0009:A735 00           stop
0009:A736 01           nop

0009:A737 EF           getb
0009:A738 DE           inc   r14
0009:A739 4D           swap
0009:A73A 3D A6 00     lms   r6,(0000)
0009:A73D 19 9F        fmult
0009:A73F E7           dec   r7
0009:A740 0B 04        bmi   A746
0009:A742 D7           inc   r7
0009:A743 29 4F        not
0009:A745 D9           inc   r9
0009:A746 EF           getb
0009:A747 DE           inc   r14
0009:A748 4D           swap
0009:A749 3D A6 01     lms   r6,(0002)
0009:A74C 1A 9F        fmult
0009:A74E 3D A0 08     lms   r0,(0010)
0009:A751 14 59        add   r9
0009:A753 3D A0 09     lms   r0,(0012)
0009:A756 15 5A        add   r10
0009:A758 AC 10        ibt   r12,#0010
0009:A75A BF 3E 57     add   #07
0009:A75D 3E A0 30     sms   (0060),r0
0009:A760 FF 69 A7     iwt   r15,#A769
0009:A763 01           nop
0009:A764 3E AB 49     sms   (0092),r11
0009:A767 00           stop
0009:A768 01           nop

0009:A769 02           cache
0009:A76A 2F 1D        move  r13,r15
0009:A76C 16 EF        getb
0009:A76E DE           inc   r14
0009:A76F A8 07        ibt   r8,#0007
0009:A771 B6 3E 72     and   #02
0009:A774 09 03        beq   A779
0009:A776 01           nop
0009:A777 A8 0F        ibt   r8,#000F
0009:A779 3F EF        getbs
0009:A77B DE           inc   r14
0009:A77C E7           dec   r7
0009:A77D 0B 03        bmi   A782
0009:A77F D7           inc   r7
0009:A780 4F           not
0009:A781 68           sub   r8
0009:A782 54           add   r4
0009:A783 3B           stw   (r11)
0009:A784 DB           inc   r11
0009:A785 DB           inc   r11
0009:A786 3F EF        getbs
0009:A788 DE           inc   r14
0009:A789 55           add   r5
0009:A78A 3B           stw   (r11)
0009:A78B DB           inc   r11
0009:A78C DB           inc   r11
0009:A78D EF           getb
0009:A78E DE           inc   r14
0009:A78F F8 00 40     iwt   r8,#4000
0009:A792 3D EF        getbh
0009:A794 DE           inc   r14
0009:A795 E7           dec   r7
0009:A796 0B 03        bmi   A79B
0009:A798 D7           inc   r7
0009:A799 3D C8        xor   r8
0009:A79B 3B           stw   (r11)
0009:A79C DB           inc   r11
0009:A79D DB           inc   r11
0009:A79E B6 3B        stw   (r11)
0009:A7A0 DB           inc   r11
0009:A7A1 3C           loop
0009:A7A2 DB           inc   r11
0009:A7A3 3D AF 30     lms   r15,(0060)
0009:A7A6 01           nop

0009:A7A7 3F DF        romb
0009:A7A9 3D F2 72 19  lm    r2,(1972)
0009:A7AD F0 40 10     iwt   r0,#1040
0009:A7B0 52           add   r2
0009:A7B1 40           ldw   (r0)
0009:A7B2 C0           hib
0009:A7B3 03           lsr
0009:A7B4 03           lsr
0009:A7B5 1C 03        lsr
0009:A7B7 F0 02 14     iwt   r0,#1402
0009:A7BA 52           add   r2
0009:A7BB 40           ldw   (r0)
0009:A7BC 8C           mult  r12
0009:A7BD 3E 85        mult  #05
0009:A7BF 1E 51        add   r1
0009:A7C1 F0 00 14     iwt   r0,#1400
0009:A7C4 52           add   r2
0009:A7C5 13 40        ldw   (r0)
0009:A7C7 B3 03        lsr
0009:A7C9 03           lsr
0009:A7CA 97           ror
0009:A7CB 14 03        lsr
0009:A7CD F0 42 10     iwt   r0,#1042
0009:A7D0 52           add   r2
0009:A7D1 40           ldw   (r0)
0009:A7D2 4D           swap
0009:A7D3 14 3D C4     xor   r4
0009:A7D6 F0 80 16     iwt   r0,#1680
0009:A7D9 52           add   r2
0009:A7DA 15 40        ldw   (r0)
0009:A7DC F0 82 16     iwt   r0,#1682
0009:A7DF 52           add   r2
0009:A7E0 16 40        ldw   (r0)
0009:A7E2 F0 62 13     iwt   r0,#1362
0009:A7E5 52           add   r2
0009:A7E6 17 40        ldw   (r0)
0009:A7E8 B4 54        add   r4
0009:A7EA 04           rol
0009:A7EB 3E 71        and   #01
0009:A7ED 18 50        add   r0
0009:A7EF 02           cache
0009:A7F0 2F 1D        move  r13,r15
0009:A7F2 11 EF        getb
0009:A7F4 DE           inc   r14
0009:A7F5 3F EF        getbs
0009:A7F7 DE           inc   r14
0009:A7F8 E3           dec   r3
0009:A7F9 0B 09        bmi   A804
0009:A7FB D3           inc   r3
0009:A7FC 4F           not
0009:A7FD D0           inc   r0
0009:A7FE E1           dec   r1
0009:A7FF 0A 03        bpl   A804
0009:A801 D1           inc   r1
0009:A802 3E 58        add   #08
0009:A804 55           add   r5
0009:A805 37           stw   (r7)
0009:A806 D7           inc   r7
0009:A807 D7           inc   r7
0009:A808 3F EF        getbs
0009:A80A DE           inc   r14
0009:A80B E8           dec   r8
0009:A80C 0B 09        bmi   A817
0009:A80E D8           inc   r8
0009:A80F 4F           not
0009:A810 D0           inc   r0
0009:A811 E1           dec   r1
0009:A812 0A 03        bpl   A817
0009:A814 D1           inc   r1
0009:A815 3E 58        add   #08
0009:A817 56           add   r6
0009:A818 37           stw   (r7)
0009:A819 D7           inc   r7
0009:A81A D7           inc   r7
0009:A81B EF           getb
0009:A81C DE           inc   r14
0009:A81D 3D EF        getbh
0009:A81F DE           inc   r14
0009:A820 3D C4        xor   r4
0009:A822 37           stw   (r7)
0009:A823 D7           inc   r7
0009:A824 D7           inc   r7
0009:A825 B1 37        stw   (r7)
0009:A827 D7           inc   r7
0009:A828 3C           loop
0009:A829 D7           inc   r7
0009:A82A 00           stop
0009:A82B 01           nop

0009:A82C 3E A1 01     sms   (0002),r1
0009:A82F 3E A2 02     sms   (0004),r2
0009:A832 F3 02 3A     iwt   r3,#3A02
0009:A835 F4 09 00     iwt   r4,#0009
0009:A838 B4 3F DF     romb
0009:A83B F4 D2 00     iwt   r4,#00D2
0009:A83E F5 DA AA     iwt   r5,#AADA
0009:A841 3E 60        sub   #00
0009:A843 09 05        beq   A84A
0009:A845 01           nop
0009:A846 FF 74 A9     iwt   r15,#A974
0009:A849 01           nop
0009:A84A 02           cache
0009:A84B A0 10        ibt   r0,#0010
0009:A84D B2 1C 60     sub   r0
0009:A850 0A 59        bpl   A8AB
0009:A852 01           nop
0009:A853 A2 00        ibt   r2,#0000
0009:A855 BC 16 4F     not
0009:A858 D6           inc   r6
0009:A859 A0 20        ibt   r0,#0020
0009:A85B B6 60        sub   r0
0009:A85D 0A 34        bpl   A893
0009:A85F 01           nop
0009:A860 B6 56        add   r6
0009:A862 50           add   r0
0009:A863 50           add   r0
0009:A864 16 50        add   r0
0009:A866 F0 50 00     iwt   r0,#0050
0009:A869 B6 60        sub   r0
0009:A86B 0B 68        bmi   A8D5
0009:A86D 01           nop
0009:A86E BC 4F        not
0009:A870 D0           inc   r0
0009:A871 F9 06 00     iwt   r9,#0006
0009:A874 69           sub   r9
0009:A875 B1 60        sub   r0
0009:A877 1A 3E 6B     sub   #0B
0009:A87A F0 B0 01     iwt   r0,#01B0
0009:A87D B6 60        sub   r0
0009:A87F 0B 54        bmi   A8D5
0009:A881 01           nop
0009:A882 BC 4F        not
0009:A884 D0           inc   r0
0009:A885 F9 1B 00     iwt   r9,#001B
0009:A888 69           sub   r9
0009:A889 51           add   r1
0009:A88A 15 3E 5B     add   #0B
0009:A88D 2A 16        move  r6,r10
0009:A88F FF 37 A9     iwt   r15,#A937
0009:A892 01           nop
0009:A893 A0 05        ibt   r0,#0005
0009:A895 B6 60        sub   r0
0009:A897 B1 60        sub   r0
0009:A899 18 3E 6B     sub   #0B
0009:A89C A0 1B        ibt   r0,#001B
0009:A89E B6 60        sub   r0
0009:A8A0 B1 60        sub   r0
0009:A8A2 15 3E 5B     add   #0B
0009:A8A5 28 16        move  r6,r8
0009:A8A7 FF 37 A9     iwt   r15,#A937
0009:A8AA 01           nop
0009:A8AB 09 19        beq   A8C6
0009:A8AD 01           nop
0009:A8AE AB 00        ibt   r11,#0000
0009:A8B0 F0 FF 00     iwt   r0,#00FF
0009:A8B3 2F 1D        move  r13,r15
0009:A8B5 BB 3F 64     cmp   r4
0009:A8B8 0B 05        bmi   A8BF
0009:A8BA 01           nop
0009:A8BB FF 70 A9     iwt   r15,#A970
0009:A8BE 01           nop
0009:A8BF 33           stw   (r3)
0009:A8C0 D3           inc   r3
0009:A8C1 D3           inc   r3
0009:A8C2 D3           inc   r3
0009:A8C3 D3           inc   r3
0009:A8C4 3C           loop
0009:A8C5 DB           inc   r11
0009:A8C6 A6 00        ibt   r6,#0000
0009:A8C8 A0 10        ibt   r0,#0010
0009:A8CA 22 60        sub   r0
0009:A8CC B2 64        sub   r4
0009:A8CE 0B 05        bmi   A8D5
0009:A8D0 01           nop
0009:A8D1 FF 70 A9     iwt   r15,#A970
0009:A8D4 01           nop
0009:A8D5 B5 1E 56     add   r6
0009:A8D8 EF           getb
0009:A8D9 03           lsr
0009:A8DA 03           lsr
0009:A8DB 03           lsr
0009:A8DC 19 03        lsr
0009:A8DE F0 50 00     iwt   r0,#0050
0009:A8E1 B6 60        sub   r0
0009:A8E3 0B 0C        bmi   A8F1
0009:A8E5 01           nop
0009:A8E6 F0 B0 01     iwt   r0,#01B0
0009:A8E9 B6 60        sub   r0
0009:A8EB 0A 3F        bpl   A92C
0009:A8ED 01           nop
0009:A8EE 05 04        bra   A8F4

0009:A8F0 EA           dec   r10

0009:A8F1 B1 1A 69     sub   r9
0009:A8F4 0A 07        bpl   A8FD
0009:A8F6 01           nop
0009:A8F7 F0 00 FF     iwt   r0,#FF00
0009:A8FA 05 0C        bra   A908

0009:A8FC 01           nop

0009:A8FD BA C0        hib
0009:A8FF 09 07        beq   A908
0009:A901 BA F0 FF 00  iwt   r0,#00FF
0009:A905 05 19        bra   A920

0009:A907 01           nop

0009:A908 18 4D        swap
0009:A90A B1 17 59     add   r9
0009:A90D 0A 07        bpl   A916
0009:A90F B7 F0 FF 00  iwt   r0,#00FF
0009:A913 05 0B        bra   A920

0009:A915 01           nop

0009:A916 C0           hib
0009:A917 09 04        beq   A91D
0009:A919 01           nop
0009:A91A F7 FF 00     iwt   r7,#00FF
0009:A91D 27 4D        swap
0009:A91F 70           merge
0009:A920 33           stw   (r3)
0009:A921 D3           inc   r3
0009:A922 D3           inc   r3
0009:A923 D3           inc   r3
0009:A924 D3           inc   r3
0009:A925 A0 10        ibt   r0,#0010
0009:A927 16 56        add   r6
0009:A929 05 A1        bra   A8CC

0009:A92B D2           inc   r2

0009:A92C F0 0B 00     iwt   r0,#000B
0009:A92F 15 51        add   r1
0009:A931 F0 21 00     iwt   r0,#0021
0009:A934 B1 16 60     sub   r0
0009:A937 B2 64        sub   r4
0009:A939 0A 35        bpl   A970
0009:A93B 01           nop
0009:A93C B6 C0        hib
0009:A93E 0A 07        bpl   A947
0009:A940 01           nop
0009:A941 F0 00 FF     iwt   r0,#FF00
0009:A944 05 0A        bra   A950

0009:A946 01           nop

0009:A947 09 07        beq   A950
0009:A949 B6 F0 FF 00  iwt   r0,#00FF
0009:A94D 05 17        bra   A966

0009:A94F 01           nop

0009:A950 18 4D        swap
0009:A952 B5 C0        hib
0009:A954 0A 07        bpl   A95D
0009:A956 01           nop
0009:A957 F0 FF 00     iwt   r0,#00FF
0009:A95A 05 0A        bra   A966

0009:A95C 01           nop

0009:A95D 09 04        beq   A963
0009:A95F B5 F0 FF 00  iwt   r0,#00FF
0009:A963 17 4D        swap
0009:A965 70           merge
0009:A966 33           stw   (r3)
0009:A967 D3           inc   r3
0009:A968 D3           inc   r3
0009:A969 D3           inc   r3
0009:A96A D3           inc   r3
0009:A96B E5           dec   r5
0009:A96C E6           dec   r6
0009:A96D 05 C8        bra   A937

0009:A96F D2           inc   r2

0009:A970 FF 84 AA     iwt   r15,#AA84
0009:A973 01           nop
0009:A974 02           cache
0009:A975 A0 10        ibt   r0,#0010
0009:A977 52           add   r2
0009:A978 09 04        beq   A97E
0009:A97A 01           nop
0009:A97B 0A 08        bpl   A985
0009:A97D 01           nop
0009:A97E FC D2 00     iwt   r12,#00D2
0009:A981 FF 79 AA     iwt   r15,#AA79
0009:A984 01           nop
0009:A985 F0 0B 00     iwt   r0,#000B
0009:A988 1B 52        add   r2
0009:A98A 3E AB 03     sms   (0006),r11
0009:A98D 0A 10        bpl   A99F
0009:A98F 01           nop
0009:A990 F0 05 00     iwt   r0,#0005
0009:A993 5B           add   r11
0009:A994 50           add   r0
0009:A995 50           add   r0
0009:A996 50           add   r0
0009:A997 16 50        add   r0
0009:A999 A2 00        ibt   r2,#0000
0009:A99B FF 22 AA     iwt   r15,#AA22
0009:A99E 01           nop
0009:A99F F0 0B 00     iwt   r0,#000B
0009:A9A2 51           add   r1
0009:A9A3 19 5B        add   r11
0009:A9A5 F0 0B 00     iwt   r0,#000B
0009:A9A8 B2 1B 60     sub   r0
0009:A9AB 3E AB 04     sms   (0008),r11
0009:A9AE 0A 0D        bpl   A9BD
0009:A9B0 01           nop
0009:A9B1 F0 1B 00     iwt   r0,#001B
0009:A9B4 5B           add   r11
0009:A9B5 50           add   r0
0009:A9B6 50           add   r0
0009:A9B7 50           add   r0
0009:A9B8 16 50        add   r0
0009:A9BA 05 0B        bra   A9C7

0009:A9BC 01           nop

0009:A9BD F0 0B 00     iwt   r0,#000B
0009:A9C0 B1 60        sub   r0
0009:A9C2 1A 5B        add   r11
0009:A9C4 F6 A0 01     iwt   r6,#01A0
0009:A9C7 A2 00        ibt   r2,#0000
0009:A9C9 B2 64        sub   r4
0009:A9CB 0B 05        bmi   A9D2
0009:A9CD 01           nop
0009:A9CE FF 70 A9     iwt   r15,#A970
0009:A9D1 01           nop
0009:A9D2 3D A0 04     lms   r0,(0008)
0009:A9D5 B2 60        sub   r0
0009:A9D7 0B 1B        bmi   A9F4
0009:A9D9 01           nop
0009:A9DA 3D A0 03     lms   r0,(0006)
0009:A9DD B2 60        sub   r0
0009:A9DF 0A 41        bpl   AA22
0009:A9E1 01           nop
0009:A9E2 B6 1E 55     add   r5
0009:A9E5 A0 10        ibt   r0,#0010
0009:A9E7 26 60        sub   r0
0009:A9E9 EF           getb
0009:A9EA 03           lsr
0009:A9EB 03           lsr
0009:A9EC 03           lsr
0009:A9ED 03           lsr
0009:A9EE 3E A0 05     sms   (000A),r0
0009:A9F1 B1 1A 60     sub   r0
0009:A9F4 BA C0        hib
0009:A9F6 09 10        beq   AA08
0009:A9F8 BA           from  r10
0009:A9F9 0A 07        bpl   AA02
0009:A9FB 01           nop
0009:A9FC F0 00 00     iwt   r0,#0000
0009:A9FF 05 07        bra   AA08

0009:AA01 01           nop

0009:AA02 F0 FF 00     iwt   r0,#00FF
0009:AA05 05 11        bra   AA18

0009:AA07 01           nop

0009:AA08 18 4D        swap
0009:AA0A B9 C0        hib
0009:AA0C 09 07        beq   AA15
0009:AA0E B9           from  r9
0009:AA0F 0B F1        bmi   AA02
0009:AA11 01           nop
0009:AA12 F0 FF 00     iwt   r0,#00FF
0009:AA15 17 4D        swap
0009:AA17 70           merge
0009:AA18 33           stw   (r3)
0009:AA19 D3           inc   r3
0009:AA1A D3           inc   r3
0009:AA1B D3           inc   r3
0009:AA1C D3           inc   r3
0009:AA1D E9           dec   r9
0009:AA1E EA           dec   r10
0009:AA1F 05 A8        bra   A9C9

0009:AA21 D2           inc   r2

0009:AA22 B2 64        sub   r4
0009:AA24 0A 5E        bpl   AA84
0009:AA26 01           nop
0009:AA27 B6 1E 55     add   r5
0009:AA2A EF           getb
0009:AA2B 03           lsr
0009:AA2C 03           lsr
0009:AA2D 03           lsr
0009:AA2E 1B 03        lsr
0009:AA30 B1 6B        sub   r11
0009:AA32 B1 1A 6B     sub   r11
0009:AA35 0A 06        bpl   AA3D
0009:AA37 BA A0 00     ibt   r0,#0000
0009:AA3A 05 0B        bra   AA47

0009:AA3C 01           nop

0009:AA3D C0           hib
0009:AA3E 09 07        beq   AA47
0009:AA40 BA F0 FF 00  iwt   r0,#00FF
0009:AA44 05 18        bra   AA5E

0009:AA46 01           nop
0009:AA47 18 4D        swap
0009:AA49 B1 1A 5B     add   r11
0009:AA4C 0A 07        bpl   AA55
0009:AA4E BA F0 FF 00  iwt   r0,#00FF
0009:AA52 05 0A        bra   AA5E

0009:AA54 01           nop

0009:AA55 C0           hib
0009:AA56 09 03        beq   AA5B
0009:AA58 BA A0 FF     ibt   r0,#FFFF
0009:AA5B 17 4D        swap
0009:AA5D 70           merge
0009:AA5E 33           stw   (r3)
0009:AA5F D3           inc   r3
0009:AA60 D3           inc   r3
0009:AA61 D3           inc   r3
0009:AA62 D3           inc   r3
0009:AA63 A0 10        ibt   r0,#0010
0009:AA65 26 60        sub   r0
0009:AA67 0A B9        bpl   AA22
0009:AA69 D2           inc   r2
0009:AA6A B4 1C 62     sub   r2
0009:AA6D 09 15        beq   AA84
0009:AA6F 01           nop
0009:AA70 0B 12        bmi   AA84
0009:AA72 01           nop
0009:AA73 05 04        bra   AA79

0009:AA75 01           nop

0009:AA76 FC D2 00     iwt   r12,#00D2
0009:AA79 F0 FF 00     iwt   r0,#00FF
0009:AA7C 2F 1D        move  r13,r15
0009:AA7E 33           stw   (r3)
0009:AA7F D3           inc   r3
0009:AA80 D3           inc   r3
0009:AA81 D3           inc   r3
0009:AA82 3C           loop
0009:AA83 D3           inc   r3
0009:AA84 02           cache
0009:AA85 3D A1 01     lms   r1,(0002)
0009:AA88 3D A2 02     lms   r2,(0004)
0009:AA8B F3 04 3A     iwt   r3,#3A04
0009:AA8E FC D2 00     iwt   r12,#00D2
0009:AA91 A0 16        ibt   r0,#0016
0009:AA93 51           add   r1
0009:AA94 11 52        add   r2
0009:AA96 0A 07        bpl   AA9F
0009:AA98 01           nop
0009:AA99 F0 00 FF     iwt   r0,#FF00
0009:AA9C 05 32        bra   AAD0

0009:AA9E 01           nop

0009:AA9F F0 D2 01     iwt   r0,#01D2
0009:AAA2 B1 60        sub   r0
0009:AAA4 0A 27        bpl   AACD
0009:AAA6 01           nop
0009:AAA7 F7 00 FF     iwt   r7,#FF00
0009:AAAA 2F 1D        move  r13,r15
0009:AAAC B1 3E 60     sub   #00
0009:AAAF 0A 07        bpl   AAB8
0009:AAB1 B1 F0 00 FF  iwt   r0,#FF00
0009:AAB5 05 0D        bra   AAC4

0009:AAB7 01           nop

0009:AAB8 C0           hib
0009:AAB9 09 07        beq   AAC2
0009:AABB 01           nop
0009:AABC F0 FF 00     iwt   r0,#00FF
0009:AABF 05 03        bra   AAC4

0009:AAC1 01           nop

0009:AAC2 B1 C7        or    r7
0009:AAC4 33           stw   (r3)
0009:AAC5 D3           inc   r3
0009:AAC6 D3           inc   r3
0009:AAC7 D3           inc   r3
0009:AAC8 D3           inc   r3
0009:AAC9 3C           loop
0009:AACA E1           dec   r1
0009:AACB 00           stop
0009:AACC 01           nop
0009:AACD F0 FF 00     iwt   r0,#00FF
0009:AAD0 2F 1D        move  r13,r15
0009:AAD2 33           stw   (r3)
0009:AAD3 D3           inc   r3
0009:AAD4 D3           inc   r3
0009:AAD5 D3           inc   r3
0009:AAD6 3C           loop
0009:AAD7 D3           inc   r3
0009:AAD8 00           stop
0009:AAD9 01           nop

DATA_09AADA:         db $16, $1F, $27, $2D, $37, $3B, $3F, $43
DATA_09AAE2:         db $46, $4A, $4D, $50, $53, $56, $59, $5B
DATA_09AAEA:         db $5E, $60, $63, $65, $67, $6A, $6C, $6E
DATA_09AAF2:         db $70, $72, $74, $76, $78, $7A, $7B, $7D
DATA_09AAFA:         db $7F, $81, $82, $84, $86, $87, $89, $8A
DATA_09AB02:         db $8C, $8E, $8F, $90, $92, $93, $95, $96
DATA_09AB0A:         db $97, $99, $9A, $9B, $9D, $9E, $9F, $A1
DATA_09AB12:         db $A2, $A3, $A4, $A5, $A7, $A8, $A9, $AA
DATA_09AB1A:         db $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B3
DATA_09AB22:         db $B4, $C1, $C2, $C2, $C3, $C4, $C5, $C6
DATA_09AB2A:         db $C7, $C7, $C8, $C9, $CA, $CA, $CB, $CC
DATA_09AB32:         db $CD, $CD, $CE, $CF, $D0, $D0, $D1, $D2
DATA_09AB3A:         db $D2, $D3, $D4, $D5, $D5, $D6, $D6, $D7
DATA_09AB42:         db $D8, $D8, $D9, $DA, $DA, $DB, $DB, $DC
DATA_09AB4A:         db $DD, $DD, $DE, $DE, $DF, $DF, $E0, $E1
DATA_09AB52:         db $E1, $E2, $E2, $E3, $E3, $E4, $E4, $E5
DATA_09AB5A:         db $E5, $E6, $E6, $E7, $E7, $E8, $E8, $E9
DATA_09AB62:         db $E9, $E9, $EA, $EA, $EB, $EB, $EC, $EC
DATA_09AB6A:         db $EC, $ED, $ED, $EE, $EE, $EE, $EF, $EF
DATA_09AB72:         db $F0, $F0, $F0, $F1, $F1, $F1, $F2, $F2
DATA_09AB7A:         db $F2, $F3, $F3, $F3, $F4, $F4, $F4, $F5
DATA_09AB82:         db $F5, $F5, $F5, $F6, $F6, $F6, $F7, $F7
DATA_09AB8A:         db $F7, $F7, $F8, $F8, $F8, $F8, $F9, $F9
DATA_09AB92:         db $F9, $F9, $FA, $FA, $FA, $FA, $FA, $FB
DATA_09AB9A:         db $FB, $FB, $FB, $FB, $FC, $FC, $FC, $FC
DATA_09ABA2:         db $FC, $FC, $FD, $FD, $FD, $FD, $FD, $FD
DATA_09ABAA:         db $FD, $FD, $FE, $FE, $FE, $FE, $FE, $FE
DATA_09ABB2:         db $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF
DATA_09ABBA:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09ABC2:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09ABCA:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09ABD2:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09ABDA:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09ABE2:         db $FF, $FE, $FE, $FE, $FE, $FE, $FE, $FE
DATA_09ABEA:         db $FE, $FE, $FD, $FD, $FD, $FD, $FD, $FD
DATA_09ABF2:         db $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
DATA_09ABFA:         db $FB, $FB, $FB, $FB, $FB, $FA, $FA, $FA
DATA_09AC02:         db $FA, $FA, $F9, $F9, $F9, $F9, $F8, $F8
DATA_09AC0A:         db $F8, $F8, $F7, $F7, $F7, $F7, $F6, $F6
DATA_09AC12:         db $F6, $F5, $F5, $F5, $F5, $F4, $F4, $F4
DATA_09AC1A:         db $F3, $F3, $F3, $F2, $F2, $F2, $F1, $F1
DATA_09AC22:         db $F1, $F0, $F0, $F0, $EF, $EF, $EE, $EE
DATA_09AC2A:         db $EE, $ED, $ED, $EC, $EC, $EC, $EB, $EB
DATA_09AC32:         db $EA, $EA, $E9, $E9, $E9, $E8, $E8, $E7
DATA_09AC3A:         db $E7, $E6, $E6, $E5, $E5, $E4, $E4, $E3
DATA_09AC42:         db $E3, $E2, $E2, $E1, $E1, $E0, $DF, $DF
DATA_09AC4A:         db $DE, $DE, $DD, $DD, $DC, $DB, $DB, $DA
DATA_09AC52:         db $DA, $D9, $D8, $D8, $D7, $D6, $D6, $D5
DATA_09AC5A:         db $D5, $D4, $D3, $D2, $D2, $D1, $D0, $D0
DATA_09AC62:         db $CF, $CE, $CD, $CD, $CC, $CB, $CA, $CA
DATA_09AC6A:         db $C9, $C8, $C7, $C7, $C6, $C5, $C4, $C3
DATA_09AC72:         db $C2, $C2, $C1, $C0, $BF, $BE, $BD, $BC
DATA_09AC7A:         db $AD, $AC, $AB, $AA, $A9, $A8, $A7, $A5
DATA_09AC82:         db $A4, $A3, $A2, $A1, $9F, $9E, $9D, $9B
DATA_09AC8A:         db $9A, $99, $97, $96, $95, $93, $92, $90
DATA_09AC92:         db $8F, $8E, $8C, $8A, $89, $87, $86, $84
DATA_09AC9A:         db $82, $81, $7F, $7D, $7B, $7A, $78, $76
DATA_09ACA2:         db $74, $72, $70, $6E, $6C, $6A, $67, $65
DATA_09ACAA:         db $63, $60, $5E, $5B, $59, $56, $53, $50
DATA_09ACB2:         db $4D, $4A, $46, $43, $3F, $3B, $37, $32
DATA_09ACBA:         db $2D, $27, $1F, $16

0009:ACDA 02           cache
0009:ACDB 3D F1 72 19  lm    r1,(1972)
0009:ACDF 3D F2 92 00  lm    r2,(0092)
0009:ACE3 F0 80 16     iwt   r0,#1680
0009:ACE6 51           add   r1
0009:ACE7 13 40        ldw   (r0)
0009:ACE9 F0 82 16     iwt   r0,#1682
0009:ACEC 51           add   r1
0009:ACED 14 40        ldw   (r0)
0009:ACEF E5           dec   r5
0009:ACF0 0B 64        bmi   AD56
0009:ACF2 01           nop
0009:ACF3 F0 08 00     iwt   r0,#0008
0009:ACF6 3F DF        romb
0009:ACF8 F0 58 AE     iwt   r0,#AE58
0009:ACFB 1E 59        add   r9
0009:ACFD 3F EF        getbs
0009:ACFF 96           asr
0009:AD00 96           asr
0009:AD01 96           asr
0009:AD02 96           asr
0009:AD03 8A           mult  r10
0009:AD04 50           add   r0
0009:AD05 50           add   r0
0009:AD06 C0           hib
0009:AD07 95           sex
0009:AD08 18 54        add   r4
0009:AD0A F0 09 00     iwt   r0,#0009
0009:AD0D 3F DF        romb
0009:AD0F F0 5C AD     iwt   r0,#AD5C
0009:AD12 59           add   r9
0009:AD13 19 9E        lob
0009:AD15 F0 61 AD     iwt   r0,#AD61
0009:AD18 1E 55        add   r5
0009:AD1A EF           getb
0009:AD1B 3D 86        umult r6
0009:AD1D 50           add   r0
0009:AD1E C0           hib
0009:AD1F B3 17 60     sub   r0
0009:AD22 F0 66 AD     iwt   r0,#AD66
0009:AD25 1E 55        add   r5
0009:AD27 1C EF        getb
0009:AD29 F0 6B AD     iwt   r0,#AD6B
0009:AD2C 55           add   r5
0009:AD2D 1E 55        add   r5
0009:AD2F EF           getb
0009:AD30 DE           inc   r14
0009:AD31 3D EF        getbh
0009:AD33 20 1E        move  r14,r0
0009:AD35 2F 1D        move  r13,r15
0009:AD37 3F EF        getbs
0009:AD39 DE           inc   r14
0009:AD3A 57           add   r7
0009:AD3B 32           stw   (r2)
0009:AD3C D2           inc   r2
0009:AD3D D2           inc   r2
0009:AD3E 3F EF        getbs
0009:AD40 DE           inc   r14
0009:AD41 58           add   r8
0009:AD42 32           stw   (r2)
0009:AD43 D2           inc   r2
0009:AD44 D2           inc   r2
0009:AD45 EF           getb
0009:AD46 DE           inc   r14
0009:AD47 3D EF        getbh
0009:AD49 DE           inc   r14
0009:AD4A 32           stw   (r2)
0009:AD4B D2           inc   r2
0009:AD4C D2           inc   r2
0009:AD4D EF           getb
0009:AD4E DE           inc   r14
0009:AD4F 32           stw   (r2)
0009:AD50 D2           inc   r2
0009:AD51 3C           loop
0009:AD52 D2           inc   r2
0009:AD53 05 9A        bra   ACEF

0009:AD55 01           nop

0009:AD56 3E F2 92 00  sm    (0092),r2
0009:AD5A 00           stop
0009:AD5B 01           nop

0009:AD5C A0 10        ibt   r0,#0010
0009:AD5E D0           inc   r0
0009:AD5F 40           ldw   (r0)
0009:AD60 00           stop

0009:AD61 00           stop
0009:AD62 28 4E        color
0009:AD64 72           and   r2
0009:AD65 98           jmp   r8

0009:AD66 06 0B        bge   AD73
0009:AD68 08 0C        bne   AD76
0009:AD6A 11        sub   r5

DATA_09AD6B:         dw $AE65, $AE2E, $AE06, $ADCA
DATA_09AD73:         dw $AD75

DATA_09AD75:         db $20, $20, $BA, $37, $00, $20, $18, $BA
DATA_09AD7D:         db $37, $00, $1A, $10, $A3, $37, $00, $12
DATA_09AD85:         db $10, $A2, $37, $00, $18, $20, $B4, $37
DATA_09AD8D:         db $00, $10, $18, $B2, $37, $00, $18, $18
DATA_09AD95:         db $B3, $37, $00, $10, $20, $A2, $37, $00
DATA_09AD9D:         db $20, $28, $95, $37, $00, $00, $28, $BB
DATA_09ADA5:         db $37, $00, $18, $28, $94, $37, $00, $10
DATA_09ADAD:         db $28, $85, $37, $00, $08, $28, $84, $37
DATA_09ADB5:         db $00, $08, $00, $96, $37, $00, $10, $00
DATA_09ADBD:         db $82, $37, $02, $00, $18, $A0, $37, $02
DATA_09ADC5:         db $00, $08, $80, $37, $02

DATA_09ADCA:         db $18, $08, $80, $77, $02, $10, $20, $A2
DATA_09ADD2:         db $37, $00, $00, $28, $BB, $37, $00, $20
DATA_09ADDA:         db $28, $95, $37, $00, $18, $28, $94, $37
DATA_09ADE2:         db $00, $10, $28, $85, $37, $00, $08, $28
DATA_09ADEA:         db $84, $37, $00, $18, $18, $A4, $37, $02
DATA_09ADF2:         db $08, $00, $96, $37, $00, $10, $00, $82
DATA_09ADFA:         db $37, $02, $00, $08, $80, $37, $02, $00
DATA_09AE02:         db $18, $A0, $37, $02

DATA_09AE06:         db $0F, $00, $86, $37, $00, $17, $00, $87
DATA_09AE0E:         db $37, $00, $18, $08, $88, $37, $00, $18
DATA_09AE16:         db $20, $AB, $37, $02, $18, $10, $8B, $37
DATA_09AE1E:         db $02, $08, $08, $89, $37, $02, $08, $18
DATA_09AE26:         db $97, $37, $02, $00, $20, $A6, $37, $02

DATA_09AE2E:         db $08, $18, $B8, $37, $00, $08, $10, $B8
DATA_09AE36:         db $37, $00, $18, $20, $A2, $37, $00, $18
DATA_09AE3E:         db $28, $85, $37, $00, $20, $28, $BD, $37
DATA_09AE46:         db $00, $20, $20, $AD, $37, $00, $10, $10
DATA_09AE4E:         db $BA, $37, $00, $10, $18, $BA, $37, $00
DATA_09AE56:         db $08, $00, $A9, $37, $02, $08, $20, $8E
DATA_09AE5E:         db $37, $02, $00, $20, $8D, $37, $02

DATA_09AE65:         db $00, $18, $B8, $37, $00, $00, $10, $B8
DATA_09AE6D:         db $37, $00, $08, $10, $BA, $37, $00, $08
DATA_09AE75:         db $18, $BA, $37, $00, $00, $20, $AE, $37
DATA_09AE7D:         db $02, $00, $00, $A9, $37, $02

0009:AE83 3F DF        romb
0009:AE85 25 1E        move  r14,r5
0009:AE87 02           cache
0009:AE88 3D F1 72 19  lm    r1,(1972)
0009:AE8C 3D F2 92 00  lm    r2,(0092)
0009:AE90 F0 80 16     iwt   r0,#1680
0009:AE93 51           add   r1
0009:AE94 13 40        ldw   (r0)
0009:AE96 F0 82 16     iwt   r0,#1682
0009:AE99 51           add   r1
0009:AE9A 14 40        ldw   (r0)
0009:AE9C 2F 1D        move  r13,r15
0009:AE9E 3F EF        getbs
0009:AEA0 DE           inc   r14
0009:AEA1 53           add   r3
0009:AEA2 32           stw   (r2)
0009:AEA3 D2           inc   r2
0009:AEA4 D2           inc   r2
0009:AEA5 3F EF        getbs
0009:AEA7 DE           inc   r14
0009:AEA8 54           add   r4
0009:AEA9 32           stw   (r2)
0009:AEAA D2           inc   r2
0009:AEAB D2           inc   r2
0009:AEAC EF           getb
0009:AEAD DE           inc   r14
0009:AEAE 3D EF        getbh
0009:AEB0 DE           inc   r14
0009:AEB1 32           stw   (r2)
0009:AEB2 D2           inc   r2
0009:AEB3 D2           inc   r2
0009:AEB4 EF           getb
0009:AEB5 DE           inc   r14
0009:AEB6 32           stw   (r2)
0009:AEB7 D2           inc   r2
0009:AEB8 D2           inc   r2
0009:AEB9 3C           loop
0009:AEBA 01           nop
0009:AEBB 3E F2 92 00  sm    (0092),r2
0009:AEBF 00           stop
0009:AEC0 01           nop

0009:AEC1 3F DF        romb
0009:AEC3 3D F2 72 19  lm    r2,(1972)
0009:AEC7 F0 40 10     iwt   r0,#1040
0009:AECA 52           add   r2
0009:AECB 40           ldw   (r0)
0009:AECC C0           hib
0009:AECD 03           lsr
0009:AECE 03           lsr
0009:AECF 1C 03        lsr
0009:AED1 F0 02 14     iwt   r0,#1402
0009:AED4 52           add   r2
0009:AED5 40           ldw   (r0)
0009:AED6 8C           mult  r12
0009:AED7 3E 85        mult  #05
0009:AED9 1E 51        add   r1
0009:AEDB F0 00 14     iwt   r0,#1400
0009:AEDE 52           add   r2
0009:AEDF 13 40        ldw   (r0)
0009:AEE1 B3 03        lsr
0009:AEE3 03           lsr
0009:AEE4 97           ror
0009:AEE5 14 03        lsr
0009:AEE7 F0 80 16     iwt   r0,#1680
0009:AEEA 52           add   r2
0009:AEEB 15 40        ldw   (r0)
0009:AEED F0 82 16     iwt   r0,#1682
0009:AEF0 52           add   r2
0009:AEF1 16 40        ldw   (r0)
0009:AEF3 F0 62 13     iwt   r0,#1362
0009:AEF6 52           add   r2
0009:AEF7 17 40        ldw   (r0)
0009:AEF9 F0 42 10     iwt   r0,#1042
0009:AEFC 52           add   r2
0009:AEFD 40           ldw   (r0)
0009:AEFE 18 4D        swap
0009:AF00 F0 FF CF     iwt   r0,#CFFF
0009:AF03 78           and   r8
0009:AF04 14 3D C4     xor   r4
0009:AF07 F0 00 30     iwt   r0,#3000
0009:AF0A 18 78        and   r8
0009:AF0C A9 05        ibt   r9,#0005
0009:AF0E 02           cache
0009:AF0F 2F 1D        move  r13,r15
0009:AF11 11 EF        getb
0009:AF13 DE           inc   r14
0009:AF14 3F EF        getbs
0009:AF16 DE           inc   r14
0009:AF17 E9           dec   r9
0009:AF18 0B 0D        bmi   AF27
0009:AF1A D9           inc   r9
0009:AF1B E3           dec   r3
0009:AF1C 0B 09        bmi   AF27
0009:AF1E D3           inc   r3
0009:AF1F 4F           not
0009:AF20 D0           inc   r0
0009:AF21 E1           dec   r1
0009:AF22 0A 03        bpl   AF27
0009:AF24 D1           inc   r1
0009:AF25 3E 58        add   #08
0009:AF27 55           add   r5
0009:AF28 37           stw   (r7)
0009:AF29 D7           inc   r7
0009:AF2A D7           inc   r7
0009:AF2B 3F EF        getbs
0009:AF2D DE           inc   r14
0009:AF2E 56           add   r6
0009:AF2F 37           stw   (r7)
0009:AF30 D7           inc   r7
0009:AF31 D7           inc   r7
0009:AF32 EF           getb
0009:AF33 DE           inc   r14
0009:AF34 3D EF        getbh
0009:AF36 DE           inc   r14
0009:AF37 E9           dec   r9
0009:AF38 0B 03        bmi   AF3D
0009:AF3A D9           inc   r9
0009:AF3B 3D C4        xor   r4
0009:AF3D 3D C8        xor   r8
0009:AF3F 37           stw   (r7)
0009:AF40 D7           inc   r7
0009:AF41 D7           inc   r7
0009:AF42 B1 37        stw   (r7)
0009:AF44 D7           inc   r7
0009:AF45 D7           inc   r7
0009:AF46 3C           loop
0009:AF47 E9           dec   r9
0009:AF48 00           stop
0009:AF49 01           nop

0009:AF4A 02           cache
0009:AF4B F1 00 0F     iwt   r1,#0F00
0009:AF4E F2 A2 0F     iwt   r2,#0FA2
0009:AF51 F3 00 60     iwt   r3,#6000
0009:AF54 A4 04        ibt   r4,#0004
0009:AF56 AB 00        ibt   r11,#0000
0009:AF58 AC 18        ibt   r12,#0018
0009:AF5A 2F 1D        move  r13,r15
0009:AF5C 41           ldw   (r1)
0009:AF5D 3E 60        sub   #00
0009:AF5F 09 06        beq   AF67
0009:AF61 01           nop
0009:AF62 42           ldw   (r2)
0009:AF63 73           and   r3
0009:AF64 09 08        beq   AF6E
0009:AF66 01           nop
0009:AF67 21 54        add   r4
0009:AF69 22 54        add   r4
0009:AF6B 3C           loop
0009:AF6C 01           nop
0009:AF6D EB           dec   r11
0009:AF6E 00           stop
0009:AF6F 01           nop

; freespace
DATA_09AF70:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AF78:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AF80:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AF88:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AF90:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AF98:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFA0:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFA8:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFB0:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFB8:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFC0:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFC8:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFD0:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFD8:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFE0:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFE8:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFF0:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09AFF8:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B000:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B008:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B010:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B018:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B020:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B028:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B030:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09B038:         db $01, $01, $01, $01, $01, $01

0009:B03E A0 09        ibt   r0,#0009
0009:B040 3F DF        romb
0009:B042 A0 00        ibt   r0,#0000
0009:B044 3D 4E        cmode
0009:B046 A0 03        ibt   r0,#0003
0009:B048 4E           color
0009:B049 3D F0 6E 40  lm    r0,(406E)
0009:B04D 50           add   r0
0009:B04E 50           add   r0
0009:B04F D0           inc   r0
0009:B050 1F 5F        add   r15
0009:B052 FF 5F B0     iwt   r15,#B05F
0009:B055 01           nop
0009:B056 01           nop
0009:B057 9F           fmult
0009:B058 B0 01        nop
0009:B05A 01           nop
0009:B05B E1           dec   r1
0009:B05C B4 01        nop
0009:B05E 01           nop
0009:B05F A0 01        ibt   r0,#0001
0009:B061 3E F0 6E 40  sm    (406E),r0
0009:B065 60           sub   r0
0009:B066 3E F0 7E 40  sm    (407E),r0
0009:B06A 3E F0 84 40  sm    (4084),r0
0009:B06E 3E F0 88 40  sm    (4088),r0
0009:B072 3E F0 8A 40  sm    (408A),r0
0009:B076 3E F0 80 40  sm    (4080),r0
0009:B07A 3E F0 82 40  sm    (4082),r0
0009:B07E 3E F0 94 40  sm    (4094),r0
0009:B082 A0 10        ibt   r0,#0010
0009:B084 3E F0 86 40  sm    (4086),r0
0009:B088 3D F0 96 40  lm    r0,(4096)
0009:B08C 3E F0 7C 40  sm    (407C),r0
0009:B090 F0 FF 00     iwt   r0,#00FF
0009:B093 F1 00 4E     iwt   r1,#4E00
0009:B096 FC 00 05     iwt   r12,#0500
0009:B099 2F 1D        move  r13,r15
0009:B09B 31           stw   (r1)
0009:B09C D1           inc   r1
0009:B09D 3C           loop
0009:B09E D1           inc   r1
0009:B09F 60           sub   r0
0009:B0A0 3E A0 3D     sms   (007A),r0
0009:B0A3 3D F0 88 40  lm    r0,(4088)
0009:B0A7 E0           dec   r0
0009:B0A8 0B 05        bmi   B0AF
0009:B0AA 90           sbk
0009:B0AB FF 99 BA     iwt   r15,#BA99
0009:B0AE 01           nop
0009:B0AF 3D F0 8A 40  lm    r0,(408A)
0009:B0B3 3E F0 88 40  sm    (4088),r0
0009:B0B7 3D F0 98 40  lm    r0,(4098)
0009:B0BB 3F DF        romb
0009:B0BD 3D FE 7C 40  lm    r14,(407C)
0009:B0C1 EF           getb
0009:B0C2 DE           inc   r14
0009:B0C3 3D EF        getbh
0009:B0C5 3E F0 72 40  sm    (4072),r0
0009:B0C9 A1 09        ibt   r1,#0009
0009:B0CB B1 3F DF     romb
0009:B0CE 20 11        move  r1,r0
0009:B0D0 D0           inc   r0
0009:B0D1 9E           lob
0009:B0D2 09 05        beq   B0D9
0009:B0D4 01           nop
0009:B0D5 FF E3 B4     iwt   r15,#B4E3
0009:B0D8 01           nop
0009:B0D9 B1 C0        hib
0009:B0DB 50           add   r0
0009:B0DC 50           add   r0
0009:B0DD D0           inc   r0
0009:B0DE 1F 5F        add   r15
0009:B0E0 FF 57 B6     iwt   r15,#B657
0009:B0E3 01           nop

DATA_09B0E4:         db $01, $60, $B6, $01
DATA_09B0E8:         db $01, $69, $B6, $01
DATA_09B0EC:         db $01, $72, $B6, $01
DATA_09B0F0:         db $01, $7B, $B6, $01
DATA_09B0F4:         db $01, $91, $B6, $01
DATA_09B0F8:         db $01, $A1, $B6, $01
DATA_09B0FC:         db $01, $B1, $B6, $01
DATA_09B100:         db $01, $C1, $B6, $01
DATA_09B104:         db $01, $D1, $B6, $01
DATA_09B108:         db $01, $E6, $B6, $01
DATA_09B10C:         db $01, $0C, $B7, $01
DATA_09B110:         db $01, $0C, $B7, $01
DATA_09B114:         db $01, $0C, $B7, $01
DATA_09B118:         db $01, $0C, $B7, $01
DATA_09B11C:         db $01, $F6, $B6, $01
DATA_09B120:         db $01, $2B, $B7, $01
DATA_09B124:         db $01, $54, $B7, $01
DATA_09B128:         db $01, $5B, $B7, $01
DATA_09B12C:         db $01, $61, $B7, $01
DATA_09B130:         db $01, $67, $B7, $01
DATA_09B134:         db $01, $6D, $B7, $01
DATA_09B138:         db $01, $6D, $B7, $01
DATA_09B13C:         db $01, $6D, $B7, $01
DATA_09B140:         db $01, $6D, $B7, $01
DATA_09B144:         db $01, $6D, $B7, $01
DATA_09B148:         db $01, $6D, $B7, $01
DATA_09B14C:         db $01, $6D, $B7, $01
DATA_09B150:         db $01, $6D, $B7, $01
DATA_09B154:         db $01, $6D, $B7, $01
DATA_09B158:         db $01, $6D, $B7, $01
DATA_09B15C:         db $01, $6D, $B7, $01
DATA_09B160:         db $01, $C2, $B7, $01
DATA_09B164:         db $01, $C2, $B7, $01
DATA_09B168:         db $01, $C2, $B7, $01
DATA_09B16C:         db $01, $C2, $B7, $01
DATA_09B170:         db $01, $C2, $B7, $01
DATA_09B174:         db $01, $C2, $B7, $01
DATA_09B178:         db $01, $C2, $B7, $01
DATA_09B17C:         db $01, $C2, $B7, $01
DATA_09B180:         db $01, $C2, $B7, $01
DATA_09B184:         db $01, $C2, $B7, $01
DATA_09B188:         db $01, $C2, $B7, $01
DATA_09B18C:         db $01, $C2, $B7, $01
DATA_09B190:         db $01, $C2, $B7, $01
DATA_09B194:         db $01, $C2, $B7, $01
DATA_09B198:         db $01, $C2, $B7, $01
DATA_09B19C:         db $01, $C2, $B7, $01
DATA_09B1A0:         db $01, $C2, $B7, $01
DATA_09B1A4:         db $01, $D0, $B7, $01
DATA_09B1A8:         db $01, $DE, $B7, $01
DATA_09B1AC:         db $01, $EC, $B7, $01
DATA_09B1B0:         db $01, $FA, $B7, $01
DATA_09B1B4:         db $01, $04, $B8, $01
DATA_09B1B8:         db $01, $0E, $B8, $01
DATA_09B1BC:         db $01, $18, $B8, $01
DATA_09B1C0:         db $01, $22, $B8, $01
DATA_09B1C4:         db $01, $2C, $B8, $01
DATA_09B1C8:         db $01, $36, $B8, $01
DATA_09B1CC:         db $01, $40, $B8, $01
DATA_09B1D0:         db $01, $4A, $B8, $01
DATA_09B1D4:         db $01, $4A, $B8, $01
DATA_09B1D8:         db $01, $77, $B8, $01
DATA_09B1DC:         db $01, $91, $B8, $01
DATA_09B1E0:         db $01, $AC, $B8, $01
DATA_09B1E4:         db $01, $AC, $B8, $01
DATA_09B1E8:         db $01, $AC, $B8, $01
DATA_09B1EC:         db $01, $AC, $B8, $01
DATA_09B1F0:         db $01, $AC, $B8, $01
DATA_09B1F4:         db $01, $AC, $B8, $01
DATA_09B1F8:         db $01, $AC, $B8, $01
DATA_09B1FC:         db $01, $AC, $B8, $01
DATA_09B200:         db $01, $AC, $B8, $01
DATA_09B204:         db $01, $AC, $B8, $01
DATA_09B208:         db $01, $AC, $B8, $01
DATA_09B20C:         db $01, $AC, $B8, $01
DATA_09B210:         db $01, $AC, $B8, $01
DATA_09B214:         db $01, $AC, $B8, $01
DATA_09B218:         db $01, $AC, $B8, $01
DATA_09B21C:         db $01, $AC, $B8, $01
DATA_09B220:         db $01, $BC, $B8, $01
DATA_09B224:         db $01, $BC, $B8, $01
DATA_09B228:         db $01, $CE, $B9, $01
DATA_09B22C:         db $01, $F0, $B9, $01
DATA_09B230:         db $01, $F0, $B9, $01
DATA_09B234:         db $01, $F0, $B9, $01
DATA_09B238:         db $01, $F0, $B9, $01
DATA_09B23C:         db $01, $F0, $B9, $01
DATA_09B240:         db $01, $F0, $B9, $01
DATA_09B244:         db $01, $F0, $B9, $01
DATA_09B248:         db $01, $F0, $B9, $01
DATA_09B24C:         db $01, $F0, $B9, $01
DATA_09B250:         db $01, $F0, $B9, $01
DATA_09B254:         db $01, $F0, $B9, $01
DATA_09B258:         db $01, $F0, $B9, $01
DATA_09B25C:         db $01, $F0, $B9, $01
DATA_09B260:         db $01, $F4, $B9, $01
DATA_09B264:         db $01, $84, $BA, $01
DATA_09B268:         db $01, $84, $BA, $01
DATA_09B26C:         db $01, $84, $BA, $01
DATA_09B270:         db $01, $84, $BA, $01
DATA_09B274:         db $01, $84, $BA, $01
DATA_09B278:         db $01, $84, $BA, $01
DATA_09B27C:         db $01, $84, $BA, $01
DATA_09B280:         db $01, $84, $BA, $01
DATA_09B284:         db $01, $84, $BA, $01
DATA_09B288:         db $01, $84, $BA, $01
DATA_09B28C:         db $01, $84, $BA, $01
DATA_09B290:         db $01, $84, $BA, $01
DATA_09B294:         db $01, $84, $BA, $01
DATA_09B298:         db $01, $84, $BA, $01
DATA_09B29C:         db $01, $84, $BA, $01
DATA_09B2A0:         db $01, $84, $BA, $01
DATA_09B2A4:         db $01, $84, $BA, $01
DATA_09B2A8:         db $01, $84, $BA, $01
DATA_09B2AC:         db $01, $84, $BA, $01
DATA_09B2B0:         db $01, $84, $BA, $01
DATA_09B2B4:         db $01, $84, $BA, $01
DATA_09B2B8:         db $01, $84, $BA, $01
DATA_09B2BC:         db $01, $84, $BA, $01
DATA_09B2C0:         db $01, $84, $BA, $01
DATA_09B2C4:         db $01, $84, $BA, $01
DATA_09B2C8:         db $01, $84, $BA, $01
DATA_09B2CC:         db $01, $84, $BA, $01
DATA_09B2D0:         db $01, $84, $BA, $01
DATA_09B2D4:         db $01, $84, $BA, $01
DATA_09B2D8:         db $01, $84, $BA, $01
DATA_09B2DC:         db $01, $84, $BA, $01
DATA_09B2E0:         db $01, $84, $BA, $01
DATA_09B2E4:         db $01, $84, $BA, $01
DATA_09B2E8:         db $01, $84, $BA, $01
DATA_09B2EC:         db $01, $84, $BA, $01
DATA_09B2F0:         db $01, $84, $BA, $01
DATA_09B2F4:         db $01, $84, $BA, $01
DATA_09B2F8:         db $01, $84, $BA, $01
DATA_09B2FC:         db $01, $84, $BA, $01
DATA_09B300:         db $01, $84, $BA, $01
DATA_09B304:         db $01, $84, $BA, $01
DATA_09B308:         db $01, $84, $BA, $01
DATA_09B30C:         db $01, $84, $BA, $01
DATA_09B310:         db $01, $84, $BA, $01
DATA_09B314:         db $01, $84, $BA, $01
DATA_09B318:         db $01, $84, $BA, $01
DATA_09B31C:         db $01, $84, $BA, $01
DATA_09B320:         db $01, $84, $BA, $01
DATA_09B324:         db $01, $84, $BA, $01
DATA_09B328:         db $01, $84, $BA, $01
DATA_09B32C:         db $01, $84, $BA, $01
DATA_09B330:         db $01, $84, $BA, $01
DATA_09B334:         db $01, $84, $BA, $01
DATA_09B338:         db $01, $84, $BA, $01
DATA_09B33C:         db $01, $84, $BA, $01
DATA_09B340:         db $01, $84, $BA, $01
DATA_09B344:         db $01, $84, $BA, $01
DATA_09B348:         db $01, $84, $BA, $01
DATA_09B34C:         db $01, $84, $BA, $01
DATA_09B350:         db $01, $84, $BA, $01
DATA_09B354:         db $01, $84, $BA, $01
DATA_09B358:         db $01, $84, $BA, $01
DATA_09B35C:         db $01, $84, $BA, $01
DATA_09B360:         db $01, $84, $BA, $01
DATA_09B364:         db $01, $84, $BA, $01
DATA_09B368:         db $01, $84, $BA, $01
DATA_09B36C:         db $01, $84, $BA, $01
DATA_09B370:         db $01, $84, $BA, $01
DATA_09B374:         db $01, $84, $BA, $01
DATA_09B378:         db $01, $84, $BA, $01
DATA_09B37C:         db $01, $84, $BA, $01
DATA_09B380:         db $01, $84, $BA, $01
DATA_09B384:         db $01, $84, $BA, $01
DATA_09B388:         db $01, $84, $BA, $01
DATA_09B38C:         db $01, $84, $BA, $01
DATA_09B390:         db $01, $84, $BA, $01
DATA_09B394:         db $01, $84, $BA, $01
DATA_09B398:         db $01, $84, $BA, $01
DATA_09B39C:         db $01, $84, $BA, $01
DATA_09B3A0:         db $01, $84, $BA, $01
DATA_09B3A4:         db $01, $84, $BA, $01
DATA_09B3A8:         db $01, $84, $BA, $01
DATA_09B3AC:         db $01, $84, $BA, $01
DATA_09B3B0:         db $01, $84, $BA, $01
DATA_09B3B4:         db $01, $84, $BA, $01
DATA_09B3B8:         db $01, $84, $BA, $01
DATA_09B3BC:         db $01, $84, $BA, $01
DATA_09B3C0:         db $01, $84, $BA, $01
DATA_09B3C4:         db $01, $84, $BA, $01
DATA_09B3C8:         db $01, $84, $BA, $01
DATA_09B3CC:         db $01, $84, $BA, $01
DATA_09B3D0:         db $01, $84, $BA, $01
DATA_09B3D4:         db $01, $84, $BA, $01
DATA_09B3D8:         db $01, $84, $BA, $01
DATA_09B3DC:         db $01, $84, $BA, $01
DATA_09B3E0:         db $01, $84, $BA, $01
DATA_09B3E4:         db $01, $84, $BA, $01
DATA_09B3E8:         db $01, $84, $BA, $01
DATA_09B3EC:         db $01, $84, $BA, $01
DATA_09B3F0:         db $01, $84, $BA, $01
DATA_09B3F4:         db $01, $84, $BA, $01
DATA_09B3F8:         db $01, $84, $BA, $01
DATA_09B3FC:         db $01, $84, $BA, $01
DATA_09B400:         db $01, $84, $BA, $01
DATA_09B404:         db $01, $84, $BA, $01
DATA_09B408:         db $01, $84, $BA, $01
DATA_09B40C:         db $01, $84, $BA, $01
DATA_09B410:         db $01, $84, $BA, $01
DATA_09B414:         db $01, $84, $BA, $01
DATA_09B418:         db $01, $84, $BA, $01
DATA_09B41C:         db $01, $84, $BA, $01
DATA_09B420:         db $01, $84, $BA, $01
DATA_09B424:         db $01, $84, $BA, $01
DATA_09B428:         db $01, $84, $BA, $01
DATA_09B42C:         db $01, $84, $BA, $01
DATA_09B430:         db $01, $84, $BA, $01
DATA_09B434:         db $01, $84, $BA, $01
DATA_09B438:         db $01, $84, $BA, $01
DATA_09B43C:         db $01, $84, $BA, $01
DATA_09B440:         db $01, $84, $BA, $01
DATA_09B444:         db $01, $84, $BA, $01
DATA_09B448:         db $01, $84, $BA, $01
DATA_09B44C:         db $01, $84, $BA, $01
DATA_09B450:         db $01, $84, $BA, $01
DATA_09B454:         db $01, $84, $BA, $01
DATA_09B458:         db $01, $84, $BA, $01
DATA_09B45C:         db $01, $84, $BA, $01
DATA_09B460:         db $01, $84, $BA, $01
DATA_09B464:         db $01, $84, $BA, $01
DATA_09B468:         db $01, $84, $BA, $01
DATA_09B46C:         db $01, $84, $BA, $01
DATA_09B470:         db $01, $84, $BA, $01
DATA_09B474:         db $01, $84, $BA, $01
DATA_09B478:         db $01, $84, $BA, $01
DATA_09B47C:         db $01, $84, $BA, $01
DATA_09B480:         db $01, $84, $BA, $01
DATA_09B484:         db $01, $84, $BA, $01
DATA_09B488:         db $01, $84, $BA, $01
DATA_09B48C:         db $01, $84, $BA, $01
DATA_09B490:         db $01, $84, $BA, $01
DATA_09B494:         db $01, $84, $BA, $01
DATA_09B498:         db $01, $84, $BA, $01
DATA_09B49C:         db $01, $84, $BA, $01
DATA_09B4A0:         db $01, $84, $BA, $01
DATA_09B4A4:         db $01, $84, $BA, $01
DATA_09B4A8:         db $01, $84, $BA, $01
DATA_09B4AC:         db $01, $84, $BA, $01
DATA_09B4B0:         db $01, $84, $BA, $01
DATA_09B4B4:         db $01, $84, $BA, $01
DATA_09B4B8:         db $01, $84, $BA, $01
DATA_09B4BC:         db $01, $84, $BA, $01
DATA_09B4C0:         db $01, $84, $BA, $01
DATA_09B4C4:         db $01, $84, $BA, $01
DATA_09B4C8:         db $01, $84, $BA, $01
DATA_09B4CC:         db $01, $84, $BA, $01
DATA_09B4D0:         db $01, $84, $BA, $01
DATA_09B4D4:         db $01, $84, $BA, $01
DATA_09B4D8:         db $01, $84, $BA, $01
DATA_09B4DC:         db $01, $84, $BA, $01
DATA_09B4E0:         db $01, $00, $01

0009:B4E3 3D F0 82 40  lm    r0,(4082)
0009:B4E7 50           add   r0
0009:B4E8 50           add   r0
0009:B4E9 3D F1 80 40  lm    r1,(4080)
0009:B4ED C1           or    r1
0009:B4EE 50           add   r0
0009:B4EF 50           add   r0
0009:B4F0 D0           inc   r0
0009:B4F1 1F 5F        add   r15
0009:B4F3 FF 34 B5     iwt   r15,#B534
0009:B4F6 01           nop

DATA_09B4F7:         db $01, $C4, $B5, $01, $01, $C4, $B5, $01
DATA_09B4FF:         db $01, $C4, $B5, $01, $01, $C4, $B5, $01
DATA_09B507:         db $01, $C4, $B5, $01, $01, $C4, $B5, $01
DATA_09B50F:         db $01, $C4, $B5, $01, $01, $C4, $B5, $01
DATA_09B517:         db $01, $C4, $B5, $01, $01, $C4, $B5, $01
DATA_09B51F:         db $01, $C4, $B5, $01, $01, $C4, $B5, $01
DATA_09B527:         db $01, $C4, $B5, $01, $01, $C4, $B5, $01
DATA_09B52F:         db $01, $C4, $B5, $01, $01

0009:B534 02           cache
0009:B535 3D F0 72 40  lm    r0,(4072)
0009:B539 9E           lob
0009:B53A 3F 8C        umult #0C
0009:B53C F1 2F BD     iwt   r1,#BD2F
0009:B53F 1E 51        add   r1
0009:B541 3D F0 86 40  lm    r0,(4086)
0009:B545 12 3E 53     add   #03
0009:B548 3D F3 84 40  lm    r3,(4084)
0009:B54C AC 0C        ibt   r12,#000C
0009:B54E 2F 1D        move  r13,r15
0009:B550 23 11        move  r1,r3
0009:B552 EF           getb
0009:B553 DE           inc   r14
0009:B554 4D           swap
0009:B555 50           add   r0
0009:B556 0C 03        bcc   B55B
0009:B558 D1           inc   r1
0009:B559 E1           dec   r1
0009:B55A 4C           plot
0009:B55B 50           add   r0
0009:B55C 0C 03        bcc   B561
0009:B55E D1           inc   r1
0009:B55F E1           dec   r1
0009:B560 4C           plot
0009:B561 50           add   r0
0009:B562 0C 03        bcc   B567
0009:B564 D1           inc   r1
0009:B565 E1           dec   r1
0009:B566 4C           plot
0009:B567 50           add   r0
0009:B568 0C 03        bcc   B56D
0009:B56A D1           inc   r1
0009:B56B E1           dec   r1
0009:B56C 4C           plot
0009:B56D 50           add   r0
0009:B56E 0C 03        bcc   B573
0009:B570 D1           inc   r1
0009:B571 E1           dec   r1
0009:B572 4C           plot
0009:B573 50           add   r0
0009:B574 0C 03        bcc   B579
0009:B576 D1           inc   r1
0009:B577 E1           dec   r1
0009:B578 4C           plot
0009:B579 50           add   r0
0009:B57A 0C 03        bcc   B57F
0009:B57C D1           inc   r1
0009:B57D E1           dec   r1
0009:B57E 4C           plot
0009:B57F 50           add   r0
0009:B580 0C 03        bcc   B585
0009:B582 D1           inc   r1
0009:B583 E1           dec   r1
0009:B584 4C           plot
0009:B585 3C           loop
0009:B586 D2           inc   r2
0009:B587 3D 4C        rpix
0009:B589 3D F0 7C 40  lm    r0,(407C)
0009:B58D D0           inc   r0
0009:B58E 90           sbk
0009:B58F 3D F0 72 40  lm    r0,(4072)
0009:B593 9E           lob
0009:B594 F1 2F BC     iwt   r1,#BC2F
0009:B597 1E 51        add   r1
0009:B599 EF           getb
0009:B59A 11 53        add   r3
0009:B59C F0 82 00     iwt   r0,#0082
0009:B59F B1 60        sub   r0
0009:B5A1 0C 19        bcc   B5BC
0009:B5A3 01           nop
0009:B5A4 A1 00        ibt   r1,#0000
0009:B5A6 3D F0 86 40  lm    r0,(4086)
0009:B5AA D0           inc   r0
0009:B5AB 12 3E 5F     add   #0F
0009:B5AE F0 40 00     iwt   r0,#0040
0009:B5B1 B2 60        sub   r0
0009:B5B3 0C 03        bcc   B5B8
0009:B5B5 01           nop
0009:B5B6 A2 10        ibt   r2,#0010
0009:B5B8 3E F2 86 40  sm    (4086),r2
0009:B5BC 3E F1 84 40  sm    (4084),r1
0009:B5C0 FF 9F B0     iwt   r15,#B09F
0009:B5C3 01           nop
0009:B5C4 02           cache
0009:B5C5 3D F5 80 40  lm    r5,(4080)
0009:B5C9 D5           inc   r5
0009:B5CA 3D F6 82 40  lm    r6,(4082)
0009:B5CE D6           inc   r6
0009:B5CF 3D F4 86 40  lm    r4,(4086)
0009:B5D3 B6 3F 83     umult #03
0009:B5D6 14 54        add   r4
0009:B5D8 3D F9 84 40  lm    r9,(4084)
0009:B5DC 3D F0 72 40  lm    r0,(4072)
0009:B5E0 9E           lob
0009:B5E1 3F 8C        umult #0C
0009:B5E3 F1 2F BD     iwt   r1,#BD2F
0009:B5E6 1E 51        add   r1
0009:B5E8 FD F5 B5     iwt   r13,#B5F5
0009:B5EB AB 0C        ibt   r11,#000C
0009:B5ED EF           getb
0009:B5EE DE           inc   r14
0009:B5EF 1A 4D        swap
0009:B5F1 AC 08        ibt   r12,#0008
0009:B5F3 A3 00        ibt   r3,#0000
0009:B5F5 2A 5A        add   r10
0009:B5F7 0C 14        bcc   B60D
0009:B5F9 01           nop
0009:B5FA B9 17 53     add   r3
0009:B5FD 24 12        move  r2,r4
0009:B5FF 26 18        move  r8,r6
0009:B601 27 11        move  r1,r7
0009:B603 25 10        move  r0,r5
0009:B605 E0           dec   r0
0009:B606 08 FD        bne   B605
0009:B608 4C           plot
0009:B609 E8           dec   r8
0009:B60A 08 F5        bne   B601
0009:B60C D2           inc   r2
0009:B60D 23 55        add   r5
0009:B60F 3C           loop
0009:B610 01           nop
0009:B611 24 56        add   r6
0009:B613 EB           dec   r11
0009:B614 08 D7        bne   B5ED
0009:B616 01           nop
0009:B617 3D 4C        rpix
0009:B619 3D F0 7C 40  lm    r0,(407C)
0009:B61D D0           inc   r0
0009:B61E 90           sbk
0009:B61F 3D F0 72 40  lm    r0,(4072)
0009:B623 9E           lob
0009:B624 F1 2F BC     iwt   r1,#BC2F
0009:B627 1E 51        add   r1
0009:B629 EF           getb
0009:B62A 3D 85        umult r5
0009:B62C 11 59        add   r9
0009:B62E F0 82 00     iwt   r0,#0082
0009:B631 B1 60        sub   r0
0009:B633 0C 1A        bcc   B64F
0009:B635 01           nop
0009:B636 A1 00        ibt   r1,#0000
0009:B638 3D F0 86 40  lm    r0,(4086)
0009:B63C A2 10        ibt   r2,#0010
0009:B63E 22 3D 86     umult r6
0009:B641 F0 40 00     iwt   r0,#0040
0009:B644 B2 60        sub   r0
0009:B646 0C 03        bcc   B64B
0009:B648 01           nop
0009:B649 A2 10        ibt   r2,#0010
0009:B64B 3E F2 86 40  sm    (4086),r2
0009:B64F 3E F1 84 40  sm    (4084),r1
0009:B653 FF 9F B0     iwt   r15,#B09F
0009:B656 01           nop
0009:B657 F1 00 4E     iwt   r1,#4E00
0009:B65A FC 00 05     iwt   r12,#0500
0009:B65D 05 25        bra   B684

0009:B65F 01           nop

0009:B660 F1 00 4E     iwt   r1,#4E00
0009:B663 FC 00 01     iwt   r12,#0100
0009:B666 05 1C        bra   B684

0009:B668 01           nop

0009:B669 F1 00 50     iwt   r1,#5000
0009:B66C FC 00 01     iwt   r12,#0100
0009:B66F 05 13        bra   B684

0009:B671 01           nop

0009:B672 F1 00 52     iwt   r1,#5200
0009:B675 FC 00 01     iwt   r12,#0100
0009:B678 05 0A        bra   B684

0009:B67A 01           nop

0009:B67B F1 00 54     iwt   r1,#5400
0009:B67E FC 00 01     iwt   r12,#0100
0009:B681 05 01        bra   B684

0009:B683 01           nop

0009:B684 F0 FF 00     iwt   r0,#00FF
0009:B687 2F 1D        move  r13,r15
0009:B689 31           stw   (r1)
0009:B68A D1           inc   r1
0009:B68B 3C           loop
0009:B68C D1           inc   r1
0009:B68D FF 8E BA     iwt   r15,#BA8E
0009:B690 01           nop
0009:B691 A0 00        ibt   r0,#0000
0009:B693 3E F0 84 40  sm    (4084),r0
0009:B697 A0 10        ibt   r0,#0010
0009:B699 3E F0 86 40  sm    (4086),r0
0009:B69D FF 8E BA     iwt   r15,#BA8E
0009:B6A0 01           nop
0009:B6A1 A0 00        ibt   r0,#0000
0009:B6A3 3E F0 84 40  sm    (4084),r0
0009:B6A7 A0 20        ibt   r0,#0020
0009:B6A9 3E F0 86 40  sm    (4086),r0
0009:B6AD FF 8E BA     iwt   r15,#BA8E
0009:B6B0 01           nop
0009:B6B1 A0 00        ibt   r0,#0000
0009:B6B3 3E F0 84 40  sm    (4084),r0
0009:B6B7 A0 30        ibt   r0,#0030
0009:B6B9 3E F0 86 40  sm    (4086),r0
0009:B6BD FF 8E BA     iwt   r15,#BA8E
0009:B6C0 01           nop
0009:B6C1 A0 00        ibt   r0,#0000
0009:B6C3 3E F0 84 40  sm    (4084),r0
0009:B6C7 A0 40        ibt   r0,#0040
0009:B6C9 3E F0 86 40  sm    (4086),r0
0009:B6CD FF 8E BA     iwt   r15,#BA8E
0009:B6D0 01           nop
0009:B6D1 3D F0 86 40  lm    r0,(4086)
0009:B6D5 A1 40        ibt   r1,#0040
0009:B6D7 D0           inc   r0
0009:B6D8 3E 5F        add   #0F
0009:B6DA 3F 61        cmp   r1
0009:B6DC 0C 03        bcc   B6E1
0009:B6DE 01           nop
0009:B6DF A0 10        ibt   r0,#0010
0009:B6E1 90           sbk
0009:B6E2 FF 8E BA     iwt   r15,#BA8E
0009:B6E5 01           nop
0009:B6E6 F0 C0 04     iwt   r0,#04C0
0009:B6E9 3D F1 76 40  lm    r1,(4076)
0009:B6ED 71           and   r1
0009:B6EE 09 06        beq   B6F6
0009:B6F0 01           nop
0009:B6F1 A0 5C        ibt   r0,#005C
0009:B6F3 3E A0 3D     sms   (007A),r0
0009:B6F6 F0 C0 04     iwt   r0,#04C0
0009:B6F9 3D F1 76 40  lm    r1,(4076)
0009:B6FD 71           and   r1
0009:B6FE 09 08        beq   B708
0009:B700 01           nop
0009:B701 3D F0 7C 40  lm    r0,(407C)
0009:B705 D0           inc   r0
0009:B706 D0           inc   r0
0009:B707 90           sbk
0009:B708 FF E1 B4     iwt   r15,#B4E1
0009:B70B 01           nop
0009:B70C F1 00 56     iwt   r1,#5600
0009:B70F FC 00 01     iwt   r12,#0100
0009:B712 F0 FF 00     iwt   r0,#00FF
0009:B715 2F 1D        move  r13,r15
0009:B717 31           stw   (r1)
0009:B718 D1           inc   r1
0009:B719 3C           loop
0009:B71A D1           inc   r1
0009:B71B A0 00        ibt   r0,#0000
0009:B71D 3E F0 84 40  sm    (4084),r0
0009:B721 A0 50        ibt   r0,#0050
0009:B723 3E F0 86 40  sm    (4086),r0
0009:B727 FF 8E BA     iwt   r15,#BA8E
0009:B72A 01           nop
0009:B72B FC 00 01     iwt   r12,#0100
0009:B72E F1 00 4E     iwt   r1,#4E00
0009:B731 F2 00 50     iwt   r2,#5000
0009:B734 F3 00 52     iwt   r3,#5200
0009:B737 F4 00 54     iwt   r4,#5400
0009:B73A F5 FF 00     iwt   r5,#00FF
0009:B73D 2F 1D        move  r13,r15
0009:B73F 42           ldw   (r2)
0009:B740 31           stw   (r1)
0009:B741 D1           inc   r1
0009:B742 D1           inc   r1
0009:B743 43           ldw   (r3)
0009:B744 32           stw   (r2)
0009:B745 D2           inc   r2
0009:B746 D2           inc   r2
0009:B747 44           ldw   (r4)
0009:B748 33           stw   (r3)
0009:B749 D3           inc   r3
0009:B74A D3           inc   r3
0009:B74B B5 34        stw   (r4)
0009:B74D D4           inc   r4
0009:B74E 3C           loop
0009:B74F D4           inc   r4
0009:B750 FF 8E BA     iwt   r15,#BA8E
0009:B753 01           nop
0009:B754 F0 01 00     iwt   r0,#0001
0009:B757 FF 6D B7     iwt   r15,#B76D
0009:B75A 01           nop
0009:B75B A0 02        ibt   r0,#0002
0009:B75D FF 6D B7     iwt   r15,#B76D
0009:B760 01           nop
0009:B761 A0 03        ibt   r0,#0003
0009:B763 FF 6D B7     iwt   r15,#B76D
0009:B766 01           nop
0009:B767 A0 04        ibt   r0,#0004
0009:B769 FF 6D B7     iwt   r15,#B76D
0009:B76C 01           nop
0009:B76D 3D 50        adc   r0
0009:B76F F1 00 4E     iwt   r1,#4E00
0009:B772 21 12        move  r2,r1
0009:B774 12 3D 52     adc   r2
0009:B777 A5 10        ibt   r5,#0010
0009:B779 F6 00 58     iwt   r6,#5800
0009:B77C FD 85 B7     iwt   r13,#B785
0009:B77F 25 1C        move  r12,r5
0009:B781 22 14        move  r4,r2
0009:B783 21 13        move  r3,r1
0009:B785 44           ldw   (r4)
0009:B786 33           stw   (r3)
0009:B787 24 3D 55     adc   r5
0009:B78A 23 3D 55     adc   r5
0009:B78D 3C           loop
0009:B78E 01           nop
0009:B78F D2           inc   r2
0009:B790 D2           inc   r2
0009:B791 B5 72        and   r2
0009:B793 09 0B        beq   B7A0
0009:B795 01           nop
0009:B796 F0 00 FF     iwt   r0,#FF00
0009:B799 72           and   r2
0009:B79A F2 00 01     iwt   r2,#0100
0009:B79D 12 3D 52     adc   r2
0009:B7A0 D1           inc   r1
0009:B7A1 D1           inc   r1
0009:B7A2 B5 71        and   r1
0009:B7A4 09 0B        beq   B7B1
0009:B7A6 01           nop
0009:B7A7 F0 00 FF     iwt   r0,#FF00
0009:B7AA 71           and   r1
0009:B7AB F1 00 01     iwt   r1,#0100
0009:B7AE 11 3D 51     adc   r1
0009:B7B1 B1 3F 66     cmp   r6
0009:B7B4 0C C9        bcc   B77F
0009:B7B6 01           nop
0009:B7B7 3D F0 7C 40  lm    r0,(407C)
0009:B7BB D0           inc   r0
0009:B7BC D0           inc   r0
0009:B7BD 90           sbk
0009:B7BE FF E1 B4     iwt   r15,#B4E1
0009:B7C1 01           nop
0009:B7C2 A0 00        ibt   r0,#0000
0009:B7C4 3E F0 80 40  sm    (4080),r0
0009:B7C8 3E F0 82 40  sm    (4082),r0
0009:B7CC FF 8E BA     iwt   r15,#BA8E
0009:B7CF 01           nop
0009:B7D0 A0 01        ibt   r0,#0001
0009:B7D2 3E F0 80 40  sm    (4080),r0
0009:B7D6 3E F0 82 40  sm    (4082),r0
0009:B7DA FF 8E BA     iwt   r15,#BA8E
0009:B7DD 01           nop
0009:B7DE A0 02        ibt   r0,#0002
0009:B7E0 3E F0 80 40  sm    (4080),r0
0009:B7E4 3E F0 82 40  sm    (4082),r0
0009:B7E8 FF 8E BA     iwt   r15,#BA8E
0009:B7EB 01           nop
0009:B7EC A0 03        ibt   r0,#0003
0009:B7EE 3E F0 80 40  sm    (4080),r0
0009:B7F2 3E F0 82 40  sm    (4082),r0
0009:B7F6 FF 8E BA     iwt   r15,#BA8E
0009:B7F9 01           nop
0009:B7FA A0 00        ibt   r0,#0000
0009:B7FC 3E F0 82 40  sm    (4082),r0
0009:B800 FF 8E BA     iwt   r15,#BA8E
0009:B803 01           nop
0009:B804 A0 01        ibt   r0,#0001
0009:B806 3E F0 82 40  sm    (4082),r0
0009:B80A FF 8E BA     iwt   r15,#BA8E
0009:B80D 01           nop
0009:B80E A0 02        ibt   r0,#0002
0009:B810 3E F0 82 40  sm    (4082),r0
0009:B814 FF 8E BA     iwt   r15,#BA8E
0009:B817 01           nop
0009:B818 A0 03        ibt   r0,#0003
0009:B81A 3E F0 82 40  sm    (4082),r0
0009:B81E FF 8E BA     iwt   r15,#BA8E
0009:B821 01           nop
0009:B822 A0 00        ibt   r0,#0000
0009:B824 3E F0 80 40  sm    (4080),r0
0009:B828 FF 8E BA     iwt   r15,#BA8E
0009:B82B 01           nop
0009:B82C A0 01        ibt   r0,#0001
0009:B82E 3E F0 80 40  sm    (4080),r0
0009:B832 FF 8E BA     iwt   r15,#BA8E
0009:B835 01           nop
0009:B836 A0 02        ibt   r0,#0002
0009:B838 3E F0 80 40  sm    (4080),r0
0009:B83C FF 8E BA     iwt   r15,#BA8E
0009:B83F 01           nop
0009:B840 A0 03        ibt   r0,#0003
0009:B842 3E F0 80 40  sm    (4080),r0
0009:B846 FF 8E BA     iwt   r15,#BA8E
0009:B849 01           nop
0009:B84A F6 A0 00     iwt   r6,#00A0
0009:B84D F5 D0 00     iwt   r5,#00D0
0009:B850 A1 64        ibt   r1,#0064
0009:B852 A2 0A        ibt   r2,#000A
0009:B854 A3 00        ibt   r3,#0000
0009:B856 A4 00        ibt   r4,#0000
0009:B858 3D F0 9A 40  lm    r0,(409A)
0009:B85C 61           sub   r1
0009:B85D 0A FD        bpl   B85C
0009:B85F D3           inc   r3
0009:B860 51           add   r1
0009:B861 E3           dec   r3
0009:B862 09 04        beq   B868
0009:B864 01           nop
0009:B865 B6 15 53     add   r3
0009:B868 62           sub   r2
0009:B869 0A FD        bpl   B868
0009:B86B D4           inc   r4
0009:B86C E4           dec   r4
0009:B86D 52           add   r2
0009:B86E 4D           swap
0009:B86F C4           or    r4
0009:B870 3E F0 9C 40  sm    (409C),r0
0009:B874 05 25        bra   B89B

0009:B876 01           nop

0009:B877 3D F0 9C 40  lm    r0,(409C)
0009:B87B F4 A0 00     iwt   r4,#00A0
0009:B87E F5 D0 00     iwt   r5,#00D0
0009:B881 3D F1 9A 40  lm    r1,(409A)
0009:B885 A2 0A        ibt   r2,#000A
0009:B887 B1 3F 62     cmp   r2
0009:B88A 0C 0F        bcc   B89B
0009:B88C 15 54        add   r4
0009:B88E 05 0B        bra   B89B

0009:B890 01           nop

0009:B891 3D F0 9C 40  lm    r0,(409C)
0009:B895 C0           hib
0009:B896 F4 A0 00     iwt   r4,#00A0
0009:B899 15 54        add   r4
0009:B89B 3E F5 72 40  sm    (4072),r5
0009:B89F 3D F0 7C 40  lm    r0,(407C)
0009:B8A3 D0           inc   r0
0009:B8A4 3E F0 7C 40  sm    (407C),r0
0009:B8A8 FF E3 B4     iwt   r15,#B4E3
0009:B8AB 01           nop
0009:B8AC FF E1 B4     iwt   r15,#B4E1
0009:B8AF 01           nop

DATA_09B8B0:         dw $4007, $2002

DATA_09B8B4:         dw $4034, $3002

DATA_09B8B8:         dw $0802, $0401

0009:B8BC 3D F1 76 40  lm    r1,(4076)
0009:B8C0 21 4D        swap
0009:B8C2 F0 C0 C0     iwt   r0,#C0C0
0009:B8C5 71           and   r1
0009:B8C6 09 22        beq   B8EA
0009:B8C8 01           nop
0009:B8C9 A1 43        ibt   r1,#0043
0009:B8CB 3D F0 94 40  lm    r0,(4094)
0009:B8CF 3E 71        and   #01
0009:B8D1 09 09        beq   B8DC
0009:B8D3 01           nop
0009:B8D4 A1 2E        ibt   r1,#002E
0009:B8D6 A0 02        ibt   r0,#0002
0009:B8D8 3E F0 6E 40  sm    (406E),r0
0009:B8DC 3E A1 3D     sms   (007A),r1
0009:B8DF 3D F0 7C 40  lm    r0,(407C)
0009:B8E3 D0           inc   r0
0009:B8E4 D0           inc   r0
0009:B8E5 90           sbk
0009:B8E6 FF E1 B4     iwt   r15,#B4E1
0009:B8E9 01           nop
0009:B8EA 3D F0 72 40  lm    r0,(4072)
0009:B8EE 4D           swap
0009:B8EF 3E 71        and   #01
0009:B8F1 FE B8 B8     iwt   r14,#B8B8
0009:B8F4 1E 5E        add   r14
0009:B8F6 EF           getb
0009:B8F7 71           and   r1
0009:B8F8 09 60        beq   B95A
0009:B8FA 01           nop
0009:B8FB A0 5C        ibt   r0,#005C
0009:B8FD 3E A0 3D     sms   (007A),r0
0009:B900 A0 00        ibt   r0,#0000
0009:B902 3E F0 94 40  sm    (4094),r0
0009:B906 F0 D4 00     iwt   r0,#00D4
0009:B909 3E F0 90 40  sm    (4090),r0
0009:B90D 3D F0 72 40  lm    r0,(4072)
0009:B911 4D           swap
0009:B912 3E 71        and   #01
0009:B914 50           add   r0
0009:B915 FE B0 B8     iwt   r14,#B8B0
0009:B918 1E 5E        add   r14
0009:B91A EF           getb
0009:B91B 3E F0 8C 40  sm    (408C),r0
0009:B91F DE           inc   r14
0009:B920 EF           getb
0009:B921 3E F0 8E 40  sm    (408E),r0
0009:B925 F0 30 B9     iwt   r0,#B930
0009:B928 3E F0 92 40  sm    (4092),r0
0009:B92C FF 9B BA     iwt   r15,#BA9B
0009:B92F 01           nop

0009:B930 F0 D0 00     iwt   r0,#00D0
0009:B933 3E F0 90 40  sm    (4090),r0
0009:B937 3D F0 72 40  lm    r0,(4072)
0009:B93B 4D           swap
0009:B93C 3E 71        and   #01
0009:B93E 50           add   r0
0009:B93F FE B4 B8     iwt   r14,#B8B4
0009:B942 1E 5E        add   r14
0009:B944 EF           getb
0009:B945 3E F0 8C 40  sm    (408C),r0
0009:B949 DE           inc   r14
0009:B94A EF           getb
0009:B94B 3E F0 8E 40  sm    (408E),r0
0009:B94F F0 E1 B4     iwt   r0,#B4E1
0009:B952 3E F0 92 40  sm    (4092),r0
0009:B956 FF 9B BA     iwt   r15,#BA9B
0009:B959 01           nop
0009:B95A 3D F0 72 40  lm    r0,(4072)
0009:B95E 4D           swap
0009:B95F 3E 71        and   #01
0009:B961 FE BA B8     iwt   r14,#B8BA
0009:B964 1E 5E        add   r14
0009:B966 EF           getb
0009:B967 71           and   r1
0009:B968 09 60        beq   B9CA
0009:B96A 01           nop
0009:B96B A0 5C        ibt   r0,#005C
0009:B96D 3E A0 3D     sms   (007A),r0
0009:B970 A0 01        ibt   r0,#0001
0009:B972 3E F0 94 40  sm    (4094),r0
0009:B976 F0 D4 00     iwt   r0,#00D4
0009:B979 3E F0 90 40  sm    (4090),r0
0009:B97D 3D F0 72 40  lm    r0,(4072)
0009:B981 4D           swap
0009:B982 3E 71        and   #01
0009:B984 50           add   r0
0009:B985 FE B4 B8     iwt   r14,#B8B4
0009:B988 1E 5E        add   r14
0009:B98A EF           getb
0009:B98B 3E F0 8C 40  sm    (408C),r0
0009:B98F DE           inc   r14
0009:B990 EF           getb
0009:B991 3E F0 8E 40  sm    (408E),r0
0009:B995 F0 A0 B9     iwt   r0,#B9A0
0009:B998 3E F0 92 40  sm    (4092),r0
0009:B99C FF 9B BA     iwt   r15,#BA9B
0009:B99F 01           nop
0009:B9A0 F0 D0 00     iwt   r0,#00D0
0009:B9A3 3E F0 90 40  sm    (4090),r0
0009:B9A7 3D F0 72 40  lm    r0,(4072)
0009:B9AB 4D           swap
0009:B9AC 3E 71        and   #01
0009:B9AE 50           add   r0
0009:B9AF FE B0 B8     iwt   r14,#B8B0
0009:B9B2 1E 5E        add   r14
0009:B9B4 EF           getb
0009:B9B5 3E F0 8C 40  sm    (408C),r0
0009:B9B9 DE           inc   r14
0009:B9BA EF           getb
0009:B9BB 3E F0 8E 40  sm    (408E),r0
0009:B9BF F0 E1 B4     iwt   r0,#B4E1
0009:B9C2 3E F0 92 40  sm    (4092),r0
0009:B9C6 FF 9B BA     iwt   r15,#BA9B
0009:B9C9 01           nop
0009:B9CA FF E1 B4     iwt   r15,#B4E1
0009:B9CD 01           nop
0009:B9CE 3D F0 76 40  lm    r0,(4076)
0009:B9D2 F1 C0 C0     iwt   r1,#C0C0
0009:B9D5 71           and   r1
0009:B9D6 09 14        beq   B9EC
0009:B9D8 01           nop
0009:B9D9 3D F0 94 40  lm    r0,(4094)
0009:B9DD 3E 71        and   #01
0009:B9DF 09 0B        beq   B9EC
0009:B9E1 01           nop
0009:B9E2 3D F0 82 00  lm    r0,(0082)
0009:B9E6 3F C2        xor   #02
0009:B9E8 3E F0 82 00  sm    (0082),r0
0009:B9EC FF BC B8     iwt   r15,#B8BC
0009:B9EF 01           nop
0009:B9F0 FF E1 B4     iwt   r15,#B4E1
0009:B9F3 01           nop
0009:B9F4 02           cache
0009:B9F5 3D F0 98 40  lm    r0,(4098)
0009:B9F9 3F DF        romb
0009:B9FB 3D F0 7C 40  lm    r0,(407C)
0009:B9FF 1E 3E 52     add   #02
0009:BA02 EF           getb
0009:BA03 DE           inc   r14
0009:BA04 03           lsr
0009:BA05 03           lsr
0009:BA06 03           lsr
0009:BA07 20 1B        move  r11,r0
0009:BA09 20 1A        move  r10,r0
0009:BA0B EF           getb
0009:BA0C DE           inc   r14
0009:BA0D 3D EF        getbh
0009:BA0F DE           inc   r14
0009:BA10 50           add   r0
0009:BA11 50           add   r0
0009:BA12 50           add   r0
0009:BA13 19 50        add   r0
0009:BA15 EF           getb
0009:BA16 DE           inc   r14
0009:BA17 3E 57        add   #07
0009:BA19 03           lsr
0009:BA1A 03           lsr
0009:BA1B 18 03        lsr
0009:BA1D 17 EF        getb
0009:BA1F DE           inc   r14
0009:BA20 13 EF        getb
0009:BA22 DE           inc   r14
0009:BA23 EF           getb
0009:BA24 12 3E 5F     add   #0F
0009:BA27 D1           inc   r1
0009:BA28 A0 09        ibt   r0,#0009
0009:BA2A 3F DF        romb
0009:BA2C 23 11        move  r1,r3
0009:BA2E 2A 1B        move  r11,r10
0009:BA30 28 1C        move  r12,r8
0009:BA32 2F 1D        move  r13,r15
0009:BA34 F0 2F C9     iwt   r0,#C92F
0009:BA37 59           add   r9
0009:BA38 1E 5B        add   r11
0009:BA3A 3D EF        getbh
0009:BA3C 50           add   r0
0009:BA3D 0C 03        bcc   BA42
0009:BA3F D1           inc   r1
0009:BA40 E1           dec   r1
0009:BA41 4C           plot
0009:BA42 50           add   r0
0009:BA43 0C 03        bcc   BA48
0009:BA45 D1           inc   r1
0009:BA46 E1           dec   r1
0009:BA47 4C           plot
0009:BA48 50           add   r0
0009:BA49 0C 03        bcc   BA4E
0009:BA4B D1           inc   r1
0009:BA4C E1           dec   r1
0009:BA4D 4C           plot
0009:BA4E 50           add   r0
0009:BA4F 0C 03        bcc   BA54
0009:BA51 D1           inc   r1
0009:BA52 E1           dec   r1
0009:BA53 4C           plot
0009:BA54 50           add   r0
0009:BA55 0C 03        bcc   BA5A
0009:BA57 D1           inc   r1
0009:BA58 E1           dec   r1
0009:BA59 4C           plot
0009:BA5A 50           add   r0
0009:BA5B 0C 03        bcc   BA60
0009:BA5D D1           inc   r1
0009:BA5E E1           dec   r1
0009:BA5F 4C           plot
0009:BA60 50           add   r0
0009:BA61 0C 03        bcc   BA66
0009:BA63 D1           inc   r1
0009:BA64 E1           dec   r1
0009:BA65 4C           plot
0009:BA66 50           add   r0
0009:BA67 0C 03        bcc   BA6C
0009:BA69 D1           inc   r1
0009:BA6A E1           dec   r1
0009:BA6B 4C           plot
0009:BA6C 3C           loop
0009:BA6D DB           inc   r11
0009:BA6E 29 3E 5F     add   #0F
0009:BA71 D9           inc   r9
0009:BA72 E7           dec   r7
0009:BA73 08 B7        bne   BA2C
0009:BA75 D2           inc   r2
0009:BA76 3D F0 7C 40  lm    r0,(407C)
0009:BA7A 3E 59        add   #09
0009:BA7C 3E F0 7C 40  sm    (407C),r0
0009:BA80 FF E1 B4     iwt   r15,#B4E1
0009:BA83 01           nop
0009:BA84 A0 02        ibt   r0,#0002
0009:BA86 3E F0 6E 40  sm    (406E),r0
0009:BA8A FF 99 BA     iwt   r15,#BA99
0009:BA8D 01           nop
0009:BA8E 3D F0 7C 40  lm    r0,(407C)
0009:BA92 D0           inc   r0
0009:BA93 D0           inc   r0
0009:BA94 90           sbk
0009:BA95 FF 9F B0     iwt   r15,#B09F
0009:BA98 01           nop
0009:BA99 00           stop
0009:BA9A 01           nop

0009:BA9B A0 01        ibt   r0,#0001
0009:BA9D 4E           color
0009:BA9E 3D F8 8C 40  lm    r8,(408C)
0009:BAA2 3D F2 8E 40  lm    r2,(408E)
0009:BAA6 A0 0A        ibt   r0,#000A
0009:BAA8 3D F1 80 40  lm    r1,(4080)
0009:BAAC D1           inc   r1
0009:BAAD 16 81        mult  r1
0009:BAAF A0 10        ibt   r0,#0010
0009:BAB1 3D F1 82 40  lm    r1,(4082)
0009:BAB5 D1           inc   r1
0009:BAB6 17 81        mult  r1
0009:BAB8 28 11        move  r1,r8
0009:BABA 26 1C        move  r12,r6
0009:BABC 2F 1D        move  r13,r15
0009:BABE 3C           loop
0009:BABF 4C           plot
0009:BAC0 E7           dec   r7
0009:BAC1 08 F5        bne   BAB8
0009:BAC3 D2           inc   r2
0009:BAC4 A0 03        ibt   r0,#0003
0009:BAC6 4E           color
0009:BAC7 3D F0 82 40  lm    r0,(4082)
0009:BACB 50           add   r0
0009:BACC 50           add   r0
0009:BACD 3D F1 80 40  lm    r1,(4080)
0009:BAD1 C1           or    r1
0009:BAD2 50           add   r0
0009:BAD3 50           add   r0
0009:BAD4 D0           inc   r0
0009:BAD5 1F 5F        add   r15
0009:BAD7 FF 18 BB     iwt   r15,#BB18
0009:BADA 01           nop

DATA_09BADB:         db $01, $A2, $BB, $01
DATA_09BADF:         db $01, $A2, $BB, $01
DATA_09BAE3:         db $01, $A2, $BB, $01
DATA_09BAE7:         db $01, $A2, $BB, $01
DATA_09BAEB:         db $01, $A2, $BB, $01
DATA_09BAEF:         db $01, $A2, $BB, $01
DATA_09BAF3:         db $01, $A2, $BB, $01
DATA_09BAF7:         db $01, $A2, $BB, $01
DATA_09BAFB:         db $01, $A2, $BB, $01
DATA_09BAFF:         db $01, $A2, $BB, $01
DATA_09BB03:         db $01, $A2, $BB, $01
DATA_09BB07:         db $01, $A2, $BB, $01
DATA_09BB0B:         db $01, $A2, $BB, $01
DATA_09BB0F:         db $01, $A2, $BB, $01
DATA_09BB13:         db $01, $A2, $BB, $01
DATA_09BB17:         db $01

0009:BB18 3D F0 90 40  lm    r0,(4090)
0009:BB1C 9E           lob
0009:BB1D 3F 8C        umult #0C
0009:BB1F F1 2F BD     iwt   r1,#BD2F
0009:BB22 1E 51        add   r1
0009:BB24 3D F0 8E 40  lm    r0,(408E)
0009:BB28 12 3E 53     add   #03
0009:BB2B 3D F3 8C 40  lm    r3,(408C)
0009:BB2F AC 0C        ibt   r12,#000C
0009:BB31 2F 1D        move  r13,r15
0009:BB33 23 11        move  r1,r3
0009:BB35 EF           getb
0009:BB36 DE           inc   r14
0009:BB37 4D           swap
0009:BB38 50           add   r0
0009:BB39 0C 03        bcc   BB3E
0009:BB3B D1           inc   r1
0009:BB3C E1           dec   r1
0009:BB3D 4C           plot
0009:BB3E 50           add   r0
0009:BB3F 0C 03        bcc   BB44
0009:BB41 D1           inc   r1
0009:BB42 E1           dec   r1
0009:BB43 4C           plot
0009:BB44 50           add   r0
0009:BB45 0C 03        bcc   BB4A
0009:BB47 D1           inc   r1
0009:BB48 E1           dec   r1
0009:BB49 4C           plot
0009:BB4A 50           add   r0
0009:BB4B 0C 03        bcc   BB50
0009:BB4D D1           inc   r1
0009:BB4E E1           dec   r1
0009:BB4F 4C           plot
0009:BB50 50           add   r0
0009:BB51 0C 03        bcc   BB56
0009:BB53 D1           inc   r1
0009:BB54 E1           dec   r1
0009:BB55 4C           plot
0009:BB56 50           add   r0
0009:BB57 0C 03        bcc   BB5C
0009:BB59 D1           inc   r1
0009:BB5A E1           dec   r1
0009:BB5B 4C           plot
0009:BB5C 50           add   r0
0009:BB5D 0C 03        bcc   BB62
0009:BB5F D1           inc   r1
0009:BB60 E1           dec   r1
0009:BB61 4C           plot
0009:BB62 50           add   r0
0009:BB63 0C 03        bcc   BB68
0009:BB65 D1           inc   r1
0009:BB66 E1           dec   r1
0009:BB67 4C           plot
0009:BB68 3C           loop
0009:BB69 D2           inc   r2
0009:BB6A 3D 4C        rpix
0009:BB6C 3D F0 90 40  lm    r0,(4090)
0009:BB70 9E           lob
0009:BB71 F1 2F BC     iwt   r1,#BC2F
0009:BB74 1E 51        add   r1
0009:BB76 EF           getb
0009:BB77 11 53        add   r3
0009:BB79 F0 82 00     iwt   r0,#0082
0009:BB7C B1 60        sub   r0
0009:BB7E 0C 19        bcc   BB99
0009:BB80 01           nop
0009:BB81 A1 00        ibt   r1,#0000
0009:BB83 3D F0 86 40  lm    r0,(4086)
0009:BB87 D0           inc   r0
0009:BB88 12 3E 5F     add   #0F
0009:BB8B F0 40 00     iwt   r0,#0040
0009:BB8E B2 60        sub   r0
0009:BB90 0C 03        bcc   BB95
0009:BB92 01           nop
0009:BB93 A2 10        ibt   r2,#0010
0009:BB95 3E F2 86 40  sm    (4086),r2
0009:BB99 3E F1 84 40  sm    (4084),r1
0009:BB9D 3D FF 92 40  lm    r15,(4092)
0009:BBA1 01           nop
0009:BBA2 3D F5 80 40  lm    r5,(4080)
0009:BBA6 D5           inc   r5
0009:BBA7 3D F6 82 40  lm    r6,(4082)
0009:BBAB D6           inc   r6
0009:BBAC 3D F4 8E 40  lm    r4,(408E)
0009:BBB0 B6 3F 83     umult #03
0009:BBB3 14 54        add   r4
0009:BBB5 3D F9 8C 40  lm    r9,(408C)
0009:BBB9 3D F0 90 40  lm    r0,(4090)
0009:BBBD 9E           lob
0009:BBBE 3F 8C        umult #0C
0009:BBC0 F1 2F BD     iwt   r1,#BD2F
0009:BBC3 1E 51        add   r1
0009:BBC5 FD D2 BB     iwt   r13,#BBD2
0009:BBC8 AB 0C        ibt   r11,#000C
0009:BBCA EF           getb
0009:BBCB DE           inc   r14
0009:BBCC 1A 4D        swap
0009:BBCE AC 08        ibt   r12,#0008
0009:BBD0 A3 00        ibt   r3,#0000
0009:BBD2 2A 5A        add   r10
0009:BBD4 0C 14        bcc   BBEA
0009:BBD6 01           nop
0009:BBD7 B9 17 53     add   r3
0009:BBDA 24 12        move  r2,r4
0009:BBDC 26 18        move  r8,r6
0009:BBDE 27 11        move  r1,r7
0009:BBE0 25 10        move  r0,r5
0009:BBE2 E0           dec   r0
0009:BBE3 08 FD        bne   BBE2
0009:BBE5 4C           plot
0009:BBE6 E8           dec   r8
0009:BBE7 08 F5        bne   BBDE
0009:BBE9 D2           inc   r2
0009:BBEA 23 55        add   r5
0009:BBEC 3C           loop
0009:BBED 01           nop
0009:BBEE 24 56        add   r6
0009:BBF0 EB           dec   r11
0009:BBF1 08 D7        bne   BBCA
0009:BBF3 01           nop
0009:BBF4 3D 4C        rpix
0009:BBF6 3D F0 90 40  lm    r0,(4090)
0009:BBFA 9E           lob
0009:BBFB F1 2F BC     iwt   r1,#BC2F
0009:BBFE 1E 51        add   r1
0009:BC00 EF           getb
0009:BC01 3D 85        umult r5
0009:BC03 11 59        add   r9
0009:BC05 F0 82 00     iwt   r0,#0082
0009:BC08 B1 60        sub   r0
0009:BC0A 0C 1A        bcc   BC26
0009:BC0C 01           nop
0009:BC0D A1 00        ibt   r1,#0000
0009:BC0F 3D F0 86 40  lm    r0,(4086)
0009:BC13 A2 10        ibt   r2,#0010
0009:BC15 22 3D 86     umult r6
0009:BC18 F0 40 00     iwt   r0,#0040
0009:BC1B B2 60        sub   r0
0009:BC1D 0C 03        bcc   BC22
0009:BC1F 01           nop
0009:BC20 A2 10        ibt   r2,#0010
0009:BC22 3E F2 86 40  sm    (4086),r2
0009:BC26 3E F1 84 40  sm    (4084),r1
0009:BC2A 3D FF 92 40  lm    r15,(4092)
0009:BC2E 01           nop

; width of each character in the font (height is always $0C)
DATA_09BC2F:         db $08, $08, $08, $08, $08, $08, $05, $08
DATA_09BC37:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC3F:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC47:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC4F:         db $08, $08, $08, $08, $08, $08, $04, $04
DATA_09BC57:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC5F:         db $08, $08, $08, $08, $08, $08, $08, $04
DATA_09BC67:         db $06, $03, $07, $06, $07, $06, $07, $03
DATA_09BC6F:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC77:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC7F:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC87:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC8F:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC97:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BC9F:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCA7:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCAF:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCB7:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCBF:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCC7:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCCF:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCD7:         db $08, $08, $08, $08, $08, $08, $07, $07
DATA_09BCDF:         db $08, $08, $05, $08, $08, $07, $08, $08
DATA_09BCE7:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCEF:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCF7:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BCFF:         db $04, $08, $08, $08, $08, $08, $08, $08
DATA_09BD07:         db $08, $08, $08, $08, $07, $07, $08, $08
DATA_09BD0F:         db $04, $07, $08, $04, $08, $08, $08, $08
DATA_09BD17:         db $08, $07, $08, $08, $08, $08, $08, $08
DATA_09BD1F:         db $08, $08, $08, $08, $08, $08, $08, $08
DATA_09BD27:         db $08, $08, $08, $08, $08, $08, $08, $08

; font graphics (1bpp)
DATA_09BD2F:         db $18, $04, $00, $1C, $02, $3A, $44, $4E
DATA_09BD37:         db $3B, $00, $00, $00, $0C, $16, $00, $1C
DATA_09BD3F:         db $02, $3A, $44, $4E, $3B, $00, $00, $00
DATA_09BD47:         db $00, $00, $00, $3C, $62, $40, $40, $63
DATA_09BD4F:         db $3E, $08, $04, $38, $18, $04, $00, $1C
DATA_09BD57:         db $22, $7E, $40, $62, $3C, $00, $00, $00
DATA_09BD5F:         db $0C, $10, $00, $1C, $22, $7E, $40, $62
DATA_09BD67:         db $3C, $00, $00, $00, $0C, $16, $00, $1C
DATA_09BD6F:         db $22, $7E, $40, $62, $3C, $00, $00, $00
DATA_09BD77:         db $30, $58, $00, $20, $20, $20, $40, $40
DATA_09BD7F:         db $20, $00, $00, $00, $0C, $16, $00, $3C
DATA_09BD87:         db $62, $41, $41, $23, $1E, $00, $00, $00
DATA_09BD8F:         db $18, $04, $00, $40, $42, $42, $42, $67
DATA_09BD97:         db $3D, $00, $00, $00, $0C, $16, $00, $40
DATA_09BD9F:         db $42, $42, $42, $67, $3D, $00, $00, $00
DATA_09BDA7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDAF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDB7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDBF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDC7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDCF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDD7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDDF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDE7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BDEF:         db $14, $14, $00, $1C, $02, $3A, $44, $4E
DATA_09BDF7:         db $3B, $00, $00, $00, $14, $14, $00, $3C
DATA_09BDFF:         db $62, $41, $41, $23, $1E, $00, $00, $00
DATA_09BE07:         db $14, $14, $00, $40, $42, $42, $42, $67
DATA_09BE0F:         db $3D, $00, $00, $00, $1C, $22, $22, $3C
DATA_09BE17:         db $22, $21, $21, $29, $26, $40, $00, $00
DATA_09BE1F:         db $14, $00, $1C, $26, $22, $43, $7F, $41
DATA_09BE27:         db $41, $41, $01, $00, $14, $00, $1C, $26
DATA_09BE2F:         db $43, $41, $41, $41, $23, $1E, $00, $00
DATA_09BE37:         db $14, $00, $22, $21, $41, $41, $41, $43
DATA_09BE3F:         db $66, $3C, $00, $00, $00, $00, $00, $00
DATA_09BE47:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BE4F:         db $03, $0F, $1C, $19, $39, $39, $38, $39
DATA_09BE57:         db $19, $19, $0F, $03, $C0, $F0, $38, $98
DATA_09BE5F:         db $9C, $9C, $1C, $9C, $98, $98, $F0, $C0
DATA_09BE67:         db $03, $0F, $18, $19, $39, $38, $39, $39
DATA_09BE6F:         db $19, $18, $0F, $03, $C0, $F0, $38, $98
DATA_09BE77:         db $9C, $3C, $DC, $CC, $88, $18, $F0, $C0
DATA_09BE7F:         db $03, $0F, $19, $19, $39, $3C, $3E, $3E
DATA_09BE87:         db $1E, $1E, $0F, $03, $C0, $F0, $98, $98
DATA_09BE8F:         db $9C, $3C, $7C, $7C, $78, $78, $F0, $C0
DATA_09BE97:         db $03, $0F, $19, $19, $38, $3C, $3E, $3D
DATA_09BE9F:         db $1B, $1B, $0F, $03, $C0, $F0, $D8, $D8
DATA_09BEA7:         db $BC, $7C, $3C, $1C, $98, $98, $F0, $C0
DATA_09BEAF:         db $00, $1F, $3F, $72, $76, $72, $7A, $72
DATA_09BEB7:         db $3F, $1F, $00, $00, $00, $FF, $FF, $59
DATA_09BEBF:         db $DB, $59, $DB, $49, $FF, $FF, $00, $00
DATA_09BEC7:         db $00, $FC, $FE, $23, $77, $77, $77, $37
DATA_09BECF:         db $FE, $FC, $00, $00, $00, $1F, $3F, $7F
DATA_09BED7:         db $7F, $7F, $7F, $7F, $3F, $1F, $00, $00
DATA_09BEDF:         db $00, $FF, $FF, $9F, $9F, $9F, $9F, $81
DATA_09BEE7:         db $FF, $FF, $00, $00, $00, $FC, $FE, $FF
DATA_09BEEF:         db $FF, $FF, $FF, $FF, $FE, $FC, $00, $00
DATA_09BEF7:         db $00, $00, $30, $30, $00, $00, $00, $30
DATA_09BEFF:         db $30, $00, $00, $00, $00, $00, $30, $30
DATA_09BF07:         db $00, $00, $30, $30, $10, $20, $00, $00
DATA_09BF0F:         db $00, $1F, $3F, $7F, $7F, $7F, $7F, $7F
DATA_09BF17:         db $3F, $1F, $00, $00, $00, $FF, $FF, $83
DATA_09BF1F:         db $99, $83, $99, $99, $FF, $FF, $00, $00
DATA_09BF27:         db $00, $FC, $FE, $FF, $FF, $FF, $FF, $FF
DATA_09BF2F:         db $FE, $FC, $00, $00, $30, $10, $20, $40
DATA_09BF37:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BF3F:         db $14, $22, $41, $77, $14, $14, $14, $14
DATA_09BF47:         db $14, $1C, $00, $00, $00, $04, $0C, $1F
DATA_09BF4F:         db $3F, $7F, $3F, $1F, $0C, $04, $00, $00
DATA_09BF57:         db $00, $20, $30, $F8, $FC, $FE, $FC, $F8
DATA_09BF5F:         db $30, $20, $00, $00, $00, $00, $08, $1C
DATA_09BF67:         db $3E, $7F, $3E, $3E, $3E, $3E, $00, $00
DATA_09BF6F:         db $00, $00, $3E, $3E, $3E, $3E, $7F, $3E
DATA_09BF77:         db $1C, $08, $00, $00, $00, $1F, $3F, $72
DATA_09BF7F:         db $77, $73, $7B, $73, $3F, $1F, $00, $00
DATA_09BF87:         db $00, $FF, $FF, $36, $6A, $62, $6A, $6A
DATA_09BF8F:         db $FF, $FF, $00, $00, $00, $FC, $FE, $63
DATA_09BF97:         db $B7, $77, $B7, $B7, $FE, $FC, $00, $00
DATA_09BF9F:         db $0D, $12, $21, $43, $47, $2F, $43, $43
DATA_09BFA7:         db $23, $18, $07, $00, $C0, $30, $88, $CC
DATA_09BFAF:         db $E2, $F2, $C2, $C4, $C4, $18, $E0, $00
DATA_09BFB7:         db $00, $00, $00, $3E, $00, $00, $3E, $00
DATA_09BFBF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09BFC7:         db $00, $00, $00, $00, $30, $10, $20, $40
DATA_09BFCF:         db $00, $00, $00, $18, $24, $7C, $40, $64
DATA_09BFD7:         db $38, $00, $00, $00, $00, $20, $00, $40
DATA_09BFDF:         db $40, $40, $40, $40, $20, $00, $00, $00
DATA_09BFE7:         db $00, $10, $20, $78, $20, $20, $20, $34
DATA_09BFEF:         db $18, $00, $00, $00, $00, $00, $00, $58
DATA_09BFF7:         db $34, $20, $20, $20, $20, $00, $00, $00
DATA_09BFFF:         db $40, $20, $20, $2C, $32, $22, $24, $24
DATA_09C007:         db $22, $00, $00, $00, $18, $30, $20, $78
DATA_09C00F:         db $20, $20, $20, $10, $10, $00, $00, $00
DATA_09C017:         db $00, $00, $00, $58, $2C, $24, $24, $24
DATA_09C01F:         db $22, $00, $00, $00, $00, $00, $00, $00
DATA_09C027:         db $00, $00, $00, $00, $60, $60, $00, $00
DATA_09C02F:         db $18, $06, $00, $1C, $26, $22, $43, $7F
DATA_09C037:         db $41, $41, $41, $01, $1C, $16, $00, $1C
DATA_09C03F:         db $26, $22, $43, $7F, $41, $41, $41, $01
DATA_09C047:         db $1C, $22, $40, $40, $40, $40, $41, $23
DATA_09C04F:         db $1E, $08, $04, $38, $1C, $06, $00, $3E
DATA_09C057:         db $40, $40, $7C, $40, $40, $40, $7F, $00
DATA_09C05F:         db $1C, $30, $00, $3E, $40, $40, $7C, $40
DATA_09C067:         db $40, $40, $7F, $00, $1C, $16, $00, $3E
DATA_09C06F:         db $40, $40, $7C, $40, $40, $40, $7F, $00
DATA_09C077:         db $38, $2C, $00, $38, $10, $10, $10, $20
DATA_09C07F:         db $20, $20, $70, $00, $1C, $16, $00, $1C
DATA_09C087:         db $26, $43, $41, $41, $41, $23, $1E, $00
DATA_09C08F:         db $06, $18, $00, $21, $21, $41, $41, $41
DATA_09C097:         db $43, $66, $3C, $00, $18, $06, $00, $21
DATA_09C09F:         db $21, $41, $41, $41, $43, $66, $3C, $00
DATA_09C0A7:         db $14, $00, $38, $10, $10, $20, $20, $20
DATA_09C0AF:         db $20, $70, $00, $00, $50, $50, $00, $20
DATA_09C0B7:         db $20, $20, $20, $30, $18, $00, $00, $00
DATA_09C0BF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0C7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0CF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0D7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0DF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0E7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0EF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0F7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C0FF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C107:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C10F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C117:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C11F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C127:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C12F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C137:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C13F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C147:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C14F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C157:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C15F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C167:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C16F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C177:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C17F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C187:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C18F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C197:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C19F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1A7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1AF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1B7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1BF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1C7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1CF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1D7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1DF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1E7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1EF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1F7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C1FF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C207:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C20F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C217:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C21F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C227:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C22F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C237:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C23F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C247:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C24F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C257:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C25F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C267:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C26F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C277:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C27F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C287:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C28F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C297:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C29F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2A7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2AF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2B7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2BF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2C7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2CF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2D7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2DF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2E7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2EF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2F7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C2FF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C307:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C30F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C317:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C31F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C327:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C32F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C337:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C33F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C347:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C34F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C357:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C35F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C367:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C36F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C377:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C37F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C387:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C38F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C397:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C39F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3A7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3AF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3B7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3BF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3C7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3CF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3D7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3DF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3E7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3EF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3F7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C3FF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C407:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C40F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C417:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C41F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C427:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C42F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C437:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C43F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C447:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C44F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C457:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C45F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C467:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C46F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C477:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C47F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C487:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C48F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C497:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C49F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C4A7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C4AF:         db $1C, $32, $21, $41, $41, $41, $41, $22
DATA_09C4B7:         db $1C, $00, $00, $00, $0C, $14, $04, $04
DATA_09C4BF:         db $04, $08, $08, $08, $1C, $00, $00, $00
DATA_09C4C7:         db $1E, $31, $21, $01, $06, $18, $20, $42
DATA_09C4CF:         db $7E, $00, $00, $00, $1C, $22, $02, $0C
DATA_09C4D7:         db $02, $01, $41, $63, $3E, $00, $00, $00
DATA_09C4DF:         db $22, $22, $44, $44, $64, $3F, $08, $08
DATA_09C4E7:         db $08, $00, $00, $00, $20, $3E, $20, $20
DATA_09C4EF:         db $3E, $03, $01, $43, $3E, $00, $00, $00
DATA_09C4F7:         db $1C, $20, $40, $5E, $63, $41, $41, $23
DATA_09C4FF:         db $1E, $00, $00, $00, $3F, $61, $42, $04
DATA_09C507:         db $04, $08, $08, $08, $08, $00, $00, $00
DATA_09C50F:         db $1C, $22, $22, $1C, $22, $41, $41, $63
DATA_09C517:         db $3E, $00, $00, $00, $3E, $61, $41, $42
DATA_09C51F:         db $3E, $04, $04, $08, $08, $00, $00, $00
DATA_09C527:         db $1C, $26, $22, $43, $7F, $41, $41, $41
DATA_09C52F:         db $01, $00, $00, $00, $7C, $22, $22, $3C
DATA_09C537:         db $22, $21, $21, $23, $3E, $00, $00, $00
DATA_09C53F:         db $1C, $22, $40, $40, $40, $40, $41, $23
DATA_09C547:         db $1E, $00, $00, $00, $7C, $26, $23, $21
DATA_09C54F:         db $21, $21, $21, $22, $7C, $00, $00, $00
DATA_09C557:         db $3E, $40, $40, $40, $7C, $40, $40, $40
DATA_09C55F:         db $7E, $00, $00, $00, $3E, $40, $40, $40
DATA_09C567:         db $7C, $40, $40, $40, $20, $00, $00, $00
DATA_09C56F:         db $1C, $22, $40, $40, $4F, $41, $41, $23
DATA_09C577:         db $1E, $00, $00, $00, $21, $41, $41, $41
DATA_09C57F:         db $7F, $41, $41, $41, $41, $00, $00, $00
DATA_09C587:         db $38, $10, $10, $10, $20, $20, $20, $20
DATA_09C58F:         db $70, $00, $00, $00, $01, $01, $01, $21
DATA_09C597:         db $41, $41, $41, $62, $3C, $00, $00, $00
DATA_09C59F:         db $42, $44, $48, $50, $70, $58, $4C, $46
DATA_09C5A7:         db $43, $00, $00, $00, $40, $40, $40, $40
DATA_09C5AF:         db $40, $40, $40, $40, $7E, $00, $00, $00
DATA_09C5B7:         db $20, $21, $73, $55, $49, $41, $41, $41
DATA_09C5BF:         db $21, $00, $00, $00, $42, $61, $61, $51
DATA_09C5C7:         db $51, $49, $49, $45, $43, $00, $00, $00
DATA_09C5CF:         db $1C, $26, $43, $41, $41, $41, $41, $23
DATA_09C5D7:         db $1E, $00, $00, $00, $7E, $43, $41, $43
DATA_09C5DF:         db $3E, $20, $20, $20, $20, $00, $00, $00
DATA_09C5E7:         db $1C, $26, $43, $41, $41, $41, $51, $2A
DATA_09C5EF:         db $1C, $02, $01, $00, $7C, $42, $41, $43
DATA_09C5F7:         db $7E, $48, $44, $42, $41, $00, $00, $00
DATA_09C5FF:         db $1C, $22, $20, $30, $1C, $02, $41, $43
DATA_09C607:         db $3E, $00, $00, $00, $3F, $48, $08, $08
DATA_09C60F:         db $08, $04, $04, $04, $04, $00, $00, $00
DATA_09C617:         db $22, $21, $41, $41, $41, $41, $43, $66
DATA_09C61F:         db $3C, $00, $00, $00, $40, $41, $21, $23
DATA_09C627:         db $22, $16, $14, $1C, $08, $00, $00, $00
DATA_09C62F:         db $42, $41, $41, $49, $49, $5D, $55, $77
DATA_09C637:         db $22, $00, $00, $00, $40, $41, $23, $16
DATA_09C63F:         db $0C, $1C, $32, $61, $41, $00, $00, $00
DATA_09C647:         db $41, $43, $26, $1C, $08, $08, $08, $08
DATA_09C64F:         db $08, $00, $00, $00, $70, $0F, $02, $04
DATA_09C657:         db $08, $10, $20, $40, $7F, $00, $00, $00
DATA_09C65F:         db $7E, $82, $BE, $A0, $A0, $A0, $E0, $00
DATA_09C667:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C66F:         db $00, $07, $05, $05, $05, $7D, $41, $7E
DATA_09C677:         db $3C, $62, $42, $06, $0C, $18, $10, $00
DATA_09C67F:         db $10, $10, $00, $00, $30, $30, $20, $60
DATA_09C687:         db $40, $40, $40, $00, $40, $40, $00, $00
DATA_09C68F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C697:         db $80, $C0, $60, $20, $00, $00, $00, $00
DATA_09C69F:         db $00, $7F, $00, $00, $00, $00, $00, $00
DATA_09C6A7:         db $03, $03, $03, $1F, $1F, $1E, $1F, $1F
DATA_09C6AF:         db $03, $03, $03, $00, $E0, $E0, $E0, $FC
DATA_09C6B7:         db $7C, $BC, $7C, $FC, $E0, $E0, $E0, $00
DATA_09C6BF:         db $00, $00, $00, $00, $2A, $2A, $00, $00
DATA_09C6C7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C6CF:         db $00, $00, $00, $00, $60, $90, $90, $60
DATA_09C6D7:         db $00, $00, $00, $00, $00, $30, $49, $06
DATA_09C6DF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C6E7:         db $00, $00, $00, $00, $30, $10, $20, $40
DATA_09C6EF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C6F7:         db $00, $00, $00, $00, $48, $48, $6C, $24
DATA_09C6FF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C707:         db $24, $24, $6C, $48, $00, $00, $00, $00
DATA_09C70F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C717:         db $00, $18, $18, $00, $00, $00, $00, $00
DATA_09C71F:         db $60, $70, $78, $7C, $7E, $7F, $7E, $7C
DATA_09C727:         db $78, $70, $60, $00, $01, $1A, $27, $21
DATA_09C72F:         db $20, $11, $0E, $02, $01, $00, $00, $00
DATA_09C737:         db $80, $40, $60, $10, $10, $26, $3A, $12
DATA_09C73F:         db $84, $58, $F0, $00, $00, $00, $44, $68
DATA_09C747:         db $30, $18, $2C, $44, $00, $00, $00, $00
DATA_09C74F:         db $00, $00, $00, $1C, $02, $3A, $44, $4E
DATA_09C757:         db $3B, $00, $00, $00, $40, $20, $20, $2E
DATA_09C75F:         db $31, $21, $21, $33, $5E, $00, $00, $00
DATA_09C767:         db $00, $00, $00, $3C, $62, $40, $40, $63
DATA_09C76F:         db $3E, $00, $00, $00, $02, $01, $01, $39
DATA_09C777:         db $66, $42, $42, $46, $3B, $00, $00, $00
DATA_09C77F:         db $00, $00, $00, $1C, $22, $7E, $40, $62
DATA_09C787:         db $3C, $00, $00, $00, $0C, $1A, $10, $7E
DATA_09C78F:         db $10, $10, $10, $08, $08, $00, $00, $00
DATA_09C797:         db $00, $00, $02, $1E, $31, $23, $1E, $08
DATA_09C79F:         db $3E, $61, $43, $3E, $40, $20, $20, $2E
DATA_09C7A7:         db $31, $21, $22, $22, $21, $00, $00, $00
DATA_09C7AF:         db $00, $20, $00, $40, $40, $40, $40, $60
DATA_09C7B7:         db $30, $00, $00, $00, $00, $02, $00, $02
DATA_09C7BF:         db $02, $02, $02, $02, $46, $4C, $38, $00
DATA_09C7C7:         db $40, $40, $42, $64, $28, $38, $2C, $26
DATA_09C7CF:         db $23, $00, $00, $00, $20, $20, $40, $40
DATA_09C7D7:         db $40, $40, $40, $60, $30, $00, $00, $00
DATA_09C7DF:         db $00, $00, $40, $56, $6B, $49, $49, $49
DATA_09C7E7:         db $49, $00, $00, $00, $00, $00, $00, $5C
DATA_09C7EF:         db $26, $22, $22, $22, $21, $00, $00, $00
DATA_09C7F7:         db $00, $00, $00, $3C, $62, $41, $41, $23
DATA_09C7FF:         db $1E, $00, $00, $00, $00, $00, $00, $5E
DATA_09C807:         db $23, $21, $21, $13, $1E, $10, $10, $10
DATA_09C80F:         db $00, $00, $00, $1D, $22, $46, $44, $4C
DATA_09C817:         db $38, $08, $08, $04, $00, $00, $00, $5C
DATA_09C81F:         db $32, $22, $20, $20, $20, $00, $00, $00
DATA_09C827:         db $00, $00, $38, $44, $60, $3C, $06, $42
DATA_09C82F:         db $3C, $00, $00, $00, $00, $08, $10, $7C
DATA_09C837:         db $10, $10, $10, $19, $0E, $00, $00, $00
DATA_09C83F:         db $00, $00, $00, $40, $42, $42, $42, $67
DATA_09C847:         db $3D, $00, $00, $00, $00, $00, $01, $42
DATA_09C84F:         db $62, $24, $34, $18, $08, $00, $00, $00
DATA_09C857:         db $00, $00, $00, $21, $41, $49, $49, $5B
DATA_09C85F:         db $36, $00, $00, $00, $00, $00, $01, $62
DATA_09C867:         db $34, $18, $18, $2C, $43, $00, $00, $00
DATA_09C86F:         db $00, $00, $00, $41, $21, $22, $12, $16
DATA_09C877:         db $0C, $18, $30, $C0, $00, $00, $00, $3C
DATA_09C87F:         db $03, $06, $18, $30, $7C, $03, $00, $00
DATA_09C887:         db $03, $07, $0F, $1F, $3F, $7F, $3F, $1F
DATA_09C88F:         db $0F, $07, $03, $00, $00, $00, $00, $00
DATA_09C897:         db $00, $00, $00, $00, $60, $60, $00, $00
DATA_09C89F:         db $0D, $12, $20, $43, $44, $40, $41, $20
DATA_09C8A7:         db $11, $0C, $03, $00, $C0, $30, $08, $C4
DATA_09C8AF:         db $22, $E2, $82, $0C, $84, $18, $E0, $00
DATA_09C8B7:         db $00, $01, $02, $3C, $11, $09, $04, $04
DATA_09C8BF:         db $38, $3D, $1E, $00, $80, $40, $20, $1E
DATA_09C8C7:         db $44, $48, $10, $10, $8E, $5E, $3C, $00
DATA_09C8CF:         db $01, $06, $09, $11, $10, $20, $20, $20
DATA_09C8D7:         db $3F, $2B, $3F, $00, $C0, $30, $C8, $C4
DATA_09C8DF:         db $84, $02, $82, $02, $FE, $02, $FE, $00
DATA_09C8E7:         db $1C, $14, $14, $14, $14, $14, $77, $41
DATA_09C8EF:         db $22, $14, $08, $00, $00, $00, $00, $00
DATA_09C8F7:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C8FF:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C907:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C90F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C917:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C91F:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C927:         db $00, $00, $00, $00, $00, $00, $00, $00

; message box pictures (1bpp)
DATA_09C930:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C938:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C940:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C948:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C950:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C958:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C960:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C968:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C970:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C978:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C980:         db $00, $00, $03, $F8, $00, $00, $00, $00
DATA_09C988:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C990:         db $00, $03, $0C, $0E, $00, $00, $00, $00
DATA_09C998:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C9A0:         db $00, $03, $98, $03, $00, $00, $00, $00
DATA_09C9A8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09C9B0:         db $00, $1B, $B0, $01, $80, $00, $00, $00
DATA_09C9B8:         db $00, $00, $00, $00, $04, $08, $00, $00
DATA_09C9C0:         db $00, $19, $C0, $00, $C0, $00, $00, $00
DATA_09C9C8:         db $00, $00, $00, $00, $04, $10, $00, $00
DATA_09C9D0:         db $00, $1C, $C0, $00, $40, $00, $00, $00
DATA_09C9D8:         db $00, $00, $00, $00, $02, $10, $00, $00
DATA_09C9E0:         db $00, $0F, $00, $00, $60, $00, $00, $00
DATA_09C9E8:         db $00, $00, $00, $00, $03, $20, $00, $00
DATA_09C9F0:         db $00, $1F, $F8, $00, $20, $00, $00, $00
DATA_09C9F8:         db $00, $00, $00, $00, $01, $C0, $00, $00
DATA_09CA00:         db $00, $30, $0C, $00, $20, $1F, $F0, $00
DATA_09CA08:         db $00, $00, $00, $00, $00, $80, $00, $00
DATA_09CA10:         db $00, $60, $02, $00, $20, $1F, $F0, $00
DATA_09CA18:         db $00, $00, $00, $00, $02, $30, $00, $00
DATA_09CA20:         db $00, $40, $01, $00, $20, $1F, $B0, $00
DATA_09CA28:         db $00, $00, $00, $00, $03, $30, $00, $00
DATA_09CA30:         db $00, $C0, $00, $80, $20, $1F, $A0, $00
DATA_09CA38:         db $00, $00, $00, $00, $03, $33, $FF, $00
DATA_09CA40:         db $03, $80, $00, $C0, $20, $0F, $A0, $60
DATA_09CA48:         db $00, $00, $00, $01, $C3, $BE, $01, $C0
DATA_09CA50:         db $04, $80, $00, $40, $20, $0F, $E3, $E0
DATA_09CA58:         db $00, $00, $00, $03, $6F, $38, $00, $60
DATA_09CA60:         db $04, $80, $00, $40, $20, $0F, $FF, $E0
DATA_09CA68:         db $00, $00, $00, $02, $33, $30, $04, $30
DATA_09CA70:         db $04, $80, $00, $40, $67, $FF, $FF, $A0
DATA_09CA78:         db $00, $00, $00, $02, $30, $00, $48, $10
DATA_09CA80:         db $03, $C0, $00, $00, $47, $FC, $7F, $E0
DATA_09CA88:         db $00, $00, $00, $02, $64, $0C, $90, $08
DATA_09CA90:         db $01, $40, $00, $00, $C7, $F8, $3F, $A0
DATA_09CA98:         db $00, $00, $02, $02, $44, $19, $21, $08
DATA_09CAA0:         db $02, $40, $00, $00, $87, $F8, $3F, $A0
DATA_09CAA8:         db $00, $00, $03, $03, $4E, $32, $62, $08
DATA_09CAB0:         db $02, $60, $00, $03, $07, $F8, $3C, $20
DATA_09CAB8:         db $7C, $00, $05, $06, $4A, $26, $C2, $08
DATA_09CAC0:         db $02, $20, $00, $1C, $07, $3C, $7F, $E1
DATA_09CAC8:         db $C7, $00, $0C, $CC, $4A, $04, $00, $08
DATA_09CAD0:         db $01, $F0, $00, $04, $04, $FF, $C0, $03
DATA_09CAD8:         db $C1, $80, $08, $78, $44, $00, $00, $08
DATA_09CAE0:         db $00, $38, $00, $04, $07, $8F, $E0, $03
DATA_09CAE8:         db $C2, $80, $08, $4C, $40, $00, $00, $08
DATA_09CAF0:         db $00, $36, $04, $0C, $00, $0F, $E0, $07
DATA_09CAF8:         db $C1, $80, $10, $47, $A0, $00, $00, $08
DATA_09CB00:         db $00, $1E, $07, $F0, $00, $1F, $F0, $0F
DATA_09CB08:         db $87, $40, $10, $40, $B0, $00, $00, $10
DATA_09CB10:         db $00, $06, $06, $00, $00, $1F, $F0, $0F
DATA_09CB18:         db $8F, $C0, $10, $67, $F8, $00, $00, $30
DATA_09CB20:         db $00, $7C, $83, $C0, $00, $1F, $D0, $1E
DATA_09CB28:         db $0F, $C0, $10, $3C, $B8, $00, $00, $60
DATA_09CB30:         db $0F, $D9, $83, $60, $00, $1F, $10, $10
DATA_09CB38:         db $0F, $C0, $10, $60, $00, $00, $00, $80
DATA_09CB40:         db $08, $11, $01, $30, $00, $1F, $F0, $10
DATA_09CB48:         db $0F, $C0, $10, $40, $C0, $10, $03, $80
DATA_09CB50:         db $08, $23, $01, $10, $00, $00, $00, $10
DATA_09CB58:         db $07, $40, $10, $C0, $81, $08, $06, $00
DATA_09CB60:         db $08, $61, $81, $30, $00, $00, $00, $10
DATA_09CB68:         db $02, $C0, $18, $81, $03, $07, $F8, $00
DATA_09CB70:         db $04, $60, $43, $E0, $00, $00, $00, $1B
DATA_09CB78:         db $89, $C0, $28, $81, $02, $01, $80, $00
DATA_09CB80:         db $04, $20, $42, $C0, $00, $3F, $F0, $0F
DATA_09CB88:         db $E5, $80, $44, $82, $06, $00, $00, $00
DATA_09CB90:         db $02, $30, $C4, $00, $00, $1F, $E0, $0F
DATA_09CB98:         db $F3, $80, $92, $66, $18, $00, $00, $00
DATA_09CBA0:         db $01, $19, $88, $00, $00, $1F, $C0, $07
DATA_09CBA8:         db $F7, $00, $A1, $9C, $70, $00, $00, $00
DATA_09CBB0:         db $00, $CE, $10, $00, $00, $0F, $80, $03
DATA_09CBB8:         db $FE, $61, $20, $E0, $F8, $00, $00, $00
DATA_09CBC0:         db $00, $30, $60, $00, $00, $07, $00, $00
DATA_09CBC8:         db $F8, $11, $41, $FF, $BF, $00, $00, $00
DATA_09CBD0:         db $00, $FF, $BC, $00, $00, $07, $00, $00
DATA_09CBD8:         db $01, $8A, $47, $C0, $C0, $E0, $00, $00
DATA_09CBE0:         db $03, $1C, $03, $80, $00, $02, $00, $00
DATA_09CBE8:         db $00, $64, $8C, $31, $80, $10, $00, $00
DATA_09CBF0:         db $04, $02, $00, $C0, $00, $00, $00, $00
DATA_09CBF8:         db $00, $10, $98, $0D, $80, $10, $00, $00
DATA_09CC00:         db $08, $01, $00, $40, $00, $00, $00, $00
DATA_09CC08:         db $00, $09, $10, $04, $E0, $70, $00, $00
DATA_09CC10:         db $0C, $01, $FF, $C0, $00, $00, $00, $00
DATA_09CC18:         db $00, $00, $13, $FE, $1F, $C0, $00, $00
DATA_09CC20:         db $07, $FE, $00, $00, $00, $00, $00, $00
DATA_09CC28:         db $00, $00, $1C, $00, $00, $00, $00, $00
DATA_09CC30:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CC38:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CC40:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CC48:         db $00, $00, $00, $02, $00, $00, $00, $00
DATA_09CC50:         db $00, $00, $00, $18, $00, $00, $00, $00
DATA_09CC58:         db $00, $00, $00, $02, $00, $00, $00, $00
DATA_09CC60:         db $00, $00, $01, $9B, $E0, $00, $00, $00
DATA_09CC68:         db $00, $00, $21, $02, $00, $00, $00, $00
DATA_09CC70:         db $00, $00, $01, $9F, $F8, $00, $00, $00
DATA_09CC78:         db $00, $00, $20, $81, $00, $00, $00, $00
DATA_09CC80:         db $00, $00, $01, $CE, $0C, $00, $00, $00
DATA_09CC88:         db $00, $00, $20, $81, $00, $00, $00, $00
DATA_09CC90:         db $00, $00, $00, $D8, $06, $00, $00, $00
DATA_09CC98:         db $00, $00, $10, $81, $00, $00, $00, $00
DATA_09CCA0:         db $00, $00, $30, $D0, $02, $00, $00, $00
DATA_09CCA8:         db $00, $00, $08, $80, $80, $00, $00, $00
DATA_09CCB0:         db $00, $00, $4C, $10, $03, $00, $00, $00
DATA_09CCB8:         db $00, $00, $08, $40, $80, $00, $00, $00
DATA_09CCC0:         db $00, $00, $C3, $00, $03, $00, $00, $00
DATA_09CCC8:         db $00, $00, $08, $40, $80, $00, $00, $00
DATA_09CCD0:         db $00, $00, $8C, $80, $03, $00, $00, $00
DATA_09CCD8:         db $00, $00, $08, $40, $00, $00, $00, $00
DATA_09CCE0:         db $00, $00, $74, $00, $03, $00, $00, $00
DATA_09CCE8:         db $00, $00, $08, $40, $40, $00, $00, $00
DATA_09CCF0:         db $00, $00, $38, $00, $03, $00, $00, $00
DATA_09CCF8:         db $00, $00, $01, $E0, $E6, $00, $00, $00
DATA_09CD00:         db $00, $00, $28, $00, $02, $00, $00, $00
DATA_09CD08:         db $00, $00, $03, $30, $EE, $00, $00, $00
DATA_09CD10:         db $00, $00, $68, $40, $02, $00, $00, $00
DATA_09CD18:         db $00, $00, $02, $11, $CE, $00, $00, $00
DATA_09CD20:         db $00, $00, $78, $20, $0C, $00, $00, $00
DATA_09CD28:         db $00, $00, $02, $19, $9C, $00, $00, $00
DATA_09CD30:         db $00, $00, $3C, $30, $08, $00, $00, $00
DATA_09CD38:         db $00, $00, $03, $E0, $3F, $C0, $00, $00
DATA_09CD40:         db $00, $00, $3C, $1C, $30, $00, $00, $00
DATA_09CD48:         db $00, $00, $04, $C0, $00, $30, $00, $00
DATA_09CD50:         db $00, $00, $0F, $07, $E0, $00, $00, $00
DATA_09CD58:         db $00, $00, $09, $80, $00, $18, $00, $00
DATA_09CD60:         db $00, $00, $03, $F2, $00, $00, $00, $00
DATA_09CD68:         db $00, $00, $09, $00, $00, $08, $00, $00
DATA_09CD70:         db $00, $00, $00, $63, $00, $00, $01, $00
DATA_09CD78:         db $00, $00, $07, $0C, $00, $0C, $00, $00
DATA_09CD80:         db $00, $00, $00, $41, $00, $00, $03, $00
DATA_09CD88:         db $00, $00, $07, $18, $00, $04, $00, $00
DATA_09CD90:         db $00, $00, $00, $81, $00, $03, $03, $00
DATA_09CD98:         db $00, $00, $35, $88, $00, $04, $00, $00
DATA_09CDA0:         db $00, $00, $03, $C1, $00, $03, $C3, $80
DATA_09CDA8:         db $00, $00, $FB, $C8, $00, $04, $00, $00
DATA_09CDB0:         db $00, $00, $07, $40, $80, $03, $F7, $80
DATA_09CDB8:         db $00, $01, $09, $F8, $00, $04, $00, $00
DATA_09CDC0:         db $00, $00, $39, $40, $80, $03, $FF, $C0
DATA_09CDC8:         db $00, $01, $0F, $44, $00, $08, $00, $00
DATA_09CDD0:         db $00, $03, $C2, $71, $80, $07, $FF, $C0
DATA_09CDD8:         db $00, $01, $01, $C6, $00, $18, $00, $00
DATA_09CDE0:         db $00, $03, $06, $11, $00, $07, $FF, $E0
DATA_09CDE8:         db $00, $01, $80, $43, $00, $30, $00, $00
DATA_09CDF0:         db $00, $01, $06, $31, $00, $0F, $FF, $F0
DATA_09CDF8:         db $00, $00, $FE, $41, $80, $40, $00, $00
DATA_09CE00:         db $00, $00, $C3, $E3, $00, $0F, $FF, $F8
DATA_09CE08:         db $00, $40, $72, $C0, $E3, $80, $00, $00
DATA_09CE10:         db $00, $00, $E0, $06, $00, $07, $FF, $FC
DATA_09CE18:         db $00, $60, $03, $80, $DC, $00, $00, $00
DATA_09CE20:         db $00, $00, $30, $18, $00, $01, $FF, $F8
DATA_09CE28:         db $00, $78, $07, $00, $60, $04, $00, $00
DATA_09CE30:         db $00, $00, $0F, $F0, $00, $00, $1F, $E0
DATA_09CE38:         db $00, $20, $1C, $08, $20, $84, $00, $00
DATA_09CE40:         db $00, $00, $00, $00, $00, $00, $1F, $80
DATA_09CE48:         db $00, $20, $78, $3C, $21, $C3, $00, $00
DATA_09CE50:         db $00, $00, $0E, $70, $00, $00, $1E, $00
DATA_09CE58:         db $00, $20, $20, $3C, $23, $C0, $E0, $00
DATA_09CE60:         db $00, $00, $1E, $50, $00, $00, $3E, $00
DATA_09CE68:         db $00, $40, $20, $7C, $67, $C1, $80, $00
DATA_09CE70:         db $00, $02, $32, $90, $00, $00, $38, $00
DATA_09CE78:         db $00, $80, $30, $F8, $4F, $C2, $00, $00
DATA_09CE80:         db $00, $04, $26, $90, $00, $00, $30, $00
DATA_09CE88:         db $07, $C0, $19, $F8, $4F, $84, $00, $00
DATA_09CE90:         db $00, $04, $24, $90, $00, $00, $00, $00
DATA_09CE98:         db $00, $60, $0F, $E0, $9E, $0C, $00, $00
DATA_09CEA0:         db $00, $08, $28, $E0, $00, $00, $00, $00
DATA_09CEA8:         db $00, $10, $07, $E3, $1C, $08, $00, $00
DATA_09CEB0:         db $00, $18, $B0, $60, $00, $00, $00, $00
DATA_09CEB8:         db $00, $10, $03, $C6, $18, $38, $00, $00
DATA_09CEC0:         db $00, $11, $00, $00, $00, $00, $00, $00
DATA_09CEC8:         db $00, $3E, $03, $F8, $01, $CC, $00, $00
DATA_09CED0:         db $00, $11, $00, $00, $00, $00, $00, $00
DATA_09CED8:         db $00, $62, $E0, $00, $01, $02, $00, $00
DATA_09CEE0:         db $00, $11, $08, $00, $00, $00, $00, $00
DATA_09CEE8:         db $00, $C3, $B0, $00, $7A, $00, $00, $00
DATA_09CEF0:         db $00, $02, $10, $00, $00, $00, $00, $00
DATA_09CEF8:         db $00, $03, $17, $CF, $46, $00, $00, $00
DATA_09CF00:         db $00, $02, $10, $00, $00, $00, $00, $00
DATA_09CF08:         db $00, $04, $18, $69, $C3, $00, $00, $00
DATA_09CF10:         db $00, $02, $20, $00, $00, $00, $00, $00
DATA_09CF18:         db $00, $00, $08, $18, $41, $00, $00, $00
DATA_09CF20:         db $00, $02, $20, $00, $00, $00, $00, $00
DATA_09CF28:         db $00, $00, $00, $18, $00, $00, $00, $00
DATA_09CF30:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF38:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF40:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF48:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF50:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF58:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF60:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF68:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF70:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF78:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF80:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF88:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF90:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CF98:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFA0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFA8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFB0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFB8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFC0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFC8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFD0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFD8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFE0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFE8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFF0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09CFF8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D000:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D008:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D010:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D018:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D020:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D028:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D030:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D038:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D040:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D048:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D050:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D058:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D060:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D068:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D070:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D078:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D080:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D088:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D090:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D098:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0A0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0A8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0B0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0C0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0D0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0E0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0F0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D0F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D100:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D108:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D110:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D118:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D120:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D128:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D130:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D138:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D140:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D148:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D150:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D158:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D160:         db $00, $00, $00, $18, $00, $00, $00, $00
DATA_09D168:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D170:         db $00, $00, $00, $1C, $07, $C0, $00, $00
DATA_09D178:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D180:         db $00, $00, $01, $9C, $18, $38, $00, $00
DATA_09D188:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D190:         db $00, $00, $01, $8E, $60, $04, $00, $00
DATA_09D198:         db $00, $00, $01, $F8, $00, $00, $00, $00
DATA_09D1A0:         db $00, $00, $01, $CE, $C0, $02, $00, $00
DATA_09D1A8:         db $00, $00, $01, $04, $00, $07, $00, $00
DATA_09D1B0:         db $00, $00, $00, $C6, $80, $03, $00, $00
DATA_09D1B8:         db $00, $00, $03, $04, $00, $18, $C0, $00
DATA_09D1C0:         db $00, $00, $00, $E1, $00, $01, $00, $00
DATA_09D1C8:         db $70, $00, $03, $04, $00, $38, $20, $00
DATA_09D1D0:         db $00, $00, $00, $61, $00, $00, $80, $00
DATA_09D1D8:         db $90, $00, $01, $0B, $80, $7C, $10, $00
DATA_09D1E0:         db $00, $00, $00, $02, $00, $00, $80, $01
DATA_09D1E8:         db $8E, $00, $01, $00, $C3, $FC, $08, $00
DATA_09D1F0:         db $00, $00, $00, $72, $00, $00, $80, $03
DATA_09D1F8:         db $83, $00, $03, $40, $7C, $7C, $E8, $00
DATA_09D200:         db $00, $00, $06, $82, $00, $00, $80, $02
DATA_09D208:         db $03, $80, $02, $30, $E0, $F9, $F4, $00
DATA_09D210:         db $00, $00, $0F, $00, $00, $00, $80, $06
DATA_09D218:         db $20, $80, $07, $E0, $60, $D9, $F4, $00
DATA_09D220:         db $00, $00, $0A, $00, $00, $00, $80, $06
DATA_09D228:         db $20, $80, $7C, $20, $C0, $E1, $F4, $00
DATA_09D230:         db $00, $00, $0A, $00, $00, $00, $80, $03
DATA_09D238:         db $38, $CF, $84, $10, $C1, $C0, $E2, $00
DATA_09D240:         db $00, $00, $0A, $00, $00, $01, $80, $01
DATA_09D248:         db $0C, $F0, $06, $18, $3E, $B8, $02, $00
DATA_09D250:         db $00, $00, $0E, $00, $00, $03, $00, $03
DATA_09D258:         db $7C, $C0, $01, $18, $20, $FC, $02, $00
DATA_09D260:         db $00, $00, $0A, $00, $00, $02, $00, $0F
DATA_09D268:         db $84, $C0, $03, $F0, $30, $FE, $0E, $00
DATA_09D270:         db $00, $00, $0B, $07, $00, $0C, $00, $F1
DATA_09D278:         db $0C, $60, $3E, $10, $10, $FE, $1E, $00
DATA_09D280:         db $00, $00, $09, $01, $C0, $78, $00, $03
DATA_09D288:         db $18, $27, $C2, $10, $1F, $FC, $3C, $00
DATA_09D290:         db $00, $00, $0F, $C0, $7F, $E0, $00, $02
DATA_09D298:         db $18, $38, $02, $18, $30, $78, $3C, $00
DATA_09D2A0:         db $00, $00, $00, $79, $90, $D0, $00, $03
DATA_09D2A8:         db $BC, $10, $01, $FC, $60, $20, $38, $00
DATA_09D2B0:         db $00, $00, $00, $2F, $0C, $9F, $00, $07
DATA_09D2B8:         db $CC, $30, $7F, $E0, $20, $18, $30, $00
DATA_09D2C0:         db $00, $00, $00, $79, $87, $99, $80, $F8
DATA_09D2C8:         db $C8, $7F, $80, $28, $20, $07, $C0, $00
DATA_09D2D0:         db $00, $00, $00, $47, $FC, $00, $80, $00
DATA_09D2D8:         db $F8, $60, $00, $28, $20, $00, $00, $00
DATA_09D2E0:         db $00, $07, $61, $A1, $EC, $00, $80, $03
DATA_09D2E8:         db $E0, $60, $00, $1C, $20, $00, $00, $00
DATA_09D2F0:         db $00, $1C, $81, $01, $94, $00, $9C, $00
DATA_09D2F8:         db $16, $40, $00, $03, $C0, $00, $00, $00
DATA_09D300:         db $00, $31, $01, $07, $1A, $01, $E4, $00
DATA_09D308:         db $1E, $60, $00, $00, $00, $00, $00, $00
DATA_09D310:         db $00, $C6, $03, $8F, $0B, $FF, $84, $00
DATA_09D318:         db $07, $C0, $00, $00, $00, $00, $00, $00
DATA_09D320:         db $03, $88, $0E, $FB, $0A, $61, $04, $00
DATA_09D328:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D330:         db $06, $30, $30, $02, $0A, $22, $08, $00
DATA_09D338:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D340:         db $08, $40, $C0, $E2, $0A, $22, $18, $00
DATA_09D348:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D350:         db $10, $47, $03, $22, $14, $24, $30, $00
DATA_09D358:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D360:         db $20, $78, $0D, $17, $34, $68, $60, $00
DATA_09D368:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D370:         db $40, $00, $71, $0F, $E8, $69, $C0, $00
DATA_09D378:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D380:         db $40, $03, $81, $07, $F0, $4B, $00, $00
DATA_09D388:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D390:         db $60, $3E, $01, $82, $00, $CC, $00, $00
DATA_09D398:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D3A0:         db $3F, $F0, $00, $81, $01, $C0, $00, $00
DATA_09D3A8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D3B0:         db $07, $80, $00, $C1, $C3, $00, $00, $00
DATA_09D3B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D3C0:         db $00, $00, $00, $30, $FC, $00, $00, $00
DATA_09D3C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D3D0:         db $00, $00, $00, $0F, $80, $00, $00, $00
DATA_09D3D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D3E0:         db $00, $00, $00, $01, $80, $00, $00, $00
DATA_09D3E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D3F0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D3F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D400:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D408:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D410:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D418:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D420:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D428:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D430:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D438:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D440:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D448:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D450:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D458:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D460:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D468:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D470:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D478:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D480:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D488:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D490:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D498:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4A0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4A8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4B0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4C0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4D0:         db $00, $00, $00, $00, $66, $00, $00, $00
DATA_09D4D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4E0:         db $00, $00, $00, $00, $66, $00, $00, $00
DATA_09D4E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D4F0:         db $00, $00, $00, $00, $66, $1F, $00, $00
DATA_09D4F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D500:         db $00, $00, $00, $00, $66, $71, $80, $00
DATA_09D508:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D510:         db $00, $00, $00, $00, $67, $80, $60, $00
DATA_09D518:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D520:         db $00, $00, $00, $00, $06, $00, $20, $00
DATA_09D528:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D530:         db $00, $00, $00, $00, $08, $00, $10, $00
DATA_09D538:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D540:         db $00, $00, $00, $00, $F0, $00, $10, $00
DATA_09D548:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D550:         db $00, $00, $00, $F3, $00, $00, $08, $00
DATA_09D558:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D560:         db $00, $00, $01, $9C, $00, $00, $08, $00
DATA_09D568:         db $00, $00, $00, $00, $30, $00, $00, $00
DATA_09D570:         db $00, $00, $02, $08, $00, $00, $08, $00
DATA_09D578:         db $00, $00, $00, $00, $50, $00, $00, $00
DATA_09D580:         db $00, $00, $02, $10, $00, $00, $08, $00
DATA_09D588:         db $00, $00, $00, $00, $97, $FC, $00, $00
DATA_09D590:         db $00, $00, $02, $10, $00, $00, $08, $00
DATA_09D598:         db $00, $00, $00, $00, $9F, $07, $00, $00
DATA_09D5A0:         db $00, $00, $01, $F0, $00, $00, $10, $00
DATA_09D5A8:         db $00, $00, $00, $00, $7B, $E1, $80, $00
DATA_09D5B0:         db $00, $00, $00, $F0, $00, $00, $10, $00
DATA_09D5B8:         db $00, $00, $00, $00, $3C, $F8, $40, $00
DATA_09D5C0:         db $00, $00, $00, $90, $03, $E0, $20, $00
DATA_09D5C8:         db $00, $00, $00, $00, $77, $1E, $60, $00
DATA_09D5D0:         db $00, $00, $00, $98, $0C, $1C, $60, $00
DATA_09D5D8:         db $00, $00, $00, $00, $53, $87, $30, $00
DATA_09D5E0:         db $00, $03, $00, $C8, $10, $07, $80, $00
DATA_09D5E8:         db $00, $00, $01, $FC, $D1, $C3, $B0, $00
DATA_09D5F0:         db $00, $03, $C3, $FC, $30, $00, $00, $00
DATA_09D5F8:         db $00, $00, $06, $06, $90, $E1, $90, $00
DATA_09D600:         db $00, $02, $6C, $66, $20, $00, $00, $00
DATA_09D608:         db $00, $00, $04, $03, $98, $F0, $D0, $00
DATA_09D610:         db $00, $02, $38, $23, $3F, $FF, $FF, $FF
DATA_09D618:         db $FF, $FF, $F8, $01, $98, $78, $D0, $00
DATA_09D620:         db $00, $02, $6F, $FF, $20, $00, $00, $00
DATA_09D628:         db $00, $00, $00, $01, $98, $3C, $D0, $00
DATA_09D630:         db $00, $02, $98, $7D, $20, $00, $00, $00
DATA_09D638:         db $00, $00, $00, $01, $9C, $1C, $50, $00
DATA_09D640:         db $00, $01, $81, $81, $BF, $FF, $FF, $FF
DATA_09D648:         db $FF, $FF, $FC, $03, $CC, $0E, $70, $00
DATA_09D650:         db $00, $01, $86, $02, $A0, $00, $00, $00
DATA_09D658:         db $00, $00, $03, $8E, $4F, $06, $20, $00
DATA_09D660:         db $00, $01, $84, $06, $A0, $00, $00, $00
DATA_09D668:         db $00, $00, $00, $78, $47, $83, $60, $00
DATA_09D670:         db $00, $00, $CC, $04, $B8, $00, $00, $00
DATA_09D678:         db $00, $00, $00, $00, $23, $E1, $C0, $00
DATA_09D680:         db $00, $00, $F8, $18, $86, $00, $00, $00
DATA_09D688:         db $00, $00, $00, $00, $18, $7D, $80, $00
DATA_09D690:         db $00, $00, $60, $EC, $42, $00, $00, $00
DATA_09D698:         db $00, $00, $00, $00, $06, $07, $00, $00
DATA_09D6A0:         db $00, $03, $FF, $FB, $66, $00, $00, $00
DATA_09D6A8:         db $00, $00, $00, $00, $01, $FE, $00, $00
DATA_09D6B0:         db $00, $04, $03, $E0, $BC, $00, $00, $00
DATA_09D6B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D6C0:         db $00, $07, $FC, $3F, $80, $00, $00, $00
DATA_09D6C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D6D0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D6D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D6E0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D6E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D6F0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D6F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D700:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D708:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D710:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D718:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D720:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D728:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D730:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D738:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D740:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D748:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D750:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D758:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D760:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D768:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D770:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D778:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D780:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D788:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D790:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D798:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7A0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7A8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7B0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7C0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7D0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7E0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7F0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D7F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D800:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D808:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D810:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D818:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D820:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D828:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D830:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D838:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D840:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D848:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D850:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D858:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D860:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D868:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D870:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D878:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D880:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D888:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D890:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D898:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8A0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8A8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8B0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8C0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8D0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8E0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8F0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D8F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D900:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D908:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D910:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D918:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D920:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D928:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09D930:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09D938:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09D940:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09D948:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09D950:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09D958:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09D960:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09D968:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09D970:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09D978:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09D980:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09D988:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09D990:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09D998:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09D9A0:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09D9A8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09D9B0:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09D9B8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09D9C0:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09D9C8:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09D9D0:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09D9D8:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09D9E0:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09D9E8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09D9F0:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09D9F8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DA00:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DA08:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DA10:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DA18:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DA20:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DA28:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DA30:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DA38:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DA40:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DA48:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DA50:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DA58:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DA60:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DA68:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DA70:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DA78:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DA80:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DA88:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DA90:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DA98:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DAA0:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DAA8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DAB0:         db $00, $00, $00, $FF, $FF, $FF, $FF, $FF
DATA_09DAB8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DAC0:         db $00, $00, $00, $BD, $BD, $BD, $BD, $BD
DATA_09DAC8:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DAD0:         db $00, $00, $00, $DB, $DB, $DB, $DB, $DB
DATA_09DAD8:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DAE0:         db $30, $00, $00, $E7, $E7, $E7, $E7, $E7
DATA_09DAE8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DAF0:         db $50, $00, $00, $E7, $E7, $E7, $E7, $E7
DATA_09DAF8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DB00:         db $90, $00, $00, $DB, $DB, $DB, $DB, $DB
DATA_09DB08:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DB10:         db $9F, $00, $00, $BD, $BD, $BD, $BD, $BD
DATA_09DB18:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DB20:         db $7D, $80, $00, $FF, $FF, $FF, $FF, $FF
DATA_09DB28:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DB30:         db $6C, $FF, $00, $FF, $FF, $FF, $FF, $FF
DATA_09DB38:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DB40:         db $48, $20, $C0, $BD, $BD, $BD, $BD, $BD
DATA_09DB48:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DB50:         db $48, $60, $60, $DB, $DB, $DB, $DB, $DB
DATA_09DB58:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DB60:         db $CC, $C0, $30, $E7, $E7, $E7, $E7, $E7
DATA_09DB68:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DB70:         db $87, $81, $10, $E7, $E7, $E7, $E7, $E7
DATA_09DB78:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DB80:         db $80, $03, $D0, $DB, $DB, $DB, $DB, $DB
DATA_09DB88:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DB90:         db $80, $04, $70, $BD, $BD, $BD, $BD, $BD
DATA_09DB98:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DBA0:         db $86, $08, $10, $FF, $FF, $FF, $FF, $FF
DATA_09DBA8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DBB0:         db $99, $88, $10, $FF, $FF, $FF, $FF, $FF
DATA_09DBB8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DBC0:         db $E0, $88, $10, $BD, $BD, $BD, $BD, $BD
DATA_09DBC8:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DBD0:         db $60, $C8, $20, $DB, $DB, $DB, $DB, $DB
DATA_09DBD8:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DBE0:         db $60, $4C, $60, $E7, $E7, $E7, $E7, $E7
DATA_09DBE8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DBF0:         db $60, $43, $C0, $E7, $E7, $E7, $E7, $E7
DATA_09DBF8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DC00:         db $30, $80, $80, $DB, $DB, $DB, $DB, $DB
DATA_09DC08:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DC10:         db $1F, $83, $00, $BD, $BD, $BD, $BD, $BD
DATA_09DC18:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DC20:         db $07, $FE, $00, $FF, $FF, $FF, $FF, $FF
DATA_09DC28:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DC30:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DC38:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DC40:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DC48:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DC50:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DC58:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DC60:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DC68:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DC70:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DC78:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DC80:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DC88:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DC90:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DC98:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DCA0:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DCA8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DCB0:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DCB8:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DCC0:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DCC8:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DCD0:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DCD8:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DCE0:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DCE8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DCF0:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DCF8:         db $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
DATA_09DD00:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DD08:         db $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB
DATA_09DD10:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DD18:         db $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD
DATA_09DD20:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DD28:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09DD30:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD38:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD40:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD48:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD50:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD58:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD60:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD68:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD70:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD78:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD80:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD88:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD90:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DD98:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDA0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDA8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDB0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDB8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDC0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDC8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDD0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDD8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDE0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDE8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDF0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DDF8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE00:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE08:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE10:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE18:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE20:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE28:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE30:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE38:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE40:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE48:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE50:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE58:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE60:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE68:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE70:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE78:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE80:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE88:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE90:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DE98:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEA0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEA8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEB0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEB8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEC0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEC8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DED0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DED8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEE0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEE8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEF0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DEF8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF00:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF08:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF10:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF18:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF20:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF28:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF30:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF38:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF40:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF48:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF50:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF58:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF60:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF68:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF70:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF78:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF80:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF88:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF90:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DF98:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFA0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFA8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFB0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFB8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFC0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFC8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFD0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFD8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFE0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFE8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFF0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09DFF8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E000:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E008:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E010:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E018:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E020:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E028:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E030:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E038:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E040:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E048:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E050:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E058:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E060:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E068:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E070:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E078:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E080:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E088:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E090:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E098:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0A0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0A8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0B0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0C0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0D0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0E0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0F0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E0F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E100:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E108:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E110:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E118:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E120:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E128:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E130:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E138:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E140:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E148:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E150:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E158:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E160:         db $00, $07, $E0, $00, $00, $05, $05, $00
DATA_09E168:         db $00, $05, $00, $0C, $0C, $00, $00, $00
DATA_09E170:         db $00, $04, $20, $10, $00, $05, $35, $00
DATA_09E178:         db $40, $05, $04, $08, $08, $00, $00, $00
DATA_09E180:         db $00, $04, $20, $10, $00, $00, $18, $00
DATA_09E188:         db $40, $80, $44, $08, $08, $00, $00, $00
DATA_09E190:         db $00, $3C, $3C, $FF, $00, $FE, $08, $00
DATA_09E198:         db $61, $84, $44, $18, $18, $00, $00, $00
DATA_09E1A0:         db $00, $21, $84, $10, $00, $0C, $08, $00
DATA_09E1A8:         db $27, $BF, $FF, $10, $10, $00, $00, $00
DATA_09E1B0:         db $00, $22, $44, $10, $00, $18, $18, $00
DATA_09E1B8:         db $3C, $82, $44, $10, $10, $00, $00, $00
DATA_09E1C0:         db $00, $22, $44, $10, $00, $30, $52, $7C
DATA_09E1C8:         db $30, $82, $44, $10, $10, $00, $00, $00
DATA_09E1D0:         db $00, $21, $84, $FF, $FF, $60, $DB, $C6
DATA_09E1D8:         db $60, $9E, $44, $10, $10, $00, $00, $00
DATA_09E1E0:         db $00, $3C, $3C, $08, $00, $40, $89, $02
DATA_09E1E8:         db $C0, $B3, $40, $00, $00, $00, $00, $00
DATA_09E1F0:         db $00, $04, $20, $08, $00, $40, $89, $06
DATA_09E1F8:         db $81, $A2, $40, $10, $10, $00, $00, $00
DATA_09E200:         db $00, $04, $20, $0C, $00, $63, $18, $0C
DATA_09E208:         db $C3, $B6, $63, $38, $38, $00, $00, $00
DATA_09E210:         db $00, $07, $E0, $04, $00, $3E, $30, $18
DATA_09E218:         db $7E, $1C, $3E, $30, $30, $00, $00, $00
DATA_09E220:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E228:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E230:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E238:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E240:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E248:         db $00, $00, $00, $02, $00, $00, $00, $00
DATA_09E250:         db $00, $00, $00, $18, $00, $00, $00, $00
DATA_09E258:         db $00, $00, $00, $02, $00, $00, $00, $00
DATA_09E260:         db $00, $00, $01, $9B, $E0, $00, $00, $00
DATA_09E268:         db $00, $00, $21, $02, $00, $00, $00, $00
DATA_09E270:         db $00, $00, $01, $9F, $F8, $00, $00, $00
DATA_09E278:         db $00, $00, $20, $81, $00, $00, $00, $00
DATA_09E280:         db $00, $00, $01, $CE, $0C, $00, $00, $00
DATA_09E288:         db $00, $00, $20, $81, $00, $00, $00, $00
DATA_09E290:         db $00, $00, $01, $D8, $06, $00, $00, $00
DATA_09E298:         db $00, $00, $10, $81, $00, $00, $00, $00
DATA_09E2A0:         db $00, $00, $30, $10, $02, $00, $00, $00
DATA_09E2A8:         db $00, $00, $08, $80, $80, $00, $00, $00
DATA_09E2B0:         db $00, $00, $4C, $10, $03, $00, $00, $00
DATA_09E2B8:         db $00, $00, $08, $40, $80, $00, $00, $00
DATA_09E2C0:         db $00, $00, $C3, $00, $03, $00, $00, $00
DATA_09E2C8:         db $00, $00, $08, $40, $80, $00, $00, $00
DATA_09E2D0:         db $00, $00, $8C, $80, $03, $00, $00, $00
DATA_09E2D8:         db $00, $00, $08, $40, $00, $00, $00, $00
DATA_09E2E0:         db $00, $00, $74, $00, $03, $00, $00, $00
DATA_09E2E8:         db $00, $00, $08, $40, $00, $00, $00, $00
DATA_09E2F0:         db $00, $00, $38, $00, $03, $00, $00, $00
DATA_09E2F8:         db $00, $00, $01, $E0, $0C, $00, $00, $00
DATA_09E300:         db $00, $00, $28, $00, $02, $00, $00, $00
DATA_09E308:         db $00, $00, $03, $31, $8C, $00, $00, $00
DATA_09E310:         db $00, $00, $68, $40, $02, $00, $00, $00
DATA_09E318:         db $00, $00, $02, $11, $98, $00, $00, $00
DATA_09E320:         db $00, $00, $78, $20, $0C, $00, $00, $00
DATA_09E328:         db $00, $00, $02, $1F, $B8, $00, $00, $00
DATA_09E330:         db $00, $00, $3C, $30, $08, $00, $00, $00
DATA_09E338:         db $00, $00, $03, $E3, $BF, $C0, $00, $00
DATA_09E340:         db $00, $00, $3C, $1C, $30, $00, $00, $00
DATA_09E348:         db $00, $00, $04, $C7, $10, $30, $00, $00
DATA_09E350:         db $00, $00, $0F, $07, $E0, $00, $00, $00
DATA_09E358:         db $00, $00, $09, $86, $20, $18, $00, $00
DATA_09E360:         db $00, $00, $03, $F2, $00, $00, $00, $00
DATA_09E368:         db $00, $00, $09, $02, $00, $08, $00, $00
DATA_09E370:         db $00, $00, $00, $63, $00, $00, $01, $00
DATA_09E378:         db $00, $00, $07, $0C, $00, $0C, $00, $00
DATA_09E380:         db $00, $00, $00, $41, $00, $00, $03, $00
DATA_09E388:         db $00, $00, $07, $18, $00, $04, $00, $00
DATA_09E390:         db $00, $00, $00, $81, $00, $03, $03, $00
DATA_09E398:         db $00, $00, $35, $88, $00, $04, $00, $00
DATA_09E3A0:         db $00, $00, $03, $C1, $00, $03, $C3, $80
DATA_09E3A8:         db $00, $00, $FB, $C8, $00, $04, $00, $00
DATA_09E3B0:         db $00, $00, $07, $40, $80, $03, $F7, $80
DATA_09E3B8:         db $00, $01, $09, $F8, $00, $04, $00, $00
DATA_09E3C0:         db $00, $00, $39, $40, $80, $03, $FF, $C0
DATA_09E3C8:         db $00, $01, $0F, $44, $00, $08, $00, $00
DATA_09E3D0:         db $00, $03, $C2, $71, $80, $07, $FF, $C0
DATA_09E3D8:         db $00, $01, $01, $C6, $00, $18, $00, $00
DATA_09E3E0:         db $00, $03, $06, $11, $00, $07, $FF, $E0
DATA_09E3E8:         db $00, $01, $80, $43, $00, $30, $00, $00
DATA_09E3F0:         db $00, $01, $06, $31, $00, $0F, $FF, $F0
DATA_09E3F8:         db $00, $00, $FE, $41, $80, $40, $00, $00
DATA_09E400:         db $00, $00, $C3, $E3, $00, $0F, $FF, $F8
DATA_09E408:         db $00, $40, $72, $C0, $E3, $80, $00, $00
DATA_09E410:         db $00, $00, $E0, $06, $00, $07, $FF, $FC
DATA_09E418:         db $00, $60, $03, $80, $DC, $00, $00, $00
DATA_09E420:         db $00, $00, $30, $18, $00, $01, $FF, $F8
DATA_09E428:         db $00, $78, $07, $00, $60, $04, $00, $00
DATA_09E430:         db $00, $00, $0F, $F0, $00, $00, $1F, $E0
DATA_09E438:         db $00, $20, $1C, $08, $20, $84, $00, $00
DATA_09E440:         db $00, $00, $00, $00, $00, $00, $1F, $80
DATA_09E448:         db $00, $20, $78, $3C, $21, $C3, $00, $00
DATA_09E450:         db $00, $00, $0E, $70, $00, $00, $1E, $00
DATA_09E458:         db $00, $20, $20, $3C, $23, $C0, $E0, $00
DATA_09E460:         db $00, $00, $1E, $50, $00, $00, $3E, $00
DATA_09E468:         db $00, $40, $20, $7C, $67, $C1, $80, $00
DATA_09E470:         db $00, $02, $32, $90, $00, $00, $38, $00
DATA_09E478:         db $00, $80, $30, $F8, $4F, $C2, $00, $00
DATA_09E480:         db $00, $04, $26, $90, $00, $00, $30, $00
DATA_09E488:         db $07, $C0, $19, $F8, $4F, $84, $00, $00
DATA_09E490:         db $00, $04, $24, $90, $00, $00, $00, $00
DATA_09E498:         db $00, $60, $0F, $E0, $9E, $0C, $00, $00
DATA_09E4A0:         db $00, $08, $28, $E0, $00, $00, $00, $00
DATA_09E4A8:         db $00, $10, $07, $E3, $1C, $08, $00, $00
DATA_09E4B0:         db $00, $18, $B0, $60, $00, $00, $00, $00
DATA_09E4B8:         db $00, $10, $03, $C6, $18, $38, $00, $00
DATA_09E4C0:         db $00, $11, $00, $00, $00, $00, $00, $00
DATA_09E4C8:         db $00, $3E, $03, $F8, $01, $CC, $00, $00
DATA_09E4D0:         db $00, $11, $00, $00, $00, $00, $00, $00
DATA_09E4D8:         db $00, $62, $E0, $00, $01, $02, $00, $00
DATA_09E4E0:         db $00, $11, $08, $00, $00, $00, $00, $00
DATA_09E4E8:         db $00, $C3, $B0, $00, $7A, $00, $00, $00
DATA_09E4F0:         db $00, $02, $10, $00, $00, $00, $00, $00
DATA_09E4F8:         db $00, $03, $17, $CF, $46, $00, $00, $00
DATA_09E500:         db $00, $02, $10, $00, $00, $00, $00, $00
DATA_09E508:         db $00, $04, $18, $69, $C3, $00, $00, $00
DATA_09E510:         db $00, $02, $20, $00, $00, $00, $00, $00
DATA_09E518:         db $00, $00, $08, $18, $41, $00, $00, $00
DATA_09E520:         db $00, $02, $20, $00, $00, $00, $00, $00
DATA_09E528:         db $00, $00, $00, $18, $00, $00, $00, $00
DATA_09E530:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E538:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E540:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E548:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E550:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E558:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E560:         db $00, $00, $05, $00, $00, $05, $00, $05
DATA_09E568:         db $00, $00, $00, $05, $0C, $0C, $00, $00
DATA_09E570:         db $00, $83, $15, $10, $00, $05, $20, $05
DATA_09E578:         db $30, $20, $FC, $05, $08, $08, $00, $00
DATA_09E580:         db $00, $C6, $10, $3E, $C0, $00, $26, $80
DATA_09E588:         db $1C, $20, $0C, $F8, $08, $08, $00, $00
DATA_09E590:         db $00, $6C, $FF, $63, $78, $FE, $F3, $84
DATA_09E598:         db $06, $AC, $18, $18, $18, $18, $00, $00
DATA_09E5A0:         db $00, $38, $10, $C1, $01, $0C, $41, $9F
DATA_09E5A8:         db $20, $BE, $30, $30, $10, $10, $00, $00
DATA_09E5B0:         db $00, $10, $10, $91, $01, $18, $C4, $82
DATA_09E5B8:         db $60, $B2, $3E, $60, $10, $10, $00, $00
DATA_09E5C0:         db $00, $10, $52, $1B, $03, $30, $84, $82
DATA_09E5C8:         db $3E, $A2, $03, $FF, $10, $10, $00, $00
DATA_09E5D0:         db $00, $30, $D2, $0E, $06, $60, $3C, $82
DATA_09E5D8:         db $03, $A6, $79, $18, $10, $10, $00, $00
DATA_09E5E0:         db $00, $20, $93, $06, $0C, $40, $66, $82
DATA_09E5E8:         db $01, $E4, $CD, $30, $00, $00, $00, $00
DATA_09E5F0:         db $00, $20, $91, $0C, $18, $40, $47, $C6
DATA_09E5F8:         db $03, $E6, $87, $20, $10, $10, $00, $00
DATA_09E600:         db $00, $20, $18, $18, $30, $63, $6D, $0C
DATA_09E608:         db $C6, $23, $C6, $33, $38, $38, $00, $00
DATA_09E610:         db $00, $20, $08, $30, $60, $3E, $38, $08
DATA_09E618:         db $7C, $20, $7C, $1E, $30, $30, $00, $00
DATA_09E620:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E628:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E630:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E638:         db $00, $00, $00, $07, $80, $00, $00, $00
DATA_09E640:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E648:         db $00, $80, $40, $18, $78, $00, $00, $00
DATA_09E650:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E658:         db $00, $86, $40, $20, $0F, $00, $00, $00
DATA_09E660:         db $00, $00, $00, $00, $00, $00, $00, $01
DATA_09E668:         db $C1, $1A, $C0, $00, $01, $80, $00, $00
DATA_09E670:         db $00, $00, $00, $00, $00, $00, $00, $01
DATA_09E678:         db $23, $08, $80, $00, $00, $C0, $00, $00
DATA_09E680:         db $00, $00, $00, $00, $00, $00, $00, $11
DATA_09E688:         db $25, $00, $00, $1F, $80, $60, $00, $00
DATA_09E690:         db $00, $00, $00, $00, $00, $00, $00, $13
DATA_09E698:         db $C9, $80, $00, $60, $60, $20, $00, $00
DATA_09E6A0:         db $00, $00, $00, $00, $00, $00, $00, $0C
DATA_09E6A8:         db $00, $80, $00, $40, $38, $00, $00, $00
DATA_09E6B0:         db $00, $00, $00, $00, $00, $00, $00, $18
DATA_09E6B8:         db $00, $80, $CC, $00, $0C, $0F, $C0, $00
DATA_09E6C0:         db $00, $00, $0D, $8F, $80, $00, $00, $29
DATA_09E6C8:         db $00, $00, $CC, $00, $06, $18, $E0, $00
DATA_09E6D0:         db $00, $00, $0D, $98, $C0, $00, $00, $45
DATA_09E6D8:         db $C0, $00, $CC, $01, $E0, $3C, $70, $00
DATA_09E6E0:         db $00, $00, $0F, $E0, $60, $00, $00, $12
DATA_09E6E8:         db $40, $33, $EC, $00, $18, $7C, $38, $00
DATA_09E6F0:         db $00, $00, $1D, $80, $20, $00, $00, $12
DATA_09E6F8:         db $00, $7E, $CD, $F8, $0C, $7C, $1C, $00
DATA_09E700:         db $00, $00, $2D, $80, $10, $00, $00, $18
DATA_09E708:         db $00, $88, $06, $0C, $04, $F8, $FC, $00
DATA_09E710:         db $00, $00, $E0, $00, $18, $00, $00, $00
DATA_09E718:         db $00, $90, $08, $02, $00, $C1, $EC, $00
DATA_09E720:         db $00, $01, $40, $00, $18, $00, $00, $00
DATA_09E728:         db $00, $B0, $10, $03, $00, $81, $EC, $00
DATA_09E730:         db $00, $01, $40, $80, $18, $00, $00, $00
DATA_09E738:         db $01, $E0, $00, $01, $00, $81, $EC, $00
DATA_09E740:         db $00, $0F, $C1, $80, $18, $02, $00, $00
DATA_09E748:         db $03, $20, $00, $01, $01, $B9, $CC, $00
DATA_09E750:         db $00, $3B, $43, $00, $18, $03, $00, $00
DATA_09E758:         db $02, $20, $00, $01, $01, $FC, $0C, $00
DATA_09E760:         db $00, $21, $E6, $00, $30, $03, $80, $00
DATA_09E768:         db $02, $20, $10, $01, $01, $DE, $1C, $00
DATA_09E770:         db $00, $71, $E2, $00, $30, $03, $80, $30
DATA_09E778:         db $03, $20, $70, $03, $00, $FE, $18, $00
DATA_09E780:         db $00, $79, $D3, $00, $60, $23, $80, $78
DATA_09E788:         db $C0, $F1, $C0, $02, $00, $FC, $70, $00
DATA_09E790:         db $00, $F9, $E9, $81, $C0, $7F, $C0, $49
DATA_09E798:         db $C0, $18, $C0, $06, $00, $7B, $E0, $00
DATA_09E7A0:         db $00, $F8, $FC, $E2, $60, $3F, $E0, $4D
DATA_09E7A8:         db $FF, $9C, $27, $84, $00, $1F, $C0, $00
DATA_09E7B0:         db $00, $B0, $2E, $3C, $90, $3F, $F0, $45
DATA_09E7B8:         db $7F, $F0, $3C, $8C, $00, $00, $00, $00
DATA_09E7C0:         db $00, $80, $24, $21, $30, $3F, $F8, $45
DATA_09E7C8:         db $20, $50, $78, $F8, $00, $00, $00, $00
DATA_09E7D0:         db $00, $80, $40, $99, $30, $3F, $FC, $43
DATA_09E7D8:         db $31, $A0, $00, $70, $00, $00, $00, $00
DATA_09E7E0:         db $00, $F0, $81, $0E, $30, $3F, $FC, $43
DATA_09E7E8:         db $3E, $60, $00, $18, $00, $00, $00, $00
DATA_09E7F0:         db $00, $7C, $82, $06, $70, $23, $F0, $63
DATA_09E7F8:         db $30, $41, $00, $08, $00, $00, $00, $00
DATA_09E800:         db $00, $7C, $CC, $02, $60, $03, $C0, $27
DATA_09E808:         db $1F, $81, $C0, $08, $00, $00, $00, $00
DATA_09E810:         db $00, $3C, $7C, $02, $60, $03, $80, $25
DATA_09E818:         db $80, $03, $FE, $18, $00, $00, $00, $00
DATA_09E820:         db $00, $1F, $C4, $01, $60, $03, $80, $2C
DATA_09E828:         db $80, $03, $03, $70, $00, $00, $00, $00
DATA_09E830:         db $00, $00, $04, $00, $C0, $03, $00, $30
DATA_09E838:         db $C0, $07, $00, $C0, $00, $00, $00, $00
DATA_09E840:         db $00, $00, $06, $00, $40, $02, $00, $00
DATA_09E848:         db $60, $06, $00, $00, $00, $00, $00, $00
DATA_09E850:         db $00, $00, $02, $00, $80, $00, $00, $00
DATA_09E858:         db $7C, $0C, $00, $00, $00, $00, $00, $00
DATA_09E860:         db $00, $00, $01, $07, $00, $00, $00, $00
DATA_09E868:         db $1F, $78, $00, $00, $00, $00, $00, $00
DATA_09E870:         db $00, $00, $07, $FC, $00, $00, $00, $00
DATA_09E878:         db $03, $C0, $00, $00, $00, $00, $00, $00
DATA_09E880:         db $00, $00, $1C, $20, $00, $00, $00, $00
DATA_09E888:         db $06, $3E, $00, $00, $00, $00, $00, $00
DATA_09E890:         db $00, $00, $20, $10, $00, $00, $00, $00
DATA_09E898:         db $0C, $01, $00, $00, $00, $00, $00, $00
DATA_09E8A0:         db $00, $00, $3F, $F0, $00, $00, $00, $00
DATA_09E8A8:         db $0F, $FF, $00, $00, $00, $00, $00, $00
DATA_09E8B0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8B8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8C0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8C8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8D0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8D8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8E0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8E8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8F0:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E8F8:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E900:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E908:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E910:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E918:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E920:         db $00, $00, $00, $00, $00, $00, $00, $00
DATA_09E928:         db $00, $00, $00, $00, $00, $00, $00

0009:E92F 3F DF        romb
0009:E931 BE 5E        add   r14
0009:E933 1E 5A        add   r10
0009:E935 1A EF        getb
0009:E937 DE           inc   r14
0009:E938 2A 3D EF     getbh
0009:E93B A0 02        ibt   r0,#0002
0009:E93D 4E           color
0009:E93E FD 88 E9     iwt   r13,#E988
0009:E941 02           cache
0009:E942 F3 FF 00     iwt   r3,#00FF
0009:E945 BA 1E 5B     add   r11
0009:E948 EF           getb
0009:E949 3E A0 1F     sms   (003E),r0
0009:E94C 3F 63        cmp   r3
0009:E94E 09 13        beq   E963
0009:E950 E3           dec   r3
0009:E951 3F 63        cmp   r3
0009:E953 09 0A        beq   E95F
0009:E955 E3           dec   r3
0009:E956 3F 63        cmp   r3
0009:E958 08 10        bne   E96A
0009:E95A 01           nop
0009:E95B FF AD E9     iwt   r15,#E9AD
0009:E95E 01           nop
0009:E95F DB           inc   r11
0009:E960 DE           inc   r14
0009:E961 18 EF        getb
0009:E963 DB           inc   r11
0009:E964 DE           inc   r14
0009:E965 19 EF        getb
0009:E967 DB           inc   r11
0009:E968 DE           inc   r14
0009:E969 EF           getb
0009:E96A DB           inc   r11
0009:E96B A6 0C        ibt   r6,#000C
0009:E96D 3D 9F        lmult
0009:E96F A0 09        ibt   r0,#0009
0009:E971 3F DF        romb
0009:E973 F0 2F BD     iwt   r0,#BD2F
0009:E976 1E 54        add   r4
0009:E978 A3 0C        ibt   r3,#000C
0009:E97A 28 12        move  r2,r8
0009:E97C AC 08        ibt   r12,#0008
0009:E97E 29 11        move  r1,r9
0009:E980 A0 00        ibt   r0,#0000
0009:E982 3E EF        getbl
0009:E984 15 4D        swap
0009:E986 09 0C        beq   E994
0009:E988 25 04        rol
0009:E98A 0C 05        bcc   E991
0009:E98C 01           nop
0009:E98D 4C           plot
0009:E98E 05 02        bra   E992

0009:E990 01           nop

0009:E991 D1           inc   r1
0009:E992 3C           loop
0009:E993 01           nop
0009:E994 E3           dec   r3
0009:E995 09 05        beq   E99C
0009:E997 D2           inc   r2
0009:E998 DE           inc   r14
0009:E999 05 E1        bra   E97C

0009:E99B 01           nop

0009:E99C 3D 4C        rpix
0009:E99E A0 09        ibt   r0,#0009
0009:E9A0 3F DF        romb
0009:E9A2 FE 2F BC     iwt   r14,#BC2F
0009:E9A5 3D A0 1F     lms   r0,(003E)
0009:E9A8 1E 5E        add   r14
0009:E9AA EF           getb
0009:E9AB 19 59        add   r9
0009:E9AD 00           stop
0009:E9AE 01           nop

0009:E9AF 02           cache
0009:E9B0 A0 00        ibt   r0,#0000
0009:E9B2 3D 4E        cmode
0009:E9B4 3E A0 58     sms   (00B0),r0
0009:E9B7 3D A0 55     lms   r0,(00AA)
0009:E9BA 3F DF        romb
0009:E9BC 3D AE 54     lms   r14,(00A8)
0009:E9BF 1B EF        getb
0009:E9C1 DE           inc   r14
0009:E9C2 3E AE 54     sms   (00A8),r14
0009:E9C5 2B 10        move  r0,r11
0009:E9C7 3E A0 1F     sms   (003E),r0
0009:E9CA F3 FF 00     iwt   r3,#00FF
0009:E9CD 3F 63        cmp   r3
0009:E9CF 09 35        beq   EA06
0009:E9D1 E3           dec   r3
0009:E9D2 3F 63        cmp   r3
0009:E9D4 09 1B        beq   E9F1
0009:E9D6 E3           dec   r3
0009:E9D7 3F 63        cmp   r3
0009:E9D9 09 16        beq   E9F1
0009:E9DB E3           dec   r3
0009:E9DC 3F 63        cmp   r3
0009:E9DE 09 11        beq   E9F1
0009:E9E0 E3           dec   r3
0009:E9E1 3F 63        cmp   r3
0009:E9E3 09 0C        beq   E9F1
0009:E9E5 E3           dec   r3
0009:E9E6 A3 FE        ibt   r3,#FFFE
0009:E9E8 3D A0 58     lms   r0,(00B0)
0009:E9EB 9E           lob
0009:E9EC 09 03        beq   E9F1
0009:E9EE 01           nop
0009:E9EF A3 F9        ibt   r3,#FFF9
0009:E9F1 D3           inc   r3
0009:E9F2 A0 09        ibt   r0,#0009
0009:E9F4 3F DF        romb
0009:E9F6 B3 95        sex
0009:E9F8 4F           not
0009:E9F9 50           add   r0
0009:E9FA FE 08 EA     iwt   r14,#EA08
0009:E9FD 1E 5E        add   r14
0009:E9FF EF           getb
0009:EA00 DE           inc   r14
0009:EA01 3D EF        getbh
0009:EA03 20 1F        move  r15,r0
0009:EA05 01           nop
0009:EA06 00           stop
0009:EA07 01           nop

DATA_09EA08:         dw $EA14
DATA_09EA0A:         dw $EA8D
DATA_09EA0C:         dw $EAB8
DATA_09EA0E:         dw $EACC
DATA_09EA10:         dw $EAE0
DATA_09EA12:         dw $EAE9

0009:EA14 A0 09        ibt   r0,#0009
0009:EA16 3F DF        romb
0009:EA18 A6 0C        ibt   r6,#000C
0009:EA1A BB 3D 9F     lmult
0009:EA1D FE 2F BD     iwt   r14,#BD2F
0009:EA20 BE 19 54     add   r4
0009:EA23 3D A5 56     lms   r5,(00AC)
0009:EA26 25 12        move  r2,r5
0009:EA28 A3 07        ibt   r3,#0007
0009:EA2A A4 7F        ibt   r4,#007F
0009:EA2C FD 47 EA     iwt   r13,#EA47
0009:EA2F 29 1E        move  r14,r9
0009:EA31 AC 08        ibt   r12,#0008
0009:EA33 3D A1 57     lms   r1,(00AE)
0009:EA36 EF           getb
0009:EA37 1A 4D        swap
0009:EA39 2E 3E 58     add   #08
0009:EA3C EF           getb
0009:EA3D 1B 4D        swap
0009:EA3F B3 3E 74     and   #04
0009:EA42 08 03        bne   EA47
0009:EA44 D9           inc   r9
0009:EA45 AB 00        ibt   r11,#0000
0009:EA47 A0 00        ibt   r0,#0000
0009:EA49 2B 04        rol
0009:EA4B 04           rol
0009:EA4C 2A 04        rol
0009:EA4E 04           rol
0009:EA4F 4E           color
0009:EA50 4C           plot
0009:EA51 21 74        and   r4
0009:EA53 08 05        bne   EA5A
0009:EA55 01           nop
0009:EA56 A0 20        ibt   r0,#0020
0009:EA58 12 52        add   r2
0009:EA5A 3C           loop
0009:EA5B 01           nop
0009:EA5C D5           inc   r5
0009:EA5D 25 12        move  r2,r5
0009:EA5F E3           dec   r3
0009:EA60 0A CD        bpl   EA2F
0009:EA62 01           nop
0009:EA63 FE 2F BC     iwt   r14,#BC2F
0009:EA66 3D A0 1F     lms   r0,(003E)
0009:EA69 1E 5E        add   r14
0009:EA6B EF           getb
0009:EA6C 3D A1 57     lms   r1,(00AE)
0009:EA6F 51           add   r1
0009:EA70 3E A0 57     sms   (00AE),r0
0009:EA73 A1 7F        ibt   r1,#007F
0009:EA75 3F 61        cmp   r1
0009:EA77 0C 0E        bcc   EA87
0009:EA79 01           nop
0009:EA7A 71           and   r1
0009:EA7B 3E A0 57     sms   (00AE),r0
0009:EA7E A0 20        ibt   r0,#0020
0009:EA80 3D A1 56     lms   r1,(00AC)
0009:EA83 51           add   r1
0009:EA84 3E A0 56     sms   (00AC),r0
0009:EA87 3D 4C        rpix
0009:EA89 FF B7 E9     iwt   r15,#E9B7
0009:EA8C 01           nop

0009:EA8D 3D A0 55     lms   r0,(00AA)
0009:EA90 3F DF        romb
0009:EA92 3D AE 54     lms   r14,(00A8)
0009:EA95 EF           getb
0009:EA96 4D           swap
0009:EA97 DE           inc   r14
0009:EA98 3E AE 54     sms   (00A8),r14
0009:EA9B F2 00 04     iwt   r2,#0400
0009:EA9E F1 00 4C     iwt   r1,#4C00
0009:EAA1 11 51        add   r1
0009:EAA3 22 51        add   r1
0009:EAA5 FC 80 00     iwt   r12,#0080
0009:EAA8 FD AD EA     iwt   r13,#EAAD
0009:EAAB A0 00        ibt   r0,#0000
0009:EAAD 31           stw   (r1)
0009:EAAE D1           inc   r1
0009:EAAF D1           inc   r1
0009:EAB0 32           stw   (r2)
0009:EAB1 D2           inc   r2
0009:EAB2 3C           loop
0009:EAB3 D2           inc   r2
0009:EAB4 FF B7 E9     iwt   r15,#E9B7
0009:EAB7 01           nop

0009:EAB8 3D A0 55     lms   r0,(00AA)
0009:EABB 3F DF        romb
0009:EABD 3D AE 54     lms   r14,(00A8)
0009:EAC0 EF           getb
0009:EAC1 DE           inc   r14
0009:EAC2 3E AE 54     sms   (00A8),r14
0009:EAC5 3E A0 56     sms   (00AC),r0
0009:EAC8 FF B7 E9     iwt   r15,#E9B7
0009:EACB 01           nop

0009:EACC 3D A0 55     lms   r0,(00AA)
0009:EACF 3F DF        romb
0009:EAD1 3D AE 54     lms   r14,(00A8)
0009:EAD4 EF           getb
0009:EAD5 DE           inc   r14
0009:EAD6 3E AE 54     sms   (00A8),r14
0009:EAD9 3E A0 57     sms   (00AE),r0
0009:EADC FF B7 E9     iwt   r15,#E9B7
0009:EADF 01           nop

0009:EAE0 A0 01        ibt   r0,#0001
0009:EAE2 3E A0 58     sms   (00B0),r0
0009:EAE5 FF B7 E9     iwt   r15,#E9B7
0009:EAE8 01           nop

0009:EAE9 A0 09        ibt   r0,#0009
0009:EAEB 3F DF        romb
0009:EAED A6 0C        ibt   r6,#000C
0009:EAEF BB 3D 9F     lmult
0009:EAF2 FE 2F BD     iwt   r14,#BD2F
0009:EAF5 BE 19 54     add   r4
0009:EAF8 3D A5 56     lms   r5,(00AC)
0009:EAFB A3 08        ibt   r3,#0008
0009:EAFD A4 7F        ibt   r4,#007F
0009:EAFF FD 14 EB     iwt   r13,#EB14
0009:EB02 AC 08        ibt   r12,#0008
0009:EB04 3D A1 57     lms   r1,(00AE)
0009:EB07 29 1E        move  r14,r9
0009:EB09 25 12        move  r2,r5
0009:EB0B EF           getb
0009:EB0C 1A 4D        swap
0009:EB0E 2E 3E 54     add   #04
0009:EB11 EF           getb
0009:EB12 1B 4D        swap
0009:EB14 A0 00        ibt   r0,#0000
0009:EB16 2B 04        rol
0009:EB18 04           rol
0009:EB19 2A 04        rol
0009:EB1B 04           rol
0009:EB1C 4E           color
0009:EB1D 4C           plot
0009:EB1E 4C           plot
0009:EB1F 21 74        and   r4
0009:EB21 08 05        bne   EB28
0009:EB23 01           nop
0009:EB24 A0 20        ibt   r0,#0020
0009:EB26 12 52        add   r2
0009:EB28 3C           loop
0009:EB29 01           nop
0009:EB2A E3           dec   r3
0009:EB2B 09 09        beq   EB36
0009:EB2D B3 3E 71     and   #01
0009:EB30 08 D0        bne   EB02
0009:EB32 D5           inc   r5
0009:EB33 05 CD        bra   EB02

0009:EB35 D9           inc   r9

0009:EB36 A0 01        ibt   r0,#0001
0009:EB38 4E           color
0009:EB39 D5           inc   r5
0009:EB3A D9           inc   r9
0009:EB3B D9           inc   r9
0009:EB3C D9           inc   r9
0009:EB3D D9           inc   r9
0009:EB3E D9           inc   r9
0009:EB3F A3 08        ibt   r3,#0008
0009:EB41 FD 50 EB     iwt   r13,#EB50
0009:EB44 AC 08        ibt   r12,#0008
0009:EB46 3D A1 57     lms   r1,(00AE)
0009:EB49 29 1E        move  r14,r9
0009:EB4B 25 12        move  r2,r5
0009:EB4D EF           getb
0009:EB4E 1A 4D        swap
0009:EB50 2A 04        rol
0009:EB52 0C 05        bcc   EB59
0009:EB54 01           nop
0009:EB55 4C           plot
0009:EB56 4C           plot
0009:EB57 E1           dec   r1
0009:EB58 E1           dec   r1
0009:EB59 D1           inc   r1
0009:EB5A D1           inc   r1
0009:EB5B 21 74        and   r4
0009:EB5D 08 05        bne   EB64
0009:EB5F 01           nop
0009:EB60 A0 20        ibt   r0,#0020
0009:EB62 12 52        add   r2
0009:EB64 3C           loop
0009:EB65 01           nop
0009:EB66 E3           dec   r3
0009:EB67 09 09        beq   EB72
0009:EB69 B3 3E 71     and   #01
0009:EB6C 08 D6        bne   EB44
0009:EB6E D5           inc   r5
0009:EB6F 05 D3        bra   EB44

0009:EB71 D9           inc   r9

0009:EB72 FE 2F BC     iwt   r14,#BC2F
0009:EB75 3D A0 1F     lms   r0,(003E)
0009:EB78 1E 5E        add   r14
0009:EB7A 11 EF        getb
0009:EB7C 3D A0 57     lms   r0,(00AE)
0009:EB7F 51           add   r1
0009:EB80 51           add   r1
0009:EB81 3E A0 57     sms   (00AE),r0
0009:EB84 A1 7F        ibt   r1,#007F
0009:EB86 3F 61        cmp   r1
0009:EB88 0C 0E        bcc   EB98
0009:EB8A 01           nop
0009:EB8B 71           and   r1
0009:EB8C 3E A0 57     sms   (00AE),r0
0009:EB8F A0 20        ibt   r0,#0020
0009:EB91 3D A1 56     lms   r1,(00AC)
0009:EB94 51           add   r1
0009:EB95 3E A0 56     sms   (00AC),r0
0009:EB98 3D 4C        rpix
0009:EB9A FF B7 E9     iwt   r15,#E9B7
0009:EB9D 01           nop
0009:EB9E 02           cache
0009:EB9F A0 11        ibt   r0,#0011
0009:EBA1 3D 4E        cmode
0009:EBA3 3D A0 14     lms   r0,(0028)
0009:EBA6 4E           color
0009:EBA7 A1 00        ibt   r1,#0000
0009:EBA9 A2 00        ibt   r2,#0000
0009:EBAB A3 7F        ibt   r3,#007F
0009:EBAD AC 10        ibt   r12,#0010
0009:EBAF FD B2 EB     iwt   r13,#EBB2
0009:EBB2 4C           plot
0009:EBB3 21 73        and   r3
0009:EBB5 08 FB        bne   EBB2
0009:EBB7 01           nop
0009:EBB8 3C           loop
0009:EBB9 D2           inc   r2
0009:EBBA 3D A0 15     lms   r0,(002A)
0009:EBBD 4E           color
0009:EBBE A1 00        ibt   r1,#0000
0009:EBC0 A2 00        ibt   r2,#0000
0009:EBC2 4C           plot
0009:EBC3 A1 00        ibt   r1,#0000
0009:EBC5 A2 0F        ibt   r2,#000F
0009:EBC7 4C           plot
0009:EBC8 A1 67        ibt   r1,#0067
0009:EBCA A2 00        ibt   r2,#0000
0009:EBCC 4C           plot
0009:EBCD A1 67        ibt   r1,#0067
0009:EBCF A2 0F        ibt   r2,#000F
0009:EBD1 4C           plot
0009:EBD2 3D A0 16     lms   r0,(002C)
0009:EBD5 4E           color
0009:EBD6 FD 24 EC     iwt   r13,#EC24
0009:EBD9 F1 FF 00     iwt   r1,#00FF
0009:EBDC 3D A0 11     lms   r0,(0022)
0009:EBDF 3F DF        romb
0009:EBE1 3D AE 10     lms   r14,(0020)
0009:EBE4 EF           getb
0009:EBE5 DE           inc   r14
0009:EBE6 3E AE 10     sms   (0020),r14
0009:EBE9 3F 61        cmp   r1
0009:EBEB 08 1C        bne   EC09
0009:EBED 01           nop
0009:EBEE EF           getb
0009:EBEF DE           inc   r14
0009:EBF0 3E AE 10     sms   (0020),r14
0009:EBF3 3F 61        cmp   r1
0009:EBF5 08 03        bne   EBFA
0009:EBF7 01           nop
0009:EBF8 00           stop
0009:EBF9 01           nop

0009:EBFA 95           sex
0009:EBFB 0B 44        bmi   EC41
0009:EBFD 1A 9E        lob
0009:EBFF EF           getb
0009:EC00 1B 9E        lob
0009:EC02 DE           inc   r14
0009:EC03 3E AE 10     sms   (0020),r14
0009:EC06 05 D1        bra   EBD9

0009:EC08 01           nop
0009:EC09 3E A0 1F     sms   (003E),r0
0009:EC0C A6 0C        ibt   r6,#000C
0009:EC0E 3D 9F        lmult
0009:EC10 A0 09        ibt   r0,#0009
0009:EC12 3F DF        romb
0009:EC14 F0 2F BD     iwt   r0,#BD2F
0009:EC17 1E 54        add   r4
0009:EC19 2B 12        move  r2,r11
0009:EC1B AC 08        ibt   r12,#0008
0009:EC1D EF           getb
0009:EC1E 9E           lob
0009:EC1F 13 4D        swap
0009:EC21 DE           inc   r14
0009:EC22 2A 11        move  r1,r10
0009:EC24 23 04        rol
0009:EC26 0C 03        bcc   EC2B
0009:EC28 01           nop
0009:EC29 4C           plot
0009:EC2A E1           dec   r1
0009:EC2B 3C           loop
0009:EC2C D1           inc   r1
0009:EC2D E6           dec   r6
0009:EC2E 08 EB        bne   EC1B
0009:EC30 D2           inc   r2
0009:EC31 3D 4C        rpix
0009:EC33 FE 2F BC     iwt   r14,#BC2F
0009:EC36 3D A0 1F     lms   r0,(003E)
0009:EC39 1E 5E        add   r14
0009:EC3B EF           getb
0009:EC3C 1A 5A        add   r10
0009:EC3E 05 99        bra   EBD9

0009:EC40 01           nop

0009:EC41 02           cache
0009:EC42 A0 11        ibt   r0,#0011
0009:EC44 3D 4E        cmode
0009:EC46 3D A0 12     lms   r0,(0024)
0009:EC49 4E           color
0009:EC4A A1 00        ibt   r1,#0000
0009:EC4C A2 10        ibt   r2,#0010
0009:EC4E A3 7F        ibt   r3,#007F
0009:EC50 AC 30        ibt   r12,#0030
0009:EC52 FD 55 EC     iwt   r13,#EC55
0009:EC55 4C           plot
0009:EC56 21 73        and   r3
0009:EC58 08 FB        bne   EC55
0009:EC5A 01           nop
0009:EC5B 3C           loop
0009:EC5C D2           inc   r2
0009:EC5D 3D A0 13     lms   r0,(0026)
0009:EC60 4E           color
0009:EC61 FD AD EC     iwt   r13,#ECAD
0009:EC64 F1 FF 00     iwt   r1,#00FF
0009:EC67 3D A0 11     lms   r0,(0022)
0009:EC6A 3F DF        romb
0009:EC6C 3D AE 10     lms   r14,(0020)
0009:EC6F EF           getb
0009:EC70 DE           inc   r14
0009:EC71 3E AE 10     sms   (0020),r14
0009:EC74 3F 61        cmp   r1
0009:EC76 08 16        bne   EC8E
0009:EC78 01           nop
0009:EC79 EF           getb
0009:EC7A DE           inc   r14
0009:EC7B 3E AE 10     sms   (0020),r14
0009:EC7E 3F 61        cmp   r1
0009:EC80 09 54        beq   ECD6
0009:EC82 1A 9E        lob
0009:EC84 EF           getb
0009:EC85 1B 9E        lob
0009:EC87 DE           inc   r14
0009:EC88 3E AE 10     sms   (0020),r14
0009:EC8B 05 D7        bra   EC64

0009:EC8D 01           nop

0009:EC8E 3E A0 1F     sms   (003E),r0
0009:EC91 A6 0C        ibt   r6,#000C
0009:EC93 3D 9F        lmult
0009:EC95 A0 09        ibt   r0,#0009
0009:EC97 3F DF        romb
0009:EC99 F0 2F BD     iwt   r0,#BD2F
0009:EC9C 1E 54        add   r4
0009:EC9E 2B 12        move  r2,r11
0009:ECA0 22 15        move  r5,r2
0009:ECA2 25 12        move  r2,r5
0009:ECA4 AC 08        ibt   r12,#0008
0009:ECA6 EF           getb
0009:ECA7 9E           lob
0009:ECA8 13 4D        swap
0009:ECAA DE           inc   r14
0009:ECAB 2A 11        move  r1,r10
0009:ECAD 23 04        rol
0009:ECAF 0C 03        bcc   ECB4
0009:ECB1 01           nop
0009:ECB2 4C           plot
0009:ECB3 E1           dec   r1
0009:ECB4 D1           inc   r1
0009:ECB5 A0 7F        ibt   r0,#007F
0009:ECB7 71           and   r1
0009:ECB8 08 05        bne   ECBF
0009:ECBA 01           nop
0009:ECBB A0 10        ibt   r0,#0010
0009:ECBD 12 52        add   r2
0009:ECBF 3C           loop
0009:ECC0 01           nop
0009:ECC1 D5           inc   r5
0009:ECC2 E6           dec   r6
0009:ECC3 08 DD        bne   ECA2
0009:ECC5 01           nop
0009:ECC6 3D 4C        rpix
0009:ECC8 FE 2F BC     iwt   r14,#BC2F
0009:ECCB 3D A0 1F     lms   r0,(003E)
0009:ECCE 1E 5E        add   r14
0009:ECD0 EF           getb
0009:ECD1 1A 5A        add   r10
0009:ECD3 05 8F        bra   EC64

0009:ECD5 01           nop

0009:ECD6 00           stop
0009:ECD7 01           nop

0009:ECD8 02           cache
0009:ECD9 A0 11        ibt   r0,#0011
0009:ECDB 3D 4E        cmode
0009:ECDD A0 09        ibt   r0,#0009
0009:ECDF 3F DF        romb
0009:ECE1 FE 2F BD     iwt   r14,#BD2F
0009:ECE4 A0 01        ibt   r0,#0001
0009:ECE6 4E           color
0009:ECE7 EF           getb
0009:ECE8 4D           swap
0009:ECE9 DE           inc   r14
0009:ECEA A3 00        ibt   r3,#0000
0009:ECEC A4 04        ibt   r4,#0004
0009:ECEE FB 08 00     iwt   r11,#0008
0009:ECF1 FD F6 EC     iwt   r13,#ECF6
0009:ECF4 AC 08        ibt   r12,#0008
0009:ECF6 AA 0C        ibt   r10,#000C
0009:ECF8 24 12        move  r2,r4
0009:ECFA 23 11        move  r1,r3
0009:ECFC 50           add   r0
0009:ECFD 0C 03        bcc   ED02
0009:ECFF D1           inc   r1
0009:ED00 E1           dec   r1
0009:ED01 4C           plot
0009:ED02 20 B0        moves r0,r0
0009:ED04 08 F6        bne   ECFC
0009:ED06 01           nop
0009:ED07 EF           getb
0009:ED08 4D           swap
0009:ED09 DE           inc   r14
0009:ED0A D2           inc   r2
0009:ED0B EA           dec   r10
0009:ED0C 08 ED        bne   ECFB
0009:ED0E 23 3E 58     add   #08
0009:ED11 3C           loop
0009:ED12 24 3E 5F     add   #0F
0009:ED15 D4           inc   r4
0009:ED16 A3 00        ibt   r3,#0000
0009:ED18 EB           dec   r11
0009:ED19 08 D9        bne   ECF4
0009:ED1B 01           nop
0009:ED1C A3 40        ibt   r3,#0040
0009:ED1E A4 04        ibt   r4,#0004
0009:ED20 FB 08 00     iwt   r11,#0008
0009:ED23 FD 28 ED     iwt   r13,#ED28
0009:ED26 AC 08        ibt   r12,#0008
0009:ED28 AA 0C        ibt   r10,#000C
0009:ED2A 24 12        move  r2,r4
0009:ED2C 23 11        move  r1,r3
0009:ED2E 50           add   r0
0009:ED2F 0C 03        bcc   ED34
0009:ED31 D1           inc   r1
0009:ED32 E1           dec   r1
0009:ED33 4C           plot
0009:ED34 20 B0        moves r0,r0
0009:ED36 08 F6        bne   ED2E
0009:ED38 01           nop
0009:ED39 EF           getb
0009:ED3A 4D           swap
0009:ED3B DE           inc   r14
0009:ED3C D2           inc   r2
0009:ED3D EA           dec   r10
0009:ED3E 08 ED        bne   ED2D
0009:ED40 23 3E 58     add   #08
0009:ED43 3C           loop
0009:ED44 24 3E 5F     add   #0F
0009:ED47 D4           inc   r4
0009:ED48 A3 40        ibt   r3,#0040
0009:ED4A EB           dec   r11
0009:ED4B 08 D9        bne   ED26
0009:ED4D 01           nop
0009:ED4E F3 80 00     iwt   r3,#0080
0009:ED51 A4 04        ibt   r4,#0004
0009:ED53 FB 08 00     iwt   r11,#0008
0009:ED56 FD 5B ED     iwt   r13,#ED5B
0009:ED59 AC 08        ibt   r12,#0008
0009:ED5B AA 0C        ibt   r10,#000C
0009:ED5D 24 12        move  r2,r4
0009:ED5F 23 11        move  r1,r3
0009:ED61 50           add   r0
0009:ED62 0C 03        bcc   ED67
0009:ED64 D1           inc   r1
0009:ED65 E1           dec   r1
0009:ED66 4C           plot
0009:ED67 20 B0        moves r0,r0
0009:ED69 08 F6        bne   ED61
0009:ED6B 01           nop
0009:ED6C EF           getb
0009:ED6D 4D           swap
0009:ED6E DE           inc   r14
0009:ED6F D2           inc   r2
0009:ED70 EA           dec   r10
0009:ED71 08 ED        bne   ED60
0009:ED73 23 3E 58     add   #08
0009:ED76 3C           loop
0009:ED77 24 3E 5F     add   #0F
0009:ED7A D4           inc   r4
0009:ED7B F3 80 00     iwt   r3,#0080
0009:ED7E EB           dec   r11
0009:ED7F 08 D8        bne   ED59
0009:ED81 01           nop
0009:ED82 F3 C0 00     iwt   r3,#00C0
0009:ED85 A4 04        ibt   r4,#0004
0009:ED87 FB 08 00     iwt   r11,#0008
0009:ED8A FD 8F ED     iwt   r13,#ED8F
0009:ED8D AC 08        ibt   r12,#0008
0009:ED8F AA 0C        ibt   r10,#000C
0009:ED91 24 12        move  r2,r4
0009:ED93 23 11        move  r1,r3
0009:ED95 50           add   r0
0009:ED96 0C 03        bcc   ED9B
0009:ED98 D1           inc   r1
0009:ED99 E1           dec   r1
0009:ED9A 4C           plot
0009:ED9B 20 B0        moves r0,r0
0009:ED9D 08 F6        bne   ED95
0009:ED9F 01           nop
0009:EDA0 EF           getb
0009:EDA1 4D           swap
0009:EDA2 DE           inc   r14
0009:EDA3 D2           inc   r2
0009:EDA4 EA           dec   r10
0009:EDA5 08 ED        bne   ED94
0009:EDA7 23 3E 58     add   #08
0009:EDAA 3C           loop
0009:EDAB 24 3E 5F     add   #0F
0009:EDAE D4           inc   r4
0009:EDAF F3 C0 00     iwt   r3,#00C0
0009:EDB2 EB           dec   r11
0009:EDB3 08 D8        bne   ED8D
0009:EDB5 01           nop
0009:EDB6 3D 4C        rpix
0009:EDB8 FA 01 1C     iwt   r10,#1C01
0009:EDBB FB 00 3C     iwt   r11,#3C00
0009:EDBE FC 00 20     iwt   r12,#2000
0009:EDC1 2F 1D        move  r13,r15
0009:EDC3 3D 4B        ldb   (r11)
0009:EDC5 3D 3A        stb   (r10)
0009:EDC7 DB           inc   r11
0009:EDC8 DB           inc   r11
0009:EDC9 DA           inc   r10
0009:EDCA 3C           loop
0009:EDCB DA           inc   r10
0009:EDCC 00           stop
0009:EDCD 01           nop

; freespace
DATA_09EDCE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EDD6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EDDE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EDE6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EDEE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EDF6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EDFE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE06:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE0E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE16:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE1E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE26:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE2E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE36:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE3E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE46:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE4E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE56:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE5E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE66:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE6E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE76:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE7E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE86:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE8E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE96:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EE9E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEA6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEAE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEB6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEBE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEC6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EECE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EED6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEDE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEE6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEEE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEF6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EEFE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF06:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF0E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF16:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF1E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF26:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF2E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF36:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF3E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF46:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF4E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF56:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF5E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF66:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF6E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF76:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF7E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF86:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF8E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF96:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EF9E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFA6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFAE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFB6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFBE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFC6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFCE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFD6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFDE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFE6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFEE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFF6:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09EFFE:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F006:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F00E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F016:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F01E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F026:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F02E:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F036:         db $01, $01, $01, $01, $01, $01, $01, $01

0009:F03E 60           sub   r0
0009:F03F 3D 4E        cmode
0009:F041 3E A1 01     sms   (0002),r1
0009:F044 3E A2 02     sms   (0004),r2
0009:F047 3E A3 03     sms   (0006),r3
0009:F04A 02           cache
0009:F04B 45           ldw   (r5)
0009:F04C D0           inc   r0
0009:F04D 08 05        bne   F054
0009:F04F E0           dec   r0
0009:F050 3D 4C        rpix
0009:F052 00           stop
0009:F053 01           nop

0009:F054 61           sub   r1
0009:F055 0B 08        bmi   F05F
0009:F057 D5           inc   r5
0009:F058 F6 C0 01     iwt   r6,#01C0
0009:F05B 66           sub   r6
0009:F05C 0C 07        bcc   F065
0009:F05E 56           add   r6
0009:F05F 25 3E 55     add   #05
0009:F062 05 E8        bra   F04C

0009:F064 45           ldw   (r5)

0009:F065 20 17        move  r7,r0
0009:F067 F6 40 00     iwt   r6,#0040
0009:F06A 56           add   r6
0009:F06B 50           add   r0
0009:F06C F6 00 12     iwt   r6,#1200
0009:F06F 56           add   r6
0009:F070 16 40        ldw   (r0)
0009:F072 D5           inc   r5
0009:F073 3D 45        ldb   (r5)
0009:F075 95           sex
0009:F076 63           sub   r3
0009:F077 3D 9F        lmult
0009:F079 24 C0        hib
0009:F07B 9E           lob
0009:F07C 4D           swap
0009:F07D C4           or    r4
0009:F07E A4 60        ibt   r4,#0060
0009:F080 13 54        add   r4
0009:F082 D5           inc   r5
0009:F083 3D 45        ldb   (r5)
0009:F085 95           sex
0009:F086 62           sub   r2
0009:F087 3D 9F        lmult
0009:F089 24 C0        hib
0009:F08B 9E           lob
0009:F08C 4D           swap
0009:F08D C4           or    r4
0009:F08E A4 20        ibt   r4,#0020
0009:F090 12 54        add   r4
0009:F092 D5           inc   r5
0009:F093 3D 45        ldb   (r5)
0009:F095 50           add   r0
0009:F096 50           add   r0
0009:F097 3D 9F        lmult
0009:F099 24 C0        hib
0009:F09B 9E           lob
0009:F09C 4D           swap
0009:F09D 16 C4        or    r4
0009:F09F A0 09        ibt   r0,#0009
0009:F0A1 3F DF        romb
0009:F0A3 D5           inc   r5
0009:F0A4 3D 45        ldb   (r5)
0009:F0A6 3E A5 25     sms   (004A),r5
0009:F0A9 F4 C0 00     iwt   r4,#00C0
0009:F0AC 15 74        and   r4
0009:F0AE 3D 74        bic   r4
0009:F0B0 3E 87        mult  #07
0009:F0B2 FE 3E F4     iwt   r14,#F43E
0009:F0B5 1E 5E        add   r14
0009:F0B7 B7 03        lsr
0009:F0B9 03           lsr
0009:F0BA 03           lsr
0009:F0BB A4 30        ibt   r4,#0030
0009:F0BD 74           and   r4
0009:F0BE 15 C5        or    r5
0009:F0C0 EF           getb
0009:F0C1 DE           inc   r14
0009:F0C2 4D           swap
0009:F0C3 9F           fmult
0009:F0C4 3D 53        adc   r3
0009:F0C6 20 13        move  r3,r0
0009:F0C8 F1 C0 00     iwt   r1,#00C0
0009:F0CB 61           sub   r1
0009:F0CC 0A 1F        bpl   F0ED
0009:F0CE EF           getb
0009:F0CF DE           inc   r14
0009:F0D0 4D           swap
0009:F0D1 9F           fmult
0009:F0D2 3D 52        adc   r2
0009:F0D4 20 12        move  r2,r0
0009:F0D6 F8 80 00     iwt   r8,#0080
0009:F0D9 68           sub   r8
0009:F0DA 0A 11        bpl   F0ED
0009:F0DC EF           getb
0009:F0DD DE           inc   r14
0009:F0DE 4D           swap
0009:F0DF 9F           fmult
0009:F0E0 19 53        add   r3
0009:F0E2 0B 09        bmi   F0ED
0009:F0E4 EF           getb
0009:F0E5 DE           inc   r14
0009:F0E6 4D           swap
0009:F0E7 9F           fmult
0009:F0E8 1A 52        add   r2
0009:F0EA 0A 07        bpl   F0F3
0009:F0EC EF           getb
0009:F0ED FF 80 F1     iwt   r15,#F180
0009:F0F0 3D A1 01     lms   r1,(0002)
0009:F0F3 DE           inc   r14
0009:F0F4 1B 3D EF     getbh
0009:F0F7 DE           inc   r14
0009:F0F8 A7 01        ibt   r7,#0001
0009:F0FA 60           sub   r0
0009:F0FB 20 14        move  r4,r0
0009:F0FD AC 20        ibt   r12,#0020
0009:F0FF FD 03 F1     iwt   r13,#F103
0009:F102 24 54        add   r4
0009:F104 27 57        add   r7
0009:F106 04           rol
0009:F107 66           sub   r6
0009:F108 0C 03        bcc   F10D
0009:F10A 56           add   r6
0009:F10B 66           sub   r6
0009:F10C D4           inc   r4
0009:F10D 3C           loop
0009:F10E 24 24 16     move  r6,r4
0009:F111 EF           getb
0009:F112 A4 7F        ibt   r4,#007F
0009:F114 74           and   r4
0009:F115 3F DF        romb
0009:F117 3F EF        getbs
0009:F119 F4 00 80     iwt   r4,#8000
0009:F11C 74           and   r4
0009:F11D 15 C5        or    r5
0009:F11F A7 00        ibt   r7,#0000
0009:F121 20 B2        moves r0,r2
0009:F123 0A 08        bpl   F12D
0009:F125 4F           not
0009:F126 D0           inc   r0
0009:F127 3D 9F        lmult
0009:F129 24 17        move  r7,r4
0009:F12B A2 00        ibt   r2,#0000
0009:F12D A4 00        ibt   r4,#0000
0009:F12F 20 B3        moves r0,r3
0009:F131 0A 06        bpl   F139
0009:F133 4F           not
0009:F134 D0           inc   r0
0009:F135 3D 9F        lmult
0009:F137 A3 00        ibt   r3,#0000
0009:F139 E1           dec   r1
0009:F13A B1 69        sub   r9
0009:F13C 0C 02        bcc   F140
0009:F13E 59           add   r9
0009:F13F B9 19 63     sub   r3
0009:F142 D9           inc   r9
0009:F143 E8           dec   r8
0009:F144 B8 6A        sub   r10
0009:F146 0C 02        bcc   F14A
0009:F148 5A           add   r10
0009:F149 BA 1A 62     sub   r2
0009:F14C DA           inc   r10
0009:F14D FD 56 F1     iwt   r13,#F156
0009:F150 23 11        move  r1,r3
0009:F152 24 18        move  r8,r4
0009:F154 29 1C        move  r12,r9
0009:F156 70           merge
0009:F157 1E 5B        add   r11
0009:F159 28 56        add   r6
0009:F15B 25 B5        moves r5,r5
0009:F15D 0A 05        bpl   F164
0009:F15F EF           getb
0009:F160 03           lsr
0009:F161 03           lsr
0009:F162 03           lsr
0009:F163 03           lsr
0009:F164 3E 7F        and   #0F
0009:F166 09 0F        beq   F177
0009:F168 55           add   r5
0009:F169 4E           color
0009:F16A 3C           loop
0009:F16B 4C           plot
0009:F16C 27 56        add   r6
0009:F16E EA           dec   r10
0009:F16F 08 DF        bne   F150
0009:F171 D2           inc   r2
0009:F172 05 0C        bra   F180

0009:F174 3D A1 01     lms   r1,(0002)
0009:F177 3C           loop
0009:F178 D1           inc   r1
0009:F179 27 56        add   r6
0009:F17B EA           dec   r10
0009:F17C 08 D2        bne   F150
0009:F17E D2           inc   r2
0009:F17F 3D A1 01     lms   r1,(0002)
0009:F182 3D A2 02     lms   r2,(0004)
0009:F185 3D A3 03     lms   r3,(0006)
0009:F188 3D A5 25     lms   r5,(004A)
0009:F18B FF 4B F0     iwt   r15,#F04B
0009:F18E D5           inc   r5

; freespace
DATA_09F18F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F197:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F19F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1A7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1AF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1B7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1BF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1C7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1CF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1D7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1DF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1E7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1EF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1F7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F1FF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F207:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F20F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F217:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F21F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F227:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F22F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F237:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F23F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F247:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F24F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F257:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F25F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F267:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F26F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F277:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F27F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F287:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F28F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F297:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F29F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2A7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2AF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2B7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2BF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2C7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2CF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2D7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2DF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2E7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2EF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2F7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F2FF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F307:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F30F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F317:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F31F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F327:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F32F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F337:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F33F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F347:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F34F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F357:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F35F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F367:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F36F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F377:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F37F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F387:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F38F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F397:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F39F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3A7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3AF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3B7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3BF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3C7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3CF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3D7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3DF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3E7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3EF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3F7:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F3FF:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F407:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F40F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F417:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F41F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F427:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F42F:         db $01, $01, $01, $01, $01, $01, $01, $01
DATA_09F437:         db $01, $01, $01, $01, $01, $01, $01

DATA_09F43E:         db $F4, $F0, $18, $28, $00, $C0, $D5, $E8
DATA_09F446:         db $F3, $2F, $28, $18, $C0, $D5, $E4, $FA
DATA_09F44E:         db $37, $1F, $80, $80, $D5, $E0, $05, $3F
DATA_09F456:         db $0F, $40, $80, $D5, $E4, $04, $37, $17
DATA_09F45E:         db $30, $E8, $D5, $F0, $04, $1F, $1F, $60
DATA_09F466:         db $A0, $D5, $F0, $04, $20, $1F, $20, $80
DATA_09F46E:         db $D5, $F0, $01, $20, $1F, $00, $80, $D5
DATA_09F476:         db $E8, $05, $2F, $10, $40, $90, $D5, $E8
DATA_09F47E:         db $02, $2F, $17, $00, $E8, $D5, $E8, $FF
DATA_09F486:         db $30, $17, $30, $A0, $D5, $E8, $F9, $2F
DATA_09F48E:         db $1F, $00, $A0, $D5, $F4, $F0, $17, $28
DATA_09F496:         db $48, $C0, $D5, $E8, $C0, $2F, $3F, $00
DATA_09F49E:         db $80, $55, $F8, $E8, $0F, $17, $30, $A8
DATA_09F4A6:         db $55, $E8, $C0, $2F, $3F, $80, $80, $55
DATA_09F4AE:         db $E8, $E8, $2F, $27, $30, $80, $55, $F0
DATA_09F4B6:         db $D0, $1F, $2F, $60, $80, $55, $F0, $F4
DATA_09F4BE:         db $1F, $17, $40, $A8, $55, $F0, $F8, $1F
DATA_09F4C6:         db $0F, $60, $B0, $55, $C0, $C8, $7F, $37
DATA_09F4CE:         db $80, $C8, $D5, $D8, $C0, $4F, $47, $B0
DATA_09F4D6:         db $80, $55, $C0, $F8, $7F, $17, $80, $E8
DATA_09F4DE:         db $55, $D8, $E0, $50, $40, $30, $C0, $55
DATA_09F4E6:         db $E8, $E0, $2F, $3F, $00, $C0, $55, $DC
DATA_09F4EE:         db $DC, $47, $47, $B8, $80, $D5, $F8, $F4
DATA_09F4F6:         db $10, $18, $60, $C0, $D5, $F8, $F4, $10
DATA_09F4FE:         db $18, $70, $C0, $D5, $F8, $F4, $10, $18
DATA_09F506:         db $30, $A8, $55, $F4, $F4, $18, $18, $80
DATA_09F50E:         db $D0, $55, $F4, $F4, $18, $18, $98, $D0
DATA_09F516:         db $55, $F4, $F4, $18, $18, $68, $D8, $D5
DATA_09F51E:         db $F4, $F4, $18, $18, $80, $A0, $D5, $F8
DATA_09F526:         db $F8, $10, $10, $80, $C0, $55, $F8, $F8
DATA_09F52E:         db $10, $10, $90, $C0, $55, $F8, $F8, $10
DATA_09F536:         db $10, $A0, $C0, $55, $F8, $F8, $10, $10
DATA_09F53E:         db $B0, $C8, $55, $F8, $F8, $10, $10, $C0
DATA_09F546:         db $C8, $55, $F8, $F8, $10, $10, $D0, $C8
DATA_09F54E:         db $55, $F8, $F8, $10, $10, $E0, $C8, $55
DATA_09F556:         db $F8, $F8, $10, $10, $F0, $C8, $55, $F8
DATA_09F55E:         db $F8, $10, $10, $B0, $D8, $55, $F8, $F8
DATA_09F566:         db $10, $10, $C0, $D8, $55, $F8, $F8, $10
DATA_09F56E:         db $10, $D0, $D8, $55

0009:F572 3F DF        romb
0009:F574 2E 1E        move  r14,r14
0009:F576 94           link  #04
0009:F577 FF CA F5     iwt   r15,#F5CA
0009:F57A 01           nop
0009:F57B F8 5E 38     iwt   r8,#385E
0009:F57E F9 00 58     iwt   r9,#5800
0009:F581 FA D2 58     iwt   r10,#58D2
0009:F584 02           cache
0009:F585 AC 4F        ibt   r12,#004F
0009:F587 2F 1D        move  r13,r15
0009:F589 B1 38        stw   (r8)
0009:F58B D8           inc   r8
0009:F58C D8           inc   r8
0009:F58D B2 3D 39     stb   (r9)
0009:F590 D9           inc   r9
0009:F591 B3 3A        stw   (r10)
0009:F593 DA           inc   r10
0009:F594 3C           loop
0009:F595 DA           inc   r10
0009:F596 A7 0E        ibt   r7,#000E
0009:F598 94           link  #04
0009:F599 FF CA F5     iwt   r15,#F5CA
0009:F59C 01           nop
0009:F59D AC 04        ibt   r12,#0004
0009:F59F 2F 1D        move  r13,r15
0009:F5A1 B1 38        stw   (r8)
0009:F5A3 D8           inc   r8
0009:F5A4 D8           inc   r8
0009:F5A5 B2 3D 39     stb   (r9)
0009:F5A8 D9           inc   r9
0009:F5A9 B3 3A        stw   (r10)
0009:F5AB DA           inc   r10
0009:F5AC 3C           loop
0009:F5AD DA           inc   r10
0009:F5AE E7           dec   r7
0009:F5AF 08 E7        bne   F598
0009:F5B1 01           nop
0009:F5B2 94           link  #04
0009:F5B3 FF CA F5     iwt   r15,#F5CA
0009:F5B6 01           nop
0009:F5B7 AC 4A        ibt   r12,#004A
0009:F5B9 2F 1D        move  r13,r15
0009:F5BB B1 38        stw   (r8)
0009:F5BD D8           inc   r8
0009:F5BE D8           inc   r8
0009:F5BF B2 3D 39     stb   (r9)
0009:F5C2 D9           inc   r9
0009:F5C3 B3 3A        stw   (r10)
0009:F5C5 DA           inc   r10
0009:F5C6 3C           loop
0009:F5C7 DA           inc   r10
0009:F5C8 00           stop
0009:F5C9 01           nop

0009:F5CA EF           getb
0009:F5CB DE           inc   r14
0009:F5CC 3D EF        getbh
0009:F5CE DE           inc   r14
0009:F5CF 20 11        move  r1,r0
0009:F5D1 A5 1F        ibt   r5,#001F
0009:F5D3 75           and   r5
0009:F5D4 A6 20        ibt   r6,#0020
0009:F5D6 12 C6        or    r6
0009:F5D8 B1 03        lsr
0009:F5DA 03           lsr
0009:F5DB 03           lsr
0009:F5DC 03           lsr
0009:F5DD 03           lsr
0009:F5DE 20 14        move  r4,r0
0009:F5E0 75           and   r5
0009:F5E1 26 56        add   r6
0009:F5E3 13 C6        or    r6
0009:F5E5 B4 03        lsr
0009:F5E7 03           lsr
0009:F5E8 03           lsr
0009:F5E9 03           lsr
0009:F5EA 03           lsr
0009:F5EB 75           and   r5
0009:F5EC 26 56        add   r6
0009:F5EE C6           or    r6
0009:F5EF 4D           swap
0009:F5F0 13 C3        or    r3
0009:F5F2 9B           jmp   r11
0009:F5F3 01           nop

0009:F5F4 B1 63        sub   r3
0009:F5F6 F9 00 01     iwt   r9,#0100
0009:F5F9 19 59        add   r9
0009:F5FB AA 01        ibt   r10,#0001
0009:F5FD 60           sub   r0
0009:F5FE 20 16        move  r6,r0
0009:F600 02           cache
0009:F601 AC 20        ibt   r12,#0020
0009:F603 FD 07 F6     iwt   r13,#F607
0009:F606 26 56        add   r6
0009:F608 2A 5A        add   r10
0009:F60A 04           rol
0009:F60B 69           sub   r9
0009:F60C 0C 03        bcc   F611
0009:F60E 59           add   r9
0009:F60F 69           sub   r9
0009:F610 D6           inc   r6
0009:F611 3C           loop
0009:F612 26 3D A8 4A  lms   r8,(0094)
0009:F616 FA 78 00     iwt   r10,#0078
0009:F619 B3 68        sub   r8
0009:F61B 6A           sub   r10
0009:F61C 3D 9F        lmult
0009:F61E 24 C0        hib
0009:F620 9E           lob
0009:F621 4D           swap
0009:F622 C4           or    r4
0009:F623 5A           add   r10
0009:F624 58           add   r8
0009:F625 11 61        sub   r1
0009:F627 3D A8 4E     lms   r8,(009C)
0009:F62A FA 88 00     iwt   r10,#0088
0009:F62D B2 68        sub   r8
0009:F62F 6A           sub   r10
0009:F630 3D 9F        lmult
0009:F632 24 C0        hib
0009:F634 9E           lob
0009:F635 4D           swap
0009:F636 C4           or    r4
0009:F637 5A           add   r10
0009:F638 58           add   r8
0009:F639 12 62        sub   r2
0009:F63B A4 06        ibt   r4,#0006
0009:F63D 27 1C        move  r12,r7
0009:F63F 2F 1D        move  r13,r15
0009:F641 45           ldw   (r5)
0009:F642 51           add   r1
0009:F643 90           sbk
0009:F644 D5           inc   r5
0009:F645 D5           inc   r5
0009:F646 45           ldw   (r5)
0009:F647 52           add   r2
0009:F648 25 54        add   r4
0009:F64A 3C           loop
0009:F64B 90           sbk
0009:F64C 00           stop
0009:F64D 01           nop

0009:F64E 02           cache
0009:F64F AA 1F        ibt   r10,#001F
0009:F651 3D F0 AA 11  lm    r0,(11AA)
0009:F655 D0           inc   r0
0009:F656 90           sbk
0009:F657 20 16        move  r6,r0
0009:F659 FC 00 01     iwt   r12,#0100
0009:F65C 2F 1D        move  r13,r15
0009:F65E 41           ldw   (r1)
0009:F65F 18 7A        and   r10
0009:F661 42           ldw   (r2)
0009:F662 19 7A        and   r10
0009:F664 94           link  #04
0009:F665 FF A3 F6     iwt   r15,#F6A3
0009:F668 01           nop
0009:F669 20 15        move  r5,r0
0009:F66B 41           ldw   (r1)
0009:F66C 50           add   r0
0009:F66D 50           add   r0
0009:F66E 50           add   r0
0009:F66F 4D           swap
0009:F670 18 7A        and   r10
0009:F672 42           ldw   (r2)
0009:F673 50           add   r0
0009:F674 50           add   r0
0009:F675 50           add   r0
0009:F676 4D           swap
0009:F677 19 7A        and   r10
0009:F679 94           link  #04
0009:F67A FF A3 F6     iwt   r15,#F6A3
0009:F67D 01           nop
0009:F67E 4D           swap
0009:F67F 03           lsr
0009:F680 03           lsr
0009:F681 03           lsr
0009:F682 15 C5        or    r5
0009:F684 41           ldw   (r1)
0009:F685 4D           swap
0009:F686 03           lsr
0009:F687 03           lsr
0009:F688 18 7A        and   r10
0009:F68A 42           ldw   (r2)
0009:F68B 4D           swap
0009:F68C 03           lsr
0009:F68D 03           lsr
0009:F68E 19 7A        and   r10
0009:F690 94           link  #04
0009:F691 FF A3 F6     iwt   r15,#F6A3
0009:F694 01           nop
0009:F695 4D           swap
0009:F696 50           add   r0
0009:F697 50           add   r0
0009:F698 C5           or    r5
0009:F699 33           stw   (r3)
0009:F69A D1           inc   r1
0009:F69B D1           inc   r1
0009:F69C D2           inc   r2
0009:F69D D2           inc   r2
0009:F69E D3           inc   r3
0009:F69F 3C           loop
0009:F6A0 D3           inc   r3
0009:F6A1 00           stop
0009:F6A2 01           nop

0009:F6A3 B9 68        sub   r8
0009:F6A5 86           mult  r6
0009:F6A6 96           asr
0009:F6A7 96           asr
0009:F6A8 96           asr
0009:F6A9 96           asr
0009:F6AA 96           asr
0009:F6AB 58           add   r8
0009:F6AC 7A           and   r10
0009:F6AD 2B 1F        move  r15,r11
0009:F6AF 01           nop
0009:F6B0 F6 40 00     iwt   r6,#0040
0009:F6B3 B1 3D 9F     lmult
0009:F6B6 24 C0        hib
0009:F6B8 9E           lob
0009:F6B9 4D           swap
0009:F6BA 19 C4        or    r4
0009:F6BC AA 01        ibt   r10,#0001
0009:F6BE 60           sub   r0
0009:F6BF 20 16        move  r6,r0
0009:F6C1 02           cache
0009:F6C2 AC 20        ibt   r12,#0020
0009:F6C4 FD C8 F6     iwt   r13,#F6C8
0009:F6C7 26 56        add   r6
0009:F6C9 2A 5A        add   r10
0009:F6CB 04           rol
0009:F6CC 61           sub   r1
0009:F6CD 0C 03        bcc   F6D2
0009:F6CF 51           add   r1
0009:F6D0 61           sub   r1
0009:F6D1 D6           inc   r6
0009:F6D2 3C           loop
0009:F6D3 26 3D A8 4A  lms   r8,(0094)
0009:F6D7 FA 80 00     iwt   r10,#0080
0009:F6DA B3 68        sub   r8
0009:F6DC 6A           sub   r10
0009:F6DD 3D 9F        lmult
0009:F6DF 24 C0        hib
0009:F6E1 9E           lob
0009:F6E2 4D           swap
0009:F6E3 C4           or    r4
0009:F6E4 E5           dec   r5
0009:F6E5 0A 03        bpl   F6EA
0009:F6E7 D5           inc   r5
0009:F6E8 4F           not
0009:F6E9 D0           inc   r0
0009:F6EA F5 80 01     iwt   r5,#0180
0009:F6ED 55           add   r5
0009:F6EE 3E A0 4C     sms   (0098),r0
0009:F6F1 3D A8 4E     lms   r8,(009C)
0009:F6F4 FA 90 00     iwt   r10,#0090
0009:F6F7 B2 68        sub   r8
0009:F6F9 6A           sub   r10
0009:F6FA 3D 9F        lmult
0009:F6FC 24 C0        hib
0009:F6FE 9E           lob
0009:F6FF 4D           swap
0009:F700 15 C4        or    r4
0009:F702 F0 80 01     iwt   r0,#0180
0009:F705 65           sub   r5
0009:F706 3E A0 50     sms   (00A0),r0
0009:F709 00           stop
0009:F70A 01           nop

0009:F70B F0 16 1C     iwt   r0,#1C16
0009:F70E 51           add   r1
0009:F70F 40           ldw   (r0)
0009:F710 E0           dec   r0
0009:F711 0A 03        bpl   F716
0009:F713 D0           inc   r0
0009:F714 4F           not
0009:F715 D0           inc   r0
0009:F716 A4 40        ibt   r4,#0040
0009:F718 64           sub   r4
0009:F719 0D 24        bcs   F73F
0009:F71B 54           add   r4
0009:F71C 12 3D 80     umult r0
0009:F71F F0 18 1C     iwt   r0,#1C18
0009:F722 51           add   r1
0009:F723 40           ldw   (r0)
0009:F724 E0           dec   r0
0009:F725 0A 03        bpl   F72A
0009:F727 D0           inc   r0
0009:F728 4F           not
0009:F729 D0           inc   r0
0009:F72A 64           sub   r4
0009:F72B 0D 12        bcs   F73F
0009:F72D 54           add   r4
0009:F72E 3D 80        umult r0
0009:F730 12 52        add   r2
0009:F732 3D A0 91     lms   r0,(0122)
0009:F735 3D 80        umult r0
0009:F737 F3 90 07     iwt   r3,#0790
0009:F73A 53           add   r3
0009:F73B 62           sub   r2
0009:F73C 0D 03        bcs   F741
0009:F73E 60           sub   r0
0009:F73F A0 01        ibt   r0,#0001
0009:F741 00           stop
0009:F742 01           nop

0009:F743 A1 00        ibt   r1,#0000
0009:F745 F2 00 0F     iwt   r2,#0F00
0009:F748 F3 60 13     iwt   r3,#1360
0009:F74B F4 38 1D     iwt   r4,#1D38
0009:F74E F5 CD 00     iwt   r5,#00CD
0009:F751 F6 26 00     iwt   r6,#0026
0009:F754 F7 04 00     iwt   r7,#0004
0009:F757 02           cache
0009:F758 AC 18        ibt   r12,#0018
0009:F75A 2F 1D        move  r13,r15
0009:F75C 42           ldw   (r2)
0009:F75D 9E           lob
0009:F75E 09 11        beq   F771
0009:F760 01           nop
0009:F761 43           ldw   (r3)
0009:F762 65           sub   r5
0009:F763 09 0B        beq   F770
0009:F765 55           add   r5
0009:F766 66           sub   r6
0009:F767 08 08        bne   F771
0009:F769 01           nop
0009:F76A 44           ldw   (r4)
0009:F76B 3E 60        sub   #00
0009:F76D 08 02        bne   F771
0009:F76F 01           nop
0009:F770 D1           inc   r1
0009:F771 22 57        add   r7
0009:F773 23 57        add   r7
0009:F775 24 57        add   r7
0009:F777 3C           loop
0009:F778 01           nop
0009:F779 00           stop
0009:F77A 01           nop

0009:F77B 02           cache
0009:F77C F3 00 68     iwt   r3,#6800
0009:F77F F0 CE 03     iwt   r0,#03CE
0009:F782 FC 00 04     iwt   r12,#0400
0009:F785 2F 1D        move  r13,r15
0009:F787 33           stw   (r3)
0009:F788 D3           inc   r3
0009:F789 3C           loop
0009:F78A D3           inc   r3
0009:F78B F1 00 20     iwt   r1,#2000
0009:F78E F2 44 6C     iwt   r2,#6C44
0009:F791 A4 10        ibt   r4,#0010
0009:F793 A5 0F        ibt   r5,#000F
0009:F795 A7 28        ibt   r7,#0028
0009:F797 A8 38        ibt   r8,#0038
0009:F799 AA 0B        ibt   r10,#000B
0009:F79B AB 0C        ibt   r11,#000C
0009:F79D 21 10        move  r0,r1
0009:F79F 2B 1C        move  r12,r11
0009:F7A1 2F 1D        move  r13,r15
0009:F7A3 32           stw   (r2)
0009:F7A4 D0           inc   r0
0009:F7A5 D0           inc   r0
0009:F7A6 1E 75        and   r5
0009:F7A8 08 02        bne   F7AC
0009:F7AA D2           inc   r2
0009:F7AB 54           add   r4
0009:F7AC 3C           loop
0009:F7AD D2           inc   r2
0009:F7AE 22 57        add   r7
0009:F7B0 B1 58        add   r8
0009:F7B2 11 3D 74     bic   r4
0009:F7B5 EA           dec   r10
0009:F7B6 08 E6        bne   F79E
0009:F7B8 21 10        move  r0,r1
0009:F7BA 00           stop
0009:F7BB 01           nop

0009:F7BC 02           cache
0009:F7BD F5 00 68     iwt   r5,#6800
0009:F7C0 60           sub   r0
0009:F7C1 FC 00 03     iwt   r12,#0300
0009:F7C4 2F 1D        move  r13,r15
0009:F7C6 35           stw   (r5)
0009:F7C7 D5           inc   r5
0009:F7C8 3C           loop
0009:F7C9 D5           inc   r5
0009:F7CA A5 00        ibt   r5,#0000
0009:F7CC A6 00        ibt   r6,#0000
0009:F7CE F9 80 00     iwt   r9,#0080
0009:F7D1 AA 10        ibt   r10,#0010
0009:F7D3 B3 3F DF     romb
0009:F7D6 24 1E        move  r14,r4
0009:F7D8 EF           getb
0009:F7D9 DE           inc   r14
0009:F7DA FB FF 00     iwt   r11,#00FF
0009:F7DD 6B           sub   r11
0009:F7DE 08 11        bne   F7F1
0009:F7E0 5B           add   r11
0009:F7E1 EF           getb
0009:F7E2 DE           inc   r14
0009:F7E3 1B 3E 6A     sub   #0A
0009:F7E6 09 03        beq   F7EB
0009:F7E8 01           nop
0009:F7E9 00           stop
0009:F7EA 01           nop

0009:F7EB EF           getb
0009:F7EC DE           inc   r14
0009:F7ED A5 40        ibt   r5,#0040
0009:F7EF A6 10        ibt   r6,#0010
0009:F7F1 2E 14        move  r4,r14
0009:F7F3 AE 09        ibt   r14,#0009
0009:F7F5 BE 3F DF     romb
0009:F7F8 FE 2F BC     iwt   r14,#BC2F
0009:F7FB 1E 5E        add   r14
0009:F7FD 17 EF        getb
0009:F7FF 3F 8C        umult #0C
0009:F801 FE 2F BD     iwt   r14,#BD2F
0009:F804 1E 5E        add   r14
0009:F806 A8 0C        ibt   r8,#000C
0009:F808 1B 3D EF     getbh
0009:F80B DE           inc   r14
0009:F80C 25 11        move  r1,r5
0009:F80E 26 12        move  r2,r6
0009:F810 27 1C        move  r12,r7
0009:F812 2F 1D        move  r13,r15
0009:F814 2B 5B        add   r11
0009:F816 04           rol
0009:F817 3E 71        and   #01
0009:F819 4E           color
0009:F81A B1 69        sub   r9
0009:F81C 0C 04        bcc   F822
0009:F81E 22 5A        add   r10
0009:F820 20 11        move  r1,r0
0009:F822 3C           loop
0009:F823 4C           plot
0009:F824 E8           dec   r8
0009:F825 08 E1        bne   F808
0009:F827 D6           inc   r6
0009:F828 26 3E 6C     sub   #0C
0009:F82B 25 57        add   r7
0009:F82D 3D 4C        rpix
0009:F82F B5 69        sub   r9
0009:F831 0C A1        bcc   F7D4
0009:F833 B3 20 15     move  r5,r0
0009:F836 26           with  r6
0009:F837 05 9A        bra   F7D3

0009:F839 5A           add   r10

0009:F83A A0 08        ibt   r0,#0008
0009:F83C 3F DF        romb
0009:F83E F0 18 AE     iwt   r0,#AE18
0009:F841 1E 51        add   r1
0009:F843 3F EF        getbs
0009:F845 20 11        move  r1,r0
0009:F847 3D A3 91     lms   r3,(0122)
0009:F84A 83           mult  r3
0009:F84B 50           add   r0
0009:F84C 50           add   r0
0009:F84D C0           hib
0009:F84E 95           sex
0009:F84F 4F           not
0009:F850 54           add   r4
0009:F851 3D A4 48     lms   r4,(0090)
0009:F854 54           add   r4
0009:F855 3E A0 8F     sms   (011E),r0
0009:F858 A0 40        ibt   r0,#0040
0009:F85A 1E 5E        add   r14
0009:F85C 3F EF        getbs
0009:F85E 20 12        move  r2,r0
0009:F860 83           mult  r3
0009:F861 50           add   r0
0009:F862 50           add   r0
0009:F863 C0           hib
0009:F864 95           sex
0009:F865 3E 58        add   #08
0009:F867 3D A4 46     lms   r4,(008C)
0009:F86A 54           add   r4
0009:F86B 3E A0 8E     sms   (011C),r0
0009:F86E E1           dec   r1
0009:F86F 0A 04        bpl   F875
0009:F871 D1           inc   r1
0009:F872 21 4F        not
0009:F874 D1           inc   r1
0009:F875 E2           dec   r2
0009:F876 0A 04        bpl   F87C
0009:F878 D2           inc   r2
0009:F879 22 4F        not
0009:F87B D2           inc   r2
0009:F87C 3D A0 90     lms   r0,(0120)
0009:F87F 15 81        mult  r1
0009:F881 16 82        mult  r2
0009:F883 B3 82        mult  r2
0009:F885 55           add   r5
0009:F886 50           add   r0
0009:F887 50           add   r0
0009:F888 C0           hib
0009:F889 3E A0 90     sms   (0120),r0
0009:F88C B3 81        mult  r1
0009:F88E 56           add   r6
0009:F88F 50           add   r0
0009:F890 50           add   r0
0009:F891 C0           hib
0009:F892 3E A0 91     sms   (0122),r0
0009:F895 00           stop
0009:F896 01           nop
0009:F897 3D F0 02 00  lm    r0,(0002)
0009:F89B 50           add   r0
0009:F89C 3E 88        mult  #08
0009:F89E 3D F1 00 00  lm    r1,(0000)
0009:F8A2 51           add   r1
0009:F8A3 3E 84        mult  #04
0009:F8A5 F1 00 58     iwt   r1,#5800
0009:F8A8 1E 51        add   r1
0009:F8AA 02           cache
0009:F8AB F1 3F 06     iwt   r1,#063F
0009:F8AE F3 FF 06     iwt   r3,#06FF
0009:F8B1 94           link  #04
0009:F8B2 FF 05 F9     iwt   r15,#F905
0009:F8B5 01           nop
0009:F8B6 F1 1F 06     iwt   r1,#061F
0009:F8B9 F3 BF 06     iwt   r3,#06BF
0009:F8BC 94           link  #04
0009:F8BD FF 05 F9     iwt   r15,#F905
0009:F8C0 01           nop
0009:F8C1 F1 3F 04     iwt   r1,#043F
0009:F8C4 F3 FF 02     iwt   r3,#02FF
0009:F8C7 94           link  #04
0009:F8C8 FF 05 F9     iwt   r15,#F905
0009:F8CB 01           nop
0009:F8CC F1 1F 04     iwt   r1,#041F
0009:F8CF F3 BF 02     iwt   r3,#02BF
0009:F8D2 94           link  #04
0009:F8D3 FF 05 F9     iwt   r15,#F905
0009:F8D6 01           nop
0009:F8D7 F1 3F 02     iwt   r1,#023F
0009:F8DA F3 7F 06     iwt   r3,#067F
0009:F8DD 94           link  #04
0009:F8DE FF 05 F9     iwt   r15,#F905
0009:F8E1 01           nop
0009:F8E2 F1 1F 02     iwt   r1,#021F
0009:F8E5 F3 3F 06     iwt   r3,#063F
0009:F8E8 94           link  #04
0009:F8E9 FF 05 F9     iwt   r15,#F905
0009:F8EC 01           nop
0009:F8ED F1 3F 00     iwt   r1,#003F
0009:F8F0 F3 7F 02     iwt   r3,#027F
0009:F8F3 94           link  #04
0009:F8F4 FF 05 F9     iwt   r15,#F905
0009:F8F7 01           nop
0009:F8F8 F1 1F 00     iwt   r1,#001F
0009:F8FB F3 3F 02     iwt   r3,#023F
0009:F8FE 94           link  #04
0009:F8FF FF 05 F9     iwt   r15,#F905
0009:F902 01           nop
0009:F903 00           stop
0009:F904 01           nop

0009:F905 21 5E        add   r14
0009:F907 23 5E        add   r14
0009:F909 A2 10        ibt   r2,#0010
0009:F90B B1 12 62     sub   r2
0009:F90E A4 20        ibt   r4,#0020
0009:F910 B3 14 64     sub   r4
0009:F913 B3 15 3E 62  sub   #02
0009:F917 B4 16 3E 62  sub   #02
0009:F91B AA 02        ibt   r10,#0002
0009:F91D AC 04        ibt   r12,#0004
0009:F91F AD 02        ibt   r13,#0002
0009:F921 17 3D 41     ldb   (r1)
0009:F924 27 18        move  r8,r7
0009:F926 27 03        lsr
0009:F928 97           ror
0009:F929 28 03        lsr
0009:F92B 97           ror
0009:F92C 27 03        lsr
0009:F92E 97           ror
0009:F92F 28 03        lsr
0009:F931 97           ror
0009:F932 27 03        lsr
0009:F934 97           ror
0009:F935 28 03        lsr
0009:F937 97           ror
0009:F938 27 03        lsr
0009:F93A 97           ror
0009:F93B 28 03        lsr
0009:F93D 97           ror
0009:F93E 4D           swap
0009:F93F 3D 33        stb   (r3)
0009:F941 E3           dec   r3
0009:F942 3D 35        stb   (r5)
0009:F944 E5           dec   r5
0009:F945 27 03        lsr
0009:F947 97           ror
0009:F948 28 03        lsr
0009:F94A 97           ror
0009:F94B 27 03        lsr
0009:F94D 97           ror
0009:F94E 28 03        lsr
0009:F950 97           ror
0009:F951 27 03        lsr
0009:F953 97           ror
0009:F954 28 03        lsr
0009:F956 97           ror
0009:F957 27 03        lsr
0009:F959 97           ror
0009:F95A 28 03        lsr
0009:F95C 97           ror
0009:F95D 4D           swap
0009:F95E 3D 34        stb   (r4)
0009:F960 E4           dec   r4
0009:F961 3D 36        stb   (r6)
0009:F963 E6           dec   r6
0009:F964 ED           dec   r13
0009:F965 08 BA        bne   F921
0009:F967 E1           dec   r1
0009:F968 23 3E 62     sub   #02
0009:F96B 24 3E 62     sub   #02
0009:F96E 25 3E 62     sub   #02
0009:F971 26 3E 62     sub   #02
0009:F974 EC           dec   r12
0009:F975 08 A8        bne   F91F
0009:F977 01           nop
0009:F978 AC 04        ibt   r12,#0004
0009:F97A AD 02        ibt   r13,#0002
0009:F97C 17 3D 42     ldb   (r2)
0009:F97F 27 18        move  r8,r7
0009:F981 27 03        lsr
0009:F983 97           ror
0009:F984 28 03        lsr
0009:F986 97           ror
0009:F987 27 03        lsr
0009:F989 97           ror
0009:F98A 28 03        lsr
0009:F98C 97           ror
0009:F98D 27 03        lsr
0009:F98F 97           ror
0009:F990 28 03        lsr
0009:F992 97           ror
0009:F993 27 03        lsr
0009:F995 97           ror
0009:F996 28 03        lsr
0009:F998 97           ror
0009:F999 4D           swap
0009:F99A 3D 33        stb   (r3)
0009:F99C E3           dec   r3
0009:F99D 3D 35        stb   (r5)
0009:F99F E5           dec   r5
0009:F9A0 27 03        lsr
0009:F9A2 97           ror
0009:F9A3 28 03        lsr
0009:F9A5 97           ror
0009:F9A6 27 03        lsr
0009:F9A8 97           ror
0009:F9A9 28 03        lsr
0009:F9AB 97           ror
0009:F9AC 27 03        lsr
0009:F9AE 97           ror
0009:F9AF 28 03        lsr
0009:F9B1 97           ror
0009:F9B2 27 03        lsr
0009:F9B4 97           ror
0009:F9B5 28 03        lsr
0009:F9B7 97           ror
0009:F9B8 4D           swap
0009:F9B9 3D 34        stb   (r4)
0009:F9BB E4           dec   r4
0009:F9BC 3D 36        stb   (r6)
0009:F9BE E6           dec   r6
0009:F9BF ED           dec   r13
0009:F9C0 08 BA        bne   F97C
0009:F9C2 E2           dec   r2
0009:F9C3 23 3E 62     sub   #02
0009:F9C6 24 3E 62     sub   #02
0009:F9C9 25 3E 62     sub   #02
0009:F9CC 26 3E 62     sub   #02
0009:F9CF EC           dec   r12
0009:F9D0 08 A8        bne   F97A
0009:F9D2 01           nop
0009:F9D3 FC E0 01     iwt   r12,#01E0
0009:F9D6 23 6C        sub   r12
0009:F9D8 24 6C        sub   r12
0009:F9DA 25 6C        sub   r12
0009:F9DC 26 6C        sub   r12
0009:F9DE EA           dec   r10
0009:F9DF 09 05        beq   F9E6
0009:F9E1 01           nop
0009:F9E2 FF 1D F9     iwt   r15,#F91D
0009:F9E5 01           nop
0009:F9E6 9B           jmp   r11
0009:F9E7 01           nop

0009:F9E8 F0 9E 40     iwt   r0,#409E
0009:F9EB 11 51        add   r1
0009:F9ED 12 52        add   r2
0009:F9EF F0 AA 0D     iwt   r0,#0DAA
0009:F9F2 14 5A        add   r10
0009:F9F4 A0 40        ibt   r0,#0040
0009:F9F6 15 54        add   r4
0009:F9F8 BC 5C        add   r12
0009:F9FA 50           add   r0
0009:F9FB 5A           add   r10
0009:F9FC AA 3E        ibt   r10,#003E
0009:F9FE 1A 7A        and   r10
0009:FA00 A0 4C        ibt   r0,#004C
0009:FA02 3F DF        romb
0009:FA04 F6 A4 32     iwt   r6,#32A4
0009:FA07 F7 F2 33     iwt   r7,#33F2
0009:FA0A A8 08        ibt   r8,#0008
0009:FA0C 94           link  #04
0009:FA0D FF 28 FA     iwt   r15,#FA28
0009:FA10 02           cache
0009:FA11 22 11        move  r1,r2
0009:FA13 2C B3        moves r12,r3
0009:FA15 09 0F        beq   FA26
0009:FA17 01           nop
0009:FA18 F0 AA 0D     iwt   r0,#0DAA
0009:FA1B 14 5A        add   r10
0009:FA1D A0 40        ibt   r0,#0040
0009:FA1F 15 54        add   r4
0009:FA21 94           link  #04
0009:FA22 FF 28 FA     iwt   r15,#FA28
0009:FA25 01           nop
0009:FA26 00           stop
0009:FA27 01           nop

0009:FA28 2F 1D        move  r13,r15
0009:FA2A 41           ldw   (r1)
0009:FA2B 19 3D 88     umult r8
0009:FA2E C0           hib
0009:FA2F 50           add   r0
0009:FA30 1E 56        add   r6
0009:FA32 EF           getb
0009:FA33 DE           inc   r14
0009:FA34 3D EF        getbh
0009:FA36 59           add   r9
0009:FA37 1E 57        add   r7
0009:FA39 A9 40        ibt   r9,#0040
0009:FA3B 21 59        add   r9
0009:FA3D EF           getb
0009:FA3E DE           inc   r14
0009:FA3F 3D 34        stb   (r4)
0009:FA41 D4           inc   r4
0009:FA42 EF           getb
0009:FA43 DE           inc   r14
0009:FA44 3D 34        stb   (r4)
0009:FA46 D4           inc   r4
0009:FA47 EF           getb
0009:FA48 DE           inc   r14
0009:FA49 3D 35        stb   (r5)
0009:FA4B D5           inc   r5
0009:FA4C EF           getb
0009:FA4D DE           inc   r14
0009:FA4E 3D 35        stb   (r5)
0009:FA50 D5           inc   r5
0009:FA51 EF           getb
0009:FA52 DE           inc   r14
0009:FA53 3D 34        stb   (r4)
0009:FA55 D4           inc   r4
0009:FA56 EF           getb
0009:FA57 DE           inc   r14
0009:FA58 3D 34        stb   (r4)
0009:FA5A D4           inc   r4
0009:FA5B EF           getb
0009:FA5C DE           inc   r14
0009:FA5D 3D 35        stb   (r5)
0009:FA5F D5           inc   r5
0009:FA60 EF           getb
0009:FA61 DE           inc   r14
0009:FA62 3D 35        stb   (r5)
0009:FA64 3C           loop
0009:FA65 D5           inc   r5
0009:FA66 9B           jmp   r11
0009:FA67 01           nop

0009:FA68 F0 9E 40     iwt   r0,#409E
0009:FA6B 11 51        add   r1
0009:FA6D 12 52        add   r2
0009:FA6F F4 2A 0E     iwt   r4,#0E2A
0009:FA72 F5 6E 0E     iwt   r5,#0E6E
0009:FA75 A0 4C        ibt   r0,#004C
0009:FA77 3F DF        romb
0009:FA79 F6 A4 32     iwt   r6,#32A4
0009:FA7C F7 F2 33     iwt   r7,#33F2
0009:FA7F A8 08        ibt   r8,#0008
0009:FA81 94           link  #04
0009:FA82 FF 91 FA     iwt   r15,#FA91
0009:FA85 02           cache
0009:FA86 22 11        move  r1,r2
0009:FA88 23 1C        move  r12,r3
0009:FA8A 94           link  #04
0009:FA8B FF 91 FA     iwt   r15,#FA91
0009:FA8E 01           nop
0009:FA8F 00           stop
0009:FA90 01           nop

0009:FA91 2F 1D        move  r13,r15
0009:FA93 41           ldw   (r1)
0009:FA94 19 3D 88     umult r8
0009:FA97 C0           hib
0009:FA98 50           add   r0
0009:FA99 1E 56        add   r6
0009:FA9B EF           getb
0009:FA9C DE           inc   r14
0009:FA9D D1           inc   r1
0009:FA9E D1           inc   r1
0009:FA9F 3D EF        getbh
0009:FAA1 59           add   r9
0009:FAA2 1E 57        add   r7
0009:FAA4 EF           getb
0009:FAA5 DE           inc   r14
0009:FAA6 3D 34        stb   (r4)
0009:FAA8 D4           inc   r4
0009:FAA9 EF           getb
0009:FAAA DE           inc   r14
0009:FAAB 3D 34        stb   (r4)
0009:FAAD D4           inc   r4
0009:FAAE EF           getb
0009:FAAF DE           inc   r14
0009:FAB0 3D 34        stb   (r4)
0009:FAB2 D4           inc   r4
0009:FAB3 EF           getb
0009:FAB4 DE           inc   r14
0009:FAB5 3D 34        stb   (r4)
0009:FAB7 D4           inc   r4
0009:FAB8 EF           getb
0009:FAB9 DE           inc   r14
0009:FABA 3D 35        stb   (r5)
0009:FABC D5           inc   r5
0009:FABD EF           getb
0009:FABE DE           inc   r14
0009:FABF 3D 35        stb   (r5)
0009:FAC1 D5           inc   r5
0009:FAC2 EF           getb
0009:FAC3 DE           inc   r14
0009:FAC4 3D 35        stb   (r5)
0009:FAC6 D5           inc   r5
0009:FAC7 EF           getb
0009:FAC8 DE           inc   r14
0009:FAC9 3D 35        stb   (r5)
0009:FACB 3C           loop
0009:FACC D5           inc   r5
0009:FACD 9B           jmp   r11
0009:FACE 01           nop

; freespace
DATA_09FACF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FAD7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FADF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FAE7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FAEF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FAF7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FAFF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB07:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB0F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB17:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB1F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB27:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB2F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB37:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB3F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB47:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB4F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB57:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB5F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB67:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB6F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB77:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB7F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB87:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB8F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB97:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FB9F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBA7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBAF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBB7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBBF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBC7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBCF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBD7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBDF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBE7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBEF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBF7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FBFF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC07:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC0F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC17:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC1F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC27:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC2F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC37:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC3F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC47:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC4F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC57:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC5F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC67:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC6F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC77:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC7F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC87:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC8F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC97:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FC9F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCA7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCAF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCB7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCBF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCC7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCCF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCD7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCDF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCE7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCEF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCF7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FCFF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD07:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD0F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD17:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD1F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD27:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD2F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD37:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD3F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD47:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD4F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD57:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD5F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD67:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD6F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD77:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD7F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD87:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD8F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD97:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FD9F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDA7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDAF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDB7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDBF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDC7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDCF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDD7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDDF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDE7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDEF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDF7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FDFF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE07:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE0F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE17:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE1F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE27:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE2F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE37:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE3F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE47:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE4F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE57:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE5F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE67:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE6F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE77:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE7F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE87:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE8F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE97:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FE9F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEA7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEAF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEB7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEBF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEC7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FECF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FED7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEDF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEE7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEEF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEF7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FEFF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF07:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF0F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF17:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF1F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF27:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF2F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF37:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF3F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF47:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF4F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF57:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF5F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF67:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF6F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF77:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF7F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF87:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF8F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF97:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FF9F:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFA7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFAF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFB7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFBF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFC7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFCF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFD7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFDF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFE7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFEF:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFF7:         db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
DATA_09FFFF:         db $FF