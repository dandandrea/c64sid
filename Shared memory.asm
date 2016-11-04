; Shared memory locations
                *=$1500

; Frequency
freqlo          byte $00
freqhi          byte $24

; ADSR values
attack          byte 3
decay           byte 3
sustain         byte $aa
release         byte 4

; Pointer to original interrupt routine
origlo          byte $00
orighi          byte $00
