; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control
; Description ...: This file controls the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; Classic Four Finger
Func cmbStandardDropSidesAB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesAB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaAB()
EndFunc   ;==>g_hCmbStandardDropSidesAB

Func Bridge()
    If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesDB) = 4 Then
            GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_UNCHECKED)
		    GUICtrlSetState($g_hChkRandomSpeedAtkDB, $GUI_UNCHECKED)
		    chkRandomSpeedAtkDB()
		For $i = $g_hChkRandomSpeedAtkDB To $g_hPicAttackNearDarkElixirDrillDB
			GUICtrlSetState($i, $GUI_DISABLE + $GUI_HIDE)
		Next
		For $i = $g_hGrpSettings To $TxtWaveFactor
			GUICtrlSetState($i, $GUI_SHOW)
	    Next
	Else
		For $i = $g_hChkRandomSpeedAtkDB To $g_hPicAttackNearDarkElixirDrillDB
			GUICtrlSetState($i, $GUI_ENABLE + $GUI_SHOW)
		Next

	    For $i = $g_hGrpSettings To $TxtWaveFactor
			GUICtrlSetState($i, $GUI_HIDE)
	    Next
        chkSmartAttackRedAreaDB()
	EndIf

EndFunc ;==>Bridge

; Unit/Wave Factor
Func chkUnitFactor()
	If GUICtrlRead($ChkUnitFactor) = $GUI_CHECKED Then
		$iChkUnitFactor = 1
		GUICtrlSetState($TxtUnitFactor, $GUI_ENABLE)
	Else
		$iChkUnitFactor = 0
		GUICtrlSetState($TxtUnitFactor, $GUI_DISABLE)
	EndIf
	$iTxtUnitFactor = GUICtrlRead($TxtUnitFactor)
EndFunc

Func chkWaveFactor()
	If GUICtrlRead($ChkWaveFactor) = $GUI_CHECKED Then
		$iChkWaveFactor = 1
		GUICtrlSetState($TxtWaveFactor, $GUI_ENABLE)
	Else
		$iChkWaveFactor = 0
		GUICtrlSetState($TxtWaveFactor, $GUI_DISABLE)
	EndIf
	$iTxtWaveFactor = GUICtrlRead($TxtWaveFactor)
EndFunc

Func ChkGiantSlot()
	If GUICtrlRead($ChkGiantSlot) = $GUI_CHECKED Then
		$iChkGiantSlot = 1
		GUICtrlSetState($CmbGiantSlot, $GUI_ENABLE)
	Else
		$iChkGiantSlot = 0
		GUICtrlSetState($CmbGiantSlot, $GUI_DISABLE)
	EndIf
EndFunc

Func CmbGiantSlot()
	If $iChkGiantSlot = 1 Then
		Switch _GUICtrlComboBox_GetCurSel($CmbGiantSlot)
			Case 0
				$iSlotsGiants = 0
			Case 1
				$iSlotsGiants = 2
		EndSwitch
	Else
	LocaL $GiantComp = $g_ahTxtTrainArmyTroopCount[$eTroopGiant]
		If Number($GiantComp) >= 1 And Number($GiantComp) <= 7 Then $iSlotsGiants = 1
		If Number($GiantComp) >= 8 Then $iSlotsGiants = 2 ; will be split in 2 slots, when >16 or >=8 with FF
		If Number($GiantComp) >= 12 Then $iSlotsGiants = 0 ; spread on vector, when >20 or >=12 with FF
	EndIf
EndFunc

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

; SmartTrain (Demen) - Added By Demen
Func chkSmartTrain()
	If GUICtrlRead($g_hchkSmartTrain) = $GUI_CHECKED Then
		If GUICtrlRead($g_hChkUseQuickTrain) = $GUI_UNCHECKED Then _GUI_Value_STATE("ENABLE", $g_hchkPreciseTroops)
		_GUI_Value_STATE("ENABLE", $g_hchkFillArcher & "#" & $g_hchkFillEQ)
		chkPreciseTroops()
		chkFillArcher()
	Else
		_GUI_Value_STATE("DISABLE", $g_hchkPreciseTroops & "#" & $g_hchkFillArcher & "#" & $g_htxtFillArcher & "#" & $g_hchkFillEQ)
		_GUI_Value_STATE("UNCHECKED", $g_hchkPreciseTroops & "#" & $g_hchkFillArcher & "#" & $g_hchkFillEQ)
	EndIf
