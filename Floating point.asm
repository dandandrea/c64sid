TXTPTR1 = $7a
TXTPTR2 = $7b
CHRGOT = $79
STROUT = $ab1e
CONUPK = $ba8c
FDIVT = $bb12
FMULT = $ba2b
QINT = $bc9b
ASCFLOAT = $bcf3
FOUT = $bddd
ROUNDFAC = $bc1b

; TODO: Generalize these functions

convertfreq$    ; Store first number in FAC
                ldy freqlo$
                lda freqhi$
                sty $63
                sta $62
                ldx #$90
                sec
                jsr $bc49

                ; Copy FAC to faccopy
                ldx #<faccopy
                ldy #>faccopy
                jsr $bbd4

                ; Store second number in FAC
                lda #<freqfactor
                ldy #>freqfactor
                sta TXTPTR1
                sty TXTPTR2
                jsr CHRGOT
                jsr ASCFLOAT

                ; Copy faccopy to ARG
                lda #<faccopy
                ldy #>faccopy
                jsr CONUPK

                ; Perform the multiplication (result in FAC)
                lda $61
                jsr FMULT

                ; Convert to integer (stored in FAC)
                jsr QINT

                lda $65
                sta freqlodisp$
                lda $64
                sta freqhidisp$

                ; Done
                rts

convertpw$      ; Store pulse width in FAC (FAC holds pulse width)
                ldy pulsewidth$
                lda pulsewidth$ + 1
                sty $63
                sta $62
                ldx #$90
                sec
                jsr $bc49

                ; Copy FAC to faccopy (faccopy holds pulse width)
                ldx #<faccopy
                ldy #>faccopy
                jsr $bbd4

                ; Store pulse width in FAC (FAC holds pw factor)
                lda #<pwfactor
                ldy #>pwfactor
                sta TXTPTR1
                sty TXTPTR2
                jsr CHRGOT
                jsr ASCFLOAT

                ; Copy faccopy to ARG (ARG holds pulse width)
                lda #<faccopy
                ldy #>faccopy
                jsr CONUPK

                ; Perform the division
                lda $61
                jsr FDIVT ; FAC = ARG / FAC

                ; Convert to integer (stored in FAC)
                jsr QINT

                ; Lowest byte of result is the output
                lda $65

                ; Done
                rts

freqfactor      text "0.0609592" ; text
                byte 0 ; Null-terminated string

pwfactor        text "40.95" ; text
                byte 0 ; Null-terminated string

faccopy         byte 0,0,0,0,0