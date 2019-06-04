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

; #FUNCTION# ====================================================================================================================
; Name ..........: MultiPSimple
; Description ...:
; Author ........: Boludoz
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func MultiPSimple($iLeft, $iTop, $iRight, $iBottom, $Hex, $iTolerance = 10, $iWait = 1000, $iDelay = 100)
	Local $aReturn[2] = [0, 0]

	Local $hTimer = __TimerInit()
	While BitOr($iWait > __TimerDiff($hTimer), $iWait <= 0) ; '-1' support
	If _Sleep($iDelay) Then Return False
	_CaptureRegion($iLeft, $iTop, $iRight, $iBottom)
	Local $xRange = $iRight - $iLeft
	Local $yRange = $iBottom - $iTop

		For $x = 0 To $xRange
			For $y = 0 To $yRange
				If _ColorCheck(_GetPixelColor($x, $y), $Hex, $iTolerance) Then
					$aReturn[0] = $x + $iLeft
					$aReturn[1] = $y + $iTop
					Return $aReturn
				EndIf
			Next
		Next
		If ($iWait <= 0) Then ExitLoop ; Loop prevention.
	WEnd

	Return 0
EndFunc   ;==>MultiPSimple

Func _WaitForCheckXML($pathImage, $SearchZone, $ForceArea = True, $iWait = 10000, $iDelay = 250)
    Local $hTimer = __TimerInit()
    While BitOr($iWait > __TimerDiff($hTimer), $iWait <= 0) ; '-1' support
    Local $aRetutn = _ImageSearchXML($pathImage, 1000, $SearchZone)
        If (UBound($aRetutn) > 0) Then Return True
        If _Sleep($iDelay) Then Return False
        If ($iWait <= 0) Then ExitLoop ; Loop prevention.
    WEnd
    Return False
EndFunc   ;==>_WaitForCheckXML