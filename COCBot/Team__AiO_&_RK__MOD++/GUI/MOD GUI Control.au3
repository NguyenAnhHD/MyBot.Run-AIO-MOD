; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control
; Description ...: This file controls the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO & RK MOD++ (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; Classic Four Finger (Demen) - Added by NguyenAnhHD
Func cmbStandardDropSidesAB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesAB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaAB()
EndFunc   ;==>g_hCmbStandardDropSidesAB

Func cmbStandardDropSidesDB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesDB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaDB()
EndFunc   ;==>g_hCmbStandardDropSidesDB

; Goblin XP (MR.ViPeR) - Added by NguyenAnhHD
Func DisableSX()
	GUICtrlSetState($chkEnableSuperXP, $GUI_UNCHECKED)
	$ichkEnableSuperXP = 0

	For $i = $grpSuperXP To $lblXPSXWonHour
		GUICtrlSetState($i, $GUI_DISABLE)
	Next

	GUICtrlSetState($lblLOCKEDSX, BitOR($GUI_SHOW, $GUI_ENABLE))
EndFunc   ;==>DisableSX

Func SXSetXP($toSet = "")
	If $toSet = "S" Or $toSet = "" Then GUICtrlSetData($lblXPatStart, $iStartXP)
	If $toSet = "C" Or $toSet = "" Then GUICtrlSetData($lblXPCurrent, $iCurrentXP)
	If $toSet = "W" Or $toSet = "" Then GUICtrlSetData($lblXPSXWon, $iGainedXP)
	$iGainedXPHour = Round($iGainedXP / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)
	If $toSet = "H" Or $toSet = "" Then GUICtrlSetData($lblXPSXWonHour, _NumberFormat($iGainedXPHour))

EndFunc   ;==>SXSetXP

Func chkEnableSuperXP()
    $ichkEnableSuperXP = 1
	If GUICtrlRead($chkEnableSuperXP) = $GUI_CHECKED Then
		GUICtrlSetState($rbSXTraining, $GUI_ENABLE)
		GUICtrlSetState($rbSXIAttacking, $GUI_ENABLE)
		GUICtrlSetState($chkSXBK, $GUI_ENABLE)
		GUICtrlSetState($chkSXAQ, $GUI_ENABLE)
		GUICtrlSetState($chkSXGW, $GUI_ENABLE)
		GUICtrlSetState($txtMaxXPtoGain, $GUI_ENABLE)
	Else
	$ichkEnableSuperXP = 0
		GUICtrlSetState($rbSXTraining, $GUI_DISABLE)
		GUICtrlSetState($rbSXIAttacking, $GUI_DISABLE)
		GUICtrlSetState($chkSXBK, $GUI_DISABLE)
		GUICtrlSetState($chkSXAQ, $GUI_DISABLE)
		GUICtrlSetState($chkSXGW, $GUI_DISABLE)
		GUICtrlSetState($txtMaxXPtoGain, $GUI_DISABLE)
	EndIf

EndFunc   ;==>chkEnableSuperXP

Func chkEnableSuperXP2()

	$ichkEnableSuperXP = GUICtrlRead($chkEnableSuperXP) = $GUI_CHECKED ? 1 : 0
	$irbSXTraining = GUICtrlRead($rbSXTraining) = $GUI_CHECKED ? 1 : 2
	$ichkSXBK = (GUICtrlRead($chkSXBK) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
	$ichkSXAQ = (GUICtrlRead($chkSXAQ) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
	$ichkSXGW = (GUICtrlRead($chkSXGW) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
	$itxtMaxXPtoGain = Int(GUICtrlRead($txtMaxXPtoGain))

EndFunc   ;==>chkEnableSuperXP2

; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
Func chkAutoHide()
	GUICtrlSetState($g_hTxtAutohideDelay, GUICtrlRead($g_hChkAutoHide) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkAutoHide

; Switch Profiles (IceCube) - Added by NguyenAnhHD
Func btnRecycle()
	FileDelete($g_sProfileConfigPath)
	saveConfig()
	SetLog("Profile " & $g_sProfileCurrentName & " was recycled with success", $COLOR_GREEN)
	SetLog("All unused settings were removed", $COLOR_GREEN)
EndFunc   ;==>btnRecycle

Func setupProfileComboBoxswitch()
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMinProfile, $profileString, "<No Profiles>")
EndFunc   ;==>setupProfileComboBoxswitch

; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
Func cmbCSVSpeed()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$g_iMatchMode])
		Case 0
			$g_hDivider = 0.5
		Case 1
			$g_hDivider = 0.75
		Case 2
			$g_hDivider = 1
		Case 3
			$g_hDivider = 1.25
		Case 4
			$g_hDivider = 1.5
		Case 5
			$g_hDivider = 2
		Case 6
			$g_hDivider = 3
	EndSwitch

EndFunc   ;==>cmbCSVSpeed

; Attack Now Button (MR.ViPeR) - Added by NguyenAnhHD
Func AttackNowLB()
	SetLog("Begin Live Base Attack TEST")
	$g_iMatchMode = $LB			; Select Live Base As Attack Type
	cmbCSVSpeed()
	$g_aiAttackAlgorithm[$LB] = 1			; Select Scripted Attack
	$g_sAttackScrScriptName[$LB] = GuiCtrlRead($g_hCmbScriptNameAB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$g_iMatchMode = 1			; Select Live Base As Attack Type
	$g_bRunState = True

	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($DELAYPREPARESEARCH3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($g_iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	SetLog("End Live Base Attack TEST")
EndFunc   ;==>AttackNowLB

Func AttackNowDB()
	SetLog("Begin Dead Base Attack TEST")
	$g_iMatchMode = $DB			; Select Dead Base As Attack Type
	cmbCSVSpeed()
	$g_aiAttackAlgorithm[$DB] = 1			; Select Scripted Attack
	$g_sAttackScrScriptName[$DB] = GuiCtrlRead($g_hCmbScriptNameDB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$g_iMatchMode = 0			; Select Dead Base As Attack Type
	$g_bRunState = True
	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($DELAYPREPARESEARCH3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($g_iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	SetLog("End Dead Base Attack TEST")
EndFunc   ;==>AttackNowLB

; Upgrade Management (MMHK) - Added by NguyenAnhHD
Func chkUpgradeAllOrNone()
	If GUICtrlRead($g_hChkUpgradeAllOrNone) = $GUI_CHECKED And GUICtrlRead($g_hChkUpgrade[0]) = $GUI_CHECKED Then
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgrade[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgrade[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkUpgradeAllOrNone, $GUI_UNCHECKED)
EndFunc   ;==>chkUpgradeAllOrNone

Func chkUpgradeRepeatAllOrNone()
	If GUICtrlRead($g_hChkUpgradeRepeatAllOrNone) = $GUI_CHECKED And GUICtrlRead($g_hChkUpgradeRepeat[0]) = $GUI_CHECKED Then
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgradeRepeat[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgradeRepeat[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkUpgradeRepeatAllOrNone, $GUI_UNCHECKED)
EndFunc   ;==>chkUpgradeRepeatAllOrNone

Func chkUpdateNewUpgradesOnly()
	If GUICtrlRead($g_hChkUpdateNewUpgradesOnly) = $GUI_CHECKED Then
		$g_ibUpdateNewUpgradesOnly = True
	Else
		$g_ibUpdateNewUpgradesOnly = False
	EndIf
EndFunc   ;==>chkUpdateNewUpgradesOnly

Func btnTop()
	MoveUpgrades($UP, $TILL_END)
EndFunc   ;==>btnTop

Func btnUp()
	MoveUpgrades($UP)
EndFunc   ;==>btnUp

Func btnDown()
	MoveUpgrades($DOWN)
EndFunc   ;==>btnDown

Func btnBottom()
	MoveUpgrades($DOWN, $TILL_END)
EndFunc   ;==>btnBottom

; CoC Stats - Added by NguyenAnhHD
Func chkCoCStats()
	GUICtrlSetState($g_hTxtAPIKey, GUICtrlRead($g_hChkCoCStats) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
	IniWrite($g_sProfileConfigPath, "Stats", "chkCoCStats", $ichkCoCStats)
EndFunc   ;==>chkCoCStats

; QuickTrainCombo (Demen) - Added By Demen
Func chkQuickTrainCombo()
	If GUICtrlRead($g_ahChkArmy[0]) = $GUI_UNCHECKED And GUICtrlRead($g_ahChkArmy[1]) = $GUI_UNCHECKED And GUICtrlRead($g_ahChkArmy[2]) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_ahChkArmy[0], $GUI_CHECKED)
		ToolTip(GetTranslated(621, 100, "QuickTrainCombo: ") & @CRLF & GetTranslated(621, 101, "At least 1 Army Check is required! Default Army1."))
		Sleep(2000)
		ToolTip('')
	EndIf
EndFunc   ;==>chkQuickTrainCombo

; SimpleTrain (Demen) - Added By Demen
Func chkSimpleTrain()
	If GUICtrlRead($g_hchkSimpleTrain) = $GUI_CHECKED Then
		If GUICtrlRead($g_hChkUseQuickTrain) = $GUI_UNCHECKED Then _GUI_Value_STATE("ENABLE", $g_hchkPreciseTroops)
		_GUI_Value_STATE("ENABLE", $g_hchkFillArcher & "#" & $g_hchkFillEQ)
		chkFillArcher()
	Else
		_GUI_Value_STATE("DISABLE", $g_hchkPreciseTroops & "#" & $g_hchkFillArcher & "#" & $g_htxtFillArcher & "#" & $g_hchkFillEQ)
		_GUI_Value_STATE("UNCHECKED", $g_hchkPreciseTroops & "#" & $g_hchkFillArcher & "#" & $g_hchkFillEQ)
	EndIf
EndFunc   ;==>chkSimpleTrain

Func chkPreciseTroops()
	If GUICtrlRead($g_hchkPreciseTroops) = $GUI_CHECKED Then
		_GUI_Value_STATE("DISABLE", $g_hchkFillArcher & "#" & $g_hchkFillEQ)
		_GUI_Value_STATE("UNCHECKED", $g_hchkFillArcher & "#" & $g_hchkFillEQ)
		chkFillArcher()
	Else
		_GUI_Value_STATE("ENABLE", $g_hchkFillArcher & "#" & $g_hchkFillEQ)
	EndIf
EndFunc   ;==>chkPreciseTroops

Func chkFillArcher()
	If GUICtrlRead($g_hchkFillArcher) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $g_htxtFillArcher)
	Else
		_GUI_Value_STATE("DISABLE", $g_htxtFillArcher)
	EndIf
EndFunc   ;==>chkFillArcher

; SwitchAcc (Demen) - Added By Demen
Func AddProfileToList()
	Switch @GUI_CtrlId
		Case $g_hBtnAddProfile
			SaveConfig_SwitchAcc()

		Case $g_hBtnConfirmAddProfile
			Local $iNewProfile = _GUICtrlComboBox_GetCurSel($g_hCmbProfile)
			Local $UpdatedProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
			Local $nUpdatedTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)
			If $iNewProfile <= 7 Then
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$iNewProfile], -1) ; clear config of new profile
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$iNewProfile], -1)
				For $i = 7 To $iNewProfile + 1 Step -1
					_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], $aMatchProfileAcc[$i - 1] - 1) ; push config up 1 level. -1 because $aMatchProfileAcc is saved from 1 to 8
					_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], $aProfileType[$i - 1] - 1)
				Next
			EndIf
			btnUpdateProfile()
	EndSwitch
