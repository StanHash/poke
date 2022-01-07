GetTrademonFrontpic:
	ld a, [wOTTrademonSpecies]
	ld hl, wOTTrademonPersonality
	ld de, vTiles2
	push de
	push af
	predef GetUnownLetter
	pop af
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef GetAnimatedFrontpic
	ret

AnimateTrademonFrontpic:
	ld a, [wOTTrademonSpecies]
	call IsAPokemon
	ret c
	farcall ShowOTTrademonStats
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wOTTrademonPersonality]
	ld [wTempMonPersonality], a
	ld a, [wOTTrademonPersonality + 1]
	ld [wTempMonPersonality + 1], a
	ld b, SCGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	farcall TradeAnim_ShowGetmonFrontpic
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	hlcoord 7, 2
	ld d, $0
	ld e, ANIM_MON_TRADE
	predef AnimateFrontpic
	ret
