HandleHighScoresScreen: ; 0xca7f
	ld a, [wScreenState]
	rst JumpTable  ; calls JumpToFuncInTable
HighScoresScreenFunctions: ; 0xca83
	dw Func_ca8f
	dw Func_cb14
	dw Func_ccac
	dw Func_ccb6
	dw Func_cd6c
	dw ExitHighScoresScreen

Func_ca8f: ; 0xca8f
	ld hl, wHighScoreId
	call GenRandom
	ld [hli], a
	call GenRandom
	ld [hli], a
	call GenRandom
	ld [hli], a
	call GenRandom
	ld [hli], a
	ld hl, wRedHighScore5Points + $5
	ld a, [wHighScoresStage]
	and a
	jr z, .asm_caae
	ld hl, wBlueHighScore5Points + $5
.asm_caae
	ld b, $5
.asm_cab0
	ld de, wScore + $5
	ld c, $6
.asm_cab5
	ld a, [de]
	cp [hl]
	jr c, .asm_cad0
	jr nz, .asm_cac2
	dec de
	dec hl
	dec c
	jr nz, .asm_cab5
	jr .asm_cad0

.asm_cac2
	dec hl
	dec c
	jr nz, .asm_cac2
	ld a, l
	sub $7
	ld l, a
	jr nc, .asm_cacd
	dec h
.asm_cacd
	dec b
	jr nz, .asm_cab0
.asm_cad0
	ld a, b
	ld [wHighScoreNameRow], a
	xor a
	ld [wHighScoreNameColumn], a
	inc b
	ld hl, wRedHighScore4Id + 3
	ld de, wRedHighScore5Id + 3
	ld a, [wHighScoresStage]
	and a
	jr z, .asm_caeb
	ld hl, wBlueHighScore4Id + 3
	ld de, wBlueHighScore5Id + 3
.asm_caeb
	ld a, $5
.asm_caed
	cp b
	jr c, .asm_cb02
	push af
	jr nz, .asm_caf6
	ld hl, wHighScoreId + $3
.asm_caf6
	ld c, $d
.asm_caf8
	ld a, [hld]
	ld [de], a
	dec de
	dec c
	jr nz, .asm_caf8
	pop af
	dec a
	jr nz, .asm_caed
.asm_cb02
	ld a, [wHighScoreNameRow]
	cp $5
	ld a, $1
	jr nz, .asm_cb0c
	xor a
.asm_cb0c
	ld [wHighScoreIsEnteringName], a
	ld hl, wScreenState
	inc [hl]
	ret

Func_cb14: ; 0xcb14
	ld a, $43
	ldh [hLCDC], a
	ld a, $e0
	ld [wBGP], a
	ld a, $e1
	ld [wOBP0], a
	ld [wOBP1], a
	xor a
	ldh [hSCX], a
	ldh [hNextFrameHBlankSCX], a
	ldh [hSCY], a
	ldh [hNextFrameHBlankSCY], a
	ld a, $e
	ldh [hLYC], a
	ldh [hLastLYC], a
	ld a, $82
	ldh [hNextLYCSub], a
	ldh [hLYCSub], a
	ld hl, hSTAT
	set 6, [hl]
	ld hl, rIE
	set 1, [hl]
	ld a, $3
	ldh [hStatIntrRoutine], a
	ldh a, [hGameBoyColorFlag]
	and a
	jr z, .asm_cb51
	ld a, [wHighScoresStage]
	inc a
.asm_cb51
	ld hl, HighScoresVideoDataPointers
	call LoadVideoData
	call ClearSpriteBuffer
	ld a, $20
	ld [wHighScoreNameEntryAsteriskBlinkCounter], a
	call Func_d211
	hlCoord 0, 14, vBGMap
	ld de, wRedHighScore5Id + $3
	call Func_d2cb
	hlCoord 0, 14, vBGWin
	ld de, wBlueHighScore5Id + $3
	call Func_d2cb
	ld a, [wHighScoresStage]
	and a
	jr z, .asm_cb7f
	ld hl, hLCDC
	set 3, [hl]
.asm_cb7f
	call SetAllPalettesWhite
	ld a, [wHighScoreIsEnteringName]
	and a
	jr z, .asm_cbbd
	ld a, [wHighScoreNameRow]
	and a
	jr nz, .asm_cb9b
	ld a, Bank(Music_EndCredits)
	call SetSongBank
	ld de, MUSIC_END_CREDITS
	call PlaySong
	jr .asm_cba6

.asm_cb9b
	ld a, Bank(Music_NameEntry)
	call SetSongBank
	ld de, MUSIC_NAME_ENTRY
	call PlaySong
.asm_cba6
	call EnableLCD
	ld bc, $0009
	call Func_d68a
	ld bc, $03c9
	call Func_d68a
	call FadeIn
	ld hl, wScreenState
	inc [hl]
	ret

.asm_cbbd
	ld a, Bank(Music_HiScore)
	call SetSongBank
	ld de, MUSIC_HI_SCORE
	call PlaySong
	call EnableLCD
	ld bc, $0009
	call Func_d68a
	ld bc, $03c9
	call Func_d68a
	call FadeIn
	ld hl, wScreenState
	inc [hl]
	ld hl, wScreenState
	inc [hl]
	ret

HighScoresVideoDataPointers: ; 0xcbe3
	dw HighScoresVideoData_GameBoy
	dw HighScoresRedStageVideoData_GameBoyColor
	dw HighScoresBlueStageVideoData_GameBoyColor

