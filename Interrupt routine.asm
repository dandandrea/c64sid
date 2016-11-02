; Program starts at $2000 (SYS 8192)
                *=$2000

; Initialize SID
begin            jsr initsid

; Load new interrupt routine
check           ; Don't install twice
                lda origlo
                cmp #$00
                beq install

                ; Already installed
                rts

install         ; Disable interrupts
                sei

                ; Further protection against interrupts firing
                lda #$7f
                sta $dc0d
                sta $dd0d
                lda $dc0d
                lda $dd0d

                ; Enable raster interrupts
                lda #$01
                sta $d01a

                ; Make copy of original interrupt routine's address
                lda $0314
                sta origlo
                lda $0315
                sta orighi

                ; Point the machine to our new interrupt routine
                lda #<main
                sta $0314
                lda #>main
                sta $0315

                ; ACK CIA and VIC interrupts
                lda $dc0d
                lda $dd0d
                asl $d019

                ; Enable interrupts
                cli

                ; Done
                rts
; New interrupt routine loaded

; Our interrupt routine
main            ; Acknowledge IRQ
                dec $d019

                ; Save register values
                pha ; a
                txa
                pha ; x
                tya
                pha ; y

                ; 60th call?
                lda counter
                cmp #60
                bne notsixty

                ; Yes
                jsr sixty
                
notsixty        ; Increment the counter
                inc counter

                ; Restore register values
                pla ; y
                tay
                pla ; x
                tax
                pla ; a

                ; Done, now call original interrupt routine
                jmp (origlo) ; Now call the original interrupt routine
; End of our interrupt routine

; Every-60-seconds routine
sixty           ; Display output
                lda gateset
                cmp #00
                bne noton

                ; Display indicator
                lda #3 ; Cyan text
                sta $0286
                lda #$2a
                sta $0400
                jmp inddone

noton           ; Clear indicator
                lda #$20
                sta $0400

                ; Play SID
inddone         jsr playsid

                ; Increment output
                inc output

                ; Reset counter
                lda #0
                sta counter

                ; Roll output if it reaches its max value
                lda output
                cmp maxout
                beq resetout
                jmp noreset

resetout        lda minout
                sta output

noreset         ; Done
                rts
; End of every-60-seconds routine

origlo          byte $00
orighi          byte $00
counter         byte $00
output          byte $30
minout          byte $30
maxout          byte $3a

; SID play routine
playsid         ; Set ADSR
                lda attack
                ora decay
                sta $d405
                lda sustain
                ora release
                sta $d406

                ; Set frequency
                lda freqlo
                sta $d400
                lda freqhi
                sta $d401

                ; Alternate gate bit
                lda gateset
                cmp #$00
                beq setgate
                jmp clrgate

setgate         ; Set gate bit
                lda #%00000001
                ora $d404
                sta $d404

                ; Toggle gate bit variable
                lda #$01
                sta gateset

                ; Done setting gate bit
                jmp gatedone

clrgate         ; Clear gate bit
                lda #%11111110
                ora $d404
                sta $d404                

                ; Toggle gate bit variable
                lda #$00
                sta gateset

                ; Bottom of SID play routine
gatedone        rts
; End of SID play routine

gateset         byte $00

; SID initialization routine
initsid         ; Clear SID registers
                ldx #$00
                lda #$00

initsidl        sta $d400,x
                inx
                cpx #$1d ; There are 29 registers, 29 = 0x1d
                bne initsidl

                ; Set SID master volume
                lda #%00001111
                sta $d418

                ; Set waveform
                lda #%00100000
                ora $d404
                sta $d404

                ; Set ADSR
                lda attack
                ora decay
                sta $d405
                lda sustain
                ora release
                sta $d406

                ; Set frequency
                lda freqlo
                sta $d400
                lda freqhi
                sta $d401

                ; Clear gate bit
                lda #%11111110
                ora $d404
                sta $d404                

                ; End of routine
                rts
; End of SID initialization routine
