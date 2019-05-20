; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: Team AiO MOD++ (2019)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
;<><><> Team AiO MOD++ (2019) <><><>
Func ReadConfig_MOD_SuperXP()
	; <><><> SuperXP / GoblinXP <><><>
	IniReadS($g_bEnableSuperXP, $g_sProfileConfigPath, "SuperXP", "EnableSuperXP", $g_bEnableSuperXP, "Bool")
	IniReadS($g_bSkipZoomOutSX, $g_sProfileConfigPath, "SuperXP", "SkipZoomOutSX", $g_bSkipZoomOutSX, "Bool")
	IniReadS($g_bFastSuperXP, $g_sProfileConfigPath, "SuperXP", "FastSuperXP", $g_bFastSuperXP, "Bool")
	IniReadS($g_bSkipDragToEndSX, $g_sProfileConfigPath, "SuperXP", "SkipDragToEndSX", $g_bSkipDragToEndSX, "Bool")
	IniReadS($g_iActivateOptionSX, $g_sProfileConfigPath, "SuperXP", "ActivateOptionSX", $g_iActivateOptionSX, "int")
	IniReadS($g_iGoblinMapOptSX, $g_sProfileConfigPath, "SuperXP", "GoblinMapOptSX", $g_iGoblinMapOptSX, "int")

	IniReadS($g_iMaxXPtoGain, $g_sProfileConfigPath, "SuperXP", "MaxXPtoGain", $g_iMaxXPtoGain, "int")
	IniReadS($g_bBKingSX, $g_sProfileConfigPath, "SuperXP", "BKingSX", $eHeroNone)
	IniReadS($g_bAQueenSX, $g_sProfileConfigPath, "SuperXP", "AQueenSX", $eHeroNone)
	IniReadS($g_bGWardenSX, $g_sProfileConfigPath, "SuperXP", "GWardenSX", $eHeroNone)
EndFunc   ;==>ReadConfig_MOD_SuperXP

Func ReadConfig_MOD_ChatActions()
	; <><><> ChatActions <><><>
	IniReadS($g_bChatGlobal, $g_sProfileConfigPath, "ChatActions", "EnableChatGlobal", $g_bChatGlobal, "Bool")
	IniReadS($g_sDelayTimeGlobal, $g_sProfileConfigPath, "ChatActions", "DelayTimeGlobal", $g_sDelayTimeGlobal, "Int")
	IniReadS($g_bScrambleGlobal, $g_sProfileConfigPath, "ChatActions", "ScrambleGlobal", $g_bScrambleGlobal, "Bool")
	IniReadS($g_bSwitchLang, $g_sProfileConfigPath, "ChatActions", "SwitchLang", $g_bSwitchLang, "Bool")
	IniReadS($g_iCmbLang, $g_sProfileConfigPath, "ChatActions", "CmbLang", $g_iCmbLang, "int")
	IniReadS($g_bRusLang, $g_sProfileConfigPath, "ChatActions", "RusLang", $g_bRusLang, "Bool")

	IniReadS($g_bChatClan, $g_sProfileConfigPath, "ChatActions", "EnableChatClan", $g_bChatClan, "Bool")
	IniReadS($g_sDelayTimeClan, $g_sProfileConfigPath, "ChatActions", "DelayTimeClan", $g_sDelayTimeClan, "Int")
	IniReadS($g_bClanUseResponses, $g_sProfileConfigPath, "ChatActions", "UseResponsesClan", $g_bClanUseResponses, "Bool")
	IniReadS($g_bClanAlwaysMsg, $g_sProfileConfigPath, "ChatActions", "UseGenericClan", $g_bClanAlwaysMsg, "Bool")
	IniReadS($g_bCleverbot, $g_sProfileConfigPath, "ChatActions", "Cleverbot", $g_bCleverbot, "Bool")
	IniReadS($g_bUseNotify, $g_sProfileConfigPath, "ChatActions", "ChatNotify", $g_bUseNotify, "Bool")
	IniReadS($g_bPbSendNew, $g_sProfileConfigPath, "ChatActions", "PbSendNewChats", $g_bPbSendNew, "Bool")

	IniReadS($g_bEnableFriendlyChallenge, $g_sProfileConfigPath, "ChatActions", "EnableFriendlyChallenge", $g_bEnableFriendlyChallenge, "Bool")
	IniReadS($g_sDelayTimeFC, $g_sProfileConfigPath, "ChatActions", "DelayTimeFriendlyChallenge", $g_sDelayTimeFC, "Int")
	IniReadS($g_bOnlyOnRequest, $g_sProfileConfigPath, "ChatActions", "EnableOnlyOnRequest", $g_bOnlyOnRequest, "Bool")
	$g_iTxtChallengeText = StringReplace(IniRead($g_sProfileConfigPath, "ChatActions", "FriendlyChallengeText", "I am challenging help you|HaHaHaHa"), "|", @CRLF)
	$g_iTxtKeywordForRequest = StringReplace(IniRead($g_sProfileConfigPath, "ChatActions", "FriendlyChallengeKeyword", "friendly|challenge"), "|", @CRLF)
	$g_bFriendlyChallengeBase = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "FriendlyChallengeBaseForShare", "0|0|0|0|0|0"), "|", $STR_NOCOUNT)
	For $i = 0 To 5
		$g_bFriendlyChallengeBase[$i] = ($g_bFriendlyChallengeBase[$i] = "1")
	Next
	$g_abFriendlyChallengeHours = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "FriendlyChallengePlannedRequestHours", "1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"), "|", $STR_NOCOUNT)
	For $i = 0 To 23
		$g_abFriendlyChallengeHours[$i] = ($g_abFriendlyChallengeHours[$i] = "1")
	Next

	IniReadS($g_sIAVar, $g_sProfileConfigPath, "ChatActions", "String", '0|0|0|0|0', Default)
	$g_aIAVar = StringSplit($g_sIAVar, "|", $STR_NOCOUNT)
