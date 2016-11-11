; 16-bit addition and subtraction
; Lifted from http://codebase64.org/doku.php?id=base:16bit_addition_and_subtraction

num1lo$ byte 0
num1hi$ byte 0
num2lo$ byte 0
num2hi$ byte 0
resultlo$ byte 0
resulthi$ byte 0

; adds numbers 1 and 2, writes result to separate location
addnums$        clc           ; clear carry
                lda num1lo$
                adc num2lo$
                sta resultlo$ ; store sum of LSBs
                lda num1hi$
                adc num2hi$   ; add the MSBs using carry from
                sta resulthi$ ; the previous calculation
                rts

; subtracts number 2 from number 1 and writes result out
subnums$        sec           ; set carry for borrow purpose
                lda num1lo$
                sbc num2lo$   ; perform subtraction on the LSBs
                sta resultlo$
                lda num1hi$   ; do the same for the MSBs, with carry
                sbc num2hi$   ; set according to the previous result
                sta resulthi$
                rts
