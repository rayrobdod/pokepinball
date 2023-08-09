TileDataPointers_CaveLights_On_GameBoy_RedField: ; 0x152dd
	dw TileData_CaveLight_C_On_GameBoy_RedField
	dw TileData_CaveLight_A_On_GameBoy_RedField
	dw TileData_CaveLight_V_On_GameBoy_RedField
	dw TileData_CaveLight_E_On_GameBoy_RedField

TileDataPointers_CaveLights_Off_GameBoy_RedField: ; 0x152e5
	dw TileData_CaveLight_C_Off_GameBoy_RedField
	dw TileData_CaveLight_A_Off_GameBoy_RedField
	dw TileData_CaveLight_V_Off_GameBoy_RedField
	dw TileData_CaveLight_E_Off_GameBoy_RedField

TileData_CaveLight_C_On_GameBoy_RedField: ; 0x152ed
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $7d

	db $00 ; terminator

TileData_CaveLight_A_On_GameBoy_RedField: ; 0x152f3
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $7d

	db $00 ; terminator

TileData_CaveLight_V_On_GameBoy_RedField: ; 0x152f9
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $7f

	db $00 ; terminator

TileData_CaveLight_E_On_GameBoy_RedField: ; 0x152ff
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $7f

	db $00 ; terminator

TileData_CaveLight_C_Off_GameBoy_RedField: ; 0x15305
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $7c

	db $00 ; terminator

TileData_CaveLight_A_Off_GameBoy_RedField: ; 0x1530b
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $7c

	db $00 ; terminator

TileData_CaveLight_V_Off_GameBoy_RedField: ; 0x15311
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $7e

	db $00 ; terminator

TileData_CaveLight_E_Off_GameBoy_RedField: ; 0x15317
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $7e

	db $00 ; terminator

TileDataPointers_CaveLights_On_GameBoyColor_RedField: ; 0x1531d
	dw TileData_CaveLight_C_On_GameBoyColor_RedField
	dw TileData_CaveLight_A_On_GameBoyColor_RedField
	dw TileData_CaveLight_V_On_GameBoyColor_RedField
	dw TileData_CaveLight_E_On_GameBoyColor_RedField

TileDataPointers_CaveLights_Off_GameBoyColor_RedField: ; 0x15325
	dw TileData_CaveLight_C_Off_GameBoyColor_RedField
	dw TileData_CaveLight_A_Off_GameBoyColor_RedField
	dw TileData_CaveLight_V_Off_GameBoyColor_RedField
	dw TileData_CaveLight_E_Off_GameBoyColor_RedField

TileData_CaveLight_C_On_GameBoyColor_RedField: ; 0x1532d
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $27

	db $00 ; terminator

TileData_CaveLight_A_On_GameBoyColor_RedField: ; 0x15333
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $29

	db $00 ; terminator

TileData_CaveLight_V_On_GameBoyColor_RedField: ; 0x15339
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $7E

	db $00 ; terminator

TileData_CaveLight_E_On_GameBoyColor_RedField: ; 0x1533f
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $7F

	db $00 ; terminator

TileData_CaveLight_C_Off_GameBoyColor_RedField: ; 0x15345
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $26

	db $00 ; terminator

TileData_CaveLight_A_Off_GameBoyColor_RedField: ; 0x1534b
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $28

	db $00 ; terminator

TileData_CaveLight_V_Off_GameBoyColor_RedField: ; 0x15351
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $7C

	db $00 ; terminator

TileData_CaveLight_E_Off_GameBoyColor_RedField: ; 0x15357
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $7D

	db $00 ; terminator
