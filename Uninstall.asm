uninstall$      ; Disable interrupts
                sei

                ; Further protection against interrupts firing
                lda #$7f
                sta $dc0d
                sta $dd0d
                lda $dc0d
                lda $dd0d

                ; Disable raster interrupts
                lda #$00
                sta $d01a

                ; Point the machine to the original interrupt routine
                lda origlo$
                sta $0314
                lda orighi$
                sta $0315

                ; Clear pointer to original interrupt routine
                lda #$00
                sta origlo$
                sta orighi$

                ; ACK CIA and VIC interrupts
                lda $dc0d
                lda $dd0d
                asl $d019

                ; Enable interrupts
                cli
