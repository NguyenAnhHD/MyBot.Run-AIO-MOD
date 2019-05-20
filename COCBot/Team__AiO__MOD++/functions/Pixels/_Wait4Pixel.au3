; #FUNCTION# ====================================================================================================================
; Name ..........: _Wait4Pixel
; Description ...:
; Author ........: Samkie
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func MultiPSimple($iX, $iY, $iX2, $iY2, $Hex, $iTolerance = 10, $iWait = 1000, $iDelay = 100)
	Local $aReturn[2] = [0, 0]

	Local $hTimer = __TimerInit()
	While BitOr($iWait > __TimerDiff($hTimer), $iWait <= 0) ; '-1' support
	_CaptureRegion()
		For $y = $iY To $iY2 - 1
			For $x = $iX To $iX2 - 1
				If _ColorCheck(_GetPixelColor($x, $y), Hex($Hex, 6), 40) Then
				$aReturn[0] = $iX + $x
				$aReturn[1] = $iY + $y
				Return $aReturn
				EndIf
			Next
		Next
		If ($iWait <= 0) Then ExitLoop ; Loop prevention.
	WEnd

	Return 0
EndFunc   ;==>MultiPSimple

Func _Wait4Pixel($x, $y, $sColor, $iColorVariation, $iWait = 1000, $iDelay = 100, $sMsglog = Default) ; Return true if pixel is true
	Local $hTimer = __TimerInit()
	While BitOr($iWait > __TimerDiff($hTimer), $iWait <= 0) ; '-1' support
		ForceCaptureRegion()
		If _CheckColorPixel($x, $y, $sColor, $iColorVariation, True, $sMsglog) Then Return True
		If _Sleep($iDelay) Then Return False
		If ($iWait <= 0) Then ExitLoop ; Loop prevention.
	WEnd
	Return False
EndFunc   ;==>_Wait4Pixel

Func _Wait4PixelGone($x, $y, $sColor, $iColorVariation, $iWait = 1000, $iDelay = 100, $sMsglog = Default) ; Return true if pixel is false
	Local $hTimer = __TimerInit()
	While BitOr($iWait > __TimerDiff($hTimer), ($iWait <= 0)) ; '-1' support
		ForceCaptureRegion()
		If Not _CheckColorPixel($x, $y, $sColor, $iColorVariation, True, $sMsglog) Then Return True ; diff
		If _Sleep($iDelay) Then Return False
		If ($iWait <= 0) Then ExitLoop ; Loop prevention.
	WEnd
	Return False
EndFunc   ;==>_Wait4PixelGone

Func _CheckColorPixel($x, $y, $sColor, $iColorVariation, $bFCapture = True, $sMsglog = Default)
	Local $hPixelColor = _GetPixelColor2($x, $y, $bFCapture)
	Local $bFound = _ColorCheck($hPixelColor, Hex($sColor,6), Int($iColorVariation))
	#cs - Fast
	Local $COLORMSG = ($bFound = True ? $COLOR_BLUE : $COLOR_RED)
	If $sMsglog <> Default And IsString($sMsglog) Then
		Local $String = $sMsglog & " - Ori Color: " & Hex($sColor,6) & " at X,Y: " & $x & "," & $y & " Found: " & $hPixelColor
		SetDebugLog($String, $COLORMSG)
	EndIf
	#ce
	Return $bFound
EndFunc   ;==>_GetPixelColor

Func _GetPixelColor2($iX, $iY, $bNeedCapture = False)
	Local $aPixelColor = 0
	If $bNeedCapture = False Or $g_bRunState = False Then
		$aPixelColor = _GDIPlus_BitmapGetPixel($g_hBitmap, $iX, $iY)
	Else
		_CaptureRegion($iX - 1, $iY - 1, $iX + 1, $iY + 1)
		$aPixelColor = _GDIPlus_BitmapGetPixel($g_hBitmap, 1, 1)
	EndIf
	Return Hex($aPixelColor, 6)
EndFunc   ;==>_GetPixelColor2
