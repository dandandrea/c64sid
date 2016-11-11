; TODO: Control of tempo, waveform, pulse modulation, etc

NUMOUT = $bdcd

; Program starts at $1000 (SYS 4096)
                *=$1000

; Jump to start
                jmp start

; Setup font color
uitext          lda #1    ; white text
                sta $0286
                rts

; Setup font color
datatext        lda #3    ; cyan text
                sta $0286
                rts

; Setup font color
hightext        lda #3    ; cyan text
                sta $0286
                rts

; Setup screen colors
scrnblk         ; Set screen colors
                lda #11    ; dark grey border
                sta $d020
                lda #0     ; black background
                sta $d021
                rts

; Initialize UI subroutine
initui          ; Clear the screen
                jsr clear

                ; Setup screen colors
                jsr scrnblk

                ; UI text
                jsr uitext

                ; Output OSC. 1 header row
                ldx #2    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$4f  ; "O"
                jsr $ffd2
                lda #$53  ; "S"
                jsr $ffd2
                lda #$43  ; "C"
                jsr $ffd2
                lda #$4c  ; "L"
                jsr $ffd2
                lda #$54  ; "T"
                jsr $ffd2
                lda #$4f  ; "O"
                jsr $ffd2
                lda #$52  ; "R"
                jsr $ffd2
                lda #$20  ; " "
                jsr $ffd2
                lda #$31  ; "1"
                jsr $ffd2
                lda #$20  ; " "
                jsr $ffd2
                lda #$2b  ; "+"
                jsr $ffd2
                lda #$2f  ; "/"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2

                ; Output OSC. 1 separator row
                ldx #3    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$20  ; " "
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2
                lda #$2d  ; "-"
                jsr $ffd2

                ; Output frequency +/- keys
                ldx #4    ; row
                ldy #10   ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$57  ; "W"
                jsr $ffd2
                lda #$2f  ; "/"
                jsr $ffd2
                lda #$51  ; "Q"
                jsr $ffd2

                ; Output attack +/- keys
                ldx #6    ; row
                ldy #10    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$52  ; "R"
                jsr $ffd2
                lda #$2f  ; "/"
                jsr $ffd2
                lda #$45  ; "E"
                jsr $ffd2

                ; Output decay +/- keys
                ldx #7    ; row
                ldy #10    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$59  ; "Y"
                jsr $ffd2
                lda #$2f  ; "/"
                jsr $ffd2
                lda #$54  ; "T"
                jsr $ffd2

                ; Output sustain +/- keys
                ldx #8    ; row
                ldy #10    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$46  ; "F"
                jsr $ffd2
                lda #$2f  ; "/"
                jsr $ffd2
                lda #$44  ; "D"
                jsr $ffd2

                ; Output release +/- keys
                ldx #9    ; row
                ldy #10    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$48  ; "H"
                jsr $ffd2
                lda #$2f  ; "/"
                jsr $ffd2
                lda #$47  ; "G"
                jsr $ffd2

                ; Output frequency legend
                ldx #4    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$46  ; "F"
                jsr $ffd2
                lda #$52  ; "R"
                jsr $ffd2
                lda #$45  ; "E"
                jsr $ffd2
                lda #$51  ; "H"
                jsr $ffd2

                ; Output attack legend
                ldx #6    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$41  ; "A"
                jsr $ffd2
                lda #$54  ; "T"
                jsr $ffd2
                lda #$43  ; "C"
                jsr $ffd2
                lda #$4b  ; "K"
                jsr $ffd2

                ; Output decay legend
                ldx #7    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$44  ; "D"
                jsr $ffd2
                lda #$43  ; "C"
                jsr $ffd2
                lda #$41  ; "A"
                jsr $ffd2
                lda #$59  ; "Y"
                jsr $ffd2

                ; Output sustain legend
                ldx #8    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$53  ; "S"
                jsr $ffd2
                lda #$55  ; "U"
                jsr $ffd2
                lda #$53  ; "S"
                jsr $ffd2
                lda #$54  ; "T"
                jsr $ffd2

                ; Output release legend
                ldx #9    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$52  ; "R"
                jsr $ffd2
                lda #$4c  ; "L"
                jsr $ffd2
                lda #$53  ; "S"
                jsr $ffd2
                lda #$45  ; "E"
                jsr $ffd2

                ; Output screen footer

                ; Position cursor
                ldx #24   ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function

                ; Draw screen footer
                lda #$56  ; "V"
                jsr $ffd2
                lda #$30  ; "0"
                jsr $ffd2
                lda #$2e  ; "."
                jsr $ffd2
                lda #$30  ; "0"
                jsr $ffd2
                lda #$2e  ; "."
                jsr $ffd2
                lda #$33  ; "3"
                jsr $ffd2
                lda #$20  ; " "
                jsr $ffd2

                ; Highlighted text
                jsr hightext

                ; Draw additional screen footer
                lda #$31  ; "1"
                jsr $ffd2
                lda #$30  ; "0"
                jsr $ffd2
                lda #$30  ; "0"
                jsr $ffd2
                lda #$25  ; "%"
                jsr $ffd2
                lda #$20  ; " "
                jsr $ffd2
                lda #$41  ; "A"
                jsr $ffd2
                lda #$53  ; "S"
                jsr $ffd2
                lda #$4d  ; "M"
                jsr $ffd2

                ; Update UI
                jsr updateui

                ; End of subroutine
                rts
