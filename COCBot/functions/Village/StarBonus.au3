
; #FUNCTION# ====================================================================================================================
; Name ..........: StarBonus
; Description ...: Checks for Star bonus window, and clicks ok to close window.
; Syntax ........: StarBonus()
; Parameters ....:
; Return values .: MonkeyHunter(2016-1)
; Modified ......: MonkeyHunter (05-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func StarBonus()

	If $g_bDebugSetlog Then SetDebugLog("Begin Star Bonus window check", $COLOR_DEBUG1)

	; Verify is Star bonus window open?
	If _CheckPixel($aIsMainGrayed, $g_bCapturePixel, Default, "IsMainGrayed") = False Then Return ; Star bonus window opens on main base view, and grays page.

	Local $aWindowChk1[4] = [640, 184 + $g_iMidOffsetY, 0xCD1A1F, 15] ; Red X to close Window
	Local $aWindowChk2[4] = [650, 462 + $g_iBottomOffsetY, 0xE8E8E0, 10] ; White pixel on top trees where it does not belong

	If _Sleep($DELAYSTARBONUS100) Then Return

	; Verify actual star bonus window open
	If _CheckPixel($aWindowChk1, $g_bCapturePixel, Default, "Starbonus1") And _CheckPixel($aWindowChk2, $g_bCapturePixel, Default, "Starbonus2") Then
		; Find and Click Okay button
		Local $offColors[3][3] = [[0x1E1E1E, 139, 0], [0xFFFFFF, 53, 20], [0xDEF885, 53, 10]] ; 2nd Black opposite button, 3rd pixel White "O" center top, 4th pixel Green "0" bottom left side
		Local $ButtonPixel = _MultiPixelSearch(352, 438 + $g_iMidOffsetY, 501, 474 + $g_iMidOffsetY, 1, 1, Hex(0x373737, 6), $offColors, 20) ; first vertical black pixel of Okay
		If $g_bDebugSetlog Then SetDebugLog("Okay btn chk-#1: " & _GetPixelColor(352, 442 + $g_iMidOffsetY, $g_bCapturePixel) & ", #2: " & _GetPixelColor(352 + 139, 438 + $g_iMidOffsetY, $g_bCapturePixel) & ", #3: " & _GetPixelColor(352 + 53, 438 + 20 + $g_iMidOffsetY, $g_bCapturePixel) & ", #4: " & _GetPixelColor(352 + 53, 438 + 10 + $g_iMidOffsetY, $g_bCapturePixel), $COLOR_DEBUG)
		If IsArray($ButtonPixel) Then
			If $g_bDebugSetlog Then
				SetDebugLog("ButtonPixelLocation = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG) ;Debug
				SetDebugLog("Pixel color found #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], $g_bCapturePixel) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 139, $ButtonPixel[1], $g_bCapturePixel) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 53, $ButtonPixel[1] + 20, $g_bCapturePixel) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 53, $ButtonPixel[1] + 10, $g_bCapturePixel), $COLOR_DEBUG)
			EndIf
			Click($ButtonPixel[0] + 75, $ButtonPixel[1] + 25, 2, 50, "#0117") ; Click Okay Button
			If _Sleep($DELAYSTARBONUS500) Then Return
			Return True
		EndIf
	EndIf

	If $g_bDebugSetlog Then SetDebugLog("Star Bonus window not found?", $COLOR_DEBUG)
	Return False

EndFunc   ;==>StarBonus