EndFunc   ;==>AddProfileToList

Func RemoveProfileFromList($iDeleteProfile)
	Local $UpdatedProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	Local $nUpdatedTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)
	If $iDeleteProfile <= 7 Then
		For $i = $iDeleteProfile To 7
			If $i <= 6 Then
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], $aMatchProfileAcc[$i + 1] - 1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], $aProfileType[$i + 1] - 1)
			Else
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
			EndIf
		Next
	EndIf
	btnUpdateProfile()
EndFunc   ;==>RemoveProfileFromList

Func g_btnUpdateProfile()
	btnUpdateProfile()
EndFunc   ;==>g_btnUpdateProfile

Func btnUpdateProfile($Config = True)

	If $Config = True Then
		SaveConfig_SwitchAcc()
		ReadConfig_SwitchAcc()
		ApplyConfig_SwitchAcc("Read")
	EndIf

	$aActiveProfile = _ArrayFindAll($aProfileType, $eActive)
	$aDonateProfile = _ArrayFindAll($aProfileType, $eDonate)
	$ProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	$nTotalProfile = _Min(8, _GUICtrlComboBox_GetCount($g_hCmbProfile))

	For $i = 0 To 7
		If $i <= $nTotalProfile - 1 Then
			GUICtrlSetData($lblProfileName[$i], $ProfileList[$i + 1])
			For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
				GUICtrlSetState($j, $GUI_SHOW)
			Next
			; Update stats GUI
			For $j = $aStartHide[$i] To $aEndHide[$i]
				GUICtrlSetState($j, $GUI_SHOW)
			Next
			Switch $aProfileType[$i]
				Case 1
					GUICtrlSetData($grpVillageAcc[$i], $ProfileList[$i + 1] & " (Active)")
				Case 2
					GUICtrlSetData($grpVillageAcc[$i], $ProfileList[$i + 1] & " (Donate)")
					For $j = $aSecondHide[$i] To $aEndHide[$i]
						GUICtrlSetState($j, $GUI_HIDE)
					Next
				Case Else
					GUICtrlSetData($grpVillageAcc[$i], $ProfileList[$i + 1] & " (Idle)")
					For $j = $aSecondHide[$i] To $aEndHide[$i]
						GUICtrlSetState($j, $GUI_HIDE)
					Next
			EndSwitch
		Else
			GUICtrlSetData($lblProfileName[$i], "")
			_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
			_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
			For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
				GUICtrlSetState($j, $GUI_HIDE)
			Next
			; Update stats GUI
			For $j = $aStartHide[$i] To $aEndHide[$i]
				GUICtrlSetState($j, $GUI_HIDE)
			Next
		EndIf
	Next
