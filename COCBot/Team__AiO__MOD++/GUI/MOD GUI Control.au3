; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control MOD
; Description ...: This file controls the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
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
	GUICtrlSetState($g_hTxtStopOnBatt, GUICtrlRead($g_hChkStopOnBatt) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkStopOnBatt

; Stop For War - Team AiO MOD++
Func ChkStopForWar()
	If GUICtrlRead($g_hChkStopForWar) = $GUI_CHECKED Then
		For $i = $g_hCmbStopTime To $g_hChkTrainWarTroop
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		ChkTrainWarTroop()
		GUICtrlSetState($g_hChkRequestCCForWar, $GUI_ENABLE)
		ChkRequestCCForWar()
	Else
		For $i = $g_hCmbStopTime To $g_hTxtRequestCCForWar
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		GUICtrlSetBkColor($g_hLblCountWarTroopsTotal, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($g_hLblCountWarSpellsTotal, $COLOR_MONEYGREEN)
	EndIf
EndFunc   ;==>ChkStopForWar

Func CmbStopTime()
	If _GUICtrlComboBox_GetCurSel($g_hCmbStopBeforeBattle) < 1 Then Return
	If _GUICtrlComboBox_GetCurSel($g_hCmbStopTime) >= 24 - _GUICtrlComboBox_GetCurSel($g_hCmbReturnTime) Then
		_GUICtrlComboBox_SetCurSel($g_hCmbReturnTime, 0)
		ToolTip("Set Return Time: " & @CRLF & "Pause time should be before Return time.")
		Sleep(3500)
		ToolTip('')
	EndIf
EndFunc   ;==>CmbStopTime

Func CmbReturnTime()
	If _GUICtrlComboBox_GetCurSel($g_hCmbStopBeforeBattle) < 1 Then Return
	If _GUICtrlComboBox_GetCurSel($g_hCmbReturnTime) >= 24 - _GUICtrlComboBox_GetCurSel($g_hCmbStopTime) Then
		_GUICtrlComboBox_SetCurSel($g_hCmbReturnTime, 0)
		ToolTip("Set Return Time: " & @CRLF & "Return time should be after Pause time.")
		Sleep(3500)
		ToolTip('')
	EndIf
EndFunc   ;==>CmbReturnTime

Func ChkTrainWarTroop()
	If GUICtrlRead($g_hChkTrainWarTroop) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkUseQuickTrainWar, $GUI_ENABLE)
		chkUseQTrainWar()
	Else
		For $i = $g_hChkUseQuickTrainWar To $g_hLblCountWarSpellsTotal
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		GUICtrlSetBkColor($g_hLblCountWarTroopsTotal, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($g_hLblCountWarSpellsTotal, $COLOR_MONEYGREEN)
	EndIf
EndFunc   ;==>ChkTrainWarTroop

Func chkUseQTrainWar()
	If GUICtrlRead($g_hChkUseQuickTrainWar) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $g_ahChkArmyWar[0] & "#" & $g_ahChkArmyWar[1] & "#" & $g_ahChkArmyWar[2])
		chkQuickTrainComboWar()
		For $i = $g_hLblRemoveArmyWar To $g_hLblCountWarSpellsTotal
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		GUICtrlSetBkColor($g_hLblCountWarTroopsTotal, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($g_hLblCountWarSpellsTotal, $COLOR_MONEYGREEN)
	Else
		_GUI_Value_STATE("DISABLE", $g_ahChkArmyWar[0] & "#" & $g_ahChkArmyWar[1] & "#" & $g_ahChkArmyWar[2])
		For $i = $g_hLblRemoveArmyWar To $g_hLblCountWarSpellsTotal
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		lblTotalWarTroopCount()
		lblTotalWarSpellCount()
	EndIf
EndFunc   ;==>chkUseQTrainWar

Func chkQuickTrainComboWar()
	If GUICtrlRead($g_ahChkArmyWar[0]) = $GUI_UNCHECKED And GUICtrlRead($g_ahChkArmyWar[1]) = $GUI_UNCHECKED And GUICtrlRead($g_ahChkArmyWar[2]) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_ahChkArmyWar[0], $GUI_CHECKED)
		ToolTip("QuickTrainCombo: " & @CRLF & "At least 1 Army Check is required! Default Army 1.")
		Sleep(2000)
		ToolTip('')
	EndIf
EndFunc   ;==>chkQuickTrainComboWar

Func RemovecampWar()
	For $T = 0 To $eTroopCount - 1
		$g_aiWarCompTroops[$T] = 0
		GUICtrlSetData($g_ahTxtTrainWarTroopCount[$T], 0)
	Next
	For $S = 0 To $eSpellCount - 1
		$g_aiWarCompSpells[$S] = 0
		GUICtrlSetData($g_ahTxtTrainWarSpellCount[$S], 0)
	Next
	lblTotalWarTroopCount()
	lblTotalWarSpellCount()
EndFunc   ;==>RemovecampWar

Func lblTotalWarTroopCount($TotalArmyCamp = 0)
	Local $TotalTroopsToTrain
	If $TotalArmyCamp = 0 Then $TotalArmyCamp = $g_bTotalCampForced ? $g_iTotalCampForcedValue : 280

	For $i = 0 To $eTroopCount - 1
		Local $iCount = GUICtrlRead($g_ahTxtTrainWarTroopCount[$i])
		If $iCount > 0 Then
			$TotalTroopsToTrain += $iCount * $g_aiTroopSpace[$i]
		Else
			GUICtrlSetData($g_ahTxtTrainWarTroopCount[$i], 0)
		EndIf
	Next

	GUICtrlSetData($g_hLblCountWarTroopsTotal, String($TotalTroopsToTrain))

	If $TotalTroopsToTrain = $TotalArmyCamp Then
		GUICtrlSetBkColor($g_hLblCountWarTroopsTotal, $COLOR_MONEYGREEN)
	ElseIf $TotalTroopsToTrain > $TotalArmyCamp / 2 And $TotalTroopsToTrain < $TotalArmyCamp Then
		GUICtrlSetBkColor($g_hLblCountWarTroopsTotal, $COLOR_ORANGE)
	Else
		GUICtrlSetBkColor($g_hLblCountWarTroopsTotal, $COLOR_RED)
	EndIf

	Local $fPctOfCalculated = Floor(($TotalTroopsToTrain / $TotalArmyCamp) * 100)

	GUICtrlSetData($g_hCalTotalWarTroops, $fPctOfCalculated < 1 ? ($TotalTroopsToTrain > 0 ? 1 : 0) : $fPctOfCalculated)

	If $TotalTroopsToTrain > $TotalArmyCamp Then
		GUICtrlSetState($g_hLblTotalWarTroopsProgress, $GUI_SHOW)
	Else
		GUICtrlSetState($g_hLblTotalWarTroopsProgress, $GUI_HIDE)
	EndIf

EndFunc   ;==>lblTotalWarTroopCount

Func lblTotalWarSpellCount($TotalArmyCamp = 0 )

	Local $TotalSpellsToBrew
	If $TotalArmyCamp = 0 Then $TotalArmyCamp = $g_iTotalSpellValue > 0 ? $g_iTotalSpellValue : 11

	For $i = 0 To $eSpellCount - 1
		Local $iCount = GUICtrlRead($g_ahTxtTrainWarSpellCount[$i])
		If $iCount > 0 Then
			$TotalSpellsToBrew += $iCount * $g_aiSpellSpace[$i]
		Else
			GUICtrlSetData($g_ahTxtTrainWarSpellCount[$i], 0)
		EndIf
	Next

	GUICtrlSetData($g_hLblCountWarSpellsTotal, String($TotalSpellsToBrew))

	If $TotalSpellsToBrew = $TotalArmyCamp Then
		GUICtrlSetBkColor($g_hLblCountWarSpellsTotal, $COLOR_MONEYGREEN)
	ElseIf $TotalSpellsToBrew > $TotalArmyCamp / 2 And $TotalSpellsToBrew < $TotalArmyCamp Then
		GUICtrlSetBkColor($g_hLblCountWarSpellsTotal, $COLOR_ORANGE)
	Else
		GUICtrlSetBkColor($g_hLblCountWarSpellsTotal, $COLOR_RED)
	EndIf

	Local $fPctOfCalculated = Floor(($TotalSpellsToBrew / $TotalArmyCamp) * 100)

	GUICtrlSetData($g_hCalTotalWarSpells, $fPctOfCalculated < 1 ? ($TotalSpellsToBrew > 0 ? 1 : 0) : $fPctOfCalculated)

	If $TotalSpellsToBrew > $TotalArmyCamp Then
		GUICtrlSetState($g_hLblTotalWarSpellsProgress, $GUI_SHOW)
	Else
		GUICtrlSetState($g_hLblTotalWarSpellsProgress, $GUI_HIDE)
	EndIf

EndFunc   ;==>lblTotalWarSpellCount

Func TrainWarTroopCountEdit()
	For $i = 0 To $eTroopCount - 1
		If @GUI_CtrlId = $g_ahTxtTrainWarTroopCount[$i] Then
			$g_aiWarCompTroops[$i] = GUICtrlRead($g_ahTxtTrainWarTroopCount[$i])
			lblTotalWarTroopCount()
			Return
		EndIf
	Next
EndFunc   ;==>TrainWarTroopCountEdit

Func TrainWarSpellCountEdit()
	For $i = 0 To $eSpellCount - 1
		If @GUI_CtrlId = $g_ahTxtTrainWarSpellCount[$i] Then
			$g_aiWarCompSpells[$i] = GUICtrlRead($g_ahTxtTrainWarSpellCount[$i])
			lblTotalWarSpellCount()
			Return
		EndIf
	Next
EndFunc   ;==>TrainWarSpellCountEdit

Func ChkRequestCCForWar()
	If GUICtrlRead($g_hChkRequestCCForWar) = $GUI_CHECKED Then
		GUICtrlSetState($g_hTxtRequestCCForWar, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hTxtRequestCCForWar, $GUI_DISABLE)
	EndIf
EndFunc   ;==>ChkRequestCCForWar
