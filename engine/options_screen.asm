HandleOptionsScreen: ; 0xc34a
	ld a, [wScreenState]
	rst JumpTable  ; calls JumpToFuncInTable
OptionsScreenFunctions: ; 0xc34e
	dw Func_c35a
	dw Func_c400
	dw Func_c483
	dw Func_c493
	dw Func_c506
	dw Func_c691

Func_c35a: ; 0xc35a
	ld a, $47
	ldh [hLCDC], a
	ld a, $e4
	ld [wBGP], a
	ld [wOBP0], a
	ld a, $d2
	ld [wOBP1], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld hl, OptionsScreenVideoDataPointers
	ldh a, [hGameBoyColorFlag]
	call LoadVideoData
	call ClearSpriteBuffer
	ld a, $2
	ld [wOptionsPokeballAnimationTimer], a
	ld [wOptionsPsyduckAnimationTimer], a
	ld a, $9
	ld [wOptionsPikachuAnimationTimer], a
	call Func_c43a
	call Func_c948
	call SetAllPalettesWhite
	ld a, Bank(Music_Options)
	call SetSongBank
	ld de, MUSIC_OPTIONS
	call PlaySong
	call EnableLCD
	ld a, [wSoundTestCurrentBackgroundMusic]
	hlCoord 7, 11, vBGMap
	call RedrawSoundTestID
	ld a, [wSoundTextCurrentSoundEffect]
	hlCoord 7, 13, vBGMap
	call RedrawSoundTestID
	call FadeIn
	ld hl, wScreenState
	inc [hl]
	ret

OptionsScreenVideoDataPointers: ; 0xc3b9
	dw OptionsScreenVideoData_GameBoy
	dw OptionsScreenVideoData_GameBoyColor

OptionsScreenVideoData_GameBoy: ; 0xc3bd
	VIDEO_DATA_TILES   OptionMenuAndKeyConfigGfx, vTilesOB, $1400
	VIDEO_DATA_TILEMAP OptionMenuTilemap,  vBGMap, $240
	VIDEO_DATA_TILEMAP OptionMenuTilemap2, vBGWin, $240
	db $FF, $FF ; terminators

OptionsScreenVideoData_GameBoyColor: ; 0xc3d4
	VIDEO_DATA_TILES         OptionMenuAndKeyConfigGfx, vTilesOB, $1400
	VIDEO_DATA_TILEMAP       OptionMenuTilemap, vBGMap, $240
	VIDEO_DATA_TILEMAP_BANK2 OptionMenuTilemap3, vBGMap, $240
	VIDEO_DATA_TILEMAP       OptionMenuTilemap2, vBGWin, $240
	VIDEO_DATA_TILEMAP_BANK2 OptionMenuTilemap4, vBGWin, $240
	VIDEO_DATA_PALETTES      OptionMenuPalettes, $80
	db $FF, $FF ; terminators

Func_c400: ; 0xc400
	call Func_c41a
	call Func_c43a
	call Func_c447
	ldh a, [hNewlyPressedButtons]
	bit 1, a
	ret z
	lb de, $00, $01
	call PlaySoundEffect
	ld a, $2
	ld [wScreenState], a
	ret

Func_c41a: ; 0xc41a
	ldh a, [hPressedButtons]
	ld b, a
	ld a, [wd916]
	bit 6, b
	jr z, .asm_c429
	and a
	ret z
	dec a
	jr .asm_c430

.asm_c429
	bit 7, b
	ret z
	cp $2
	ret z
	inc a
.asm_c430
	ld [wd916], a
	lb de, $00, $03
	call PlaySoundEffect
	ret

Func_c43a: ; 0xc43a
	call HandleOptionsPsyduckAnimation
	call HandleOptionsPikachuAnimation
	call HandleOptionsPokeballAnimation
	call Func_c92e
	ret

Func_c447: ; 0xc447
	ldh a, [hNewlyPressedButtons]
	bit BIT_A_BUTTON, a
	ret z
	lb de, $00, $01
	call PlaySoundEffect
	ld a, [wd916]
	and a
	jr nz, .asm_c465
	ldh a, [hSGBFlag]
	and a
	ret nz
	call Func_c4f4
	ld a, $3
	ld [wScreenState], a
	ret

.asm_c465
	cp $1
	jr nz, .asm_c477
	call ClearSpriteBuffer
	ld hl, hLCDC
	set 3, [hl]
	ld a, $4
	ld [wScreenState], a
	ret

