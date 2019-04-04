; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control MOD
; Description ...: This file controls the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; Request CC for defense - Team AiO MOD++
Func chkRequestCCDefense()
	If GUICtrlRead($g_hChkRequestCCDefense) = $GUI_CHECKED Then
		For $i = $g_hTxtRequestCCDefense To $g_ahCmbCCTroopDefense[2]
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		chkSaveCCTroopForDefense()
		GUIToggle_RequestOnlyDuringHours(True)
	Else
		For $i = $g_hTxtRequestCCDefense To $g_ahCmbCCTroopDefense[2]
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		If GUICtrlRead($g_hChkRequestTroopsEnable) = $GUI_UNCHECKED Then GUIToggle_RequestOnlyDuringHours(False)
	EndIf
EndFunc   ;==>chkRequestCCDefense

Func chkSaveCCTroopForDefense()
	If GUICtrlRead($g_hChkSaveCCTroopForDefense) = $GUI_CHECKED Then
		For $i = $g_ahTxtCCTroopDefense[0] To $g_ahCmbCCTroopDefense[2]
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		cmbCCTroopDefense()
	Else
		For $i = $g_ahTxtCCTroopDefense[0] To $g_ahCmbCCTroopDefense[2]
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	EndIf
EndFunc   ;==>chkSaveCCTroopForDefense

Func cmbCCTroopDefense()
	For $i = 0 To UBound($g_ahCmbCCTroopDefense) - 1
		If _GUICtrlComboBox_GetCurSel($g_ahCmbCCTroopDefense[$i]) < $eTroopCount Then
			GUICtrlSetState($g_ahTxtCCTroopDefense[$i], $GUI_ENABLE)
		Else
			GUICtrlSetState($g_ahTxtCCTroopDefense[$i], $GUI_DISABLE)
		EndIf
	Next
EndFunc   ;==>cmbCCTroopDefense

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
			$g_bChkAutoDock = True
			$g_bChkAutoHideEmulator = False
		ElseIf GUICtrlRead($g_hChkAutoHideEmulator) = $GUI_CHECKED Then
			$g_bChkAutoDock = False
			$g_bChkAutoHideEmulator = True
		EndIf
	Else
		$g_bChkAutoDock = False
		$g_bChkAutoHideEmulator = False
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

Func cmbStandardDropSidesDB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesDB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaDB()
EndFunc   ;==>g_hCmbStandardDropSidesDB
