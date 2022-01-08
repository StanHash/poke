UpdateAltFormeDex:
	ld a, [wAltForme]
	ld c, a
	ld b, NUM_ALT_FORME
	ld hl, wAltFormeDex
.loop
	ld a, [hli]
	and a
	jr z, .done
	cp c
	ret z
	dec b
	jr nz, .loop
	ret

.done
	dec hl
	ld [hl], c
	ret