HighScoresVideoData_GameBoy: ; 0xcbe9
	VIDEO_DATA_TILES HighScoresBaseGameBoyGfx, vTilesOB, $1800
	VIDEO_DATA_TILEMAP HighScoresTilemap, vBGMap, $400
	VIDEO_DATA_TILEMAP HighScoresTilemap2, vBGWin, $400
	dw HighScoresTilemap + $3c0
	db Bank(HighScoresTilemap)
	dw vBGMap
	dw ($40 << 2)
	dw HighScoresTilemap + $280
	db Bank(HighScoresTilemap)
	dw vBGMap + $200
	dw ($40 << 2)
	dw HighScoresTilemap2 + $3c0
	db Bank(HighScoresTilemap2)
	dw vBGWin
	dw ($40 << 2)
	dw HighScoresTilemap2 + $280
	db Bank(HighScoresTilemap2)
	dw vBGWin + $200
	dw ($40 << 2)
	db $FF, $FF  ; terminators

HighScoresRedStageVideoData_GameBoyColor: ; 0xcc1c
	VIDEO_DATA_TILES HighScoresBaseGameBoyGfx, vTilesOB, $1800
	VIDEO_DATA_TILEMAP HighScoresTilemap, vBGMap, $400
	VIDEO_DATA_TILEMAP HighScoresTilemap2, vBGWin, $400
	VIDEO_DATA_TILEMAP_BANK2 HighScoresTilemap4, vBGMap, $400
	VIDEO_DATA_TILEMAP_BANK2 HighScoresTilemap5, vBGWin, $400
	dw HighScoresTilemap + $3c0
	db Bank(HighScoresTilemap)
	dw vBGMap
	dw ($40 << 2)
	dw HighScoresTilemap + $280
	db Bank(HighScoresTilemap)
	dw vBGMap + $200
	dw ($40 << 2)
	dw HighScoresTilemap2 + $3c0
	db Bank(HighScoresTilemap2)
	dw vBGWin
	dw ($40 << 2)
	dw HighScoresTilemap2 + $280
	db Bank(HighScoresTilemap2)
	dw vBGWin + $200
	dw ($40 << 2)
	VIDEO_DATA_PALETTES HighScoresRedStagePalettes, $80
	db $FF, $FF

HighScoresBlueStageVideoData_GameBoyColor: ; 0xcc64
	VIDEO_DATA_TILES HighScoresBaseGameBoyGfx, vTilesOB, $1800
	VIDEO_DATA_TILEMAP HighScoresTilemap, vBGMap, $400
	VIDEO_DATA_TILEMAP HighScoresTilemap2, vBGWin, $400
	VIDEO_DATA_TILEMAP_BANK2 HighScoresTilemap4, vBGMap, $400
	VIDEO_DATA_TILEMAP_BANK2 HighScoresTilemap5, vBGWin, $400
	dw HighScoresTilemap + $3c0
	db Bank(HighScoresTilemap)
	dw vBGMap
	dw ($40 << 2)
	dw HighScoresTilemap + $280
	db Bank(HighScoresTilemap)
	dw vBGMap + $200
	dw ($40 << 2)
	dw HighScoresTilemap2 + $3c0
	db Bank(HighScoresTilemap2)
	dw vBGWin
	dw ($40 << 2)
	dw HighScoresTilemap2 + $280
	db Bank(HighScoresTilemap2)
	dw vBGWin + $200
	dw ($40 << 2)
	VIDEO_DATA_PALETTES HighScoresBlueStagePalettes, $80
	db $FF, $FF  ; terminators

Func_ccac: ; 0xccac
	call Func_d18b
	call Func_d1d2
	call Func_d211
	ret

Func_ccb6: ; 0xccb6
	call Func_d4cf
	call AnimateHighScoresArrow
	ldh a, [hNewlyPressedButtons]
	bit BIT_A_BUTTON, a
	jr z, .asm_ccd1
	lb de, $00, $01
	call PlaySoundEffect
	ld hl, wScreenState
	inc [hl]
	ld hl, wScreenState
	inc [hl]
	ret

.asm_ccd1
	bit 1, a
	jr z, .asm_cce4
	lb de, $00, $01
	call PlaySoundEffect
	ld hl, wScreenState
	inc [hl]
	ld hl, wScreenState
	inc [hl]
	ret

.asm_cce4
	bit 3, a
	jr z, .asm_ccfb
	call Func_1a43
	ldh a, [hGameBoyColorFlag]
	ld [wd8f0], a
	lb de, $00, $01
	call PlaySoundEffect
	ld hl, wScreenState
	inc [hl]
	ret

.asm_ccfb
	ldh a, [hJoypadState]
	cp (SELECT | D_UP)
	ret nz
	ldh a, [hNewlyPressedButtons]
	and (SELECT | D_UP)
	ret z
	lb de, $00, $01
	call PlaySoundEffect
	call ClearSpriteBuffer
	ld bc, $473b
	ld a, SPRITE_HIGH_SCORES_DELETE_DATA
	call LoadSpriteData
.waitForDeleteScoresConfirmation
	rst AdvanceFrame
	ldh a, [hNewlyPressedButtons]
	bit BIT_B_BUTTON, a
	jr z, .asm_cd24
	lb de, $00, $01
	call PlaySoundEffect
	ret

.asm_cd24
	bit 0, a
	jr z, .waitForDeleteScoresConfirmation
	lb de, $00, $01
	call PlaySoundEffect
	call CopyInitialHighScores
	ld a, BANK(HighScoresTilemap)
	ld hl, HighScoresTilemap + $40
	deCoord 0, 2, vBGMap
	ld bc, $01c0
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap2)
	ld hl, HighScoresTilemap2 + $40
	deCoord 0, 2, vBGWin
	ld bc, $01c0
	call LoadVRAMData
	hlCoord 0, 14, vBGMap
	ld de, wRedHighScore5Id + $3
	call Func_d361
	hlCoord 0, 14, vBGWin
	ld de, wBlueHighScore5Id + $3
	call Func_d361
	ld hl, wHighScores
	ld de, sHighScores
	ld bc, wHighScoresEnd - wHighScores
	call SaveData
	ret