.asm_c477
	ld de, MUSIC_NOTHING
	call PlaySong
	ld a, $5
	ld [wScreenState], a
	ret

Func_c483: ; 0xc483
	call FadeOut
	call DisableLCD
	ld a, SCREEN_TITLESCREEN
	ld [wCurrentScreen], a
	xor a
	ld [wScreenState], a
	ret

Func_c493: ; 0xc493
	call Func_c4b4
	call Func_c4e6
	call Func_c869
	ldh a, [hNewlyPressedButtons]
	bit BIT_B_BUTTON, a
	ret z
	lb de, $00, $01
	call PlaySoundEffect
	xor a
	ld [wRumblePattern], a
	ld [wRumbleDuration], a
	ld a, $1
	ld [wScreenState], a
	ret

Func_c4b4: ; 0xc4b4
	ldh a, [hNewlyPressedButtons]
	ld b, a
	ld a, [wd917]
	bit BIT_D_LEFT, b
	jr z, .asm_c4ce
	and a
	ret z
	dec a
	ld [wd917], a
	call Func_c4f4
	lb de, $00, $03
	call PlaySoundEffect
	ret

.asm_c4ce
	bit BIT_D_RIGHT, b
	ret z
	cp $1
	ret z
	inc a
	ld [wd917], a
	xor a
	ld [wRumblePattern], a
	ld [wRumbleDuration], a
	lb de, $00, $03
	call PlaySoundEffect
	ret

Func_c4e6: ; 0xc4e6
	call HandleOptionsPsyduckAnimation
	call HandleOptionsPikachuAnimation
	call HandleOptionsPokeballAnimation
	xor a
	call Func_c8f1
	ret

Func_c4f4: ; 0xc4f4
	xor a
	ld [wOptionsPsyduckAnimationFrame], a
	ld [wOptionsPikachuAnimationFrame], a
	ld a, $2
	ld [wOptionsPsyduckAnimationTimer], a
	ld a, $9
	ld [wOptionsPikachuAnimationTimer], a
	ret

Func_c506: ; 0xc506
	call Func_c534
	call Func_c554
	call Func_c55a
	ldh a, [hNewlyPressedButtons]
	bit BIT_B_BUTTON, a
	ret z
	lb de, $00, $01
	call PlaySoundEffect
	call ClearSpriteBuffer
	ld hl, hLCDC
	res 3, [hl]
	ld hl, wKeyConfigs
	ld de, sKeyConfigs
	ld bc, wKeyConfigsEnd - wKeyConfigs
	call SaveData
	ld a, $1
	ld [wScreenState], a
	ret

Func_c534: ; 0xc534
	ldh a, [hNewlyPressedButtons]
	ld b, a
	ld a, [wd918]
	bit BIT_D_UP, b
	jr z, .asm_c543
	and a
	ret z
	dec a
	jr .asm_c54a

.asm_c543
	bit BIT_D_DOWN, b
	ret z
	cp $7
	ret z
	inc a
.asm_c54a
	ld [wd918], a
	lb de, $00, $03
	call PlaySoundEffect
	ret

Func_c554: ; 0xc554
	ld a, $1
	call Func_c8f1
	ret

Func_c55a: ; 0xc55a
	ld a, [wd918]
	and a
	jr nz, .asm_c572
	ldh a, [hNewlyPressedButtons]
	bit BIT_A_BUTTON, a
	ret z
	lb de, $00, $01
	call PlaySoundEffect
	call SaveDefaultKeyConfigs
	call Func_c948
	ret

.asm_c572
	ldh a, [hNewlyPressedButtons]
	bit BIT_A_BUTTON, a
	ret z
	lb de, $00, $01
	call PlaySoundEffect
	ld bc, $001e
	call AdvanceFrames
	ld a, [wd918]
	dec a
	sla a
	ld c, a
	ld b, $0
	ld hl, PointerTable_c65f
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wd918]
	dec a
	sla a
	call Func_c644
	ld bc, $00ff
.asm_c59f
	push bc
	push hl
	ld a, [wd918]
	dec a
	sla a
	call Func_c621
	call Func_c554
	call CleanSpriteBuffer
	rst AdvanceFrame
	pop hl
	pop bc
	ldh a, [hJoypadState]
	and a
	jr z, .asm_c5c2
	ld c, $0
	call Func_c9be
	call Func_c95f
	jr .asm_c59f

