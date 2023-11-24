SECTION "SRAM 0", SRAM

MACRO saved_data
\1:: ds \2
\1Signature:: ds 2
\1Checksum:: dw
\1Backup:: ds \2
\1BackupSignature:: ds 2
\1BackupChecksum:: dw
ENDM

	saved_data sHighScores,     wHighScoresEnd - wHighScores   ; a000
	saved_data sPokedexFlags, wPokedexFlagsEnd - wPokedexFlags ; a10c
	saved_data sKeyConfigs,     wKeyConfigsEnd - wKeyConfigs   ; a244
	saved_data sSaveGame,         wSaveGameEnd - wSaveGame     ; a268
; abf6

	ds $409
sRNGMod:: ; afff
