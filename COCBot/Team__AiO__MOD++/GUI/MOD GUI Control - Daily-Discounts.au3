; #FUNCTION# ====================================================================================================================
; Name ..........: MOD GUI Control - Daily Discounts
; Description ...: Control sub gui for daily discounts
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

Func btnDailyDiscounts()
	GUICtrlSetState($g_hBtnDailyDiscounts, $GUI_DISABLE)
	GUISetState(@SW_SHOW, $g_hGUI_DailyDiscounts)
EndFunc   ;==>btnDailyDiscounts

Func btnDDApply()
	GUISetState(@SW_HIDE, $g_hGUI_DailyDiscounts)
	Local $iDealsChecked = 0

	For $i = 0 To $g_iDDCount - 1
		If GUICtrlRead($g_ahChkDD_Deals[$i]) = $GUI_CHECKED Then
			$g_abChkDD_Deals[$i] = True
			$g_bDD_DealsSet = True
			$iDealsChecked += 1
		Else
			$g_abChkDD_Deals[$i] = False
		EndIf
	Next

	If $g_bDD_DealsSet And $iDealsChecked <> 0 Then
		GUICtrlSetBkColor($g_hBtnDailyDiscounts, $COLOR_GREEN)
	Else
		$g_bDD_DealsSet = False
		GUICtrlSetBkColor($g_hBtnDailyDiscounts, $COLOR_RED)
	EndIf

	GUICtrlSetState($g_hBtnDailyDiscounts, $GUI_ENABLE)
EndFunc   ;==>btnDDApply

Func btnDDClose()
	GUISetState(@SW_HIDE, $g_hGUI_DailyDiscounts)
	For $i = 0 To $g_iDDCount - 1
		If Not $g_abChkDD_Deals[$i] Then GUICtrlSetState($g_ahChkDD_Deals[$i], $GUI_UNCHECKED)
		If $g_abChkDD_Deals[$i] Then GUICtrlSetState($g_ahChkDD_Deals[$i], $GUI_CHECKED)
	Next
	GUICtrlSetState($g_hBtnDailyDiscounts, $GUI_ENABLE)
EndFunc   ;==>btnDDClose

Func btnDDClear()
	For $i = 0 To $g_iDDCount - 1
		GUICtrlSetState($g_ahChkDD_Deals[$i], $GUI_UNCHECKED)
	Next
EndFunc   ;==>btnDDClear