.asm_c5c2
	or c
	jr nz, .asm_c59f
	ld a, [wd918]
	dec a
	sla a
	call Func_c639
	push hl
	ld bc, $001e
	call AdvanceFrames
	pop hl
	ld bc, $0020
	add hl, bc
	ld a, [wd918]
	dec a
	sla a
	inc a
	call Func_c644
	ld bc, $00ff
	ld d, $5a
.asm_c5e9
	push bc
	push de
	push hl
	ld a, [wd918]
	dec a
	sla a
	inc a
	call Func_c621
	call Func_c554
	call CleanSpriteBuffer
	rst AdvanceFrame
	pop hl
	pop de
	pop bc
	dec d
	ret z
	ldh a, [hJoypadState]
	and a
	jr z, .asm_c613
	ld d, $ff
	ld c, $0
	call Func_c9be
	call Func_c95f
	jr .asm_c5e9

.asm_c613
	or c
	jr nz, .asm_c5e9
	ld a, [wd918]
	dec a
	sla a
	inc a
	call Func_c639
	ret

Func_c621: ; 0xc621
	sla a
	ld c, a
	ld b, $0
	ld hl, SpritePixelOffsetData_c66d
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	ldh a, [hFrameCounter]
	bit 2, a
	ret z
	ld a, SPRITE_OPTIONS_SOLID_WHITE
	call LoadSpriteData
	ret

Func_c639: ; 0xc639
	push hl
	ld e, a
	ld d, $0
	ld hl, wKeyConfigBallStart
	add hl, de
	ld [hl], b
	pop hl
	ret

Func_c644: ; 0xc644
	push hl
	ld c, a
	ld b, $0
	ld hl, wKeyConfigBallStart
	add hl, bc
	ld [hl], $0
	pop hl
	push hl
	ld d, h
	ld e, l
	ld hl, Data_c689
	ld a, Bank(Data_c689)
	ld bc, $0008
	call LoadVRAMData
	pop hl
	ret

PointerTable_c65f: ; 0xc65f
	dw $9C6D
	dw $9CAD
	dw $9CED
	dw $9D2D
	dw $9D6D
	dw $9DAD
	dw $9DED

SpritePixelOffsetData_c66d: ; 0xc66d
	dw $6018
	dw $6020
	dw $6028
	dw $6030
	dw $6038
	dw $6040
	dw $6048
	dw $6050
	dw $6058
	dw $6060
	dw $6068
	dw $6070
	dw $6078
	dw $6080

Data_c689: ; 0xc689
	db $81, $81, $81, $81, $81, $81, $81, $81

Func_c691: ; 0xc91
	call Func_c6bf
	call Func_c6d9
	call Func_c6e8
	ldh a, [hNewlyPressedButtons]
	bit BIT_B_BUTTON, a
	ret z
	ld de, MUSIC_NOTHING
	call PlaySong
	rst AdvanceFrame
	rst AdvanceFrame
	rst AdvanceFrame
	ld a, Bank(Music_Options)
	call SetSongBank
	ld de, MUSIC_OPTIONS
	call PlaySong
	lb de, $00, $01
	call PlaySoundEffect
	ld a, $1
	ld [wScreenState], a
	ret

Func_c6bf: ; 0xc6bf
	ldh a, [hNewlyPressedButtons]
	ld b, a
	ld a, [wd919]
	bit BIT_D_UP, b
	jr z, .asm_c6ce
	and a
	ret z
	dec a
	jr .asm_c6d5

.asm_c6ce
	bit BIT_D_DOWN, b
	ret z
	cp $1
	ret z
	inc a
.asm_c6d5
	ld [wd919], a
	ret

Func_c6d9: ; 0xc6d9
	call HandleOptionsPsyduckAnimation
	call HandleOptionsPikachuAnimation
	call HandleOptionsPokeballAnimation
	ld a, $2
	call Func_c8f1
	ret

Func_c6e8: ; 0xc6e8
	ld a, [wd919]
	and a
	jr nz, UpdateSoundTestSoundEffectSelection
	ldh a, [hNewlyPressedButtons]
	bit BIT_A_BUTTON, a
	jr z, UpdateSoundTestBackgroundMusicSelection
	ld de, MUSIC_NOTHING
	call PlaySong
	rst AdvanceFrame
	rst AdvanceFrame
	rst AdvanceFrame
	ld a, [wSoundTestCurrentBackgroundMusic]
	sla a
	ld c, a
	ld b, $0
	ld hl, SongBanks
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, $0
	ld a, [hl]
	call SetSongBank
	call PlaySong
	ret

