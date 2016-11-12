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
                lda #0     
                sta $d020 ; black border
                sta $d021 ; black background
                rts

uirow1          text "trigger         trigger"
                byte 0

uirow2          text "  delay (k/l)     length (n/m)"
                byte 0

uirow3          text ""
                byte 0

uirow4          text "osc. 1      -/+   osc. 2      -/+"
                byte 0

uirow5          text "----------- ---   ----------- ---"
                byte 0

uirow6          text "freq        q/w   freq         /"
                byte 0

uirow7          text ""
                byte 0

uirow8          text "attack      e/r   attack       /"
                byte 0

uirow9          text "decay       t/y   decay        /"
                byte 0

uirow10         text "sustain     d/f   sustain      /"
                byte 0

uirow11         text "release     g/h   release      /"
                byte 0

uirow12         text ""
                byte 0

uirow13         text "wavform     z/x   wavform      -"
                byte 0

uifooter        text "v0.0.6 100% c64 6502 assembly"
                byte 0

; Initialize UI subroutine
initui          ; Clear the screen
                jsr clear

                ; Setup screen colors
                jsr scrnblk

                ; UI text
                jsr uitext

                ldx #0   ; row
                ldy #2    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow1
                ldy #>uirow1
                jsr $ab1e

                ldx #1    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow2
                ldy #>uirow2
                jsr $ab1e

                ldx #2    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow3
                ldy #>uirow3
                jsr $ab1e

                ldx #3    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow4
                ldy #>uirow4
                jsr $ab1e

                ldx #4    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow5
                ldy #>uirow5
                jsr $ab1e

                ldx #5    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow6
                ldy #>uirow6
                jsr $ab1e

                ldx #6    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow7
                ldy #>uirow7
                jsr $ab1e

                ldx #7    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow8
                ldy #>uirow8
                jsr $ab1e

                ldx #8    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow9
                ldy #>uirow9
                jsr $ab1e

                ldx #9    ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow10
                ldy #>uirow10
                jsr $ab1e

                ldx #10   ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow11
                ldy #>uirow11
                jsr $ab1e

                ldx #11   ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow12
                ldy #>uirow12
                jsr $ab1e

                ldx #12   ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uirow13
                ldy #>uirow13
                jsr $ab1e

                ldx #24   ; row
                ldy #0    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #<uifooter
                ldy #>uifooter
                jsr $ab1e

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

                ; Display current trigger length
                ldx #1    ; row
                ldy #14   ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda trlenirq$
                jsr outdecim

                ; Display current trigger interval
                ldx #1    ; row
                ldy #31   ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda trintirq$
                jsr outdecim

                ; Clear previous frequency
                ldx #5    ; row
                ldy #8    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda #$20  ; " "
                jsr $ffd2
                jsr $ffd2
                jsr $ffd2

                ; Display current frequency
                ldx #5    ; row
                ldy #7    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                jsr convertfreq$
                ldx freqlodisp$
                lda freqhidisp$
                jsr NUMOUT

                ; Display current "attack" value
                ldx #7    ; row
                ldy #8    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda attack$
                jsr outdecim

                ; Display current "decay" value
                ldx #8    ; row
                ldy #8    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda decay$
                jsr outdecim

                ; Display current "sustain" value
                ldx #9    ; row
                ldy #8    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda sustain$
                jsr outdecim

                ; Display current "release" value
                ldx #10   ; row
                ldy #8    ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function
                lda release$
                jsr outdecim

                ; Display current "waveform" value
                ldx #12   ; row
                ldy #10   ; column
                clc       ; clc = update position, sec = get position
                jsr $fff0 ; "Position cursor" KERNAL function

                lda waveform$

                cmp #16
                bne not16ui
                lda #$54 ; "T"
                jsr $ffd2
                rts

not16ui         cmp #32
                bne not32ui
                lda #$53 ; "S"
                jsr $ffd2
                rts

not32ui         cmp #64
                bne not64ui
                lda #$50 ; "P"
                jsr $ffd2
                rts

not64ui         lda #$4e ; "N"
                jsr $ffd2

                ; End of subroutine
                rts
; End updateui subroutine

; Main loop
mainloop
                ; Don't end program if RUN/STOP key not pressed
                lda $91
                cmp #$7f
                bne nkey

break           ; Restore original interrupt routine
                jsr uninstall$

                ; Reset screen and end program
                jsr resetui

                ; Done
                rts

nkey            ; If "N" is pressed
                lda $cb
                cmp #$27 ; "N"
                bne mkey
                jsr dectint
                jsr updateui
                jmp mainloop

mkey            ; If "M" is pressed
                lda $cb
                cmp #$24 ; "M"
                bne kkey
                jsr inctint
                jsr updateui
                jmp mainloop