Func_cd6c: ; 0xcd6c
	ldh a, [hFrameCounter]
	and $1f
	call z, Func_1a43
	call Func_cf7d
	call Func_cfa6
	ldh a, [hNewlyPressedButtons]
	bit BIT_A_BUTTON, a
	jr z, .asm_cdbb
	lb de, $00, $01
	call PlaySoundEffect
	ld a, [wHighScoresPrintSendSelection]
	and a
	jr nz, .asm_cda1
	ld a, [wd86e]
	and a
	jr z, .asm_cdbb
	call ClearSpriteBuffer
	ld bc, $473b
	ld a, SPRITE_HIGH_SCORES_PRINTING
	call LoadSpriteData
	call Func_d042
	jr .asm_cdc6

.asm_cda1
	ld a, [wd8f0]
	and a
	jr z, .asm_cdbb
	ld de, MUSIC_NOTHING
	call PlaySong
	rst AdvanceFrame
	call Func_cdce
	push af
	ld de, MUSIC_HI_SCORE
	call PlaySong
	pop af
	jr nc, .asm_cdc6
.asm_cdbb
	ldh a, [hNewlyPressedButtons]
	bit BIT_B_BUTTON, a
	ret z
	lb de, $00, $01
	call PlaySoundEffect
.asm_cdc6
	xor a
	ldh [rRP], a
	ld hl, wScreenState
	dec [hl]
	ret

Func_cdce: ; 0xcdce
	push af
	ld a, $0
	ld [$abf6], a
	pop af
	call ClearSpriteBuffer
	call Func_1be3
	call SendHighScores
	push af
	ld a, $1
	ld [$abf6], a
	pop af
	di
	ld a, [wd8ea]
	cp $0
	jp nz, .asm_ceb6
	ld a, [wd8e9]
	cp $1
	jr z, .asm_ce23
	push af
	ld a, $2
	ld [$abf6], a
	pop af
	ld b, $82
	ld hl, wRedHighScore1Points
	call Func_1cf8
	ld a, [wd8ea]
	cp $0
	jp nz, .asm_ceb6
	push af
	ld a, $3
	ld [$abf6], a
	pop af
	ld hl, wc4c0
	call Func_1dda
	ld a, [wd8ea]
	cp $0
	jp nz, .asm_ceb6
	jr .asm_ce4d

.asm_ce23
	push af
	ld a, $4
	ld [$abf6], a
	pop af
	ld hl, wc4c0
	call Func_1dda
	ld a, [wd8ea]
	cp $0
	jr nz, .asm_ceb6
	push af
	ld a, $5
	ld [$abf6], a
	pop af
	ld b, $82
	ld hl, wRedHighScore1Points
	call Func_1cf8
	ld a, [wd8ea]
	cp $0
	jr nz, .asm_ceb6
.asm_ce4d
	push af
	ld a, $6
	ld [$abf6], a
	pop af
	call Func_ceca
	rst AdvanceFrame
	ld hl, wc4cc
	ld b, $5
.asm_ce5d
	push bc
	push hl
	ld d, h
	ld e, l
	ld hl, wRedHighScore5Id + $3
	call Func_cfcb
	pop hl
	pop bc
	ld de, $000d
	add hl, de
	dec b
	jr nz, .asm_ce5d
	push af
	ld a, $7
	ld [$abf6], a
	pop af
	ld hl, wBottomMessageText + $0d
	ld b, $5
.asm_ce7c
	push bc
	push hl
	ld d, h
	ld e, l
	ld hl, wBlueHighScore5Id + $3
	call Func_cfcb
	pop hl
	pop bc
	ld de, $000d
	add hl, de
	dec b
	jr nz, .asm_ce7c
	push af
	ld a, $8
	ld [$abf6], a
	pop af
	hlCoord 0, 14, vBGMap
	ld de, wRedHighScore5Id + $3
	call Func_d361
	hlCoord 0, 14, vBGWin
	ld de, wBlueHighScore5Id + $3
	call Func_d361
	ld hl, wHighScores
	ld de, sHighScores
	ld bc, wHighScoresEnd - wHighScores
	call SaveData
	and a
	ret

.asm_ceb6
	push af
	ld a, $9
	ld [$abf6], a
	pop af
	call Func_ceca
	rst AdvanceFrame
	push af
	ld a, $a
	ld [$abf6], a
	pop af
	scf
	ret

Func_ceca: ; 0xceca
	ldh a, [rLY]
	and a
	jr nz, Func_ceca
	ei
	ret

SendHighScores: ; 0xced1
; Sends high scores, and plays the animation for sending the high scores.
	ld hl, SendHighScoresAnimationData
	ld de, wSendHighScoresAnimationFrameCounter
	call InitAnimation
	ld bc, $4800
	ld a, [wSendHighScoresAnimationFrame]
	call LoadSpriteData
	ld bc, $473b
	ld a, SPRITE_SENDING_HIGH_SCORES_TEXT
	call LoadSpriteData
	call CleanSpriteBuffer
	rst AdvanceFrame
	ld a, $1
	ld [wd8e9], a
	ld b, $b4  ; maximum attempts to send high scores
.attemptToSendHighScoresLoop
	push bc
	xor a
	ldh [hNumFramesSinceLastVBlank], a
.asm_cefa
	ld b, $2
	ld c, $56
	ldh a, [$ff00+c]
	and b
	jr z, .asm_cf09
	ldh a, [hNumFramesSinceLastVBlank]
	and a
	jr z, .asm_cefa
	jr .asm_cf0e

.asm_cf09
	call Func_1c50
	jr .continueAttempts

