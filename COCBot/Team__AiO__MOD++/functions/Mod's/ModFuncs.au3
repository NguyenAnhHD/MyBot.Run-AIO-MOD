; #FUNCTION# ====================================================================================================================
; Name ..........: ModFuncs.au3
; Description ...: Avoid loss of functions during updates.
; Author ........: Boludoz (2019)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func getOcrAndCapture($language, $x_start, $y_start, $width, $height, $removeSpace = Default, $bImgLoc = Default, $bForceCaptureRegion = Default)
	$g_sGetOcrMod = ""
	If $removeSpace = Default Then $removeSpace = False
	If $bImgLoc = Default Then $bImgLoc = False
	If $bForceCaptureRegion = Default Then $bForceCaptureRegion = $g_bOcrForceCaptureRegion
    Static $_hHBitmap = 0
    If $bForceCaptureRegion = True Then
        _CaptureRegion2($x_start, $y_start, $x_start + $width, $y_start + $height)
    Else
        $_hHBitmap = GetHHBitmapArea($g_hHBitmap2, $x_start, $y_start, $x_start + $width, $y_start + $height)
    EndIf
    Local $result
    If $bImgLoc Then
		If $_hHBitmap <> 0 Then
			$result = getOcrImgLoc($_hHBitmap, $language)
		Else
			$result = getOcrImgLoc($g_hHBitmap2, $language)
		EndIf
	Else
		If $_hHBitmap <> 0 Then
			$result = getOcr($_hHBitmap, $language)
		Else
			$result = getOcr($g_hHBitmap2, $language)
		EndIf
	EndIf
	If $_hHBitmap <> 0 Then
		GdiDeleteHBitmap($_hHBitmap)
	EndIf
	$_hHBitmap = 0
	If ($removeSpace) Then
		$result = StringReplace($result, " ", "")
	Else
		$result = StringStripWS($result, BitOR($STR_STRIPLEADING, $STR_STRIPTRAILING, $STR_STRIPSPACES))
	EndIf
	$g_sGetOcrMod = $result
	Return $result
EndFunc   ;==>getOcrAndCapture
