; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control MOD
; Description ...: This file controls the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; GTFO - Team AiO MOD++
Func ApplyGTFO()
	$g_bChkUseGTFO = (GUICtrlRead($g_hChkUseGTFO) = $GUI_CHECKED)
	If $g_bChkUseGTFO = True Then
		GUICtrlSetState($g_hTxtMinSaveGTFO_Elixir, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtMinSaveGTFO_DE, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hTxtMinSaveGTFO_Elixir, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtMinSaveGTFO_DE, $GUI_DISABLE)
	EndIf
EndFunc   ;==>ApplyGTFO

Func ApplyElixirGTFO()
	$g_iTxtMinSaveGTFO_Elixir = Number(GUICtrlRead($g_hTxtMinSaveGTFO_Elixir))
EndFunc   ;==>ApplyElixirGTFO

Func ApplyDarkElixirGTFO()
	$g_iTxtMinSaveGTFO_DE = Number(GUICtrlRead($g_hTxtMinSaveGTFO_DE))
EndFunc   ;==>ApplyDarkElixirGTFO

Func ApplyKickOut()
	$g_bChkUseKickOut = (GUICtrlRead($g_hChkUseKickOut) = $GUI_CHECKED)
	If $g_bChkUseKickOut = True Then
		GUICtrlSetState($g_hTxtDonatedCap, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtReceivedCap, $GUI_ENABLE)
		GUICtrlSetState($g_hChkKickOutSpammers, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtKickLimit, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hTxtDonatedCap, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtReceivedCap, $GUI_DISABLE)
		GUICtrlSetState($g_hChkKickOutSpammers, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtKickLimit, $GUI_DISABLE)
	EndIf
	ApplyKickOutSpammers()
	ApplyKickLimits()
EndFunc   ;==>ApplyKickOut

Func ApplyDonatedCap()
	$g_iTxtDonatedCap = Number(GUICtrlRead($g_hTxtDonatedCap))
	If $g_iTxtDonatedCap < 0 Then
		$g_iTxtDonatedCap = 0
		GUICtrlSetData($g_hTxtDonatedCap, $g_iTxtDonatedCap)
	EndIf

	If $g_iTxtDonatedCap > 8 Then
		$g_iTxtDonatedCap = 8
		GUICtrlSetData($g_hTxtDonatedCap, $g_iTxtDonatedCap)
	EndIf
EndFunc   ;==>ApplyDonatedCap

Func ApplyReceivedCap()
	$g_iTxtReceivedCap = Number(GUICtrlRead($g_hTxtReceivedCap))
	If $g_iTxtReceivedCap < 0 Then
		$g_iTxtReceivedCap = 0
		GUICtrlSetData($g_hTxtReceivedCap, $g_iTxtReceivedCap)
	EndIf
	If $g_iTxtReceivedCap > 35 Then
		$g_iTxtReceivedCap = 35
		GUICtrlSetData($g_hTxtReceivedCap, $g_iTxtReceivedCap)
	EndIf
EndFunc   ;==>ApplyReceivedCap

; Kick Spammer to kick only donating members
Func ApplyKickOutSpammers()
	$g_bChkKickOutSpammers = (GUICtrlRead($g_hChkKickOutSpammers) = $GUI_CHECKED)
	If $g_bChkKickOutSpammers = True Then
		GUICtrlSetState($g_hTxtDonatedCap, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtReceivedCap, $GUI_DISABLE)
	Else
		If $g_bChkUseKickOut = True Then
			GUICtrlSetState($g_hTxtDonatedCap, $GUI_ENABLE)
			GUICtrlSetState($g_hTxtReceivedCap, $GUI_ENABLE)
		EndIf
	EndIf
EndFunc   ;==>ApplyKickOutSpammers

; Set Kick Limite according to your need
Func ApplyKickLimits()
	$g_iTxtKickLimit = Number(GUICtrlRead($g_hTxtKickLimit))
	If $g_iTxtKickLimit < 1 Then
		$g_iTxtKickLimit = 1
		GUICtrlSetData($g_hTxtKickLimit, $g_iTxtKickLimit)
	EndIf
	If $g_iTxtKickLimit > 9 Then
		$g_iTxtKickLimit = 9
		GUICtrlSetData($g_hTxtKickLimit, $g_iTxtKickLimit)
	EndIf
EndFunc   ;==>ApplyKickLimits