.asm_cf0e
	ld hl, SendHighScoresAnimationData
	ld de, wSendHighScoresAnimation
	call UpdateAnimation
	jr nc, .continueAttempts
	ld bc, $4800
	ld a, [wSendHighScoresAnimationFrame]
	call LoadSpriteData
	ld bc, $473b
	ld a, SPRITE_SENDING_HIGH_SCORES_TEXT
	call LoadSpriteData
	call CleanSpriteBuffer
	call Func_1ca1
	ld a, [wSendHighScoresAnimationIndex]
	cp $6
	jr nz, .continueAttempts
	ld hl, SendHighScoresAnimationData
	ld de, wSendHighScoresAnimationFrameCounter
	call InitAnimation
.continueAttempts
	pop bc
	ld a, [wd8ea]
	cp $0
	ret z
	dec b
	jr nz, .attemptToSendHighScoresLoop
	ret

SendHighScoresAnimationData: ; 0xcf4b
; Each entry is [sprite id][duration]
	db $0C, SPRITE_SEND_HIGH_SCORES_0
	db $06, SPRITE_SEND_HIGH_SCORES_1
	db $0A, SPRITE_SEND_HIGH_SCORES_2
	db $0C, SPRITE_SEND_HIGH_SCORES_3
	db $0A, SPRITE_SEND_HIGH_SCORES_4
	db $06, SPRITE_SEND_HIGH_SCORES_5
	db $00  ; terminator

Func_cf58: ; 0xcf58
	cp SPRITE_HIGH_SCORES_ERROR_DIALOGS_COUNT + 1
	ret z
	push af
	lb de, $00, $02
	call PlaySoundEffect
	call ClearSpriteBuffer
	rst AdvanceFrame
	pop af
	ld bc, $473b
	add SPRITE_HIGH_SCORES_ERROR_DIALOGS - 1
	call LoadSpriteData
.asm_cf6f
	rst AdvanceFrame
	ldh a, [hNewlyPressedButtons]
	bit BIT_A_BUTTON, a
	jr z, .asm_cf6f
	lb de, $00, $01
	call PlaySoundEffect
	ret

Func_cf7d: ; 0xcf7d
	ld a, [wNewlyPressedButtonsPersistent]
	ld b, a
	ld a, [wHighScoresPrintSendSelection]
	bit 6, b
	jr z, .asm_cf95
	and a
	ret z
	dec a
	ld [wHighScoresPrintSendSelection], a
	lb de, $00, $03
	call PlaySoundEffect
	ret

.asm_cf95
	bit 7, b
	ret z
	cp $1
	ret z
	inc a
	ld [wHighScoresPrintSendSelection], a
	lb de, $00, $03
	call PlaySoundEffect
	ret

Func_cfa6: ; 0xcfa6
	ld bc, $473b
	ld a, SPRITE_HIGH_SCORES_PRINT_SEND_DIALOG_TEXT
	call LoadSpriteData
	ld a, [wd8f0]
	and a
	jr z, .asm_cfb6
	ld a, $2
.asm_cfb6
	ld e, a
	ld a, [wd86e]
	add e
	xor $3
	add SPRITE_HIGH_SCORES_PRINT_SEND_DIALOG_DISABLED
	call LoadSpriteData
	ld a, [wHighScoresPrintSendSelection]
	add SPRITE_HIGH_SCORES_PRINT_SEND_DIALOG_SELECTION
	call LoadSpriteData
	ret

Func_cfcb: ; 0xcfcb
	ld a, e
	ldh [hHighscoresFF8C], a
	ld a, d
	ldh [hHighscoresFF8C + 1], a
	push hl
	ld b, $5
.asm_cfd4
	ldh a, [hHighscoresFF8C]
	ld e, a
	ldh a, [hHighscoresFF8C + 1]
	ld d, a
	call Func_d005
	call Func_d017
	jr c, .asm_cfe5
	dec b
	jr nz, .asm_cfd4
.asm_cfe5
	inc b
	pop de
	ld hl, $fff3
	add hl, de
	ld a, $5
.asm_cfed
	cp b
	ret c
	push af
	jr nz, .asm_cff8
	ldh a, [hHighscoresFF8C]
	ld l, a
	ldh a, [hHighscoresFF8C + 1]
	ld h, a
.asm_cff8
	ld c, $d
.asm_cffa
	ld a, [hld]
	ld [de], a
	dec de
	dec c
	jr nz, .asm_cffa
	pop af
	dec a
	jr nz, .asm_cfed
	ret

Func_d005: ; 0xd005
	ld c, $7
.asm_d007
	ld a, [de]
	cp [hl]
	jr nz, .asm_d010
	dec de
	dec hl
	dec c
	jr nz, .asm_d007
.asm_d010
	ld a, c
	ldh [hHighscoresFF8E], a
	call Func_d035
	ret

Func_d017: ; 0xd017
	ld c, $6
.asm_d019
	ld a, [de]
	cp [hl]
	jr c, .asm_d02b
	jr nz, .asm_d030
	dec de
	dec hl
	dec c
	jr nz, .asm_d019
	ldh a, [hHighscoresFF8E]
	and a
	jr nz, .asm_d02b
	ld b, $5
.asm_d02b
	call Func_d035
	scf
	ret

.asm_d030
	call Func_d035
	and a
	ret

Func_d035: ; 0xd035
	ld a, e
	sub c
	ld e, a
	jr nc, .asm_d03b
	dec d
.asm_d03b
	ld a, l
	sub c
	ld l, a
	jr nc, .asm_d041
	dec h
.asm_d041
	ret

Func_d042: ; 0xd042
	ldh a, [hJoypadState]
	ld [wda86], a
	ld b, a
	ld a, $80
	bit BIT_D_LEFT, b
	jr z, .asm_d052
	ld a, $7f
	jr .asm_d058