; End of "initui" subroutine

; Restore screen
resetui         jsr clear ; Clear the screen
                lda #14   ; Light blue background
                sta $d020
                lda #06   ; Blue border
                sta $d021
                lda #14   ; Light blue text
                sta $0286
                rts

; Clear the screen
clear           lda #$93 ; "Clear screen" character
                jsr $ffd2
                rts

; Start
start           ; Install interrupt routine
                jsr install$

                ; Init UI and jump to main loop
                jsr initui
                jmp mainloop

; Update UI subroutine
updateui        ; Data text
                jsr datatext

                ; Clear previous frequency
                ldx #4    ; row
                ldy #4    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$20  ; " "
                jsr $ffd2
                jsr $ffd2
                jsr $ffd2
                jsr $ffd2
                jsr $ffd2
                jsr $ffd2

                ; Display current frequency
                ldx #4    ; row
                ldy #5    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                jsr convertfreq$
                ldx freqlodisp$
                lda freqhidisp$
                jsr NUMOUT

                ; Display current "attack" value
                ldx #6    ; row
                ldy #6    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda attack$
                jsr outdecim

                ; Display current "decay" value
                ldx #7    ; row
                ldy #6    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda decay$
                jsr outdecim

                ; Display current "sustain" value
                ldx #8    ; row
                ldy #6    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda sustain$
                jsr outdecim

                ; Display current "release" value
                ldx #9    ; row
                ldy #6    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda release$
                jsr outdecim

                ; End of subroutine
                rts
; End updateui subroutine

; Main loop
mainloop
                ; Don't end program if RUN/STOP key not pressed
                lda $91
                cmp #$7f
                bne hkey

break           ; Restore original interrupt routine
                jsr uninstall$

                ; Reset screen and end program
                jsr resetui

                ; Done
                rts

hkey            ; If "H" is pressed
                lda $cb
                cmp #$1d ; "H"
                bne gkey
                jsr updateui
                jmp increl

gkey            ; If "G" is pressed
                lda $cb
                cmp #$1a ; "G"
                bne ykey
                jsr updateui
                jmp decrel

ykey            ; If "Y" is pressed
                lda $cb
                cmp #$19 ; "Y"
                bne tkey
                jsr updateui
                jmp incdecay

                ; If "T" is pressed
tkey            lda $cb
                cmp #$16 ; "T"
                bne fkey
                jsr updateui
                jmp decdecay

                ; If "F" is pressed
