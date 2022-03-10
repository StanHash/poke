
_GetTimeOfDay::
; get time of day based on the current hour
	ldh a, [hHours] ; hour
	ld hl, .TimesOfDay

.check
; if we're within the given time period,
; get the corresponding time of day
	cp a, [hl]
	jr c, .match
; else, get the next entry
	inc hl
	inc hl
; try again
	jr .check

.match
; get time of day
	inc hl
	ld a, [hl]
	ld [wTimeOfDay], a
	ret

.TimesOfDay:
; hours for the time of day
; 0400-0959 morn | 1000-1759 day | 1800-0359 nite
	db MORN_HOUR, NITE_F
	db DAY_HOUR,  MORN_F
	db NITE_HOUR, DAY_F
	db MAX_HOUR,  NITE_F
	db -1, MORN_F

_ResetTime::
	ld a, 10
	ldh [hHours], a
	xor a
	ldh [hMinutes], a
	ldh [hMinutesDecimal], a
	ld [wCurDay], a
	ret

BackupInGameTime::
	ld hl, wInGameTimeBackup
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hMinutesDecimal]
	ld [hli], a
	ret

RestoreInGameTime::
	ld hl, wInGameTimeBackup
	ld a, [hli]
	ld [wCurDay], a
	ld a, [hli]
	ldh [hHours], a
	ld a, [hli]
	ldh [hMinutes], a
	ld a, [hli]
	ldh [hMinutesDecimal], a
	ret

AdvanceTime::
	; increment minutes decimal
	ld hl, hMinutesDecimal
	inc [hl]
	ret nz

	; if minutes decimal overflow
	; increment minutes

	ld hl, hMinutes
	ld a, [hl]
	inc a
	cp a, 60
	jr z, .increment_hours
	ld [hl], a
	ret

.increment_hours:
	xor a
	ld [hl], a

	; if minutes overflow
	; increment hours

	ld hl, hHours
	ld a, [hl]
	inc a
	cp a, 24
	jr z, .increment_days
	ld [hl], a
	ret

.increment_days:
	xor a
	ld [hl], a

	; if hours overflow
	; increment days

	ld hl, wCurDay
	ld a, [hl]
	inc a
	cp a, 7
	jr z, .reset_days
	ld [hl], a
	ret

.reset_days:
	xor a
	ld [hl], a
	ret