EndFunc   ;==>btnUpdateProfile

Func btnClearProfile()
	For $i = 0 To 7
		_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
		_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
	Next
EndFunc   ;==>btnClearProfile

Func chkSwitchAcc()
	If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then
		If _GUICtrlComboBox_GetCount($g_hCmbProfile) <= 1 Then
			GUICtrlSetState($chkSwitchAcc, $GUI_UNCHECKED)
			MsgBox($MB_OK, GetTranslated(110, 1, "SwitchAcc Mode"), GetTranslated(110, 2, "Cannot enable SwitchAcc Mode") & @CRLF & GetTranslated(110, 3, "You have only ") & _GUICtrlComboBox_GetCount($g_hCmbProfile) & " Profile", 30, $g_hGUI_BOT)
		Else
			For $i = $chkTrain To $g_EndHideSwitchAcc
				GUICtrlSetState($i, $GUI_ENABLE)
			Next
			radNormalSwitch()
			chkForceSwitch()
			btnUpdateProfile(False)
		EndIf
	Else
		_GUI_Value_STATE("UNCHECKED", $g_hChkForceSwitch & "#" & $g_hChkForceStayDonate)
		For $i = $chkTrain To $g_EndHideSwitchAcc
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		For $j = $aStartHide[0] To $aEndHide[7]
			GUICtrlSetState($j, $GUI_HIDE)
		Next
	EndIf
