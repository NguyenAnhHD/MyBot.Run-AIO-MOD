; #FUNCTION# ====================================================================================================================
; Name ..........: Clan Games Variables GUI (V2)
; Description ...: Clan Games Made with love by Team VENOM
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: ViperZ And Uncle Xbenk (Team VENOM)
; Modified ......: ProMac 02/2018 [v2]
; Remarks .......: This file is part of MyBotRun. Copyright 2017
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......: ---
;================================================================================================================================


; CLAN GAMES v2
Global $g_hChkClanGamesAir = 0, $g_hChkClanGamesGround = 0, $g_hChkClanGamesMisc = 0

; Clan Games v3
; [Enable or Disabe the feature]
Global $g_hChkClanGamesEnabled = 0
; [Challenges]
 Global $g_hChkClanGamesLoot = 0 , $g_hChkClanGamesBattle =0 , $g_hChkClanGamesDestruction = 0 , $g_hChkClanGamesAirTroop = 0 , $g_hChkClanGamesGroundTroop = 0 , $g_hChkClanGamesMiscellaneous = 0
; [ Purge Versus Battles Events]
 Global $g_hChkClanGamesPurge = 0 , $g_hcmbPurgeLimit = 0 , $g_hChkClanGamesStopBeforeReachAndPurge = 0
; [LogTxtBox]
Global $g_hTxtClanGamesLog = 0
; [Enable or Disable the Debug Images]
Global $g_hChkClanGamesDebug = 0
; [Labels]
Global $g_hLblRemainTime = 0 , $g_hLblYourScore = 0


; Clan Games v3
Func CreateMiscClanGamesV3SubTab()

	Local Const $g_sLibIconPathMOD = @ScriptDir & "\images\ClanGames.bmp"

	; GUI SubTab
	Local $x = 15, $y = 45
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "Group_CG", "Clan Games"), $x - 10, $y - 20, $g_iSizeWGrpTab3, 245)
		GUICtrlCreatePic($g_sLibIconPathMOD, $x + 5, $y, 94, 128, $SS_BITMAP)

		GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesTimeRemaining", "Time Remaining"), $x - 5 , $y + 135 , 110 , 40 )
			$g_hLblRemainTime = GUICtrlCreateLabel("0d 00h", $x + 15 , $y + 135 + 15 , 65 , 17, $SS_CENTER)
				GUICtrlSetFont(-1, 9.5, $FW_BOLD, $GUI_FONTNORMAL)
		GUICtrlCreateGroup("", -99, -99, 1, 1)

		GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesYourScore", "Your Score"), $x - 5 , $y + 158 + 20 , 110 , 40 )
			$g_hLblYourScore = GUICtrlCreateLabel("0/0", $x + 15 , $y + 158 + 35 , 65 , 17, $SS_CENTER)
				GUICtrlSetFont(-1, 9.5, $FW_BOLD, $GUI_FONTNORMAL)
		GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 150
		$g_hChkClanGamesEnabled = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesEnabled", "Clan Games"), $x , $y , -1, -1)
		GUICtrlSetOnEvent(-1, "chkActivateClangames")
		$g_hChkClanGamesDebug = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesDebug", "Debug"), $x + 205, $y , -1, -1)
	$x += 25
	$y += 25
		$g_hChkClanGamesLoot = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesLoot", "Loot Challenges"), $x , $y , -1, -1)
	$y += 25
		$g_hChkClanGamesBattle = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesBattle", "Battle Challenges"), $x , $y , -1, -1)
	$y += 25
		$g_hChkClanGamesDestruction = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesDestruction", "Destruction Challenges"), $x , $y , -1, -1)
	$y += 25
		$g_hChkClanGamesAirTroop = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesAirTroop", "Air Troops Challenges"), $x , $y , -1, -1)
	$y += 25
		$g_hChkClanGamesGroundTroop = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesGroundTroop", "Ground Troops Challenges"), $x , $y , -1, -1)
	$y += 25
		$g_hChkClanGamesMiscellaneous = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesMiscellaneous", "Miscellaneous Challenges"), $x , $y , -1, -1)
	$y += 25
		$g_hChkClanGamesPurge = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesPurge", "Purge Versus Battles Events"), $x , $y , -1, -1)
			GUICtrlSetOnEvent(-1, "chkPurgeLimits")
		$g_hcmbPurgeLimit = GUICtrlCreateCombo("" , $x + 155 , $y , 70 , -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1,"Unlimited| 1x| 2x| 3x| 4x| 5x| 6x| 7x| 8x| 9x|10x" , " 5x")
	$y += 25
		$g_hChkClanGamesStopBeforeReachAndPurge = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "ChkClanGamesStopBeforeReachAndPurge", "Stop before completing your limit and only Purge"), $x , $y , -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 15
	$y = 45
	$g_hTxtClanGamesLog = GUICtrlCreateEdit("", $x - 10, 275, $g_iSizeWGrpTab3, 127, BitOR($GUI_SS_DEFAULT_EDIT, $ES_READONLY, $ES_AUTOVSCROLL))
	GUICtrlSetData(-1, GetTranslatedFileIni("MBR GUI Design Child Village - Misc", "TxtClanGamesLog", _
			"--------------------------------------------------------- Clan Games LOG ------------------------------------------------"))

EndFunc   ;==>CreateMiscClanGamesV3SubTab