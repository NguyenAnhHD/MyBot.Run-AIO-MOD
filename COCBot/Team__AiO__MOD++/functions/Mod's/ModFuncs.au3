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

Func _MultiPixelSearchMod($iLeft, $iTop, $iRight, $iBottom, $xSkip, $ySkip, $firstColor, $offColor, $iColorVariation)

	Local $aTmp = _MultiPixelSearch($iLeft, $iTop, $iRight, $iBottom, $xSkip, $ySkip, $firstColor, $offColor, $iColorVariation)
	
	If $aTmp <> 0 Then
		$g_iMultiPixelOffSet[0] = $aTmp[0]
		$g_iMultiPixelOffSet[1] = $aTmp[1]
	   
		Return $g_iMultiPixelOffSet
	Else
		$g_iMultiPixelOffSet[0] = Null
		$g_iMultiPixelOffSet[1] = Null
		
		Return 0
	EndIf

EndFunc   ;==>_MultiPixelSearchMod

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

Func _ImageSearchXML($sDirectory, $Quantity2Match = 0, $saiArea2SearchOri = "0,0,860,732", $bForceCapture = True, $DebugLog = False, $checkDuplicatedpoints = False, $Distance2check = 25, $iLevel = 0)
	$g_aImageSearchXML = -1

	Local $iMax = 0

	Local $sSearchDiamond = GetDiamondFromRect($saiArea2SearchOri)
	Local $aResult = findMultiple($sDirectory , $sSearchDiamond, $sSearchDiamond, $iLevel, 1000, $Quantity2Match, "objectname,objectlevel,objectpoints", $bForceCapture)
	If Not IsArray($aResult) Then Return -1

	Local $iCount = 0

	$iMax = UBound($aResult) -1

	; Compatible with BuilderBaseBuildingsDetection()[old function] same return array
	; Result [X][0] = NAME , [x][1] = Xaxis , [x][2] = Yaxis , [x][3] = Level
	Local $AllResults[0][4]

	Local $aArrays = "", $aCoords, $aCommaCoord

	For $i = 0 To $iMax
		$aArrays = $aResult[$i] ; should be return objectname,objectpoints,objectlevel
		$aCoords = StringSplit($aArrays[2], "|", 2)
		For $iCoords = 0 To UBound($aCoords) -1
			$aCommaCoord = StringSplit($aCoords[$iCoords], ",", 2)
			; Inspired in Chilly-chill
			Local $aTmpResults[1][4] = [[$aArrays[0], Int($aCommaCoord[0]), Int($aCommaCoord[1]), Int($aArrays[1])]]
			_ArrayAdd($AllResults, $aTmpResults)
		Next
		$iCount += 1
	Next
	If $iCount < 1 Then Return -1

	If $checkDuplicatedpoints And UBound($AllResults) > 0 Then
		; Sort by X axis
		_ArraySort($AllResults, 0, 0, 0, 1)

		; Distance in pixels to check if is a duplicated detection , for deploy point will be 5
		Local $D2Check = $Distance2check

		; check if is a double Detection, near in 10px
		Local $Dime = 0
		For $i = 0 To UBound($AllResults) - 1
			If $i > UBound($AllResults) - 1 Then ExitLoop
			Local $LastCoordinate[4] = [$AllResults[$i][0], $AllResults[$i][1], $AllResults[$i][2], $AllResults[$i][3]]
			SetDebugLog("Coordinate to Check: " & _ArrayToString($LastCoordinate))
			If UBound($AllResults) > 1 Then
				For $j = 0 To UBound($AllResults) - 1
					If $j > UBound($AllResults) - 1 Then ExitLoop
					; SetDebugLog("$j: " & $j)
					; SetDebugLog("UBound($aAllResults) -1: " & UBound($aAllResults) - 1)
					Local $SingleCoordinate[4] = [$AllResults[$j][0], $AllResults[$j][1], $AllResults[$j][2], $AllResults[$j][3]]
					; SetDebugLog(" - Comparing with: " & _ArrayToString($SingleCoordinate))
					If $LastCoordinate[1] <> $SingleCoordinate[1] Or $LastCoordinate[2] <> $SingleCoordinate[2] Then
						If $SingleCoordinate[1] < $LastCoordinate[1] + $D2Check And $SingleCoordinate[1] > $LastCoordinate[1] - $D2Check Then
							; SetDebugLog(" - removed : " & _ArrayToString($SingleCoordinate))
							_ArrayDelete($AllResults, $j)
						EndIf
					Else
						If $LastCoordinate[1] = $SingleCoordinate[1] And $LastCoordinate[2] = $SingleCoordinate[2] And $LastCoordinate[3] <> $SingleCoordinate[3] Then
							; SetDebugLog(" - removed equal level : " & _ArrayToString($SingleCoordinate))
							_ArrayDelete($AllResults, $j)
						EndIf
					EndIf
				Next
			EndIf
		Next
	EndIf

	If (UBound($AllResults) > 0) Then
	;_ArrayDisplay($AllResults)
		$g_aImageSearchXML = $AllResults
		Return $AllResults
	Else
		$g_aImageSearchXML = -1
		Return -1
	EndIf
EndFunc