UpdateSoundTestBackgroundMusicSelection: ; 0xc715
	ldh a, [hPressedButtons] ; joypad state
	ld b, a
	ld a, [wSoundTestCurrentBackgroundMusic]
	bit BIT_D_LEFT, b  ; was the left dpad button pressed?
	jr z, .checkIfRightPressed
	dec a     ; decrement background music id
	bit 7, a  ; did it wrap around to $ff?
	jr z, .saveBackgroundMusicID
	ld a, NUM_SONGS - 1
	jr .saveBackgroundMusicID

.checkIfRightPressed
	bit BIT_D_RIGHT, b  ; was the right dpad button pressed?
	ret z
	inc a         ; increment background music id
	cp NUM_SONGS  ; should it wrap around to 0?
	jr nz, .saveBackgroundMusicID
	xor a
.saveBackgroundMusicID
	ld [wSoundTestCurrentBackgroundMusic], a
	hlCoord 7, 11, vBGMap
	jp RedrawSoundTestID

UpdateSoundTestSoundEffectSelection: ; 0xc73a
	ldh a, [hNewlyPressedButtons] ; joypad state
	bit BIT_A_BUTTON, a
	jr z, .didntPressAButton
	ld a, [wSoundTextCurrentSoundEffect]
	ld e, a
	ld d, $0
	call PlaySoundEffect
	ret

.didntPressAButton
	ldh a, [hPressedButtons] ; joypad state
	ld b, a
	ld a, [wSoundTextCurrentSoundEffect]
	bit BIT_D_LEFT, b  ; was the left dpad button pressed?
	jr z, .checkIfRightPressed
	dec a     ; decrement sound effect id
	bit 7, a  ; did it wrap around to $ff?
	jr z, .saveSoundEffectID
	ld a, NUM_SOUND_EFFECTS - 1
	jr .saveSoundEffectID

.checkIfRightPressed
	bit BIT_D_RIGHT, b  ; was the right dpad button pressed?
	ret z
	inc a                  ; increment background music id
	cp NUM_SOUND_EFFECTS   ; should it wrap around to 0?
	jr nz, .saveSoundEffectID
	xor a
.saveSoundEffectID
	ld [wSoundTextCurrentSoundEffect], a
	hlCoord 7, 13, vBGMap
	; fall through

RedrawSoundTestID: ; 0xc76c
; Redraws the 2-digit id number for the sound test's current background music or sound effect id.
; input:  a = id number
;        hl = pointer to bg map location where the new 2-digit id should be drawn
	push af  ; save music or sound effect id number
	swap a
	and $f   ; a contains high nybble of music id
	call .drawDigit
	pop af
	and $f   ; a contains low nybble of music id
.drawDigit
	add $b7  ; hexadecimal digit tiles start at tile number $b7
	call PutTileInVRAM
	inc hl
	ret

SongBanks: ; 0xc77e
	db MUSIC_NOTHING,BANK(Music_Nothing0F)
	db MUSIC_RED_FIELD,BANK(Music_RedField)
	db MUSIC_CATCH_EM_RED,BANK(Music_CatchEmRed)
	db MUSIC_HURRY_UP_RED,BANK(Music_HurryUpRed)
	db MUSIC_POKEDEX,BANK(Music_Pokedex)
	db MUSIC_GASTLY_GRAVEYARD,BANK(Music_GastlyInTheGraveyard)
	db MUSIC_HAUNTER_GRAVEYARD,BANK(Music_HaunterInTheGraveyard)
	db MUSIC_GENGAR_GRAVEYARD,BANK(Music_GengarInTheGraveyard)
	db MUSIC_BLUE_FIELD,BANK(Music_BlueField)
	db MUSIC_CATCH_EM_BLUE,BANK(Music_CatchEmBlue)
	db MUSIC_HURRY_UP_BLUE,BANK(Music_HurryUpBlue)
	db MUSIC_HI_SCORE,BANK(Music_HiScore)
	db MUSIC_GAME_OVER,BANK(Music_GameOver)
	db MUSIC_WHACK_DIGLETT,BANK(Music_WhackTheDiglett)
	db MUSIC_WHACK_DUGTRIO,BANK(Music_WhackTheDugtrio)
	db MUSIC_SEEL_STAGE,BANK(Music_SeelStage)
	db MUSIC_TITLE_SCREEN,BANK(Music_Title)
	db MUSIC_MEWTWO_STAGE,BANK(Music_MewtwoStage)
	db MUSIC_OPTIONS,BANK(Music_Options)
	db MUSIC_FIELD_SELECT,BANK(Music_FieldSelect)
	db MUSIC_MEOWTH_STAGE,BANK(Music_MeowthStage)
	db MUSIC_END_CREDITS,BANK(Music_EndCredits)
	db MUSIC_NAME_ENTRY,BANK(Music_NameEntry)

