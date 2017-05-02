; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True, redraws bot window after config was applied
; Return values .: NA
; Author ........: Team++ AIO (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ApplyConfig_MOD($TypeReadSave)
	; <><><> Team++ AIO MOD <><><>
	Switch $TypeReadSave
		Case "Read"

			; Classic Four Finger (Demen) & Multi Finger (LunaEclipse) - Added by NguyenAnhHD & Eloy
			_GUICtrlComboBox_SetCurSel($cmbDBMultiFinger, $iMultiFingerStyle)
			Bridge()
			cmbStandardDropSidesAB()

			; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
			GUICtrlSetState($ChkUnitFactor, $iChkUnitFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($TxtUnitFactor, $iTxtUnitFactor)
			chkUnitFactor()
			GUICtrlSetState($ChkWaveFactor, $iChkWaveFactor ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($TxtWaveFactor, $iTxtWaveFactor)
			chkWaveFactor()
			GUICtrlSetState($ChkGiantSlot, $iChkGiantSlot ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($CmbGiantSlot,$iCmbGiantSlot)
			ChkGiantSlot()
            ; Disable background by kychera
		    GUICtrlSetState($chkPic, $ichkPic = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		    chkPic()
		    ; Transparent Gui by kychera
	        GUICtrlSetData($SldTransLevel, $iSldTransLevel)        

			; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkAutohide, $ichkAutoHide = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAutohideDelay, $ichkAutoHideDelay)
			chkAutoHide()

			; Check Collector Outside (McSlither) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkDBMeetCollOutside, $ichkDBMeetCollOutside = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinCollOutsidePercent, $iDBMinCollOutsidePercent)
			chkDBMeetCollOutside()

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

			; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
			_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$DB], $g_iCmbCSVSpeed[$DB])
			_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$LB], $g_iCmbCSVSpeed[$LB])

			; Smart Upgarde (Roro-Titi) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkSmartUpgrade, $ichkSmartUpgrade = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartUpgrade()

			GUICtrlSetData($SmartMinGold, $iSmartMinGold)
			GUICtrlSetData($SmartMinElixir, $iSmartMinElixir)
			GUICtrlSetData($SmartMinDark, $iSmartMinDark)

			GUICtrlSetState($g_hChkIgnoreTH, $ichkIgnoreTH = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreKing, $ichkIgnoreKing = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreQueen, $ichkIgnoreQueen = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreWarden, $ichkIgnoreWarden = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreCC, $ichkIgnoreCC = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreLab, $ichkIgnoreLab = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreBarrack, $ichkIgnoreBarrack = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreDBarrack, $ichkIgnoreDBarrack = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreFactory, $ichkIgnoreFactory = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreDFactory, $ichkIgnoreDFactory = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreGColl, $ichkIgnoreGColl = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreEColl, $ichkIgnoreEColl = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkIgnoreDColl, $ichkIgnoreDColl = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartUpgrade()

			; Upgrade Management (MMHK) - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkUpdateNewUpgradesOnly, $g_ibUpdateNewUpgradesOnly ? $GUI_CHECKED : $GUI_UNCHECKED)

			; SimpleTrain (Demen) - Added By Demen
			GUICtrlSetState($g_hchkSimpleTrain, $ichkSimpleTrain = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hchkPreciseTroops, $ichkPreciseTroops = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hchkFillArcher, $ichkFillArcher = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_htxtFillArcher, $iFillArcher)
			GUICtrlSetState($g_hchkFillEQ, $ichkFillEQ = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSimpleTrain()

			; CoC Stats - Added by NguyenAnhHD
			GUICtrlSetState($g_hChkCoCStats, $ichkCoCStats = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtAPIKey, $MyApiKey)
			chkCoCStats()

			; Bot Humanization (Roro-Titi) - Added by NguyenAnhHD
			GUICtrlSetState($chkUseBotHumanization, $g_ichkUseBotHumanization = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkUseAltRClick, $g_ichkUseAltRClick = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkCollectAchievements, $g_ichkCollectAchievements = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkLookAtRedNotifications, $g_ichkLookAtRedNotifications = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
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
				_GUICtrlComboBox_SetCurSel($g_ahumanMessage[$i], $g_iahumanMessage[$i])
			Next
			_GUICtrlComboBox_SetCurSel($g_icmbMaxActionsNumber, $g_icmbMaxActionsNumber)
			cmbStandardReplay()
			cmbWarReplay()

			; Goblin XP (Mr.Viper) - Added by NguyenAnhHD
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

			; Notify Bot Speep (Kychera) - Added By NguyenAnhHD
;~			GUICtrlSetState($g_hChkNotifyBOTSleep, $g_bNotifyAlertBOTSleep ? $GUI_CHECKED : $GUI_UNCHECKED)
            
			;Move the Request CC Troops - Added by rulesss
			GUICtrlSetState($chkReqCCFirst, $g_bReqCCFirst = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			
			; Misc Battle Settings Added by rulesss
			GUICtrlSetState($chkFastADBClicks, $g_bAndroidAdbClicksEnabled = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
            chkFastADBClicks()
			
		Case "Save"
			; Multi Finger - Added by Eloy
			$iMultiFingerStyle = _GUICtrlComboBox_GetCurSel($CmbDBMultiFinger)

			; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
			$iChkUnitFactor = (GUICtrlRead($ChkUnitFactor) = $GUI_CHECKED)
			$iChkWaveFactor = (GUICtrlRead($ChkWaveFactor) = $GUI_CHECKED)
			$iTxtUnitFactor = GUICtrlRead($TxtUnitFactor)
			$iTxtWaveFactor = GUICtrlRead($TxtWaveFactor)
			$iChkGiantSlot = (GUICtrlRead($ChkGiantSlot) = $GUI_CHECKED)
			$iCmbGiantSlot = _GUICtrlComboBox_GetCurSel($CmbGiantSlot)
			
            ; Disable background by kychera
			$ichkPic = (GUICtrlRead($chkPic) = $GUI_CHECKED)
			; Transparent Gui by kychera
            $iSldTransLevel = GUICtrlRead($SldTransLevel)
			
			; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
			$ichkAutoHide = GUICtrlRead($g_hChkAutohide) = $GUI_CHECKED ? 1 : 0
			$ichkAutoHideDelay = GUICtrlRead($g_hTxtAutohideDelay)

			; Check Collector Outside (McSlither) - Added by NguyenAnhHD
			$ichkDBMeetCollOutside = GUICtrlRead($g_hChkDBMeetCollOutside) = $GUI_CHECKED ? 1 : 0
			$iDBMinCollOutsidePercent = GUICtrlRead($g_hTxtDBMinCollOutsidePercent)

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

			; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
			$g_iCmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$DB])
			$g_iCmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$LB])

			; Smart Upgarde (Roro-Titi) - Added by NguyenAnhHD
			$ichkSmartUpgrade = GUICtrlRead($g_hChkSmartUpgrade) = $GUI_CHECKED ? 1 : 0

			$iSmartMinGold = GUICtrlRead($SmartMinGold)
			$iSmartMinElixir = GUICtrlRead($SmartMinElixir)
			$iSmartMinDark = GUICtrlRead($SmartMinDark)

			$ichkIgnoreTH = GUICtrlRead($g_hChkIgnoreTH) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreKing = GUICtrlRead($g_hChkIgnoreKing) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreQueen = GUICtrlRead($g_hChkIgnoreQueen) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreWarden = GUICtrlRead($g_hChkIgnoreWarden) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreCC = GUICtrlRead($g_hChkIgnoreCC) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreLab = GUICtrlRead($g_hChkIgnoreLab) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreBarrack = GUICtrlRead($g_hChkIgnoreBarrack) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreDBarrack = GUICtrlRead($g_hChkIgnoreDBarrack) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreFactory = GUICtrlRead($g_hChkIgnoreFactory) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreDFactory = GUICtrlRead($g_hChkIgnoreDFactory) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreGColl = GUICtrlRead($g_hChkIgnoreGColl) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreEColl = GUICtrlRead($g_hChkIgnoreEColl) = $GUI_CHECKED ? 1 : 0
			$ichkIgnoreDColl = GUICtrlRead($g_hChkIgnoreDColl) = $GUI_CHECKED ? 1 : 0

			; Upgrade Management (MMHK) - Added by NguyenAnhHD
			$g_ibUpdateNewUpgradesOnly = (GUICtrlRead($g_hChkUpdateNewUpgradesOnly) = $GUI_CHECKED)

			; SimpleTrain (Demen) - Added by Demen
			$ichkSimpleTrain = GUICtrlRead($g_hchkSimpleTrain) = $GUI_CHECKED ? 1 : 0
			$ichkPreciseTroops = GUICtrlRead($g_hchkPreciseTroops) = $GUI_CHECKED ? 1 : 0
			$ichkFillArcher = GUICtrlRead($g_hchkFillArcher) = $GUI_CHECKED ? 1 : 0
			$iFillArcher = GUICtrlRead($g_htxtFillArcher)
			$ichkFillEQ = GUICtrlRead($g_hchkFillEQ) = $GUI_CHECKED ? 1 : 0

			; CoC Stats - Added by NguyenAnhHD
			$ichkCoCStats = GUICtrlRead($g_hChkCoCStats) = $GUI_CHECKED ? 1 : 0
			$MyApiKey = GUICtrlRead($g_hTxtAPIKey)

			; Bot Humanization (Roro-Titi) - Added by NguyenAnhHD
			$g_ichkUseBotHumanization = GUICtrlRead($chkUseBotHumanization) = $GUI_CHECKED ? 1 : 0
			$g_ichkUseAltRClick = GUICtrlRead($chkUseAltRClick) = $GUI_CHECKED ? 1 : 0
			$g_ichkCollectAchievements = GUICtrlRead($chkCollectAchievements) = $GUI_CHECKED ? 1 : 0
			$g_ichkLookAtRedNotifications = GUICtrlRead($chkLookAtRedNotifications) = $GUI_CHECKED ? 1 : 0
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

			; Goblin XP (Mr.Viper) - Added by NguyenAnhHD
			$ichkEnableSuperXP = GUICtrlRead($chkEnableSuperXP) = $GUI_CHECKED ? 1 : 0
			$irbSXTraining = GUICtrlRead($rbSXTraining) = $GUI_CHECKED ? 1 : 2
			$ichkSXBK = (GUICtrlRead($chkSXBK) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
			$ichkSXAQ = (GUICtrlRead($chkSXAQ) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
			$ichkSXGW = (GUICtrlRead($chkSXGW) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
			$itxtMaxXPtoGain = Int(GUICtrlRead($txtMaxXPtoGain))

			; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
			$g_bChkClanHop = (GUICtrlRead($g_hChkClanHop) = $GUI_CHECKED)
            
			;Move the Request CC Troops - Added by rulesss
			$g_bReqCCFirst = GUICtrlRead($chkReqCCFirst) = $GUI_CHECKED ? 1 : 0
			
			
			
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

; Android Settings (LunaEclipse)- modification (rulesss,kychera) 
Func ApplyConfig_AndroidSettings($TypeReadSave)  
	Switch $TypeReadSave
		Case "Read"
		If _GUICtrlComboBox_FindStringExact($CmbAndroid, String($sAndroid)) <> -1 Then
		_GUICtrlComboBox_SelectString($CmbAndroid, String($sAndroid))
	    Else		  
		_GUICtrlComboBox_SetCurSel($CmbAndroid, 0)
		EndIf		
	      modifyAndroid()
sleep(300)		  
		  GUICtrlSetData($TxtAndroidInstance, $sAndroidInstance)		 
         
		Case "Save"
		$sAndroid = _GUICtrlComboBox_GetCurSel($CmbAndroid)     
		   
		   $sAndroidInstance = GUICtrlRead($TxtAndroidInstance)
		   
	EndSwitch
EndFunc   ;==>ApplyConfig_AndroidSettings

Func ApplyConfig_RK_MOD_ruRequest($TypeReadSave); by kychera
	Switch $TypeReadSave
		Case "Read"
          GUICtrlSetState($chkRusLang2, $ichkRusLang2 = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
           chkRusLang2()
		Case "Save"
		   $ichkRusLang2 = GUICtrlRead($chkRusLang2) = $GUI_CHECKED ? 1 : 0

	EndSwitch
EndFunc   ;==>ApplyConfig_RK_ruRequest

Func ApplyConfig_RK_MOD_NotifyBotSleep($TypeReadSave); by kychera
	Switch $TypeReadSave
		Case "Read"
		  GUICtrlSetState($ChkNotifyAlertConnect, $iNotifyAlertConnect = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
		  ChkNotifyConnect()
		  GUICtrlSetState($ChkNotifyAlertBOTSleep, $iNotifyAlertBOTSleep = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
          ChkNotifyAlertBOTSleep()
		Case "Save"
		   $iNotifyAlertConnect = GUICtrlRead($ChkNotifyAlertConnect) = $GUI_CHECKED ? 1 : 0
		   $iNotifyAlertBOTSleep = GUICtrlRead($ChkNotifyAlertBOTSleep) = $GUI_CHECKED ? 1 : 0
	EndSwitch
EndFunc   ;==>ApplyConfig_RK_ruRequest