fkey            lda $cb
                cmp #$15 ; "F"
                bne dkey
                jsr updateui
                jmp incsust

                ; If "D" is pressed
dkey            lda $cb
                cmp #$12 ; "D"
                bne wkey
                jsr updateui
                jmp decsust

                ; If "W" is pressed
wkey            lda $cb ;
                cmp #$09 ; "W"
                bne qkey
                jsr updateui
                jmp incfreq
                
                ; If "Q" is pressed
qkey            lda $cb
                cmp #$3e ; "Q"
                bne rkey
                jsr updateui
                jmp decfreq

                ; If "R" is pressed
rkey            lda $cb
                cmp #$11 ; "R"
                bne ekey
                jsr updateui
                jmp incatt

                ; If "E" is pressed
ekey            lda $cb
                cmp #$0e ; "E"
                bne bottom
                jsr updateui
                jmp decatt

bottom          ; Bottom of main loop
                jmp mainloop
; End of main loop

; Input handlers
; Increase release
increl          inc release$
                jsr debounce
                jmp mainloop

; Decrease release
decrel          dec release$
                jsr debounce
                jmp mainloop

; Increase decay
incdecay        inc decay$
                jsr debounce
                jmp mainloop

; Decrease decay
decdecay        dec decay$
                jsr debounce
                jmp mainloop

; Increase sustain
incsust         inc sustain$
                jsr debounce
                jmp mainloop

; Decrease sustain
decsust         dec sustain$
                jsr debounce
                jmp mainloop

; Increment frequency
; TODO: Convert to subroutine
incfreq         lda freqlo$
                sta num1lo$
                lda freqhi$
                sta num1hi$
                lda #160
                sta num2lo$
                lda #0
                sta num2hi$
                jsr addnums$
                lda resultlo$
                sta freqlo$
                lda resulthi$
                sta freqhi$
                jsr debounce
                jmp mainloop

; Decrease frequency
; TODO: Convert to subroutine
decfreq         lda freqlo$
                sta num1lo$
                lda freqhi$
                sta num1hi$
                lda #160
                sta num2lo$
                lda #0
                sta num2hi$
                jsr subnums$
                lda resultlo$
                sta freqlo$
                lda resulthi$
                sta freqhi$
                jsr debounce
                jmp mainloop

; Increase attack
incatt          inc attack$
                jsr debounce
                jmp mainloop

; Decrease attack
decatt          dec attack$
                jsr debounce
                jmp mainloop
; End of input handlers

; Busywait routine
busywait        lda #$00
                sta outloopc
                sta inloopc

outloop         lda outloopc
                cmp outloops
                beq endwait

inloop          lda inloopc
                cmp inloops
                beq endinlp

                inc inloopc
                jmp inloop

endinlp         lda #$00
                sta inloopc

                inc outloopc
                jmp outloop

endwait         rts
; End of busywait routine

; Debounce key press busywait
debounce        lda dbols
                sta outloops
                lda dbils
                sta inloops
                jsr busywait
                rts

; Debounce duration
dbols           byte $40
dbils           byte $80

; Loop counters
outloops        byte $00
inloops         byte $00
outloopc        byte $00
inloopc         byte $00

; Write a byte to screen memory as a 3 digit integer quantity
; Lifted and slightly adapted from http://6502org.wikidot.com/software-output-decimal
outdecim        LDX #1
                STX outc
                INX
                LDY #$40

one             STY outb
                LSR
two             ROL
                BCS three
                CMP outa,X
                BCC four
three           SBC outa,X
                SEC
four            ROL outb
                BCC two
                TAY
                CPX outc
                LDA outb
                BCC five
                BEQ six
                STX outc
five            EOR #$10
six             EOR #$20

                ; me -- Output digit
                jsr $ffd2

                TYA
                LDY #$10
                DEX
                BPL one
                RTS

; Used by above subroutine
outa            byte 128,160,200
outb            byte 1
outc            byte 1
