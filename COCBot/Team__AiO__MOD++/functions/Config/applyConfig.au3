; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True, redraws bot window after config was applied
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
Func ApplyConfig_MOD_SuperXP($TypeReadSave)
	; <><><> SuperXP / GoblinXP <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkEnableSuperXP, $g_bEnableSuperXP ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableSuperXP()
			GUICtrlSetState($g_hChkSkipZoomOutSX, $g_bSkipZoomOutSX ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkFastSuperXP, $g_bFastSuperXP ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSkipDragToEndSX, $g_bSkipDragToEndSX ? $GUI_CHECKED : $GUI_UNCHECKED)
			radActivateOptionSX()
			radGoblinMapOptSX()
			radLblGoblinMapOpt()

			GUICtrlSetData($g_hTxtMaxXPToGain, $g_iMaxXPtoGain)
			GUICtrlSetState($g_hChkBKingSX, $g_bBKingSX = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAQueenSX, $g_bAQueenSX = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkGWardenSX, $g_bGWardenSX = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_bEnableSuperXP = (GUICtrlRead($g_hChkEnableSuperXP) = $GUI_CHECKED)
			$g_bSkipZoomOutSX = (GUICtrlRead($g_hChkSkipZoomOutSX) = $GUI_CHECKED)
			$g_bFastSuperXP = (GUICtrlRead($g_hChkFastSuperXP) = $GUI_CHECKED)
			$g_bSkipDragToEndSX = (GUICtrlRead($g_hChkSkipDragToEndSX) = $GUI_CHECKED)
			If GUICtrlRead($g_hRdoTrainingSX) = $GUI_CHECKED Then
				$g_iActivateOptionSX = 1
			ElseIf GUICtrlRead($g_hRdoAttackingSX) = $GUI_CHECKED Then
				$g_iActivateOptionSX = 2
			EndIf
			If GUICtrlRead($g_hRdoGoblinPicnic) = $GUI_CHECKED Then
				$g_iGoblinMapOptSX = 1
			ElseIf GUICtrlRead($g_hRdoTheArena) = $GUI_CHECKED Then
				$g_iGoblinMapOptSX = 2
			EndIf

			$g_iMaxXPtoGain = GUICtrlRead($g_hTxtMaxXPToGain)
			$g_bBKingSX = (GUICtrlRead($g_hChkBKingSX) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
			$g_bAQueenSX = (GUICtrlRead($g_hChkAQueenSX) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
			$g_bGWardenSX = (GUICtrlRead($g_hChkGWardenSX) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_SuperXP

Func ApplyConfig_MOD_ChatActions($TypeReadSave)
	; <><><> ChatActions <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkGlobalChat, $g_bChatGlobal = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDelayTimeGlobal, $g_sDelayTimeGlobal)
			GUICtrlSetState($g_hChkGlobalScramble, $g_bScrambleGlobal = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSwitchLang, $g_bSwitchLang = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmblang, $g_iCmbLang)
			GUICtrlSetState($g_hChkRusLang, $g_bRusLang = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkGlobalChat()

			GUICtrlSetState($g_hChkClanChat, $g_bChatClan = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDelayTimeClan, $g_sDelayTimeClan)
			GUICtrlSetState($g_hChkUseResponses, $g_bClanUseResponses = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseGeneric, $g_bClanAlwaysMsg = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCleverbot, $g_bCleverbot = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkChatNotify, $g_bUseNotify = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkPbSendNewChats, $g_bPbSendNew = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkClanChat()

			GUICtrlSetState($g_hChkEnableFriendlyChallenge, $g_bEnableFriendlyChallenge = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDelayTimeFC, $g_sDelayTimeFC)
			GUICtrlSetState($g_hChkOnlyOnRequest, $g_bOnlyOnRequest = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtChallengeText, $g_iTxtChallengeText)
			GUICtrlSetData($g_hTxtKeywordForRequest, $g_iTxtKeywordForRequest)
			For $i = 0 To 5
				GUICtrlSetState($g_hChkFriendlyChallengeBase[$i], $g_bFriendlyChallengeBase[$i] = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			For $i = 0 To 23
				GUICtrlSetState($g_ahChkFriendlyChallengeHours[$i], $g_abFriendlyChallengeHours[$i] = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			chkEnableFriendlyChallenge()
			ChatGuiEditUpdate()
		Case "Save"
			$g_bChatGlobal = (GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED)
			$g_sDelayTimeGlobal = GUICtrlRead($g_hTxtDelayTimeGlobal)
			$g_bScrambleGlobal = (GUICtrlRead($g_hChkGlobalScramble) = $GUI_CHECKED)
			$g_bSwitchLang = (GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED)
			$g_iCmbLang = _GUICtrlComboBox_GetCurSel($g_hCmbLang)
			$g_bRusLang = (GUICtrlRead($g_hChkRusLang) = $GUI_CHECKED)

			$g_bChatClan = (GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED)
			$g_sDelayTimeClan = GUICtrlRead($g_hTxtDelayTimeClan)
			$g_bClanUseResponses = (GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED)
			$g_bClanAlwaysMsg = (GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED)
			$g_bCleverbot = (GUICtrlRead($g_hChkCleverbot) = $GUI_CHECKED)
			$g_bUseNotify = (GUICtrlRead($g_hChkChatNotify) = $GUI_CHECKED)
			$g_bPbSendNew = (GUICtrlRead($g_hChkPbSendNewChats) = $GUI_CHECKED)

			$g_bEnableFriendlyChallenge = (GUICtrlRead($g_hChkEnableFriendlyChallenge) = $GUI_CHECKED)
			$g_sDelayTimeFC = GUICtrlRead($g_hTxtDelayTimeFC)
			$g_bOnlyOnRequest = (GUICtrlRead($g_hChkOnlyOnRequest) = $GUI_CHECKED)
			$g_iTxtChallengeText = GUICtrlRead($g_hTxtChallengeText)
			$g_iTxtKeywordForRequest = GUICtrlRead($g_hTxtKeywordForRequest)
			For $i = 0 To 5
				$g_bFriendlyChallengeBase[$i] = (GUICtrlRead($g_hChkFriendlyChallengeBase[$i]) = $GUI_CHECKED)
			Next
			For $i = 0 To 23
				$g_abFriendlyChallengeHours[$i] = (GUICtrlRead($g_ahChkFriendlyChallengeHours[$i]) = $GUI_CHECKED)
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_ChatActions

Func ApplyConfig_MOD_600_6($TypeReadSave)
	; <><><> Daily Discounts + Builder Base Attack + Builder Base Drop Order <><><>
	Switch $TypeReadSave
		Case "Read"
			For $i = 0 To $g_iDDCount - 1
				GUICtrlSetState($g_ahChkDD_Deals[$i], $g_abChkDD_Deals[$i] = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			GUICtrlSetBkColor($g_hBtnDailyDiscounts, $g_bDD_DealsSet = True ? $COLOR_GREEN : $COLOR_RED)
			btnDDApply()

			GUICtrlSetState($g_hChkEnableBBAttack, $g_bChkEnableBBAttack = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkBBTrophyRange, $g_bChkBBTrophyRange = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtBBTrophyLowerLimit, $g_iTxtBBTrophyLowerLimit)
			GUICtrlSetData($g_hTxtBBTrophyUpperLimit, $g_iTxtBBTrophyUpperLimit)
			GUICtrlSetState($g_hChkBBAttIfLootAvail, $g_bChkBBAttIfLootAvail = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkBBWaitForMachine, $g_bChkBBWaitForMachine = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkBBTrophyRange()
			chkEnableBBAttack()

			If $g_bBBDropOrderSet Then
				GUICtrlSetState($g_hChkBBCustomDropOrderEnable, $GUI_CHECKED)
				GUICtrlSetState($g_hBtnBBDropOrderSet, $GUI_ENABLE)
				GUICtrlSetState($g_hBtnBBRemoveDropOrder, $GUI_ENABLE)
				Local $asBBDropOrder = StringSplit($g_sBBDropOrder, "|")
				For $i=0 To $g_iBBTroopCount - 1
					_GUICtrlComboBox_SetCurSel($g_ahCmbBBDropOrder[$i], _GUICtrlComboBox_SelectString($g_ahCmbBBDropOrder[$i], $asBBDropOrder[$i+1]))
				Next
				GUICtrlSetBkColor($g_hBtnBBDropOrder, $COLOR_GREEN)
			EndIf
		Case "Save"
			For $i = 0 To $g_iDDCount - 1
				$g_abChkDD_Deals[$i] = (GUICtrlRead($g_ahChkDD_Deals[$i]) = $GUI_CHECKED)
			Next

			$g_bChkEnableBBAttack = (GUICtrlRead($g_hChkEnableBBAttack) = $GUI_CHECKED)
			$g_bChkBBTrophyRange = (GUICtrlRead($g_hChkBBTrophyRange) = $GUI_CHECKED)
			$g_iTxtBBTrophyLowerLimit = GUICtrlRead($g_hTxtBBTrophyLowerLimit)
			$g_iTxtBBTrophyUpperLimit = GUICtrlRead($g_hTxtBBTrophyUpperLimit)
			$g_bChkBBAttIfLootAvail = (GUICtrlRead($g_hChkBBAttIfLootAvail) = $GUI_CHECKED)
			$g_bChkBBWaitForMachine = (GUICtrlRead($g_hChkBBWaitForMachine) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_6

Func ApplyConfig_MOD_600_11($TypeReadSave)
	; <><><> Request CC for defense <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkRequestCCDefense, $g_bRequestCCDefense = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtRequestCCDefense, $g_sRequestCCDefenseText)
			_GUICtrlComboBox_SetCurSel($g_hCmbRequestCCDefenseWhen, $g_bRequestCCDefenseWhenPB ? 0 : 1)
			GUICtrlSetData($g_hTxtRequestCCDefenseTime, $g_iRequestDefenseTime)
			GUICtrlSetState($g_hChkSaveCCTroopForDefense, $g_bSaveCCTroopForDefense = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			For $i = 0 To 2
				_GUICtrlComboBox_SetCurSel($g_ahCmbCCTroopDefense[$i] , $g_aiCCTroopDefenseType[$i])
				GUICtrlSetData($g_ahTxtCCTroopDefense[$i], $g_aiCCTroopDefenseQty[$i])
			Next
			chkSaveCCTroopForDefense()
			chkRequestCCDefense()
		Case "Save"
			$g_bRequestCCDefense = (GUICtrlRead($g_hChkRequestCCDefense) = $GUI_CHECKED)
			$g_sRequestCCDefenseText = GUICtrlRead($g_hTxtRequestCCDefense)
			$g_bRequestCCDefenseWhenPB = (_GUICtrlComboBox_GetCurSel($g_hCmbRequestCCDefenseWhen) = 0)
			$g_iRequestDefenseTime = GUICtrlRead($g_hTxtRequestCCDefenseTime)
			$g_bSaveCCTroopForDefense = (GUICtrlRead($g_hChkSaveCCTroopForDefense) = $GUI_CHECKED)
			For $i = 0 To 2
				$g_aiCCTroopDefenseType[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbCCTroopDefense[$i])
				$g_aiCCTroopDefenseQty[$i] = GUICtrlRead($g_ahTxtCCTroopDefense[$i])
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_11

Func ApplyConfig_MOD_600_12($TypeReadSave)
	; <><><> ClanHop <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkClanHop, $g_bChkClanHop = True ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_bChkClanHop = (GUICtrlRead($g_hChkClanHop) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_12

Func ApplyConfig_MOD_600_28($TypeReadSave)
	; <><><> Restart Search Legend league <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkSearchTimeout, $g_bIsSearchTimeout = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSearchTimeout, $g_iSearchTimeout)
			chkSearchTimeout()
		Case "Save"
			$g_bIsSearchTimeout = (GUICtrlRead($g_hChkSearchTimeout) = $GUI_CHECKED)
			$g_iSearchTimeout = GUICtrlRead($g_hTxtSearchTimeout)
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_28

Func ApplyConfig_MOD_600_29($TypeReadSave)
	; <><><> Classic Four Finger + CSV Deploy Speed <><><>
	Switch $TypeReadSave
		Case "Read"
			cmbStandardDropSidesAB()
			cmbStandardDropSidesDB()

			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$LB], $icmbCSVSpeed[$LB])
			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$DB], $icmbCSVSpeed[$DB])
		Case "Save"
			$icmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$LB])
			$icmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$DB])
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_29

Func ApplyConfig_MOD_600_31($TypeReadSave)
	; <><><> Check Collectors Outside <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkDBMeetCollectorOutside, $g_bDBMeetCollectorOutside = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinCollectorOutsidePercent, $g_iDBMinCollectorOutsidePercent)

			GUICtrlSetState($g_hChkDBCollectorNearRedline, $g_bDBCollectorNearRedline = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbRedlineTiles, $g_iCmbRedlineTiles)

			GUICtrlSetState($g_hChkSkipCollectorCheck, $g_bSkipCollectorCheck = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSkipCollectorGold, $g_iTxtSkipCollectorGold)
			GUICtrlSetData($g_hTxtSkipCollectorElixir, $g_iTxtSkipCollectorElixir)
			GUICtrlSetData($g_hTxtSkipCollectorDark, $g_iTxtSkipCollectorDark)

			GUICtrlSetState($g_hChkSkipCollectorCheckTH, $g_bSkipCollectorCheckTH = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbSkipCollectorCheckTH, $g_iCmbSkipCollectorCheckTH)
			chkDBMeetCollectorOutside()
		Case "Save"
			$g_bDBMeetCollectorOutside = (GUICtrlRead($g_hChkDBMeetCollectorOutside) = $GUI_CHECKED)
			$g_iDBMinCollectorOutsidePercent = GUICtrlRead($g_hTxtDBMinCollectorOutsidePercent)

			$g_bDBCollectorNearRedline = (GUICtrlRead($g_hChkDBCollectorNearRedline) = $GUI_CHECKED)
			$g_iCmbRedlineTiles = _GUICtrlComboBox_GetCurSel($g_hCmbRedlineTiles)

			$g_bSkipCollectorCheck = (GUICtrlRead($g_hChkSkipCollectorCheck) = $GUI_CHECKED)
			$g_iTxtSkipCollectorGold = GUICtrlRead($g_hTxtSkipCollectorGold)
			$g_iTxtSkipCollectorElixir = GUICtrlRead($g_hTxtSkipCollectorElixir)
			$g_iTxtSkipCollectorDark = GUICtrlRead($g_hTxtSkipCollectorDark)

			$g_bSkipCollectorCheckTH = (GUICtrlRead($g_hChkSkipCollectorCheckTH) = $GUI_CHECKED)
			$g_iCmbSkipCollectorCheckTH = _GUICtrlComboBox_GetCurSel($g_hCmbSkipCollectorCheckTH)
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_31

Func ApplyConfig_MOD_600_35_1($TypeReadSave)
	; <><><> Auto Dock, Hide Emulator & Bot <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkEnableAuto, $g_bEnableAuto = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableAuto()
			GUICtrlSetState($g_hChkAutoDock, $g_bChkAutoDock = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAutoHideEmulator, $g_bChkAutoHideEmulator = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			btnEnableAuto()
			GUICtrlSetState($g_hChkAutoMinimizeBot, $g_bChkAutoMinimizeBot = True ? $GUI_CHECKED : $GUI_UNCHECKED)
		Case "Save"
			$g_bEnableAuto = (GUICtrlRead($g_hChkEnableAuto) = $GUI_CHECKED)
			$g_bChkAutoDock = (GUICtrlRead($g_hChkAutoDock) = $GUI_CHECKED)
			$g_bChkAutoHideEmulator = (GUICtrlRead($g_hChkAutoHideEmulator) = $GUI_CHECKED)
			$g_bChkAutoMinimizeBot = (GUICtrlRead($g_hChkAutoMinimizeBot) = $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_35_1

Func ApplyConfig_MOD_600_35_2($TypeReadSave)
	; <><><><> Switch Profiles <><><><>
	Switch $TypeReadSave
		Case "Read"
			For $i = 0 To 3
				GUICtrlSetState($g_ahChk_SwitchMax[$i], $g_abChkSwitchMax[$i] = True ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetState($g_ahChk_SwitchMin[$i], $g_abChkSwitchMin[$i] = True ? $GUI_CHECKED : $GUI_UNCHECKED)
				_GUICtrlComboBox_SetCurSel($g_ahCmb_SwitchMax[$i], $g_aiCmbSwitchMax[$i])
				_GUICtrlComboBox_SetCurSel($g_ahCmb_SwitchMin[$i], $g_aiCmbSwitchMin[$i])

				GUICtrlSetState($g_ahChk_BotTypeMax[$i], $g_abChkBotTypeMax[$i] = True ? $GUI_CHECKED : $GUI_UNCHECKED)
				GUICtrlSetState($g_ahChk_BotTypeMin[$i], $g_abChkBotTypeMin[$i] = True ? $GUI_CHECKED : $GUI_UNCHECKED)
				_GUICtrlComboBox_SetCurSel($g_ahCmb_BotTypeMax[$i], $g_aiCmbBotTypeMax[$i])
				_GUICtrlComboBox_SetCurSel($g_ahCmb_BotTypeMin[$i], $g_aiCmbBotTypeMin[$i])

				GUICtrlSetData($g_ahTxt_ConditionMax[$i], $g_aiConditionMax[$i])
				GUICtrlSetData($g_ahTxt_ConditionMin[$i], $g_aiConditionMin[$i])
			Next
			chkSwitchProfile()
			chkSwitchBotType()
		Case "Save"
			For $i = 0 To 3
				$g_abChkSwitchMax[$i] = (GUICtrlRead($g_ahChk_SwitchMax[$i]) = $GUI_CHECKED)
				$g_abChkSwitchMin[$i] = (GUICtrlRead($g_ahChk_SwitchMin[$i]) = $GUI_CHECKED)
				$g_aiCmbSwitchMax[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmb_SwitchMax[$i])
				$g_aiCmbSwitchMin[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmb_SwitchMin[$i])

				$g_abChkBotTypeMax[$i] = (GUICtrlRead($g_ahChk_BotTypeMax[$i]) = $GUI_CHECKED)
				$g_abChkBotTypeMin[$i] = (GUICtrlRead($g_ahChk_BotTypeMin[$i]) = $GUI_CHECKED)
				$g_aiCmbBotTypeMax[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmb_BotTypeMax[$i])
				$g_aiCmbBotTypeMin[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmb_BotTypeMin[$i])

				$g_aiConditionMax[$i] = GUICtrlRead($g_ahTxt_ConditionMax[$i])
				$g_aiConditionMin[$i] = GUICtrlRead($g_ahTxt_ConditionMin[$i])
			Next
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_600_35_2

Func ApplyConfig_MOD_641_1($TypeReadSave)
	; <><><> Max logout time <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($g_hChkTrainLogoutMaxTime, $g_bTrainLogoutMaxTime = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTrainLogoutMaxTime()
			GUICtrlSetData($g_hTxtTrainLogoutMaxTime, $g_iTrainLogoutMaxTime)
		Case "Save"
			$g_bTrainLogoutMaxTime = (GUICtrlRead($g_hChkTrainLogoutMaxTime) = $GUI_CHECKED)
			$g_iTrainLogoutMaxTime = GUICtrlRead($g_hTxtTrainLogoutMaxTime)
	EndSwitch
EndFunc   ;==>ApplyConfig_MOD_641_1