EndFunc   ;==>ReadConfig_MOD_ChatActions

Func ReadConfig_MOD_600_6()
	; <><><> Daily Discounts + Builder Base Attack + Builder Base Drop Order <><><>
	For $i = 0 To $g_iDDCount - 1
		IniReadS($g_abChkDD_Deals[$i], $g_sProfileConfigPath, "DailyDiscounts", "ChkDD_Deals" & String($i), $g_abChkDD_Deals[$i], "Bool")
	Next
	IniReadS($g_bDD_DealsSet, $g_sProfileConfigPath, "DailyDiscounts", "DD_DealsSet", $g_bDD_DealsSet, "Bool")

	IniReadS($g_bChkEnableBBAttack, $g_sProfileConfigPath, "BBAttack", "ChkEnableBBAttack", $g_bChkEnableBBAttack, "Bool")
	IniReadS($g_bChkBBTrophyRange, $g_sProfileConfigPath, "BBAttack", "ChkBBTrophyRange", $g_bChkBBTrophyRange, "Bool")
	IniReadS($g_iTxtBBTrophyLowerLimit, $g_sProfileConfigPath, "BBAttack", "TxtBBTrophyLowerLimit", $g_iTxtBBTrophyLowerLimit, "int")
	IniReadS($g_iTxtBBTrophyUpperLimit, $g_sProfileConfigPath, "BBAttack", "TxtBBTrophyUpperLimit", $g_iTxtBBTrophyUpperLimit, "int")
	IniReadS($g_bChkBBAttIfLootAvail, $g_sProfileConfigPath, "BBAttack", "ChkBBAttIfLootAvail", $g_bChkBBAttIfLootAvail, "Bool")
	IniReadS($g_bChkBBWaitForMachine, $g_sProfileConfigPath, "BBAttack", "ChkBBWaitForMachine", $g_bChkBBWaitForMachine, "Bool")

	IniReadS($g_bBBDropOrderSet, $g_sProfileConfigPath, "BBAttack", "bBBDropOrderSet", $g_bBBDropOrderSet, "Bool")
	$g_sBBDropOrder = IniRead($g_sProfileConfigPath, "BBAttack", "sBBDropOrder", $g_sBBDropOrderDefault)
EndFunc   ;==>ReadConfig_MOD_600_6

