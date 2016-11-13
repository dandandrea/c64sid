; Frequency
freqlo$         byte $45
freqhi$         byte $1a
freqlodisp$     byte 0
freqhidisp$     byte 0

; ADSR values
attack$         byte 5
decay$          byte 5
sustain$        byte 15
release$        byte 5

; Waveform
waveform$       byte 64

; Pulse width
pulsewidth$     byte 255,11

; Trigger timings
trintirq$       byte 20 ; Interval between clearing gate bit and then setting it
trlenirq$       byte 10 ; Interval between setting gate bit and then clearing it

; Pointer to original interrupt routine
origlo$         byte $00
orighi$         byte $00
