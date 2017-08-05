; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True, redraws bot window after config was applied
; Return values .: NA
; Author ........: Team AiO MOD++ (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ApplyConfig_MOD($TypeReadSave)
	; <><><> Team AiO MOD++ (2017) <><><>
	Switch $TypeReadSave
		Case "Read"

			; Classic Four Finger (Demen) - Added by NguyenAnhHD & Eloy
			cmbStandardDropSidesAB()
			Bridge()

			; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
			GUICtrlSetState($ChkUnitFactor, $iChkUnitFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($TxtUnitFactor, $iTxtUnitFactor)
			chkUnitFactor()
			GUICtrlSetState($ChkWaveFactor, $iChkWaveFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($TxtWaveFactor, $iTxtWaveFactor)
			chkWaveFactor()
			GUICtrlSetState($ChkGiantSlot, $iChkGiantSlot ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($CmbGiantSlot, $iCmbGiantSlot)
			ChkGiantSlot()

			; Custom Drop Order
			GUICtrlSetState($g_hChkCustomTrainDropOrderEnable, $g_bCustomTrainDropOrderEnable = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			For $p = 0 To UBound($icmbDropTroops) - 1
				_GUICtrlComboBox_SetCurSel($cmbDropTroops[$p], $icmbDropTroops[$p])
				_GUICtrlSetImage($g_ahImgTroopDropOrder[$p], $g_sLibIconPath, $g_aiTroopOrderDropIcon[$icmbDropTroops[$p] + 1])
			Next
			; process error
			If $g_bCustomTrainDropOrderEnable = True Then ; only update troop train order if enabled
				If ChangeTroopDropOrder() = False Then ; process error
					;SetDefaultTroopGroup()
					GUICtrlSetState($g_hChkCustomTrainDropOrderEnable, $GUI_UNCHECKED)
					$g_bCustomTrainDropOrderEnable = False
					GUICtrlSetState($g_hBtnTroopOrderSet2, $GUI_DISABLE) ; disable button
					GUICtrlSetState($g_hBtnRemoveTroops2, $GUI_DISABLE)
					For $i = 0 To UBound($cmbDropTroops) - 1
						GUICtrlSetState($cmbDropTroops[$i], $GUI_DISABLE) ; disable combo boxes
					Next
				EndIf
			EndIf
			chkTroopDropOrder()

			; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkAutohide, $ichkAutoHide = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAutohideDelay, $ichkAutoHideDelay)
			chkAutoHide()

			; Check Collector Outside (McSlither) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkDBMeetCollOutside, $ichkDBMeetCollOutside = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinCollOutsidePercent, $iDBMinCollOutsidePercent)
			chkDBMeetCollOutside()

			; CSV Deploy Speed - Added by NguyenAnhHD
			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$LB], $icmbCSVSpeed[$LB])
			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$DB], $icmbCSVSpeed[$DB])

			; Switch Profile (IceCube) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkGoldSwitchMax, $ichkGoldSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMaxProfile, $icmbGoldMaxProfile)
			GUICtrlSetData($g_hTxtMaxGoldAmount, $itxtMaxGoldAmount)
			GUICtrlSetState($g_hChkGoldSwitchMin, $ichkGoldSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMinProfile, $icmbGoldMinProfile)
			GUICtrlSetData($g_hTxtMinGoldAmount, $itxtMinGoldAmount)

			GUICtrlSetState($g_hChkElixirSwitchMax, $ichkElixirSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMaxProfile, $icmbElixirMaxProfile)
			GUICtrlSetData($g_hTxtMaxElixirAmount, $itxtMaxElixirAmount)
			GUICtrlSetState($g_hChkElixirSwitchMin, $ichkElixirSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMinProfile, $icmbElixirMinProfile)
			GUICtrlSetData($g_hTxtMinElixirAmount, $itxtMinElixirAmount)

			GUICtrlSetState($g_hChkDESwitchMax, $ichkDESwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMaxProfile, $icmbDEMaxProfile)
			GUICtrlSetData($g_hTxtMaxDEAmount, $itxtMaxDEAmount)
			GUICtrlSetState($g_hChkDESwitchMin, $ichkDESwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMinProfile, $icmbDEMinProfile)
			GUICtrlSetData($g_hTxtMinDEAmount, $itxtMinDEAmount)

			GUICtrlSetState($g_hChkTrophySwitchMax, $ichkTrophySwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMaxProfile, $icmbTrophyMaxProfile)
			GUICtrlSetData($g_hTxtMaxTrophyAmount, $itxtMaxTrophyAmount)
			GUICtrlSetState($g_hChkTrophySwitchMin, $ichkTrophySwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMinProfile, $icmbTrophyMinProfile)
			GUICtrlSetData($g_hTxtMinTrophyAmount, $itxtMinTrophyAmount)

			; SmartTrain (Demen) - Added By Demen
			GUICtrlSetState($g_hchkSmartTrain, $ichkSmartTrain = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hchkPreciseTroops, $ichkPreciseTroops = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hchkFillArcher, $ichkFillArcher = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_htxtFillArcher, $iFillArcher)
			GUICtrlSetState($g_hchkFillEQ, $ichkFillEQ = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartTrain()
			GUICtrlSetState($g_hChkMultiClick, $g_bChkMultiClick ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUseQTrain()

			; Bot Humanization
			GUICtrlSetState($g_chkUseBotHumanization, $g_ichkUseBotHumanization = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkUseAltRClick, $g_ichkUseAltRClick = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkCollectAchievements, $g_ichkCollectAchievements = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkLookAtRedNotifications, $g_ichkLookAtRedNotifications = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUseBotHumanization()
			For $i = 0 To 12
				_GUICtrlComboBox_SetCurSel($g_acmbPriority[$i], $g_iacmbPriority[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbMaxSpeed[$i], $g_iacmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbPause[$i], $g_iacmbPause[$i])
			Next
			For $i = 0 To 1
				GUICtrlSetData($g_ahumanMessage[$i], $g_iahumanMessage[$i])
			Next
			_GUICtrlComboBox_SetCurSel($g_cmbMaxActionsNumber, $g_icmbMaxActionsNumber)
			GUICtrlSetData($g_challengeMessage, $g_ichallengeMessage)
			cmbStandardReplay()
			cmbWarReplay()

			; Auto Upgrade
			GUICtrlSetState($g_chkAutoUpgrade, $g_ichkAutoUpgrade = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			For $i = 0 To 12
				GUICtrlSetState($g_chkUpgradesToIgnore[$i], $g_ichkUpgradesToIgnore[$i] = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			For $i = 0 To 2
				GUICtrlSetState($g_chkResourcesToIgnore[$i], $g_ichkResourcesToIgnore[$i] = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			Next
			GUICtrlSetData($g_SmartMinGold, $g_iSmartMinGold)
			GUICtrlSetData($g_SmartMinElixir, $g_iSmartMinElixir)
			GUICtrlSetData($g_SmartMinDark, $g_iSmartMinDark)
			chkAutoUpgrade()

			; Request CC Troops at first
			GUICtrlSetState($chkReqCCFirst, $g_bReqCCFirst = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Goblin XP
			GUICtrlSetState($chkEnableSuperXP, $ichkEnableSuperXP = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)

			chkEnableSuperXP()

			GUICtrlSetState($rbSXTraining, ($irbSXTraining = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($rbSXIAttacking, ($irbSXTraining = 2) ? $GUI_CHECKED : $GUI_UNCHECKED)

			GUICtrlSetData($txtMaxXPtoGain, $itxtMaxXPtoGain)

			GUICtrlSetState($chkSXBK, $ichkSXBK = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkSXAQ, $ichkSXAQ = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkSXGW, $ichkSXGW = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)

			; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkClanHop, $g_bChkClanHop ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Max logout time (mandryd)
			GUICtrlSetState($chkTrainLogoutMaxTime, $TrainLogoutMaxTime = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTrainLogoutMaxTime()
			GUICtrlSetData($txtTrainLogoutMaxTime, $TrainLogoutMaxTimeTXT)

		Case "Save"

			; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
			$iChkUnitFactor = (GUICtrlRead($ChkUnitFactor) = $GUI_CHECKED)
			$iChkWaveFactor = (GUICtrlRead($ChkWaveFactor) = $GUI_CHECKED)
			$iTxtUnitFactor = GUICtrlRead($TxtUnitFactor)
			$iTxtWaveFactor = GUICtrlRead($TxtWaveFactor)
			$iChkGiantSlot = (GUICtrlRead($ChkGiantSlot) = $GUI_CHECKED)
			$iCmbGiantSlot = _GUICtrlComboBox_GetCurSel($CmbGiantSlot)

			; Custom Drop Order
			$g_bCustomTrainDropOrderEnable = GUICtrlRead($g_hChkCustomTrainDropOrderEnable) = $GUI_CHECKED ? True : False
			For $p = 0 To UBound($icmbDropTroops) - 1
				$icmbDropTroops[$p] = _GUICtrlComboBox_GetCurSel($cmbDropTroops[$p])
			Next

			; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
			$ichkAutoHide = GUICtrlRead($g_hChkAutohide) = $GUI_CHECKED ? 1 : 0
			$ichkAutoHideDelay = GUICtrlRead($g_hTxtAutohideDelay)

			; Check Collector Outside (McSlither) - Added by NguyenAnhHD
			$ichkDBMeetCollOutside = GUICtrlRead($g_hChkDBMeetCollOutside) = $GUI_CHECKED ? 1 : 0
			$iDBMinCollOutsidePercent = GUICtrlRead($g_hTxtDBMinCollOutsidePercent)

			; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
			$icmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$LB])
			$icmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$DB])

			; Switch Profile (IceCube) - Added by NguyenAnhHD
			$ichkGoldSwitchMax = GUICtrlRead($g_hChkGoldSwitchMax) = $GUI_CHECKED ? 1 : 0
			$icmbGoldMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMaxProfile)
			$itxtMaxGoldAmount = GUICtrlRead($g_hTxtMaxGoldAmount)
			$ichkGoldSwitchMin = GUICtrlRead($g_hChkGoldSwitchMin) = $GUI_CHECKED ? 1 : 0
			$icmbGoldMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMinProfile)
			$itxtMinGoldAmount = GUICtrlRead($g_hTxtMinGoldAmount)

			$ichkElixirSwitchMax = GUICtrlRead($g_hChkElixirSwitchMax) = $GUI_CHECKED ? 1 : 0
			$icmbElixirMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMaxProfile)
			$itxtMaxElixirAmount = GUICtrlRead($g_hTxtMaxElixirAmount)
			$ichkElixirSwitchMin = GUICtrlRead($g_hChkElixirSwitchMin) = $GUI_CHECKED ? 1 : 0
			$icmbElixirMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMinProfile)
			$itxtMinElixirAmount = GUICtrlRead($g_hTxtMinElixirAmount)

			$ichkDESwitchMax = GUICtrlRead($g_hChkDESwitchMax) = $GUI_CHECKED ? 1 : 0
			$icmbDEMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMaxProfile)
			$itxtMaxDEAmount = GUICtrlRead($g_hTxtMaxDEAmount)
			$ichkDESwitchMin = GUICtrlRead($g_hChkDESwitchMin) = $GUI_CHECKED ? 1 : 0
			$icmbDEMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMinProfile)
			$itxtMinDEAmount = GUICtrlRead($g_hTxtMinDEAmount)

			$ichkTrophySwitchMax = GUICtrlRead($g_hChkTrophySwitchMax) = $GUI_CHECKED ? 1 : 0
			$icmbTrophyMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMaxProfile)
			$itxtMaxTrophyAmount = GUICtrlRead($g_hTxtMaxTrophyAmount)
			$ichkTrophySwitchMin = GUICtrlRead($g_hChkTrophySwitchMin) = $GUI_CHECKED ? 1 : 0
			$icmbTrophyMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMinProfile)
			$itxtMinTrophyAmount = GUICtrlRead($g_hTxtMinTrophyAmount)

			;SmartTrain (Demen) - Added by Demen
			$ichkSmartTrain = GUICtrlRead($g_hchkSmartTrain) = $GUI_CHECKED ? 1 : 0
			$ichkPreciseTroops = GUICtrlRead($g_hchkPreciseTroops) = $GUI_CHECKED ? 1 : 0
			$ichkFillArcher = GUICtrlRead($g_hchkFillArcher) = $GUI_CHECKED ? 1 : 0
			$iFillArcher = GUICtrlRead($g_htxtFillArcher)
			$ichkFillEQ = GUICtrlRead($g_hchkFillEQ) = $GUI_CHECKED ? 1 : 0
			$g_bChkMultiClick = (GUICtrlRead($g_hChkMultiClick) = $GUI_CHECKED)

			; Bot Humanization
			$g_ichkUseBotHumanization = GUICtrlRead($g_chkUseBotHumanization) = $GUI_CHECKED ? 1 : 0
			$g_ichkUseAltRClick = GUICtrlRead($g_chkUseAltRClick) = $GUI_CHECKED ? 1 : 0
			$g_ichkCollectAchievements = GUICtrlRead($g_chkCollectAchievements) = $GUI_CHECKED ? 1 : 0
			$g_ichkLookAtRedNotifications = GUICtrlRead($g_chkLookAtRedNotifications) = $GUI_CHECKED ? 1 : 0
			For $i = 0 To 12
				$g_iacmbPriority[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i])
			Next
			For $i = 0 To 1
				$g_iacmbMaxSpeed[$i] = _GUICtrlComboBox_GetCurSel($g_acmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				$g_iacmbPause[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPause[$i])
			Next
			For $i = 0 To 1
				$g_iahumanMessage[$i] = GUICtrlRead($g_ahumanMessage[$i])
			Next
			$g_icmbMaxActionsNumber = _GUICtrlComboBox_GetCurSel($g_icmbMaxActionsNumber)
			$g_ichallengeMessage = GUICtrlRead($g_challengeMessage)

			; Auto Upgrade
			$g_ichkAutoUpgrade = GUICtrlRead($g_chkAutoUpgrade) = $GUI_CHECKED ? 1 : 0
			For $i = 0 To 12
				$g_ichkUpgradesToIgnore[$i] = GUICtrlRead($g_chkUpgradesToIgnore[$i]) = $GUI_CHECKED ? 1 : 0
			Next
			For $i = 0 To 2
				$g_ichkResourcesToIgnore[$i] = GUICtrlRead($g_chkResourcesToIgnore[$i]) = $GUI_CHECKED ? 1 : 0
			Next
			$g_iSmartMinGold = GUICtrlRead($g_SmartMinGold)
			$g_iSmartMinElixir = GUICtrlRead($g_SmartMinElixir)
			$g_iSmartMinDark = GUICtrlRead($g_SmartMinDark)

			; Request CC Troops at first
			$g_bReqCCFirst = GUICtrlRead($chkReqCCFirst) = $GUI_CHECKED ? 1 : 0

			; Goblin XP
			$ichkEnableSuperXP = GUICtrlRead($chkEnableSuperXP) = $GUI_CHECKED ? 1 : 0
			$irbSXTraining = GUICtrlRead($rbSXTraining) = $GUI_CHECKED ? 1 : 2
			$ichkSXBK = (GUICtrlRead($chkSXBK) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
			$ichkSXAQ = (GUICtrlRead($chkSXAQ) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
			$ichkSXGW = (GUICtrlRead($chkSXGW) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
			$itxtMaxXPtoGain = Int(GUICtrlRead($txtMaxXPtoGain))

			; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
			$g_bChkClanHop = (GUICtrlRead($g_hChkClanHop) = $GUI_CHECKED)

			; Max logout time (mandryd)
			$TrainLogoutMaxTime = GUICtrlRead($chkTrainLogoutMaxTime) = $GUI_CHECKED ? 1 : 0
			$TrainLogoutMaxTimeTXT = GUICtrlRead($txtTrainLogoutMaxTime)

	EndSwitch
EndFunc

; SwitchAcc (Demen) - Added By Demen
Func ApplyConfig_SwitchAcc($TypeReadSave)
	; <><><> SwitchAcc_Demen_Style <><><>
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($chkSwitchAcc, $ichkSwitchAcc = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSwitchAcc()
			GUICtrlSetState($chkTrain, $ichkTrain = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			If $ichkSmartSwitch = 1 Then
				GUICtrlSetState($radSmartSwitch, $GUI_CHECKED)
			Else
				GUICtrlSetState($radNormalSwitch, $GUI_CHECKED)
			EndIf
			If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then radNormalSwitch()
			_GUICtrlComboBox_SetCurSel($cmbTotalAccount, $icmbTotalCoCAcc - 1)
			GUICtrlSetState($g_hChkForceSwitch, $ichkForceSwitch = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_txtForceSwitch, $iForceSwitch)
			If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then chkForceSwitch()
			GUICtrlSetState($g_hChkForceStayDonate, $ichkForceStayDonate = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			If $ichkCloseTraining >= 1 Then
				GUICtrlSetState($chkUseTrainingClose, $GUI_CHECKED)
				If $ichkCloseTraining = 1 Then
					GUICtrlSetState($radCloseCoC, $GUI_CHECKED)
				Else
					GUICtrlSetState($radCloseAndroid, $GUI_CHECKED)
				EndIf
			Else
				GUICtrlSetState($chkUseTrainingClose, $GUI_UNCHECKED)
			EndIf
			For $i = 0 To 7
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], $aMatchProfileAcc[$i] - 1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], $aProfileType[$i] - 1)
			Next

		Case "Save"
			$ichkSwitchAcc = GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED ? 1 : 0
			$ichkTrain = GUICtrlRead($chkTrain) = $GUI_CHECKED ? 1 : 0
			$icmbTotalCoCAcc = _GUICtrlComboBox_GetCurSel($cmbTotalAccount) + 1
			$ichkSmartSwitch = GUICtrlRead($radSmartSwitch) = $GUI_CHECKED ? 1 : 0
			$ichkForceSwitch = GUICtrlRead($g_hChkForceSwitch) = $GUI_CHECKED ? 1 : 0
			$ichkForceStayDonate = GUICtrlRead($g_hChkForceStayDonate) = $GUI_CHECKED ? 1 : 0
			$iForceSwitch = GUICtrlRead($g_txtForceSwitch)
			$ichkCloseTraining = GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED ? 1 : 0
			If $ichkCloseTraining = 1 Then
				$ichkCloseTraining = GUICtrlRead($radCloseCoC) = $GUI_CHECKED ? 1 : 2
			EndIf
	EndSwitch
EndFunc   ;==>ApplyConfig_SwitchAcc

; Forecast - Added by Eloy (modification rulesss,kychera)
Func ApplyConfig_Forecast($TypeReadSave)
	Switch $TypeReadSave
		Case "Read"
			GUICtrlSetState($chkForecastBoost, $iChkForecastBoost = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($txtForecastBoost, $iTxtForecastBoost)
			chkForecastBoost()
			GUICtrlSetState($chkForecastPause, $iChkForecastPause = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($txtForecastPause, $iTxtForecastPause)
			chkForecastPause()
			GUICtrlSetState($chkForecastHopingSwitchMax, $ichkForecastHopingSwitchMax = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMax, $icmbForecastHopingSwitchMax)
			GUICtrlSetData($txtForecastHopingSwitchMax, $itxtForecastHopingSwitchMax)
			chkForecastHopingSwitchMax()
			GUICtrlSetState($chkForecastHopingSwitchMin, $ichkForecastHopingSwitchMin = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($cmbForecastHopingSwitchMin, $icmbForecastHopingSwitchMin)
			GUICtrlSetData($txtForecastHopingSwitchMin, $itxtForecastHopingSwitchMin)
			chkForecastHopingSwitchMin()
			_GUICtrlComboBox_SetCurSel($cmbSwLang, $icmbSwLang)

		Case "Save"
			$iChkForecastBoost = (GUICtrlRead($chkForecastBoost) = $GUI_UNCHECKED)
			$iTxtForecastBoost = GUICtrlRead($txtForecastBoost)
			$iChkForecastPause = (GUICtrlRead($chkForecastPause) = $GUI_UNCHECKED)
			$iTxtForecastPause = GUICtrlRead($txtForecastPause)
			$ichkForecastHopingSwitchMax = (GUICtrlRead($chkForecastHopingSwitchMax) = $GUI_UNCHECKED)
			$icmbForecastHopingSwitchMax = _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax)
			$itxtForecastHopingSwitchMax = GUICtrlRead($txtForecastHopingSwitchMax)
			$ichkForecastHopingSwitchMin = (GUICtrlRead($chkForecastHopingSwitchMin) = $GUI_UNCHECKED)
			$icmbForecastHopingSwitchMin = _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin)
			$itxtForecastHopingSwitchMin = GUICtrlRead($txtForecastHopingSwitchMin)
			$icmbSwLang = _GUICtrlComboBox_GetCurSel($cmbSwLang)
	EndSwitch
EndFunc   ;==>ApplyConfig_Forecast