EndFunc   ;==>chkSmartTrain

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
				Case Else
					GUICtrlSetData($grpVillageAcc[$i], $ProfileList[$i + 1] & " (Idle)")
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
			MsgBox($MB_OK, GetTranslatedFileIni("MOD GUI Control - Switch Account", "chkSwitchAcc", "SwitchAcc Mode"), GetTranslatedFileIni("MOD GUI Control - Switch Account", "chkSwitchAcc_Info_01", "Cannot enable SwitchAcc Mode") & @CRLF & GetTranslatedFileIni("MOD GUI Control - Switch Account", "chkSwitchAcc_Info_02", "You have only ") & _GUICtrlComboBox_GetCount($g_hCmbProfile) & " Profile", 30, $g_hGUI_BOT)
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
		MsgBox($MB_OK, GetTranslatedFileIni("MOD GUI Control - Switch Account", "cmbAccountNo", "SwitchAcc Mode"), GetTranslatedFileIni("MOD GUI Control - Switch Account", "cmbAccountNo_Info_01", "Account [") & _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) & GetTranslatedFileIni("MOD GUI Control - Switch Account", "cmbAccountNo_Info_02", "] exceeds Total Account declared"), 30, $g_hGUI_BOT)
		_GUICtrlComboBox_SetCurSel($cmbAccountNo[$Num], -1)
		_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], -1)
		btnUpdateProfile()
	EndIf

	Local $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num])
	If $AccSelected >= 0 Then
		For $i = 0 To 7
			If $i = $Num Then ContinueLoop
			If $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$i]) Then
				MsgBox($MB_OK, GetTranslatedFileIni("MOD GUI Control - Switch Account", "cmbAccountNo", -1), GetTranslatedFileIni("MOD GUI Control - Switch Account", "cmbAccountNo_Info_01", -1) & $AccSelected + 1 & GetTranslatedFileIni("MOD GUI Control - Switch Account", "cmbAccountNo_Info_03", "] has been assigned to Profile [") & $i + 1 & "]", 30, $g_hGUI_BOT)
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

	SetLog(GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_01", "Locating Y-Coordinate of CoC Account No. ") & $AccNo & GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_02", ", please wait..."), $COLOR_BLUE)
	WinGetAndroidHandle()

	Zoomout()

	Click(820, 585, 1, 0, "Click Setting") ;Click setting
	Sleep(500)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 600)
		$stext = GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_03", "Click Connect/Disconnect on emulator to show the accout list") & @CRLF & @CRLF & _
				GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_04", "Click OK then click on your Account No. ") & $AccNo & @CRLF & @CRLF & _
				GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_05", "Do not move mouse quickly after clicking location") & @CRLF & @CRLF
		$MsgBox = _ExtMsgBox(0, GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_06", "Ok|Cancel"), GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_07", "Locate CoC Account No. ") & $AccNo, $stext, 60, $g_hFrmBot)
		If $MsgBox = 1 Then
			WinGetAndroidHandle()
			Local $aPos = FindPos()
			$aLocateAccConfig[$AccNo - 1] = Int($aPos[1])
			ClickP($aAway, 1, 0, "#0379")
		Else
			SetLog(GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_08", "Locate CoC Account Cancelled"), $COLOR_BLUE)
			ClickP($aAway, 1, 0, "#0382")
			Return
		EndIf
		SetLog(GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnLocateAcc_Info_09", "Locate CoC Account Success: ") & "(383, " & $aLocateAccConfig[$AccNo - 1] & ")", $COLOR_GREEN)

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
	Setlog(GetTranslatedFileIni("MOD GUI Control - Switch Account", "btnClearAccLocation", "Position of all accounts cleared"))
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