EndFunc   ;==>chkSwitchAcc

Func radNormalSwitch()
	If GUICtrlRead($radNormalSwitch) = $GUI_CHECKED Then
		_GUI_Value_STATE("UNCHECKED", $g_hChkForceStayDonate & "#" & $chkUseTrainingClose)
		_GUI_Value_STATE("DISABLE", $g_hChkForceStayDonate & "#" & $chkUseTrainingClose & "#" & $radCloseCoC & "#" & $radCloseAndroid)
	Else
		_GUI_Value_STATE("ENABLE", $g_hChkForceStayDonate & "#" & $chkUseTrainingClose & "#" & $radCloseCoC & "#" & $radCloseAndroid)
	EndIf
EndFunc   ;==>radNormalSwitch

Func chkForceSwitch()
	If GUICtrlRead($g_hChkForceSwitch) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $g_txtForceSwitch & "#" & $g_lblForceSwitch)
	Else
		_GUI_Value_STATE("DISABLE", $g_txtForceSwitch & "#" & $g_lblForceSwitch)
	EndIf
EndFunc   ;==>chkForceSwitch

Func cmbMatchProfileAcc1()
	MatchProfileAcc(0)
EndFunc   ;==>cmbMatchProfileAcc1
Func cmbMatchProfileAcc2()
	MatchProfileAcc(1)