HandleOptionsPsyduckAnimation: ; 0xc7ac
	ld c, $0
	ld a, [wScreenState]
	cp $1
	jr z, .asm_c7cc
	ld a, [wd916]
	and a
	jr nz, .asm_c7cc
	ld a, [wd917]
	and a
	jr nz, .asm_c7cc
	ld a, [wOptionsPikachuAnimationFrame]
	cp $4
	jr nz, .asm_c7cc
	ld a, [wOptionsPsyduckAnimationFrame]
	ld c, a
.asm_c7cc
	sla c
	ld b, $0
	ld hl, AnimationData_OptionsPsyduck
	add hl, bc
	ld a, [hl]
	ld bc, $5050
	call LoadSpriteData
	ld a, [wOptionsPsyduckAnimationTimer]
	dec a
	jr nz, .asm_c802
	ld a, [wOptionsPsyduckAnimationFrame]
	sla a
	ld c, a
	ld b, $0
	ld hl, AnimationData_OptionsPsyduck + 2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_c7f5
	ld a, [wOptionsPsyduckAnimationFrame]
	inc a
.asm_c7f5
	ld [wOptionsPsyduckAnimationFrame], a
	sla a
	ld c, a
	ld b, $0
	ld hl, AnimationData_OptionsPsyduck + 1
	add hl, bc
	ld a, [hl]
.asm_c802
	ld [wOptionsPsyduckAnimationTimer], a
	ret

AnimationData_OptionsPsyduck: ; 0xc806
	; [sprite id][duration]
	db SPRITE_OPTIONS_PSYDUCK_0, $02
	db SPRITE_OPTIONS_PSYDUCK_1, $02
	db $00 ; terminator

HandleOptionsPikachuAnimation: ; 0xc80b
	ld c, $0
	ld a, [wScreenState]
	cp $1
	jr z, .asm_c824
	ld a, [wd916]
	and a
	jr nz, .asm_c824
	ld a, [wd917]
	and a
	jr nz, .asm_c824
	ld a, [wOptionsPikachuAnimationFrame]
	ld c, a
.asm_c824
	sla c
	ld b, $0
	ld hl, AnimationData_OptionsPikachu
	add hl, bc
	ld bc, $7870
	ld a, [hl]
	call LoadSpriteData
	ld a, [wOptionsPikachuAnimationTimer]
	dec a
	jr nz, .asm_c85a
	ld a, [wOptionsPikachuAnimationFrame]
	sla a
	ld c, a
	ld b, $0
	ld hl, AnimationData_OptionsPikachu + 2
	add hl, bc
	ld a, [hl]
	and a
	ld a, [wOptionsPikachuAnimationFrame]
	jr z, .asm_c850
	inc a
	ld [wOptionsPikachuAnimationFrame], a
.asm_c850
	sla a
	ld c, a
	ld b, $0
	ld hl, AnimationData_OptionsPikachu + 1
	add hl, bc
	ld a, [hl]
.asm_c85a
	ld [wOptionsPikachuAnimationTimer], a
	ret

AnimationData_OptionsPikachu: ; 0xc85e
	db SPRITE_OPTIONS_PIKACHU_0, $09
	db SPRITE_OPTIONS_PIKACHU_1, $09
	db SPRITE_OPTIONS_PIKACHU_2, $09
	db SPRITE_OPTIONS_PIKACHU_3, $0D
	db SPRITE_OPTIONS_PIKACHU_3, $01
	db $00 ; terminator

Func_c869: ; 0xc869
	ld a, [wd916]
	and a
	ret nz
	ld a, [wd917]
	and a
	ret nz
	ld a, [wOptionsPikachuAnimationFrame]
	cp $3
	ret nz
	ld a, [wOptionsPikachuAnimationTimer]
	cp $1
	ret nz
	ld a, $55
	ld [wRumblePattern], a
	ld a, $40
	ld [wRumbleDuration], a
	ret

