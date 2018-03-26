; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ReadConfig_MOD()
	; <><><> Team AiO MOD++ (2018) <><><>
	; CSV Deploy Speed - Team AiO MOD++
	IniReadS($icmbCSVSpeed[$LB], $g_sProfileConfigPath, "CSV Speed", "cmbCSVSpeed[LB]", $icmbCSVSpeed[$LB], "int")
	IniReadS($icmbCSVSpeed[$DB], $g_sProfileConfigPath, "CSV Speed", "cmbCSVSpeed[DB]", $icmbCSVSpeed[$DB], "int")
	For $i = $DB To $LB
		If $icmbCSVSpeed[$i] < 5 Then
			$g_CSVSpeedDivider[$i] = 0.5 + $icmbCSVSpeed[$i] * 0.25        ; $g_CSVSpeedDivider = 0.5, 0.75, 1, 1.25, 1.5
		Else
			$g_CSVSpeedDivider[$i] = 2 + $icmbCSVSpeed[$i] - 5            ; $g_CSVSpeedDivider = 2, 3, 4, 5
		EndIf
	Next
	; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
	IniReadS($g_bEnableAuto, $g_sProfileConfigPath, "general", "EnableAuto", $g_bEnableAuto, "Bool")
	IniReadS($g_iChkAutoDock, $g_sProfileConfigPath, "general", "AutoDock", $g_iChkAutoDock, "Bool")
	IniReadS($g_iChkAutoHideEmulator, $g_sProfileConfigPath, "general", "AutoHide", $g_iChkAutoHideEmulator, "Bool")
	IniReadS($g_iChkAutoMinimizeBot, $g_sProfileConfigPath, "general", "AutoMinimize", $g_iChkAutoMinimizeBot, "Bool")

	; Check Collector Outside - Team AiO MOD++
	IniReadS($g_bDBMeetCollOutside, $g_sProfileConfigPath, "search", "DBMeetCollOutside", $g_bDBMeetCollOutside, "Bool")
	IniReadS($g_iTxtDBMinCollOutsidePercent, $g_sProfileConfigPath, "search", "TxtDBMinCollOutsidePercent", $g_iTxtDBMinCollOutsidePercent, "int")
	IniReadS($g_bDBCollectorsNearRedline, $g_sProfileConfigPath, "search", "DBCollectorsNearRedline", $g_bDBCollectorsNearRedline, "int")
	IniReadS($g_iCmbRedlineTiles, $g_sProfileConfigPath, "search", "CmbRedlineTiles", $g_iCmbRedlineTiles, "int")
	IniReadS($g_bSkipCollectorCheck, $g_sProfileConfigPath, "search", "SkipCollectorCheck", $g_bSkipCollectorCheck, "int")
	IniReadS($g_iTxtSkipCollectorGold, $g_sProfileConfigPath, "search", "TxtSkipCollectorGold", $g_iTxtSkipCollectorGold, "int")
	IniReadS($g_iTxtSkipCollectorElixir, $g_sProfileConfigPath, "search", "TxtSkipCollectorElixir", $g_iTxtSkipCollectorElixir, "int")
	IniReadS($g_iTxtSkipCollectorDark, $g_sProfileConfigPath, "search", "TxtSkipCollectorDark", $g_iTxtSkipCollectorDark, "int")
	IniReadS($g_bSkipCollectorCheckTH, $g_sProfileConfigPath, "search", "SkipCollectorCheckTH", $g_bSkipCollectorCheckTH, "int")
	IniReadS($g_iCmbSkipCollectorCheckTH, $g_sProfileConfigPath, "search", "CmbSkipCollectorCheckTH", $g_iCmbSkipCollectorCheckTH, "int")

	; ClanHop - Team AiO MOD++
	IniReadS($g_bChkClanHop, $g_sProfileConfigPath, "donate", "chkClanHop", $g_bChkClanHop, "Bool")

	; Bot Humanization - Team AiO MOD++
	IniReadS($g_ichkUseBotHumanization, $g_sProfileConfigPath, "Bot Humanization", "chkUseBotHumanization", $g_ichkUseBotHumanization, "int")
	IniReadS($g_ichkUseAltRClick, $g_sProfileConfigPath, "Bot Humanization", "chkUseAltRClick", $g_ichkUseAltRClick, "int")
	IniReadS($g_ichkCollectAchievements, $g_sProfileConfigPath, "Bot Humanization", "chkCollectAchievements", $g_ichkCollectAchievements, "int")
	IniReadS($g_ichkLookAtRedNotifications, $g_sProfileConfigPath, "Bot Humanization", "chkLookAtRedNotifications", $g_ichkLookAtRedNotifications, "int")
	For $i = 0 To 12
		IniReadS($g_iacmbPriority[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPriority[" & $i & "]", $g_iacmbPriority[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbMaxSpeed[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbMaxSpeed[" & $i & "]", $g_iacmbMaxSpeed[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbPause[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPause[" & $i & "]", $g_iacmbPause[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iahumanMessage[$i], $g_sProfileConfigPath, "Bot Humanization", "humanMessage[" & $i & "]", $g_iahumanMessage[$i])
	Next
	IniReadS($g_icmbMaxActionsNumber, $g_sProfileConfigPath, "Bot Humanization", "cmbMaxActionsNumber", $g_icmbMaxActionsNumber, "int")
	IniReadS($g_ichallengeMessage, $g_sProfileConfigPath, "Bot Humanization", "challengeMessage", $g_ichallengeMessage)

	; Goblin XP - Team AiO MOD++
	IniReadS($ichkEnableSuperXP, $g_sProfileConfigPath, "GoblinXP", "EnableSuperXP", 0, "int")
	IniReadS($ichkSkipZoomOutXP, $g_sProfileConfigPath, "GoblinXP", "SkipZoomOutXP", 0, "int")
	IniReadS($ichkFastGoblinXP, $g_sProfileConfigPath, "GoblinXP", "FastGoblinXP", 0, "int")
	IniReadS($irbSXTraining, $g_sProfileConfigPath, "GoblinXP", "SXTraining", 1, "int")
	IniReadS($itxtMaxXPtoGain, $g_sProfileConfigPath, "GoblinXP", "MaxXptoGain", 500, "int")
	IniReadS($ichkSXBK, $g_sProfileConfigPath, "GoblinXP", "SXBK", $eHeroNone)
	IniReadS($ichkSXAQ, $g_sProfileConfigPath, "GoblinXP", "SXAQ", $eHeroNone)
	IniReadS($ichkSXGW, $g_sProfileConfigPath, "GoblinXP", "SXGW", $eHeroNone)

	; GTFO - Team AiO MOD++
	IniReadS($g_bChkUseGTFO, $g_sProfileConfigPath, "GTFO", "chkUseGTFO", $g_bChkUseGTFO, "Bool")
	IniReadS($g_iTxtMinSaveGTFO_Elixir, $g_sProfileConfigPath, "GTFO", "txtMinSaveGTFO_Elixir", $g_iTxtMinSaveGTFO_Elixir, "Int")
	IniReadS($g_iTxtMinSaveGTFO_DE, $g_sProfileConfigPath, "GTFO", "txtMinSaveGTFO_DE", $g_iTxtMinSaveGTFO_DE, "Int")
	IniReadS($g_bChkUseKickOut, $g_sProfileConfigPath, "GTFO", "chkUseKickOut", $g_bChkUseKickOut, "Bool")
	IniReadS($g_iTxtDonatedCap, $g_sProfileConfigPath, "GTFO", "txtDonatedCap", $g_iTxtDonatedCap, "Int")
	IniReadS($g_iTxtReceivedCap, $g_sProfileConfigPath, "GTFO", "txtReceivedCap", $g_iTxtReceivedCap, "Int")
	IniReadS($g_bChkKickOutSpammers, $g_sProfileConfigPath, "GTFO", "chkKickOutSpammers", $g_bChkKickOutSpammers, "Bool")
	IniReadS($g_iTxtKickLimit, $g_sProfileConfigPath, "GTFO", "txtKickLimit", $g_iTxtKickLimit, "Int")

	; Max logout time - Team AiO MOD++
	IniReadS($g_bTrainLogoutMaxTime, $g_sProfileConfigPath, "TrainLogout", "TrainLogoutMaxTime", $g_bTrainLogoutMaxTime, "Bool")
	IniReadS($g_iTrainLogoutMaxTime, $g_sProfileConfigPath, "TrainLogout", "TrainLogoutMaxTimeTXT", $g_iTrainLogoutMaxTime, "int")

	; Request CC Troops at first - Team AiO MOD++
	IniReadS($g_bReqCCFirst, $g_sProfileConfigPath, "planned", "ReqCCFirst", $g_bReqCCFirst, "Bool")

	; CheckCC Troops - Team AiO MOD++
	IniReadS($g_bChkCC, $g_sProfileConfigPath, "CheckCC", "Enable", $g_bChkCC, "Bool")
	IniReadS($g_iCmbCastleCapacityT, $g_sProfileConfigPath, "CheckCC", "Troop Capacity", $g_iCmbCastleCapacityT, "int")
	IniReadS($g_iCmbCastleCapacityS, $g_sProfileConfigPath, "CheckCC", "Spell Capacity", $g_iCmbCastleCapacityS, "int")

	For $i = 0 To $eTroopCount - 1
		$g_aiCCTroopsExpected[$i] = 0
		If $i >= $eSpellCount Then ContinueLoop
		$g_aiCCSpellsExpected[$i] = 0
	Next
	$g_bChkCCTroops = False

	For $i = 0 To 4
		Local $default = 19
		If $i > 2 Then $default = 9
		IniReadS($g_aiCmbCCSlot[$i], $g_sProfileConfigPath, "CheckCC", "ExpectSlot" & $i, $default, "int")
		IniReadS($g_aiTxtCCSlot[$i], $g_sProfileConfigPath, "CheckCC", "ExpectQty" & $i, 0, "int")
		If $g_aiCmbCCSlot[$i] > -1 And $g_aiCmbCCSlot[$i] < $default Then
			Local $j = $g_aiCmbCCSlot[$i]
			If $i <= 2 Then
				$g_aiCCTroopsExpected[$j] += $g_aiTxtCCSlot[$i]
			Else
				If $j > $eSpellFreeze Then $j += 1 ; exclude Clone Spell
				$g_aiCCSpellsExpected[$j] += $g_aiTxtCCSlot[$i]
			EndIf
			If $g_bChkCC Then $g_bChkCCTroops = True
		EndIf
	Next

	; Check Grand Warden Mode - Team AiO MOD++
	IniReadS($g_bCheckWardenMode, $g_sProfileConfigPath, "other", "chkCheckWardenMode", False, "Bool")
	IniReadS($g_iCheckWardenMode, $g_sProfileConfigPath, "other", "cmbCheckWardenMode", 0, "int")

	; Unit/Wave Factor - Team AiO MOD++
	IniReadS($g_iChkGiantSlot, $g_sProfileConfigPath, "SetSleep", "EnableGiantSlot", $g_iChkGiantSlot, "int")
	IniReadS($g_iCmbGiantSlot, $g_sProfileConfigPath, "SetSleep", "CmbGiantSlot", $g_iCmbGiantSlot ,"int")
	IniReadS($g_iChkUnitFactor, $g_sProfileConfigPath, "SetSleep", "EnableUnitFactor", $g_iChkUnitFactor, "int")
	IniReadS($g_iTxtUnitFactor, $g_sProfileConfigPath, "SetSleep", "UnitFactor", $g_iTxtUnitFactor, "int")
	IniReadS($g_iChkWaveFactor, $g_sProfileConfigPath, "SetSleep", "EnableWaveFactor", $g_iChkWaveFactor, "int")
	IniReadS($g_iTxtWaveFactor, $g_sProfileConfigPath, "SetSleep", "WaveFactor", $g_iTxtWaveFactor, "int")

	; Restart Search Legend league - Team AiO MOD++
	IniReadS($g_bIsSearchTimeout, $g_sProfileConfigPath, "other", "ChkSearchTimeout", $g_bIsSearchTimeout, "Bool")
	IniReadS($g_iSearchTimeout, $g_sProfileConfigPath, "other", "SearchTimeout", $g_iSearchTimeout, "int")

	; Stop on Low battery - Team AiO MOD++
	IniReadS($g_bStopOnBatt, $g_sProfileConfigPath, "other", "ChkStopOnBatt", $g_bStopOnBatt, "Bool")
	IniReadS($g_iSearchTimeout, $g_sProfileConfigPath, "other", "StopOnBatt", $g_iStopOnBatt, "int")

	; Attack Log - Team AiO MOD++
	IniReadS($g_bColorfulAttackLog, $g_sProfileConfigPath, "attack", "ColorfulAttackLog", False, "Bool")

EndFunc   ;==>ReadConfig_MOD
