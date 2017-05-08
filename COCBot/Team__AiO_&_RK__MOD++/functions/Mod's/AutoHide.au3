; #FUNCTION# ====================================================================================================================
; Name ..........: AutoHide
; Description ...: This file contains all functions of AutoHide feature
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: NguyenAnhHD
; Modified ......: 03/09/2016
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......:  =====================================================================================================================
#include-once

Func AutoHide()
	If $ichkAutoHide = 1 Then
		SetLog("Bot Auto Hide in " & $ichkAutoHideDelay & " seconds", $COLOR_ERROR)
		FlushGuiLog($g_hTxtLog, $g_oTxtLogInitText, True)
		Sleep($ichkAutoHideDelay * 1000)
		btnHide()
	EndIf
EndFunc   ;==>AutoHide