HandleOptionsPokeballAnimation: ; 0xc88a
	ld a, [wd916]
	sla a
	ld c, a
	ld b, $0
	ld hl, SpritePixelOffsets_OptionsPokeball
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld e, $0
	ld a, [wScreenState]
	cp $1
	jr nz, .asm_c8a9
	ld a, [wOptionsPokeballAnimationFrame]
	sla a
	ld e, a
.asm_c8a9
	ld d, $0
	ld hl, AnimationData_OptionsPokeball
	add hl, de
	ld a, [hl]
	call LoadSpriteData
	ld a, [wOptionsPokeballAnimationTimer]
	dec a
	jr nz, .asm_c8da
	ld a, [wOptionsPokeballAnimationFrame]
	sla a
	ld c, a
	ld b, $0
	ld hl, AnimationData_OptionsPokeball + 2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_c8cd
	ld a, [wOptionsPokeballAnimationFrame]
	inc a
.asm_c8cd
	ld [wOptionsPokeballAnimationFrame], a
	sla a
	ld c, a
	ld b, $0
	ld hl, AnimationData_OptionsPokeball + 1
	add hl, bc
	ld a, [hl]
.asm_c8da
	ld [wOptionsPokeballAnimationTimer], a
	ret

AnimationData_OptionsPokeball: ; 0xc8de
	; [sprite id][duration]
	db SPRITE_OPTIONS_POKEBALL_0, $02
	db SPRITE_OPTIONS_POKEBALL_1, $06
	db SPRITE_OPTIONS_POKEBALL_2, $02
	db SPRITE_OPTIONS_POKEBALL_3, $04
	db SPRITE_OPTIONS_POKEBALL_4, $06
	db SPRITE_OPTIONS_POKEBALL_2, $04
	db $00 ; terminator

SpritePixelOffsets_OptionsPokeball: ; 0xc8eb
	; [y][x]
	db $18, $08
	db $30, $08
	db $48, $08

Func_c8f1: ; 0xc8f1
	ld c, a
	ld b, $0
	ld hl, wd917
	add hl, bc
	ld e, [hl]
	sla c
	ld hl, SpritePixelOffsetss_OptionsArrow
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld c, e
	sla c
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	ld a, SPRITE_OPTIONS_ARROW
	call LoadSpriteData
	ret

SpritePixelOffsetss_OptionsArrow: ; 0xc910
	dw SpritePixelOffsets_OptionsArrowRumble
	dw SpritePixelOffsets_OptionsArrowKeyConfig
	dw SpritePixelOffsets_OptionsArrowBgm

SpritePixelOffsets_OptionsArrowRumble: ; 0xc916
	dw $5018
	dw $7018

SpritePixelOffsets_OptionsArrowKeyConfig: ; 0xc91a
	dw $0808
	dw $0818
	dw $0828
	dw $0838
	dw $0848
	dw $0858
	dw $0868
	dw $0878

SpritePixelOffsets_OptionsArrowBgm: ; 0xc92a
	dw $1058
	dw $1068

Func_c92e: ; 0xc92e
	ld a, [wd917]
	sla a
	ld c, a
	ld b, $0
	ld hl, SpritePixelOffsets_OptionsArrowFadedRumble
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, SPRITE_OPTIONS_ARROW_FADED
	call LoadSpriteData
	ret

SpritePixelOffsets_OptionsArrowFadedRumble: ; 0xc944
	dw $5018
	dw $7018

Func_c948: ; 0xc948
	hlCoord 13, 3, vBGWin
	ld de, wKeyConfigBallStart
	ld b, $e
.asm_c950
	push bc
	ld a, [de]
	call Func_c95f
	inc de
	ld bc, $0020
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_c950
	ret

Func_c95f: ; 0xc95f
	push bc
	push de
	push hl
	push hl
	push af
	ld hl, wd922
	ld a, $81
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop af
	ld hl, wd922
	ld de, Data_c9ae
	ld b, $8
.asm_c979
	srl a
	push af
	jr nc, .asm_c994
	ld a, [de]
	inc de
	call Func_c9aa
	ld a, [de]
	inc de
	call Func_c9aa
	pop af
	push af
	and a
	jr z, .asm_c996
	ld a, $1a
	call Func_c9aa
	jr .asm_c996

.asm_c994
	inc de
	inc de
