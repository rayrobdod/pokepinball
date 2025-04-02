HandleFieldSelectScreen: ; 0xd6d3
	ld a, [wScreenState]
	rst JumpTable  ; calls JumpToFuncInTable
FieldSelectScreenFunctions: ; 0xd6d7
	dw LoadFieldSelectScreen
	dw ChooseFieldToPlay
	dw ExitFieldSelectScreen

LoadFieldSelectScreen: ; 0xd6dd
	ld a, $43
	ldh [hLCDC], a
	ld a, $e4
	ld [wBGP], a
	ld a, $d2
	ld [wOBP0], a
	ld [wOBP1], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld hl, FieldSelectGfxPointers
	ldh a, [hGameBoyColorFlag]
	call LoadVideoData
	call ClearSpriteBuffer
	ld a, $8
	ld [wFieldSelectBlinkingBorderFrame], a
	call SetAllPalettesWhite
	ld a, Bank(Music_FieldSelect)
	call SetSongBank
	ld de, MUSIC_FIELD_SELECT
	call PlaySong
	call EnableLCD
	call FadeIn
	ld hl, wScreenState
	inc [hl]
	ret

FieldSelectGfxPointers: ; 0xd71c
	dw FieldSelectGfx_GameBoy
	dw FieldSelectGfx_GameBoyColor

FieldSelectGfx_GameBoy: ; 0xd720
	VIDEO_DATA_TILES   FieldSelectScreenGfx, vTilesSH - $100, $d00
	VIDEO_DATA_TILEMAP FieldSelectTilemap, vBGMap, $240
	db $FF, $FF ; terminators

FieldSelectGfx_GameBoyColor: ; 0xd730
	VIDEO_DATA_TILES    FieldSelectScreenGfx, vTilesSH - $100, $d00
	VIDEO_DATA_TILEMAP  FieldSelectTilemap, vBGMap, $240
	VIDEO_DATA_BGATTR   FieldSelectBGAttributes, vBGMap, $240
	VIDEO_DATA_PALETTES FieldSelectScreenPalettes, $48
	db $FF, $FF ; terminators

ChooseFieldToPlay: ; 0xd74e
	call MoveFieldSelectCursor
	ld hl, FieldSelectBorderAnimationData
	call AnimateBlinkingFieldSelectBorder
	ldh a, [hNewlyPressedButtons]
	and (A_BUTTON | B_BUTTON)
	ret z
	ld [wFieldSelectPressedButton], a
	ld a, $18  ; number of frames to blink the border after selecting the Field
	ld [wFieldSelectBlinkingBorderTimer], a
	ld a, $1
	ld [wFieldSelectBlinkingBorderFrame], a
	lb de, $00, $01
	call PlaySoundEffect
	ld hl, wScreenState
	inc [hl]
	ret

ExitFieldSelectScreen: ; 0xd774
	ld a, [wFieldSelectPressedButton]  ; this holds the button that was pressed (A or B)
	bit BIT_A_BUTTON, a
	jr z, .didntPressA
	ld hl, FieldSelectConfirmationAnimationData
	call AnimateBlinkingFieldSelectBorder
	ld a, [wFieldSelectBlinkingBorderTimer]
	dec a
	ld [wFieldSelectBlinkingBorderTimer], a
	ret nz
.didntPressA
	ldh a, [hJoypadState]
	push af
	call FadeOut
	call DisableLCD
	ld a, [wFieldSelectPressedButton]
	bit BIT_A_BUTTON, a
	jr z, .pressedB
	ld a, [wSelectedFieldIndex]
	ld c, a
	ld b, $0
	ld hl, StartingStages
	add hl, bc
	ld a, [hl]
	ld [wCurrentStage], a
	pop af
	xor a
	ld [wSavedGame], a
	ld hl, wSaveGame
	ld de, sSaveGame
	ld bc, wSaveGameEnd - wSaveGame
	call SaveData
	xor a
	ld [wLoadingSavedGame], a
	; Start a game of Pinball
	ld a, SCREEN_PINBALL_GAME
	ld [wCurrentScreen], a
	xor a
	ld [wScreenState], a
	ret

.pressedB
	pop af
	ld a, SCREEN_TITLESCREEN
	ld [wCurrentScreen], a
	xor a
	ld [wScreenState], a
	ret

StartingStages: ; 0xd7d1
; wSelectedFieldIndex is used to index this array
	db STAGE_RED_FIELD_BOTTOM, STAGE_BLUE_FIELD_BOTTOM

MoveFieldSelectCursor: ; 0xd7d3
; When the player presses Right or Left, the stage is
; illuminated with a blinking border.  This function keeps tracks
; of which field is currently selected.
	ldh a, [hPressedButtons]
	ld b, a
	ld a, [wSelectedFieldIndex]
	bit BIT_D_LEFT, b
	jr z, .didntPressLeft
	and a
	ret z  ; if cursor is already hovering over Red stage, don't do anything
	dec a  ; move cursor over Red stage
	ld [wSelectedFieldIndex], a
	lb de, $00, $3c
	call PlaySoundEffect
	ret

.didntPressLeft
	bit BIT_D_RIGHT, b
	ret z
	cp $1
	ret z  ; if cursor is already hovering over Blue stage, don't do anything
	inc a  ; move cursor over Red stage
	ld [wSelectedFieldIndex], a
	lb de, $00, $3d
	call PlaySoundEffect
	ret

AnimateBlinkingFieldSelectBorder: ; 0xd7fb
; This makes the border of the currently-selected Field blink in the Field Select screen.
	push hl
	ld a, [wSelectedFieldIndex]
	sla a
	ld c, a
	ld b, $0
	ld hl, FieldSelectBorderSpritePixelOffsetData
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [wd915]
	sla a
	ld e, a
	ld d, $0
	pop hl
	push hl
	add hl, de
	ld a, [hl]
	call LoadSpriteData
	ld a, [wFieldSelectBlinkingBorderFrame]
	dec a
	jr nz, .asm_d838
	inc hl
	inc hl
	ld a, [hl]
	and a
	jr z, .asm_d82b
	ld a, [wd915]
	inc a
.asm_d82b
	ld [wd915], a
	sla a
	ld c, a
	ld b, $0
	pop hl
	push hl
	inc hl
	add hl, bc
	ld a, [hl]
.asm_d838
	ld [wFieldSelectBlinkingBorderFrame], a
	pop hl
	ret

FieldSelectBorderAnimationData:
; [sprite id][duration]
	db SPRITE_FIELD_SELECT_BORDER_GREY, $08
	db SPRITE_FIELD_SELECT_BORDER_WHITE, $08
	db SPRITE_FIELD_SELECT_BORDER_GREY, $08
	db SPRITE_FIELD_SELECT_BORDER_BLACK, $08
	db $00  ; terminator

FieldSelectConfirmationAnimationData:
; [sprite id][duration]
	db SPRITE_FIELD_SELECT_BORDER_WHITE, $03
	db SPRITE_FIELD_SELECT_BORDER_BLACK, $03
	db SPRITE_FIELD_SELECT_BORDER_WHITE, $03
	db SPRITE_FIELD_SELECT_BORDER_BLACK, $03
	db $00  ; terminator

FieldSelectBorderSpritePixelOffsetData:
	dw $2A42
	dw $7242
