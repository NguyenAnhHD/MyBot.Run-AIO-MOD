; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
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
Func SaveConfig_MOD_SuperXP()
	; <><><> SuperXP / GoblinXP <><><>
	ApplyConfig_MOD_SuperXP(GetApplyConfigSaveAction())
	_Ini_Add("SuperXP", "EnableSuperXP", $g_bEnableSuperXP ? 1 : 0)
	_Ini_Add("SuperXP", "SkipZoomOutSX", $g_bSkipZoomOutSX ? 1 : 0)
	_Ini_Add("SuperXP", "FastSuperXP", $g_bFastSuperXP ? 1 : 0)
	_Ini_Add("SuperXP", "SkipDragToEndSX", $g_bSkipDragToEndSX ? 1 : 0)
	_Ini_Add("SuperXP", "ActivateOptionSX", $g_iActivateOptionSX)
	_Ini_Add("SuperXP", "GoblinMapOptSX", $g_iGoblinMapOptSX)

	_Ini_Add("SuperXP", "MaxXPtoGain", $g_iMaxXPtoGain)
	_Ini_Add("SuperXP", "BKingSX", $g_bBKingSX)
	_Ini_Add("SuperXP", "AQueenSX", $g_bAQueenSX)
	_Ini_Add("SuperXP", "GWardenSX", $g_bGWardenSX)
EndFunc   ;==>SaveConfig_MOD_SuperXP

Func SaveConfig_MOD_ChatActions()
	; <><><> ChatActions <><><>
	ApplyConfig_MOD_ChatActions(GetApplyConfigSaveAction())
	_Ini_Add("ChatActions", "GlobalMsg1", $g_sGlobal1)
	_Ini_Add("ChatActions", "GlobalMsg2", $g_sGlobal2)
	_Ini_Add("ChatActions", "ResponseMsgClan", $g_sResponse)
	_Ini_Add("ChatActions", "GenericMsgClan", $g_sGeneric)
	_Ini_Add("ChatActions", "FriendlyChallengeText", $g_sWriteFriendlyChallengeText)
	_Ini_Add("ChatActions", "FriendlyChallengeKeyword", $g_sWriteFriendlyChallengeKeyword)

	_Ini_Add("ChatActions", "EnableChatGlobal", $g_bChatGlobal ? 1 : 0)
	_Ini_Add("ChatActions", "DelayTimeGlobal", $g_sDelayTimeGlobal)
	_Ini_Add("ChatActions", "ScrambleGlobal", $g_bScrambleGlobal ? 1 : 0)
	_Ini_Add("ChatActions", "SwitchLang", $g_bSwitchLang ? 1 : 0)
	_Ini_Add("ChatActions", "CmbLang", $g_iCmbLang)
	_Ini_Add("ChatActions", "RusLang", $g_bRusLang ? 1 : 0)

	_Ini_Add("ChatActions", "EnableChatClan", $g_bChatClan ? 1 : 0)
	_Ini_Add("ChatActions", "DelayTimeClan", $g_sDelayTimeClan)
	_Ini_Add("ChatActions", "UseResponsesClan", $g_bClanUseResponses ? 1 : 0)
	_Ini_Add("ChatActions", "UseGenericClan", $g_bClanUseGeneric ? 1 : 0)
	_Ini_Add("ChatActions", "Cleverbot", $g_bCleverbot ? 1 : 0)
	_Ini_Add("ChatActions", "ChatNotify", $g_bUseNotify ? 1 : 0)
	_Ini_Add("ChatActions", "PbSendNewChats", $g_bPbSendNew ? 1 : 0)

	_Ini_Add("ChatActions", "EnableFriendlyChallenge", $g_bEnableFriendlyChallenge ? 1 : 0)
	_Ini_Add("ChatActions", "DelayTimeFriendlyChallenge", $g_sDelayTimeFC)
	_Ini_Add("ChatActions", "EnableOnlyOnRequest", $g_bOnlyOnRequest ? 1 : 0)
	Local $string = ""
	For $i = 0 To 5
		$string &= ($g_bFriendlyChallengeBase[$i] ? "1" : "0") & "|"
	Next
	_Ini_Add("ChatActions", "FriendlyChallengeBaseForShare", $string)
	$string = ""
	For $i = 0 To 23
		$string &= ($g_abFriendlyChallengeHours[$i] ? "1" : "0") & "|"
	Next
	_Ini_Add("ChatActions", "FriendlyChallengePlannedRequestHours", $string)

	$g_sIAVar = _ArrayToString($g_aIAVar)
	_Ini_Add("ChatActions", "String", $g_sIAVar)