.asm_d052
	bit BIT_D_RIGHT, b
	jr z, .asm_d058
	ld a, $10
.asm_d058
	ld [wd8a7], a
	ld a, $e0
	ld [wd8aa], a
	ld a, BANK(HighScoresTilemap)
	ld hl, HighScoresTilemap + $3c0
	ld de, wSendHighScoresTopBarTilemap
	ld bc, $0040
	call FarCopyData
	ld a, $0
	hlCoord 0, 2, vBGMap
	ld de, wSendHighScoresTopBarTilemap + $40
	ld bc, $01c0
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap)
	ld hl, HighScoresTilemap + $280
	ld de, wSendHighScoresTopBarTilemap + $200
	ld bc, $0040
	call FarCopyData
	call Func_d6b6
	call Func_d0e3
	ret c
	ld a, [wda86]
	bit 2, a
	jr z, .asm_d0a2
	ld de, wRedHighScore1Id
	call Func_d107
	call Func_d0f5
	ret c
.asm_d0a2
	ld a, BANK(HighScoresTilemap2)
	ld hl, HighScoresTilemap2 + $3c0
	ld de, wSendHighScoresTopBarTilemap
	ld bc, $0040
	call FarCopyData
	ld a, $0
	hlCoord 0, 2, vBGWin
	ld de, wSendHighScoresTopBarTilemap + $40
	ld bc, $01c0
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap2)
	ld hl, HighScoresTilemap2 + $280
	ld de, wSendHighScoresTopBarTilemap + $200
	ld bc, $0040
	call FarCopyData
	call Func_d6b6
	call Func_d0e3
	ret c
	ld a, [wda86]
	bit 2, a
	ret z
	ld de, wBlueHighScore1Id
	call Func_d107
	call Func_d0f5
	ret

Func_d0e3: ; 0xd0e3
	ld a, BANK(HighScoresBaseGameBoyGfx)
	ld hl, HighScoresBaseGameBoyGfx + $800
	call Func_1a21
	ld a, [wd86d]
	and a
	ret z
	call Func_cf58
	scf
	ret

Func_d0f5: ; 0xd0f5
	ld a, BANK(HighScoresHexadecimalCharsGfx)
	ld hl, HighScoresHexadecimalCharsGfx
	call Func_1a21
	ld a, [wd86d]
	and a
	ret z
	call Func_cf58
	scf
	ret

Func_d107: ; 0xd107
	ld hl, wSendHighScoresTopBarTilemap
	ld a, $c0
	ld b, $20
.clear
rept 32
	ld [hli], a
endr
	dec b
	jr nz, .clear
	ld hl, wSendHighScoresTopBarTilemap
	ld b, $5
.loop
	ld c, $4
.inner
	ld a, [de]
	swap a
	call Func_d159
	ld a, [de]
	call Func_d159
	inc de
	inc hl
	dec c
	jr nz, .inner
	ld a, l
	add $4c
	ld l, a
	jr nc, .no_carry_1
	inc h
.no_carry_1
	ld a, e
	add $9
	ld e, a
	jr nc, .no_carry_2
	inc d
.no_carry_2
	dec b
	jr nz, .loop
	ret

Func_d159: ; 0xd159
	and $f
	sla a
	sla a
	xor $80
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	push bc
	push hl
	ld bc, $001e
	add hl, bc
	ld [hli], a
	inc a
	ld [hli], a
	pop hl
	pop bc
	ret

ExitHighScoresScreen: ; 0xd171
	call FadeOut
	call DisableLCD
	ld hl, hSTAT
	res 6, [hl]
	ld hl, rIE
	res 1, [hl]
	ld a, SCREEN_TITLESCREEN
	ld [wCurrentScreen], a
	xor a
	ld [wScreenState], a
	ret

Func_d18b: ; 0xd18b
	ldh a, [hPressedButtons]
	ld b, a
	ld a, [wHighScoreNameRow]
	ld e, a
	sla e
	sla e
	add e
	sla e
	add e
	ld e, a
	ld a, [wHighScoreNameColumn]
	add e
	ld e, a
	ld d, $0
	ld hl, wRedHighScore1Name
	ld a, [wHighScoresStage]
	and a
	jr z, .asm_d1ae
	ld hl, wBlueHighScore1Name
.asm_d1ae
	add hl, de
	ld a, [hl]
	bit 4, b
	jr z, .asm_d1bd
	inc a
	cp $38
	jr nz, .asm_d1c7
	ld a, $a
	jr .asm_d1c7

.asm_d1bd
	bit 5, b
	ret z
	dec a
	cp $9
	jr nz, .asm_d1c7
	ld a, $37
.asm_d1c7
	ld [hl], a
	call Func_d46f
	lb de, $00, $03
	call PlaySoundEffect
	ret

Func_d1d2: ; 0xd1d2
	ldh a, [hNewlyPressedButtons]
	ld b, a
	ld a, [wHighScoreNameColumn]
	bit BIT_A_BUTTON, b
	jr z, .asm_d1fc
	inc a
	cp $3
	jr nz, .asm_d202
	lb de, $07, $45
	call PlaySoundEffect
	xor a
	ld [wHighScoreIsEnteringName], a
	ld hl, wScreenState
	inc [hl]
	ld hl, wHighScores
	ld de, sHighScores
	ld bc, wHighScoresEnd - wHighScores
	call SaveData
	ret

.asm_d1fc
	bit 1, b
	ret z
	and a
	ret z
	dec a
.asm_d202
	ld [wHighScoreNameColumn], a
	ld a, $20
	ld [wHighScoreNameEntryAsteriskBlinkCounter], a
	lb de, $00, $01
	call PlaySoundEffect
	ret