; Check Grand Warden Mode - Team AiO MOD++
Func chkCheckWardenMode()
	$g_bCheckWardenMode = (GUICtrlRead($g_hChkCheckWardenMode) = $GUI_CHECKED)
	GUICtrlSetState($g_hCmbCheckWardenMode, $g_bCheckWardenMode ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkCheckWardenMode

; Classic Four Finger - Team AiO MOD++
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
		For $i = $g_hGrpSettings To $g_hTxtWaveFactor
			GUICtrlSetState($i, $GUI_SHOW)
	    Next
	Else
		For $i = $g_hChkRandomSpeedAtkDB To $g_hPicAttackNearDarkElixirDrillDB
			GUICtrlSetState($i, $GUI_ENABLE + $GUI_SHOW)
		Next

	    For $i = $g_hGrpSettings To $g_hTxtWaveFactor
			GUICtrlSetState($i, $GUI_HIDE)
	    Next
        chkSmartAttackRedAreaDB()
	EndIf

EndFunc   ;==>Bridge

; Unit/Wave Factor - Team AiO MOD++
Func cmbGiantSlot()
	If $g_iChkGiantSlot = 1 Then
		Switch _GUICtrlComboBox_GetCurSel($g_hCmbGiantSlot)
			Case 0
				$g_aiSlotsGiants = 0
			Case 1
				$g_aiSlotsGiants = 2
		EndSwitch
	Else
	LocaL $GiantComp = $g_ahTxtTrainArmyTroopCount[$eTroopGiant]
		If Number($GiantComp) >= 1 And Number($GiantComp) <= 7 Then $g_aiSlotsGiants = 1
		If Number($GiantComp) >= 8 Then $g_aiSlotsGiants = 2 ; will be split in 2 slots, when >16 or >=8 with FF
		If Number($GiantComp) >= 12 Then $g_aiSlotsGiants = 0 ; spread on vector, when >20 or >=12 with FF
	EndIf
EndFunc   ;==>cmbGiantSlot

Func chkGiantSlot()
	GUICtrlSetState($g_hCmbGiantSlot, GUICtrlRead($g_hChkGiantSlot) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkGiantSlot

Func chkUnitFactor()
	GUICtrlSetState($g_hTxtUnitFactor, GUICtrlRead($g_hChkUnitFactor) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkUnitFactor

Func chkWaveFactor()
	GUICtrlSetState($g_hTxtWaveFactor, GUICtrlRead($g_hChkWaveFactor) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkWaveFactor

; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
Func chkEnableAuto()
	If GUICtrlRead($g_hChkEnableAuto) = $GUI_CHECKED Then
		$g_bEnableAuto = True
		_GUI_Value_STATE("ENABLE", $g_hChkAutoDock & "#" & $g_hChkAutoHideEmulator)
	Else
		$g_bEnableAuto = False
		_GUI_Value_STATE("DISABLE", $g_hChkAutoDock & "#" & $g_hChkAutoHideEmulator)
	EndIf
EndFunc   ;==>chkEnableAuto

Func btnEnableAuto()
	If $g_bEnableAuto = True Then
		If GUICtrlRead($g_hChkAutoDock) = $GUI_CHECKED Then
			$g_iChkAutoDock = True
			$g_iChkAutoHideEmulator = False
		ElseIf GUICtrlRead($g_hChkAutoHideEmulator) = $GUI_CHECKED Then
			$g_iChkAutoDock = False
			$g_iChkAutoHideEmulator = True
		EndIf
	Else
		$g_iChkAutoDock = False
		$g_iChkAutoHideEmulator = False
	EndIf
EndFunc   ;==>btnEnableAuto

; Restart Search Legend league - Team AiO MOD++
Func chkSearchTimeout()
	If GUICtrlRead($g_hChkSearchTimeout) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $g_hLblSearchTimeout & "#" & $g_hTxtSearchTimeout & "#" & $g_hLblSearchTimeoutminutes)
	Else
		_GUI_Value_STATE("DISABLE", $g_hLblSearchTimeout & "#" & $g_hTxtSearchTimeout & "#" & $g_hLblSearchTimeoutminutes)
	EndIf
EndFunc   ;==>chkSearchTimeout

; Stop on Low battery - Team AiO MOD++
Func _BatteryStatus()
	Local $aData = _WinAPI_GetSystemPowerStatus()
	If @error Then Return

	If BitAND($aData[1], 128) Then
		$aData[0] = '!!'
	Else
		Switch $aData[0]; ac or battery
			Case 0
				$aData[0] = 'BATT'
			Case 1
				$aData[0] = 'AC'
			Case Else
				$aData[0] = '--'
		EndSwitch

		If $aData[0] = 'BATT' Then
			SetLog("Battery/Charging: " & $aData[0] & " Battery status: " & $aData[2] & "%")
			GUICtrlSetData($g_hLblBatteryAC, $aData[0])
			GUICtrlSetData($g_hLblBatteryStatus, $aData[2] & "%")

			If $aData[2] < $g_iStopOnBatt Then
				SetLog("Battery status: " & $aData[2] & "% and is below than " & $g_iStopOnBatt & "%", $COLOR_WARNING)
				SetLog("Stopping bot", $COLOR_ACTION1)
				PoliteCloseCoC()
				CloseAndroid(_BatteryStatus)
				BotStop()
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_BatteryStatus

Func chkStopOnBatt()
	If GUICtrlRead($g_hChkStopOnBatt) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $g_hTxtStopOnBatt & "#" & $g_hLblStopOnBatt)
	Else
		_GUI_Value_STATE("DISABLE", $g_hTxtStopOnBatt & "#" & $g_hLblStopOnBatt)
	EndIf
EndFunc   ;==>chkStopOnBatt