kkey            ; If "K" is pressed
                lda $cb
                cmp #$25 ; "K"
                bne lkey
                jsr dectlen
                jsr updateui
                jmp mainloop

lkey            ; If "L" is pressed
                lda $cb
                cmp #$2a ; "L"
                bne hkey
                jsr inctlen
                jsr updateui
                jmp mainloop

hkey            ; If "H" is pressed
                lda $cb
                cmp #$1d ; "H"
                bne gkey
                jsr increl
                jsr updateui
                jmp mainloop

gkey            ; If "G" is pressed
                lda $cb
                cmp #$1a ; "G"
                bne ykey
                jsr decrel
                jsr updateui
                jmp mainloop

ykey            ; If "Y" is pressed
                lda $cb
                cmp #$19 ; "Y"
                bne tkey
                jsr incdecay
                jsr updateui
                jmp mainloop

                ; If "T" is pressed
tkey            lda $cb
                cmp #$16 ; "T"
                bne fkey
                jsr decdecay
                jsr updateui
                jmp mainloop

                ; If "F" is pressed
fkey            lda $cb
                cmp #$15 ; "F"
                bne dkey
                jsr incsust
                jsr updateui
                jmp mainloop

                ; If "D" is pressed
dkey            lda $cb
                cmp #$12 ; "D"
                bne wkey
                jsr decsust
                jsr updateui
                jmp mainloop

                ; If "W" is pressed
wkey            lda $cb ;
                cmp #$09 ; "W"
                bne qkey
                jsr incfreq
                jsr updateui
                jmp mainloop
                
                ; If "Q" is pressed
qkey            lda $cb
                cmp #$3e ; "Q"
                bne rkey
                jsr decfreq
                jsr updateui
                jmp mainloop

                ; If "R" is pressed
rkey            lda $cb
                cmp #$11 ; "R"
                bne ekey
                jsr incatt
                jsr updateui
                jmp mainloop

                ; If "E" is pressed
ekey            lda $cb
                cmp #$0e ; "E"
                bne zkey
                jsr decatt
                jsr updateui

zkey            ; If "Z" is pressed
                lda $cb
                cmp #$0c ; "Z"
                bne xkey
                jsr waveformleft
                jsr updateui

xkey            ; If "X" is pressed
                lda $cb
                cmp #$17 ; "X"
                bne bottom
                jsr waveformright
                jsr updateui

bottom          ; Bottom of main loop
                jmp mainloop
; End of main loop

; Input handlers
; Increase release
increl          inc release$
                jsr debounce
                rts

; Decrease release
decrel          dec release$
                jsr debounce
                rts

; Increase decay
incdecay        inc decay$
                jsr debounce
                rts

; Decrease decay
decdecay        dec decay$
                jsr debounce
                rts

; Increase sustain
incsust         inc sustain$
                jsr debounce
                rts

; Decrease sustain
decsust         dec sustain$
                jsr debounce
                rts

; Increment frequency
incfreq         lda freqlo$
                sta num1lo$
                lda freqhi$
                sta num1hi$
                lda #255
                sta num2lo$
                lda #0
                sta num2hi$
                jsr addnums$
                lda resultlo$
                sta freqlo$
                lda resulthi$
                sta freqhi$
                jsr debounce
                rts

; Decrease frequency
decfreq         lda freqlo$
                sta num1lo$
                lda freqhi$
                sta num1hi$
                lda #255
                sta num2lo$
                lda #0
                sta num2hi$
                jsr subnums$
                lda resultlo$
                sta freqlo$
                lda resulthi$
                sta freqhi$
                jsr debounce
                rts

; Increase attack
incatt          inc attack$
                jsr debounce
                rts

; Decrease attack
decatt          dec attack$
                jsr debounce
                rts

; Decrease trigger interval
dectint         dec trintirq$
                jsr debounce
                rts

; Increase trigger interval
inctint         inc trintirq$
                jsr debounce
                rts

; Decrease trigger length
dectlen         dec trlenirq$
                jsr debounce
                rts

; Increase trigger length
inctlen         inc trlenirq$
                jsr debounce
                rts

; Waveform left
waveformleft    jsr debounce

                lda waveform$

                ; First edge case: 1000 -> 0001
                cmp #128
                bne not128
                lda #16
                sta waveform$
                rts

not128          asl waveform$
                rts

; Waveform right
waveformright   jsr debounce

                lda waveform$

                ; Second edge case: 0001 -> 1000
                cmp #16
                bne not16
                lda #128
                sta waveform$
                rts

not16           lsr waveform$
                rts
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

1; Debounce key press busywait
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