.asm_c996
	pop af
	dec b
	jr nz, .asm_c979
	pop de
	ld hl, wd922
	ld a, $0
	ld bc, $0008
	call LoadOrCopyVRAMData
	pop hl
	pop de
	pop bc
	ret

Func_c9aa: ; 0xc9aa
	and a
	ret z
	ld [hli], a
	ret

Data_c9ae: ; 0xc9ae
	db $14, $00, $15, $00, $18, $19, $16, $17, $13, $00, $12, $00, $10, $00, $11, $00

Func_c9be: ; 0xc9be
	push af
	push bc
	push hl
	ld c, a
	xor b
	and c
	ld hl, wd936
	call Func_c9ff
	ld a, b
	ld hl, wd93f
	call Func_c9ff
	ld a, [wd947]
	cp $3
	jr nc, .asm_c9f3
	ld hl, wd93e
	add [hl]
	sub $4
	ld hl, wd936
	call nc, Func_ca15
	ld de, wd936
	ld hl, wd93f
	ld b, $8
.asm_c9ec
	ld a, [de]
	or [hl]
	ld [hli], a
	inc de
	dec b
	jr nz, .asm_c9ec
.asm_c9f3
	ld hl, wd93f
	call Func_ca29
	pop hl
	pop bc
	ld b, a
	pop af
	ld a, b
	ret

Func_c9ff: ; 0xc9ff
	push bc
	ld bc, $0800
.asm_ca03
	sla a
	jr nc, .asm_ca0c
	ld [hl], $ff
	inc c
	jr .asm_ca0e

.asm_ca0c
	ld [hl], $0
.asm_ca0e
	inc hl
	dec b
	jr nz, .asm_ca03
	ld [hl], c
	pop bc
	ret

Func_ca15: ; 0xca15
	push bc
	inc a
	ld c, a
	ld b, $8
.asm_ca1a
	ld a, [hl]
	and a
	jr z, .asm_ca23
	ld [hl], $0
	dec c
	jr z, .asm_ca27
.asm_ca23
	inc hl
	dec b
	jr nz, .asm_ca1a
.asm_ca27
	pop bc
	ret

Func_ca29: ; 0ca29
	push bc
	ld bc, $0800
.asm_ca2d
	ld a, [hli]
	and a
	jr z, .asm_ca32
	scf
.asm_ca32
	rl c
	dec b
	jr nz, .asm_ca2d
	ld a, c
	pop bc
	ret

SaveDefaultKeyConfigs: ; 0ca3a
	ld hl, DefaultKeyConfigs
	ld de, wKeyConfigs
	ld b, $e
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ld hl, wKeyConfigs
	ld de, sKeyConfigs
	ld bc, wKeyConfigsEnd - wKeyConfigs
	call SaveData
	ret

DefaultKeyConfigs: ; 0xca55
	db A_BUTTON, $00  ; wKeyConfigBallStart
	db D_LEFT,   $00  ; wKeyConfigLeftFlipper
	db A_BUTTON, $00  ; wKeyConfigRightFlipper
	db D_DOWN,   $00  ; wKeyConfigLeftTilt
	db B_BUTTON, $00  ; wKeyConfigRightTilt
	db SELECT,   $00  ; wKeyConfigUpperTilt
	db START,    $00  ; wKeyConfigMenu

UnusedKeyConfig1: ; 0xca63
	db A_BUTTON,       $00  ; wKeyConfigBallStart
	db D_LEFT,         $00  ; wKeyConfigLeftFlipper
	db A_BUTTON,       $00  ; wKeyConfigRightFlipper
	db D_DOWN,         $00  ; wKeyConfigLeftTilt
	db B_BUTTON,       $00  ; wKeyConfigRightTilt
	db START,          $04  ; wKeyConfigUpperTilt
	db D_UP | D_RIGHT, $00  ; wKeyConfigMenu

UnusedKeyConfig2: ; 0xca71
	db A_BUTTON,              $00  ; wKeyConfigBallStart
	db D_LEFT,                $00  ; wKeyConfigLeftFlipper
	db A_BUTTON,              $00  ; wKeyConfigRightFlipper
	db D_DOWN,                $00  ; wKeyConfigLeftTilt
	db B_BUTTON,              $00  ; wKeyConfigRightTilt
	db START,                 $00  ; wKeyConfigUpperTilt
	db D_UP | START | SELECT, $00  ; wKeyConfigMenu