Func_d211: ; 0xd211
; related to high scores name entry?
	ld a, [wHighScoreIsEnteringName]
	and a
	ret z
	ldh a, [hJoypadState]
	and (D_RIGHT | D_LEFT)
	jr z, .asm_d221
	; current name entry character changed; hide asterisk to show new letter
	xor a
	ld [wHighScoreNameEntryAsteriskBlinkCounter], a
	ret

.asm_d221
	ld a, [wHighScoreNameEntryAsteriskBlinkCounter]
	inc a
	ld [wHighScoreNameEntryAsteriskBlinkCounter], a
	bit 5, a
	ret z
	ld a, [wHighScoreNameRow]
	ld e, a
	ld d, $0
	ld hl, SpritePixelYOffsets_Names
	add hl, de
	ld c, [hl]
	ld a, [wHighScoreNameColumn]
	ld e, a
	ld d, $0
	ld hl, SpritePixelXOffsets_Names
	add hl, de
	ld b, [hl]
	ld a, SPRITE_HIGH_SCORES_NAME_ENTRY_ASTERISK
	call LoadSpriteData
	ret

SpritePixelYOffsets_Names: ; 0xd247
	db $10, $28, $40, $58, $70

SpritePixelXOffsets_Names: ; 0xd24c
	db $18, $20, $28

AnimateHighScoresArrow: ; 0xd24f
; Handles the animation of the arrow in the bottom
; corner of the high scores screens.
	ld a, [wHighScoresArrowAnimationCounter]
	inc a
	cp $28
	jr c, .noOverflow
	xor a
.noOverflow
	ld [wHighScoresArrowAnimationCounter], a
	ld a, [wHighScoresStage]
	and a
	ld c, $77
	ld a, SPRITE_HIGH_SCORES_ARROW_RIGHT
	ld hl, HighScoresRightArrowSpritePixelXOffsets
	jr z, .asm_d26d
	ld a, SPRITE_HIGH_SCORES_ARROW_LEFT
	ld hl, HighScoresLeftArrowSpritePixelXOffsets
.asm_d26d
	push af
	ld a, [wHighScoresArrowAnimationCounter]
	ld e, a
	ld d, $0
	add hl, de
	ld b, [hl]
	pop af
	call LoadSpriteData
	ret

HighScoresRightArrowSpritePixelXOffsets: ; 0xd27b
; Controls the animation of the right-arrow in the bottom corner of the
; high scores screen.
	db $87, $87, $8A, $8A, $8A, $8A, $8A, $8A
	db $89, $89, $88, $88, $88, $88, $88, $88
	db $88, $88, $88, $88, $88, $88, $88, $88
	db $88, $88, $88, $88, $88, $88, $88, $88
	db $88, $88, $88, $88, $88, $88, $88, $88

HighScoresLeftArrowSpritePixelXOffsets: ; 0xd2a3
	db $02, $02, $FF, $FF, $FF, $FF, $FF, $FF
	db $00, $00, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01

Func_d2cb: ; 0xd2cb
	ld b, $5
.asm_d2cd
	push bc
	push hl
	dec de
	dec de
	dec de
	dec de
	ld a, l
	add $5
	ld l, a
	ld b, $3
.asm_d2d9
	ld a, [de]
	call Func_d348
	dec de
	dec hl
	dec b
	jr nz, .asm_d2d9
	pop hl
	push hl
	ld a, l
	add $6
	ld l, a
	ld bc, $0c01
.asm_d2eb
	ld a, [de]
	swap a
	and $f
	call Func_d30e
	inc hl
	dec b
	ld a, [de]
	and $f
	call Func_d30e
	dec de
	inc hl
	dec b
	jr nz, .asm_d2eb
	xor a
	call Func_d317
	pop hl
	ld bc, -3 * $20
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_d2cd
	ret

Func_d30e: ; 0xd30e
	jr nz, Func_d317
	ld a, b
	dec a
	jr z, Func_d317
	ld a, c
	and a
	ret nz
	; fall through
Func_d317: ; 0xd317
	push de
	push af
	call Func_d336
	pop af
	ld c, $0
	sla a
	add e
	ld [hl], a
	cp $fe
	jr z, .asm_d328
	inc a
.asm_d328
	push hl
	push af
	ld a, l
	add $20
	ld l, a
	jr nc, .asm_d331
	inc h
.asm_d331
	pop af
	ld [hl], a
	pop hl
	pop de
	ret

Func_d336: ; 0xd336
	ld e, $6c
	ld a, b
	cp $3
	ret z
	cp $6
	ret z
	cp $9
	ret z
	cp $c
	ret z
	ld e, $58
	ret

Func_d348: ; 0xd348
	ld c, $0
	sla a
	add $90
	ld [hl], a
	cp $fe
	jr z, .asm_d354
	inc a
.asm_d354
	push hl
	push af
	ld a, l
	add $20
	ld l, a
	jr nc, .asm_d35d
	inc h
.asm_d35d
	pop af
	ld [hl], a
	pop hl
	ret

Func_d361: ; 0xd361
	ld b, $5
.asm_d363
	push bc
	push hl
	dec de
	dec de
	dec de
	dec de
	ld a, l
	add $5
	ld l, a
	ld b, $3
.asm_d36f
	ld a, [de]
	call Func_d3e2
	dec de
	dec hl
	dec b
	jr nz, .asm_d36f
	pop hl
	push hl
	ld a, l
	add $6
	ld l, a
	ld bc, $0c01
.asm_d381
	ld a, [de]
	swap a
	and $f
	call Func_d3a4
	inc hl
	dec b
	ld a, [de]
	and $f
	call Func_d3a4
	dec de
	inc hl
	dec b
	jr nz, .asm_d381
	xor a
	call Func_d3ad
	pop hl
	ld bc, -3 * $20
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_d363
	ret

