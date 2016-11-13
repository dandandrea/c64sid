; Frequency
freqlo$         byte $45
freqhi$         byte $04
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

; Filter cutoff frequency: $d415 and $d416
; 11 bits: $d415 bits 0-2, $d416 all bits
filtercutoff$   byte $28,$14

; Filter resonance and control: $d417
; Upper 4 bits = resonance
; Lower 4 bits = 3: ext input, 2: filt voice 3, 1: filt voice 2: 0: filt voice 1
filterres$      byte %00001111
filterctrl$     byte %00000001

; Filter mode: $d418
; Upper bits = 7: mute voice 3, 6: high pass, 5: band pass, 4: low pass
filtermode$     byte %00000001

; Trigger timings
trintirq$       byte 20 ; Interval between clearing gate bit and then setting it
trlenirq$       byte 10 ; Interval between setting gate bit and then clearing it

; Pointer to original interrupt routine
origlo$         byte $00
orighi$         byte $00