Func ReadConfig_MOD_600_11()
	; <><><> Request CC for defense <><><>
	$g_bRequestCCDefense = (IniRead($g_sProfileConfigPath, "donate", "RequestDefenseEnable", "0") = "1")
	$g_sRequestCCDefenseText = IniRead($g_sProfileConfigPath, "donate", "RequestDefenseText", "")
	$g_bRequestCCDefenseWhenPB = (IniRead($g_sProfileConfigPath, "donate", "RequestDefenseWhenPB", "1") = "1")
	$g_iRequestDefenseTime = Int(IniRead($g_sProfileConfigPath, "donate", "RequestDefenseTime", "30"))
	$g_bSaveCCTroopForDefense = (IniRead($g_sProfileConfigPath, "donate", "SaveCCTroopForDefense", "0") = "1")

	For $i = 0 To $eTroopCount - 1
		$g_aiCCTroopsExpectedForDefense[$i] = 0
	Next
	For $i = 0 To 2
		$g_aiCCTroopDefenseType[$i] = Int(IniRead($g_sProfileConfigPath, "donate", "cmbCCTroopDefense" & $i, $eTroopCount))
		$g_aiCCTroopDefenseQty[$i] = Int(IniRead($g_sProfileConfigPath, "donate", "txtCCTroopDefense" & $i, "0"))
		If $g_aiCCTroopDefenseType[$i] < $eTroopCount Then ; Barb - IceG
			$g_aiCCTroopsExpectedForDefense[$g_aiCCTroopDefenseType[$i]] += $g_aiCCTroopDefenseQty[$i]
		EndIf
	Next
EndFunc   ;==>ReadConfig_MOD_600_11

Func ReadConfig_MOD_600_12()
	; <><><> ClanHop <><><>
	IniReadS($g_bChkClanHop, $g_sProfileConfigPath, "donate", "chkClanHop", $g_bChkClanHop, "Bool")
EndFunc   ;==>ReadConfig_MOD_600_12

Func ReadConfig_MOD_600_28()
	; <><><> Restart Search Legend league <><><>
	IniReadS($g_bIsSearchTimeout, $g_sProfileConfigPath, "other", "ChkSearchTimeout", $g_bIsSearchTimeout, "Bool")
	IniReadS($g_iSearchTimeout, $g_sProfileConfigPath, "other", "SearchTimeout", $g_iSearchTimeout, "int")
EndFunc   ;==>ReadConfig_MOD_600_28

Func ReadConfig_MOD_600_29()
	; <><><> CSV Deploy Speed <><><>
	IniReadS($icmbCSVSpeed[$LB], $g_sProfileConfigPath, "attack", "cmbCSVSpeedLB", $icmbCSVSpeed[$LB], "int")
	IniReadS($icmbCSVSpeed[$DB], $g_sProfileConfigPath, "attack", "cmbCSVSpeedDB", $icmbCSVSpeed[$DB], "int")
	For $i = $DB To $LB
		If $icmbCSVSpeed[$i] < 5 Then
			$g_CSVSpeedDivider[$i] = 0.5 + $icmbCSVSpeed[$i] * 0.25        ; $g_CSVSpeedDivider = 0.5, 0.75, 1, 1.25, 1.5
		Else
			$g_CSVSpeedDivider[$i] = 2 + $icmbCSVSpeed[$i] - 5            ; $g_CSVSpeedDivider = 2, 3, 4, 5
		EndIf
	Next
EndFunc   ;==>ReadConfig_MOD_600_29

Func ReadConfig_MOD_600_31()
	; <><><> Check Collectors Outside <><><>
	IniReadS($g_bDBMeetCollectorOutside, $g_sProfileConfigPath, "search", "DBMeetCollectorOutside", $g_bDBMeetCollectorOutside, "Bool")
	IniReadS($g_iDBMinCollectorOutsidePercent, $g_sProfileConfigPath, "search", "TxtDBMinCollectorOutsidePercent", $g_iDBMinCollectorOutsidePercent, "int")

	IniReadS($g_bDBCollectorNearRedline, $g_sProfileConfigPath, "search", "DBCollectorNearRedline", $g_bDBCollectorNearRedline, "Bool")
	IniReadS($g_iCmbRedlineTiles, $g_sProfileConfigPath, "search", "CmbRedlineTiles", $g_iCmbRedlineTiles, "int")

	IniReadS($g_bSkipCollectorCheck, $g_sProfileConfigPath, "search", "SkipCollectorCheck", $g_bSkipCollectorCheck, "Bool")
	IniReadS($g_iTxtSkipCollectorGold, $g_sProfileConfigPath, "search", "TxtSkipCollectorGold", $g_iTxtSkipCollectorGold, "int")
	IniReadS($g_iTxtSkipCollectorElixir, $g_sProfileConfigPath, "search", "TxtSkipCollectorElixir", $g_iTxtSkipCollectorElixir, "int")
	IniReadS($g_iTxtSkipCollectorDark, $g_sProfileConfigPath, "search", "TxtSkipCollectorDark", $g_iTxtSkipCollectorDark, "int")

	IniReadS($g_bSkipCollectorCheckTH, $g_sProfileConfigPath, "search", "SkipCollectorCheckTH", $g_bSkipCollectorCheckTH, "Bool")
	IniReadS($g_iCmbSkipCollectorCheckTH, $g_sProfileConfigPath, "search", "CmbSkipCollectorCheckTH", $g_iCmbSkipCollectorCheckTH, "int")