EndFunc   ;==>cmbMatchProfileAcc2
Func cmbMatchProfileAcc3()
	MatchProfileAcc(2)
EndFunc   ;==>cmbMatchProfileAcc3
Func cmbMatchProfileAcc4()
	MatchProfileAcc(3)
EndFunc   ;==>cmbMatchProfileAcc4
Func cmbMatchProfileAcc5()
	MatchProfileAcc(4)
EndFunc   ;==>cmbMatchProfileAcc5
Func cmbMatchProfileAcc6()
	MatchProfileAcc(5)
EndFunc   ;==>cmbMatchProfileAcc6
Func cmbMatchProfileAcc7()
	MatchProfileAcc(6)
EndFunc   ;==>cmbMatchProfileAcc7
Func cmbMatchProfileAcc8()
	MatchProfileAcc(7)
EndFunc   ;==>cmbMatchProfileAcc8

Func MatchProfileAcc($Num)
	If _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) > _GUICtrlComboBox_GetCurSel($cmbTotalAccount) Then
		MsgBox($MB_OK, GetTranslated(110, 1, "SwitchAcc Mode"), GetTranslated(110, 4, "Account [") & _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) & GetTranslated(110, 5, "] exceeds Total Account declared"), 30, $g_hGUI_BOT)
		_GUICtrlComboBox_SetCurSel($cmbAccountNo[$Num], -1)
		_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], -1)
		btnUpdateProfile()
	EndIf

	Local $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num])
	If $AccSelected >= 0 Then
		For $i = 0 To 7
			If $i = $Num Then ContinueLoop
			If $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$i]) Then
				MsgBox($MB_OK, GetTranslated(110, 1, "SwitchAcc Mode"), GetTranslated(110, 4, "Account [") & $AccSelected + 1 & GetTranslated(110, 6, "] has been assigned to Profile [") & $i + 1 & "]", 30, $g_hGUI_BOT)
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$Num], -1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], -1)
				btnUpdateProfile()
				ExitLoop
			EndIf
		Next

		If _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) >= 0 Then
			_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], 0)
			btnUpdateProfile()
		EndIf
	EndIf
EndFunc   ;==>MatchProfileAcc

