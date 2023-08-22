TileDataPointers_15511:
	dw TileData_1551d
	dw TileData_15523
	dw TileData_1552a

TileDataPointers_15517:
	dw TileData_15530
	dw TileData_15536
	dw TileData_1553d

TileData_1551d: ; 0x1551d
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $E7
	db $ac

	db $00 ; terminator

TileData_15523: ; 0x15523
	db $02 ; total number of tiles

	db $02 ; number of tiles
	dw vBGMap + $C9
	db $ad, $ae

	db $00 ; terminator

TileData_1552a: ; 0x1552a
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $CC
	db $af

	db $00 ; terminator

TileData_15530: ; 0x15530
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $E7
	db $66

	db $00 ; terminator

TileData_15536: ; 0x15536
	db $02 ; total number of tiles

	db $02 ; number of tiles
	dw vBGMap + $C9
	db $68, $69

	db $00 ; terminator

TileData_1553d: ; 0x1553d
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $CC
	db $6a

	db $00 ; terminator

TileDataPointers_BallUpgrade_On_GameBoyColor_RedField: ; 0x15543
	dw TileData_BallUpgrade_Left_On_GameBoyColor_RedField
	dw TileData_BallUpgrade_Center_On_GameBoyColor_RedField
	dw TileData_BallUpgrade_Right_On_GameBoyColor_RedField

TileDataPointers_BallUpgrade_Off_GameBoyColor_RedField: ; 0x15549
	dw TileData_BallUpgrade_Left_Off_GameBoyColor_RedField
	dw TileData_BallUpgrade_Center_Off_GameBoyColor_RedField
	dw TileData_BallUpgrade_Right_Off_GameBoyColor_RedField

TileData_BallUpgrade_Left_On_GameBoyColor_RedField: ; 0x1554f
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $e7
	db $3D

	db $00 ; terminator

TileData_BallUpgrade_Center_On_GameBoyColor_RedField: ; 0x15555
	db $02 ; total number of tiles

	db $02 ; number of tiles
	dw vBGMap + $c9
	db $3F, $40

	db $00 ; terminator

TileData_BallUpgrade_Right_On_GameBoyColor_RedField: ; 0x1555c
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $cc
	db $41

	db $00 ; terminator

TileData_BallUpgrade_Left_Off_GameBoyColor_RedField: ; 0x15562
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $e7
	db $37

	db $00 ; terminator

TileData_BallUpgrade_Center_Off_GameBoyColor_RedField: ; 0x15568
	db $02 ; total number of tiles

	db $02 ; number of tiles
	dw vBGMap + $c9
	db $39, $3a

	db $00 ; terminator

TileData_BallUpgrade_Right_Off_GameBoyColor_RedField: ; 0x1556F
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $cc
	db $3B

	db $00 ; terminator