Func_d3a4: ; 0xd3a4
	jr nz, Func_d3ad
	ld a, b
	dec a
	jr z, Func_d3ad
	ld a, c
	and a
	ret nz
	; fall through
Func_d3ad: ; 0xd3ad
	push de
	push af
	call Func_d3d0
	pop af
	ld c, $0
	sla a
	add e
	call PutTileInVRAM
	cp $fe
	jr z, .asm_d3c0
	inc a
.asm_d3c0
	push hl
	push af
	ld a, l
	add $20
	ld l, a
	jr nc, .asm_d3c9
	inc h
.asm_d3c9
	pop af
	call PutTileInVRAM
	pop hl
	pop de
	ret

Func_d3d0: ; 0xd3d0
	ld e, $6c
	ld a, b
	cp $3
	ret z
	cp $6
	ret z
	cp $9
	ret z
	cp $c
	ret z
	ld e, $58
	ret

Func_d3e2: ; 0xd3e2
	ld c, $0
	sla a
	add $90
	call PutTileInVRAM
	cp $fe
	jr z, .asm_d3f0
	inc a
.asm_d3f0
	push hl
	push af
	ld a, l
	add $20
	ld l, a
	jr nc, .asm_d3f9
	inc h
.asm_d3f9
	pop af
	call PutTileInVRAM
	pop hl
	ret

CopyInitialHighScores: ; 0xd3ff
	ld hl, InitialHighScores
	ld de, wRedHighScore1Points
	call CopyInitialHighScoresForStage
	ld hl, InitialHighScores
	ld de, wBlueHighScore1Points

CopyInitialHighScoresForStage: ; 0xd40e
; input:  hl = address of high score entries
;         de = destination address for high score entries to be copied
	ld b, $5  ; 5 high score entries to copy
.copyHighScoreEntry
	ld c, $6  ; high score points are 6 bytes long
.copyPoints
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copyPoints
	ld c, $3  ; name is 3 bytes
.copyName
	ld a, [hli]
	sub $37
	ld [de], a
	inc de
	dec c
	jr nz, .copyName
	ld c, $4
.asm_d424  ; TODO: what are these 4 bytes used for?
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .asm_d424
	dec b
	jr nz, .copyHighScoreEntry
	ret

INCLUDE "data/initial_high_scores.asm" ; 0xd42e

Func_d46f: ; 0xd46f
	ld a, [wHighScoreNameRow]
	ld d, a
	sla a
	add d
	ld d, a
	ld e, $0
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	ld a, [wHighScoreNameColumn]
	add e
	ld e, a
	hlCoord 3, 2, vBGMap
	ld a, [wHighScoresStage]
	and a
	jr z, .asm_d496
	hlCoord 3, 2, vBGWin
.asm_d496
	add hl, de
	push hl
	ld a, [wHighScoreNameRow]
	ld e, a
	sla e
	sla e
	add e
	sla e
	add e
	ld e, a
	ld a, [wHighScoreNameColumn]
	add e
	ld e, a
	ld d, $0
	ld hl, wRedHighScore1Name
	ld a, [wHighScoresStage]
	and a
	jr z, .asm_d4b8
	ld hl, wBlueHighScore1Name
.asm_d4b8
	add hl, de
	ld a, [hl]
	sla a
	add $90
	pop hl
	call PutTileInVRAM
	ld de, $0020
	add hl, de
	cp $fe
	jr z, .asm_d4cb
	inc a
.asm_d4cb
	call PutTileInVRAM
	ret

Func_d4cf: ; 0xd4cf
	ldh a, [hNewlyPressedButtons]
	ld b, a
	ld a, [wHighScoresStage]
	bit 4, b
	jr z, .asm_d4e3
	and a
	ret nz
	lb de, $00, $03
	call PlaySoundEffect
	jr .asm_d4f0

.asm_d4e3
	bit 5, b
	ret z
	and a
	ret z
	lb de, $00, $03
	call PlaySoundEffect
	jr .asm_d537

.asm_d4f0
	call ClearSpriteBuffer
	call Func_d57b
	ld a, $a5
	ldh [hWX], a
	xor a
	ldh [hWY], a
	ld a, $2
	ldh [hSCX], a
	ld hl, hLCDC
	set 5, [hl]
	ld b, $27
.asm_d508
	push bc
	ld a, $27
	sub b
	bit 0, b
	call nz, TransitionHighScoresPalettes
	ld hl, hWX
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	ld hl, hSCX
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	rst AdvanceFrame
	pop bc
	dec b
	jr nz, .asm_d508
	xor a
	ldh [hSCX], a
	ld hl, hLCDC
	res 5, [hl]
	set 3, [hl]
	ld a, $1
	ld [wHighScoresStage], a
	call Func_d5d0
	ret

.asm_d537
	call ClearSpriteBuffer
	call Func_d57b
	ld a, $7
	ldh [hWX], a
	xor a
	ldh [hWY], a
	ld a, $a0
	ldh [hSCX], a
	ld hl, hLCDC
	set 5, [hl]
	res 3, [hl]
	ld b, $27
.asm_d551
	push bc
	ld a, b
	bit 0, b
	call nz, TransitionHighScoresPalettes
	ld hl, hWX
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ld hl, hSCX
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	rst AdvanceFrame
	pop bc
	dec b
	jr nz, .asm_d551
	xor a
	ldh [hSCX], a
	ld hl, hLCDC
	res 5, [hl]
	xor a
	ld [wHighScoresStage], a
	call Func_d5d0
	ret