EndFunc   ;==>SaveConfig_MOD_ChatActions

Func SaveConfig_MOD_600_6()
	; <><><> Daily Discounts + Builder Base Attack + Builder Base Drop Order <><><>
	ApplyConfig_MOD_600_6(GetApplyConfigSaveAction())
	For $i = 0 To $g_iDDCount - 1
		_Ini_Add("DailyDiscounts", "ChkDD_Deals" & String($i), $g_abChkDD_Deals[$i] ? 1 : 0)
	Next
	_Ini_Add("DailyDiscounts", "DD_DealsSet", $g_bDD_DealsSet ? 1 : 0)

	_Ini_Add("BBAttack", "ChkEnableBBAttack", $g_bChkEnableBBAttack)
	_Ini_Add("BBAttack", "ChkBBTrophyRange", $g_bChkBBTrophyRange)
	_Ini_Add("BBAttack", "TxtBBTrophyLowerLimit", $g_iTxtBBTrophyLowerLimit)
	_Ini_Add("BBAttack", "TxtBBTrophyUpperLimit", $g_iTxtBBTrophyUpperLimit)
	_Ini_Add("BBAttack", "ChkBBAttIfLootAvail", $g_bChkBBAttIfLootAvail)
	_Ini_Add("BBAttack", "ChkBBWaitForMachine", $g_bChkBBWaitForMachine)
	_Ini_Add("BBAttack", "iBBNextTroopDelay", $g_iBBNextTroopDelay)
	_Ini_Add("BBAttack", "iBBSameTroopDelay", $g_iBBSameTroopDelay)

	_Ini_Add("BBAttack", "bBBDropOrderSet", $g_bBBDropOrderSet)
	_Ini_Add("BBAttack", "sBBDropOrder", $g_sBBDropOrder)

	; BB Suggested Upgrades
	_Ini_Add("other", "ChkBBIgnoreWalls", $g_bChkBBIgnoreWalls ? 1 : 0)
EndFunc   ;==>SaveConfig_MOD_600_6

Func SaveConfig_MOD_600_11()
	; <><><> Request CC for defense <><><>
	ApplyConfig_MOD_600_11(GetApplyConfigSaveAction())
	_Ini_Add("donate", "RequestDefenseEnable", $g_bRequestCCDefense ? 1 : 0)
	_Ini_Add("donate", "RequestDefenseText", $g_sRequestCCDefenseText)
	_Ini_Add("donate", "RequestDefenseWhenPB", $g_bRequestCCDefenseWhenPB ? 1 : 0)
	_Ini_Add("donate", "RequestDefenseTime", $g_iRequestDefenseTime)
	_Ini_Add("donate", "SaveCCTroopForDefense", $g_bSaveCCTroopForDefense ? 1 : 0)
	For $i = 0 To 2
		_Ini_Add("donate", "cmbCCTroopDefense" & $i, $g_aiCCTroopDefenseType[$i])
		_Ini_Add("donate", "txtCCTroopDefense" & $i, $g_aiCCTroopDefenseQty[$i])
	Next
EndFunc   ;==>SaveConfig_MOD_600_11

Func SaveConfig_MOD_600_12()
	; <><><> ClanHop <><><>
	ApplyConfig_MOD_600_12(GetApplyConfigSaveAction())
	_Ini_Add("donate", "chkClanHop", $g_bChkClanHop ? 1 : 0)
EndFunc   ;==>SaveConfig_MOD_600_12

Func SaveConfig_MOD_600_28()
	; <><><> Max logout time + Restart Search Legend league <><><>
	ApplyConfig_MOD_600_28(GetApplyConfigSaveAction())
	_Ini_Add("other", "chkTrainLogoutMaxTime", $g_bTrainLogoutMaxTime ? 1 : 0)
	_Ini_Add("other", "txtTrainLogoutMaxTime", $g_iTrainLogoutMaxTime)

	_Ini_Add("other", "ChkSearchTimeout", $g_bIsSearchTimeout ? 1 : 0)
	_Ini_Add("other", "SearchTimeout", $g_iSearchTimeout)
