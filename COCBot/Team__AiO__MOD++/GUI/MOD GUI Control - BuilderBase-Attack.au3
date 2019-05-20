; #FUNCTION# ====================================================================================================================
; Name ..........: MOD GUI Control - BuilderBase Attack
; Description ...: Control sub gui for BB tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Chilly-Chill 2019
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func chkEnableBBAttack()
	If GUICtrlRead($g_hChkEnableBBAttack) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkBBTrophyRange, $GUI_ENABLE)
		GUICtrlSetState($g_hChkBBAttIfLootAvail, $GUI_ENABLE)
		GUICtrlSetState($g_hChkBBWaitForMachine, $GUI_ENABLE)
		GUICtrlSetState($g_hBtnBBDropOrder, $GUI_ENABLE)
		chkBBTrophyRange()
	Else
		GUICtrlSetState($g_hChkBBTrophyRange, $GUI_DISABLE)
		GUICtrlSetState($g_hChkBBAttIfLootAvail, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtBBTrophyLowerLimit, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtBBTrophyUpperLimit, $GUI_DISABLE)
		GUICtrlSetState($g_hChkBBWaitForMachine, $GUI_DISABLE)
		GUICtrlSetState($g_hBtnBBDropOrder, $GUI_DISABLE)
	EndIf
EndFunc

Func chkBBTrophyRange()
	If GUICtrlRead($g_hChkBBTrophyRange) = $GUI_CHECKED Then
		GUICtrlSetState($g_hTxtBBTrophyLowerLimit, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtBBTrophyUpperLimit, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hTxtBBTrophyLowerLimit, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtBBTrophyUpperLimit, $GUI_DISABLE)
	EndIf
EndFunc

Func btnBBDropOrder()
	GUICtrlSetState( $g_hBtnBBDropOrder, $GUI_DISABLE )
	GUICtrlSetState( $g_hChkEnableBBAttack, $GUI_DISABLE )
	GUISetState(@SW_SHOW, $g_hGUI_BBDropOrder)
EndFunc

Func chkBBDropOrder()
	If GUICtrlRead($g_hChkBBCustomDropOrderEnable) = $GUI_CHECKED Then
		GUICtrlSetState($g_hBtnBBDropOrderSet, $GUI_ENABLE)
		GUICtrlSetState($g_hBtnBBRemoveDropOrder, $GUI_ENABLE)
		For $i = 0 To $g_iBBTroopCount - 1
			GUICtrlSetState($g_ahCmbBBDropOrder[$i], $GUI_ENABLE)
		Next
	Else
		GUICtrlSetState($g_hBtnBBDropOrderSet, $GUI_DISABLE)
		GUICtrlSetState($g_hBtnBBRemoveDropOrder, $GUI_DISABLE)
		For $i = 0 To $g_iBBTroopCount - 1
			GUICtrlSetState($g_ahCmbBBDropOrder[$i], $GUI_DISABLE)
		Next
		GUICtrlSetBkColor($g_hBtnBBDropOrder, $COLOR_RED)
		$g_bBBDropOrderSet = False
	EndIf
EndFunc

Func GUIBBDropOrder()
	Local $iGUI_CtrlId = @GUI_CtrlId
	Local $iDropIndex = _GUICtrlComboBox_GetCurSel($iGUI_CtrlId)

	For $i = 0 To $g_iBBTroopCount - 1
		If $iGUI_CtrlId = $g_ahCmbBBDropOrder[$i] Then ContinueLoop
		If $iDropIndex = _GUICtrlComboBox_GetCurSel($g_ahCmbBBDropOrder[$i]) Then
			_GUICtrlComboBox_SetCurSel($g_ahCmbBBDropOrder[$i], -1)
			GUISetState()
		EndIf
	Next
EndFunc

Func btnBBDropOrderSet()
	$g_sBBDropOrder = ""
	; loop through reading and disabling all combo boxes
	For $i = 0 To $g_iBBTroopCount - 1
		GUICtrlSetState($g_ahCmbBBDropOrder[$i], $GUI_DISABLE)
		If GUICtrlRead($g_ahCmbBBDropOrder[$i]) = "" Then ; if not picked assign from default list in order
			Local $asDefaultOrderSplit = StringSplit($g_sBBDropOrderDefault, "|")
			Local $bFound = False, $bSet = False
			Local $j = 0
			While $j < $g_iBBTroopCount And Not $bSet ; loop through troops
				Local $k = 0
				While $k < $g_iBBTroopCount And Not $bFound ; loop through handles
					If $g_ahCmbBBDropOrder[$i] <> $g_ahCmbBBDropOrder[$k] Then
						SetDebugLog("Word: " & $asDefaultOrderSplit[$j+1] & " " & " Word in slot: " & GUICtrlRead($g_ahCmbBBDropOrder[$k]))
						If $asDefaultOrderSplit[$j+1] = GUICtrlRead($g_ahCmbBBDropOrder[$k]) Then $bFound = True
					EndIf
					$k += 1
				WEnd
				If Not $bFound Then
					_GUICtrlComboBox_SetCurSel($g_ahCmbBBDropOrder[$i], $j)
					$bSet = True
				Else
					$j += 1
					$bFound = False
				EndIf
			WEnd
		EndIf
		$g_sBBDropOrder &= (GUICtrlRead($g_ahCmbBBDropOrder[$i]) & "|")
		SetDebugLog("DropOrder: " & $g_sBBDropOrder)
	Next
	$g_sBBDropOrder = StringTrimRight($g_sBBDropOrder, 1) ; Remove last '|'
	GUICtrlSetBkColor($g_hBtnBBDropOrder, $COLOR_GREEN)
	$g_bBBDropOrderSet = True
EndFunc

Func btnBBRemoveDropOrder()
	For $i = 0 To $g_iBBTroopCount-1
		_GUICtrlComboBox_SetCurSel($g_ahCmbBBDropOrder[$i], -1)
		GUICtrlSetState($g_ahCmbBBDropOrder[$i], $GUI_ENABLE)
	Next
	GUICtrlSetBkColor($g_hBtnBBDropOrder, $COLOR_RED)
	$g_bBBDropOrderSet = False
EndFunc

Func CloseCustomBBDropOrder()
	GUISetState(@SW_HIDE, $g_hGUI_BBDropOrder)
	GUICtrlSetState($g_hBtnBBDropOrder, $GUI_ENABLE)
	GUICtrlSetState( $g_hChkEnableBBAttack, $GUI_ENABLE )
EndFunc