Func_d57b: ; 0xd57b
	ld a, $f0
	ldh [hSCY], a
	xor a
	ldh [hNextFrameHBlankSCX], a
	ld a, $10
	ldh [hNextFrameHBlankSCY], a
	rst AdvanceFrame
	ld a, BANK(HighScoresTilemap)
	ld hl, HighScoresTilemap
	deCoord 0, 0, vBGMap
	ld bc, $0040
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap)
	ld hl, HighScoresTilemap + $200
	deCoord 0, 16, vBGMap
	ld bc, $0040
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap2)
	ld hl, HighScoresTilemap2
	deCoord 0, 0, vBGWin
	ld bc, $0040
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap2)
	ld hl, HighScoresTilemap2 + $200
	deCoord 0, 16, vBGWin
	ld bc, $0040
	call LoadVRAMData
	ld b, $10
.asm_d5c1
	push bc
	ld hl, hSCY
	inc [hl]
	ld hl, hNextFrameHBlankSCY
	dec [hl]
	rst AdvanceFrame
	pop bc
	dec b
	jr nz, .asm_d5c1
	ret

Func_d5d0: ; 0xd5d0
	ld b, $10
.asm_d5d2
	push bc
	ld hl, hSCY
	dec [hl]
	ld hl, hNextFrameHBlankSCY
	inc [hl]
	rst AdvanceFrame
	pop bc
	dec b
	jr nz, .asm_d5d2
	ld a, BANK(HighScoresTilemap)
	ld hl, HighScoresTilemap + $3c0
	deCoord 0, 0, vBGMap
	ld bc, $0040
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap)
	ld hl, HighScoresTilemap + $280
	deCoord 0, 16, vBGMap
	ld bc, $0040
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap2)
	ld hl, HighScoresTilemap2 + $3c0
	deCoord 0, 0, vBGWin
	ld bc, $0040
	call LoadVRAMData
	ld a, BANK(HighScoresTilemap2)
	ld hl, HighScoresTilemap2 + $280
	deCoord 0, 16, vBGWin
	ld bc, $0040
	call LoadVRAMData
	ld bc, $0009
	call Func_d68a
	xor a
	ldh [hSCY], a
	ldh [hNextFrameHBlankSCX], a
	ldh [hNextFrameHBlankSCY], a
	ret

TransitionHighScoresPalettes: ; 0xd626
; When switching between the Red and Blue field high scores, the palettes
; of the rows smoothly transition between red and blue.
	ld c, a
	ldh a, [hGameBoyColorFlag]
	and a
	ret z
	ld a, c
	srl a
	sub $2
	cp $10
	ret nc
	ld c, a
	ld b, $0
	sla c
	add c
	ld c, a
	ld hl, HighScoresPalettesTransition
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld h, b
	ld l, c
	ld de, $0008
	ld bc, $0038
	push af
	call Func_7dc
	pop af
	ld de, $0040
	ld bc, $0008
	call Func_7dc
	ret

HighScoresPalettesTransition: ; 0xd65a
; When switching between the Red and Blue field high scores, the palette
; of the rows fades between red and blue. This table defines the transition
; of those palettes.
	dwb HighScoresTransitionPalettes1,  Bank(HighScoresTransitionPalettes1)
	dwb HighScoresTransitionPalettes2,  Bank(HighScoresTransitionPalettes2)
	dwb HighScoresTransitionPalettes3,  Bank(HighScoresTransitionPalettes3)
	dwb HighScoresTransitionPalettes4,  Bank(HighScoresTransitionPalettes4)
	dwb HighScoresTransitionPalettes5,  Bank(HighScoresTransitionPalettes5)
	dwb HighScoresTransitionPalettes6,  Bank(HighScoresTransitionPalettes6)
	dwb HighScoresTransitionPalettes7,  Bank(HighScoresTransitionPalettes7)
	dwb HighScoresTransitionPalettes8,  Bank(HighScoresTransitionPalettes8)
	dwb HighScoresTransitionPalettes9,  Bank(HighScoresTransitionPalettes9)
	dwb HighScoresTransitionPalettes10, Bank(HighScoresTransitionPalettes10)
	dwb HighScoresTransitionPalettes11, Bank(HighScoresTransitionPalettes11)
	dwb HighScoresTransitionPalettes12, Bank(HighScoresTransitionPalettes12)
	dwb HighScoresTransitionPalettes13, Bank(HighScoresTransitionPalettes13)
	dwb HighScoresTransitionPalettes14, Bank(HighScoresTransitionPalettes14)
	dwb HighScoresTransitionPalettes15, Bank(HighScoresTransitionPalettes15)
	dwb HighScoresTransitionPalettes16, Bank(HighScoresTransitionPalettes16)

Func_d68a: ; 0xd68a
	push bc
	ld hl, wPokedexFlags
	ld bc, (NUM_POKEMON << 8)
.asm_d691
	bit 1, [hl]
	jr z, .asm_d696
	inc c
.asm_d696
	inc hl
	dec b
	jr nz, .asm_d691
	ld a, c
	pop bc
	cp NUM_POKEMON
	ret nz
	ld hl, vBGMap
	add hl, bc
	call ShowDexCompletionCrown
	ld hl, vBGWin
	add hl, bc
	; fall through
ShowDexCompletionCrown: ; 0xd6aa
	ld a, $56
	call PutTileInVRAM
	inc hl
	ld a, $57
	call PutTileInVRAM
	ret

Func_d6b6: ; 0xd6b6
	ld hl, wPokedexFlags
	ld bc, (NUM_POKEMON << 8)
.asm_d6bc
	bit 1, [hl]
	jr z, .asm_d6c1
	inc c
.asm_d6c1
	inc hl
	dec b
	jr nz, .asm_d6bc
	ld a, c
	cp NUM_POKEMON
	ret nz
	ld hl, wSendHighScoresTopBarTilemap + $9
	ld a, $56   ; a crown is shown when Dex is completed
	ld [hli], a
	ld a, $57
	ld [hli], a
	ret