EndFunc   ;==>SaveConfig_MOD_600_28

Func SaveConfig_MOD_600_29()
	; <><><> CSV Deploy Speed <><><>
	ApplyConfig_MOD_600_29(GetApplyConfigSaveAction())
	_Ini_Add("attack", "cmbCSVSpeedLB", $icmbCSVSpeed[$LB])
	_Ini_Add("attack", "cmbCSVSpeedDB", $icmbCSVSpeed[$DB])
EndFunc   ;==>SaveConfig_MOD_600_29

Func SaveConfig_MOD_600_31()
	; <><><> Check Collectors Outside <><><>
	ApplyConfig_MOD_600_31(GetApplyConfigSaveAction())
	_Ini_Add("search", "DBMeetCollectorOutside", $g_bDBMeetCollectorOutside ? 1 : 0)
	_Ini_Add("search", "TxtDBMinCollectorOutsidePercent", $g_iDBMinCollectorOutsidePercent)

	_Ini_Add("search", "DBCollectorNearRedline", $g_bDBCollectorNearRedline ? 1 : 0)
	_Ini_Add("search", "CmbRedlineTiles", $g_iCmbRedlineTiles)

	_Ini_Add("search", "SkipCollectorCheck", $g_bSkipCollectorCheck ? 1 : 0)
	_Ini_Add("search", "TxtSkipCollectorGold", $g_iTxtSkipCollectorGold)
	_Ini_Add("search", "TxtSkipCollectorElixir", $g_iTxtSkipCollectorElixir)
	_Ini_Add("search", "TxtSkipCollectorDark", $g_iTxtSkipCollectorDark)

	_Ini_Add("search", "SkipCollectorCheckTH", $g_bSkipCollectorCheckTH ? 1 : 0)
	_Ini_Add("search", "CmbSkipCollectorCheckTH", $g_iCmbSkipCollectorCheckTH)
EndFunc   ;==>SaveConfig_MOD_600_31

Func SaveConfig_MOD_600_35_1()
	; <><><> Auto Dock, Hide Emulator & Bot <><><>
	ApplyConfig_MOD_600_35_1(GetApplyConfigSaveAction())
	_Ini_Add("general", "EnableAuto", $g_bEnableAuto ? 1 : 0)
	_Ini_Add("general", "AutoDock", $g_bChkAutoDock ? 1 : 0)
	_Ini_Add("general", "AutoHide", $g_bChkAutoHideEmulator ? 1 : 0)
	_Ini_Add("general", "AutoMinimize", $g_bChkAutoMinimizeBot ? 1 : 0)
EndFunc   ;==>SaveConfig_MOD_600_35_1

Func SaveConfig_MOD_600_35_2()
	; <><><> Switch Profiles <><><>
	ApplyConfig_MOD_600_35_2(GetApplyConfigSaveAction())
	For $i = 0 To 3
		_Ini_Add("SwitchProfile", "SwitchProfileMax" & $i, $g_abChkSwitchMax[$i] ? 1 : 0)
		_Ini_Add("SwitchProfile", "SwitchProfileMin" & $i, $g_abChkSwitchMin[$i] ? 1 : 0)
		_Ini_Add("SwitchProfile", "TargetProfileMax" & $i, $g_aiCmbSwitchMax[$i])
		_Ini_Add("SwitchProfile", "TargetProfileMin" & $i, $g_aiCmbSwitchMin[$i])

		_Ini_Add("SwitchProfile", "ChangeBotTypeMax" & $i, $g_abChkBotTypeMax[$i] ? 1 : 0)
		_Ini_Add("SwitchProfile", "ChangeBotTypeMin" & $i, $g_abChkBotTypeMin[$i] ? 1 : 0)
		_Ini_Add("SwitchProfile", "TargetBotTypeMax" & $i, $g_aiCmbBotTypeMax[$i])
		_Ini_Add("SwitchProfile", "TargetBotTypeMin" & $i, $g_aiCmbBotTypeMin[$i])

		_Ini_Add("SwitchProfile", "ConditionMax" & $i, $g_aiConditionMax[$i])
		_Ini_Add("SwitchProfile", "ConditionMin" & $i, $g_aiConditionMin[$i])
	Next
EndFunc   ;==>SaveConfig_MOD_600_35_2