EndFunc   ;==>ReadConfig_MOD_600_31

Func ReadConfig_MOD_600_35_1()
	; <><><> Auto Dock, Hide Emulator & Bot <><><>
	IniReadS($g_bEnableAuto, $g_sProfileConfigPath, "general", "EnableAuto", $g_bEnableAuto, "Bool")
	IniReadS($g_bChkAutoDock, $g_sProfileConfigPath, "general", "AutoDock", $g_bChkAutoDock, "Bool")
	IniReadS($g_bChkAutoHideEmulator, $g_sProfileConfigPath, "general", "AutoHide", $g_bChkAutoHideEmulator, "Bool")
	IniReadS($g_bChkAutoMinimizeBot, $g_sProfileConfigPath, "general", "AutoMinimize", $g_bChkAutoMinimizeBot, "Bool")
EndFunc   ;==>ReadConfig_MOD_600_35_1

Func ReadConfig_MOD_600_35_2()
	; <><><> Switch Profiles <><><>
	For $i = 0 To 3
		IniReadS($g_abChkSwitchMax[$i], $g_sProfileConfigPath, "SwitchProfile", "SwitchProfileMax" & $i, $g_abChkSwitchMax[$i], "Bool")
		IniReadS($g_abChkSwitchMin[$i], $g_sProfileConfigPath, "SwitchProfile", "SwitchProfileMin" & $i, $g_abChkSwitchMin[$i], "Bool")
		IniReadS($g_aiCmbSwitchMax[$i], $g_sProfileConfigPath, "SwitchProfile", "TargetProfileMax" & $i, $g_aiCmbSwitchMax[$i], "Int")
		IniReadS($g_aiCmbSwitchMin[$i], $g_sProfileConfigPath, "SwitchProfile", "TargetProfileMin" & $i, $g_aiCmbSwitchMin[$i], "Int")

		IniReadS($g_abChkBotTypeMax[$i], $g_sProfileConfigPath, "SwitchProfile", "ChangeBotTypeMax" & $i, $g_abChkBotTypeMax[$i], "Bool")
		IniReadS($g_abChkBotTypeMin[$i], $g_sProfileConfigPath, "SwitchProfile", "ChangeBotTypeMin" & $i, $g_abChkBotTypeMin[$i], "Bool")
		IniReadS($g_aiCmbBotTypeMax[$i], $g_sProfileConfigPath, "SwitchProfile", "TargetBotTypeMax" & $i, $g_aiCmbBotTypeMax[$i], "Int")
		IniReadS($g_aiCmbBotTypeMin[$i], $g_sProfileConfigPath, "SwitchProfile", "TargetBotTypeMin" & $i, $g_aiCmbBotTypeMin[$i], "Int")

		IniReadS($g_aiConditionMax[$i], $g_sProfileConfigPath, "SwitchProfile", "ConditionMax" & $i, $g_aiConditionMax[$i], "Int")
		IniReadS($g_aiConditionMin[$i], $g_sProfileConfigPath, "SwitchProfile", "ConditionMin" & $i, $g_aiConditionMin[$i], "Int")
	Next
EndFunc   ;==>ReadConfig_MOD_600_35_2

Func ReadConfig_MOD_641_1()
	; <><><> Max logout time <><><>
	IniReadS($g_bTrainLogoutMaxTime, $g_sProfileConfigPath, "other", "chkTrainLogoutMaxTime", $g_bTrainLogoutMaxTime, "Bool")
	IniReadS($g_iTrainLogoutMaxTime, $g_sProfileConfigPath, "other", "txtTrainLogoutMaxTime", $g_iTrainLogoutMaxTime, "int")
EndFunc   ;==>ReadConfig_MOD_641_1
