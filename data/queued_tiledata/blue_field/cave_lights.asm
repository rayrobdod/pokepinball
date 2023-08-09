TileDataPointers_CaveLights_On_GameBoy_BlueField: ; 0x1e6d7
	dw TileData_CaveLight_C_On_GameBoy_BlueField
	dw TileData_CaveLight_A_On_GameBoy_BlueField
	dw TileData_CaveLight_V_On_GameBoy_BlueField
	dw TileData_CaveLight_E_On_GameBoy_BlueField

TileDataPointers_CaveLights_Off_GameBoy_BlueField: ; 0x1e6df
	dw TileData_CaveLight_C_Off_GameBoy_BlueField
	dw TileData_CaveLight_A_Off_GameBoy_BlueField
	dw TileData_CaveLight_V_Off_GameBoy_BlueField
	dw TileData_CaveLight_E_Off_GameBoy_BlueField

TileData_CaveLight_C_On_GameBoy_BlueField: ; 0x1e6e7
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $5E

	db $00 ; terminator

TileData_CaveLight_A_On_GameBoy_BlueField: ; 0x1e6ed
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $5E

	db $00 ; terminator

TileData_CaveLight_V_On_GameBoy_BlueField: ; 0x1e6f3
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $60

	db $00 ; terminator

TileData_CaveLight_E_On_GameBoy_BlueField: ; 0x1e6f9
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $60

	db $00 ; terminator

TileData_CaveLight_C_Off_GameBoy_BlueField: ; 0x1e6ff
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $5D

	db $00 ; terminator

TileData_CaveLight_A_Off_GameBoy_BlueField: ; 0x1e705
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $5D

	db $00 ; terminator

TileData_CaveLight_V_Off_GameBoy_BlueField: ; 0x1e70b
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $5F

	db $00 ; terminator

TileData_CaveLight_E_Off_GameBoy_BlueField: ; 0x1e711
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $5F

	db $00 ; terminator

TileDataPointers_CaveLights_On_GameBoyColor_BlueField: ; 0x1e717
	dw TileData_CaveLight_C_On_GameBoyColor_BlueField
	dw TileData_CaveLight_A_On_GameBoyColor_BlueField
	dw TileData_CaveLight_V_On_GameBoyColor_BlueField
	dw TileData_CaveLight_E_On_GameBoyColor_BlueField

TileDataPointers_CaveLights_Off_GameBoyColor_BlueField: ; 0x1e71f
	dw TileData_CaveLight_C_Off_GameBoyColor_BlueField
	dw TileData_CaveLight_A_Off_GameBoyColor_BlueField
	dw TileData_CaveLight_V_Off_GameBoyColor_BlueField
	dw TileData_CaveLight_E_Off_GameBoyColor_BlueField

TileData_CaveLight_C_On_GameBoyColor_BlueField: ; 0x1e727
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $49

	db $00 ; terminator

TileData_CaveLight_A_On_GameBoyColor_BlueField: ; 0x1e72d
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $4A

	db $00 ; terminator

TileData_CaveLight_V_On_GameBoyColor_BlueField: ; 0x1e733
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $4B

	db $00 ; terminator

TileData_CaveLight_E_On_GameBoyColor_BlueField: ; 0x1e739
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $4C

	db $00 ; terminator

TileData_CaveLight_C_Off_GameBoyColor_BlueField: ; 0x1e73f
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $121
	db $47

	db $00 ; terminator

TileData_CaveLight_A_Off_GameBoyColor_BlueField: ; 0x1e745
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $123
	db $48

	db $00 ; terminator

TileData_CaveLight_V_Off_GameBoyColor_BlueField: ; 0x1e74b
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $130
	db $7A

	db $00 ; terminator

TileData_CaveLight_E_Off_GameBoyColor_BlueField: ; 0x1e751
	db $01 ; total number of tiles

	db $01 ; number of tiles
	dw vBGMap + $132
	db $7B

	db $00 ; terminator