Func btnLocateAcc()
	Local $AccNo = _GUICtrlComboBox_GetCurSel($cmbLocateAcc) + 1
	Local $stext, $MsgBox

	Local $wasRunState = $g_bRunState
	$g_bRunState = True

	SetLog(GetTranslated(110, 7, "Locating Y-Coordinate of CoC Account No. ") & $AccNo & GetTranslated(110, 8, ", please wait..."), $COLOR_BLUE)
	WinGetAndroidHandle()

	Zoomout()

	Click(820, 585, 1, 0, "Click Setting") ;Click setting
	Sleep(500)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 600)
		$stext = GetTranslated(110, 9, "Click Connect/Disconnect on emulator to show the accout list") & @CRLF & @CRLF & _
				GetTranslated(110, 10, "Click OK then click on your Account No. ") & $AccNo & @CRLF & @CRLF & _
				GetTranslated(110, 11, "Do not move mouse quickly after clicking location") & @CRLF & @CRLF
		$MsgBox = _ExtMsgBox(0, GetTranslated(110, 12, "Ok|Cancel"), GetTranslated(110, 13, "Locate CoC Account No. ") & $AccNo, $stext, 60, $g_hFrmBot)
		If $MsgBox = 1 Then
			WinGetAndroidHandle()
			Local $aPos = FindPos()
			$aLocateAccConfig[$AccNo - 1] = Int($aPos[1])
			ClickP($aAway, 1, 0, "#0379")
		Else
			SetLog(GetTranslated(110, 14, "Locate CoC Account Cancelled"), $COLOR_BLUE)
			ClickP($aAway, 1, 0, "#0382")
			Return
		EndIf
		SetLog(GetTranslated(110, 15, "Locate CoC Account Success: ") & "(383, " & $aLocateAccConfig[$AccNo - 1] & ")", $COLOR_GREEN)

		ExitLoop
	WEnd
	Clickp($aAway, 2, 0, "#0207")
	IniWriteS($profile, "Switch Account", "AccLocation." & $AccNo, $aLocateAccConfig[$AccNo - 1])
	$g_bRunState = $wasRunState
	AndroidShield("LocateAcc") ; Update shield status due to manual $RunState

EndFunc   ;==>btnLocateAcc

Func btnClearAccLocation()
	For $i = 1 To 8
		$aLocateAccConfig[$i - 1] = -1
		$aAccPosY[$i - 1] = -1
	Next
	Setlog(GetTranslated(110, 16, "Position of all accounts cleared"))
	SaveConfig_SwitchAcc()
EndFunc   ;==>btnClearAccLocation

; Forecast Switch Language Control - Added By Eloy
Func cmbSwLang()
	Switch GUICtrlRead($cmbSwLang)

		Case "EN"
			setForecast2()
		Case "RU"
			setForecast3()
		Case "FR"
			setForecast4()
		Case "DE"
			setForecast5()
		Case "ES"
			setForecast6()
		Case "FA"
			setForecast7()
		Case "PT"
			setForecast8()
		Case "IN"
			setForecast9()
	EndSwitch
EndFunc

; Android Settings (LunaEclipse)- modification (rulesss,kychera)
Func setupAndroidComboBox()
	Local $androidString = ""
	Local $aAndroidWindow = getInstalledEmulators()

	; Convert the array into a string
	$androidString = _ArrayToString($aAndroidWindow, "|")

	; Set the new data of valid Emulators
	GUICtrlSetData($CmbAndroid, $androidString, $aAndroidWindow[0])
EndFunc   ;==>setupAndroidComboBox

Func CmbAndroid()
	$sAndroid = GUICtrlRead($CmbAndroid)
	modifyAndroid()
EndFunc   ;==>cmbAndroid

Func TxtAndroidInstance()
	$sAndroidInstance = GUICtrlRead($TxtAndroidInstance)
	modifyAndroid()
EndFunc   ;==>$txtAndroidInstance

; Misc Battle Settings added by rulesss
Func chkFastADBClicks()
	If GUICtrlRead($chkFastADBClicks) = $GUI_CHECKED Then
		$g_bAndroidAdbClicksEnabled = 1
	Else
		$g_bAndroidAdbClicksEnabled = 0
	EndIf
EndFunc   ;==>chkFastADBClicks
Func chkAndroid()
    If GUICtrlRead($g_hChkAndroid) = $GUI_CHECKED Then
		$g_iChkAndroid = 1
		GUICtrlSetState($CmbAndroid, $GUI_ENABLE)
		GUICtrlSetState($TxtAndroidInstance, $GUI_ENABLE)		
	Else
		$g_iChkAndroid = 0
		GUICtrlSetState($CmbAndroid, $GUI_DISABLE)
		GUICtrlSetState($TxtAndroidInstance, $GUI_DISABLE)
	EndIf
EndFunc