_Sine::
; a = d * sin(e * pi/32)
	ld a, e
	call .Sine
	ld e, a
	ret

.Sine:
	calc_sine_wave
