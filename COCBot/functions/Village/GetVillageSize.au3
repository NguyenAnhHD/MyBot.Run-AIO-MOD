; #FUNCTION# ====================================================================================================================
; Name ..........: GetVillageSize
; Description ...: Measures the size of village. After CoC October 2016 update, max'ed zoomed out village is 440 (reference!)
;                  But usually sizes around 470 - 490 pixels are measured due to lock on max zoom out.
; Syntax ........: GetVillageSize()
; Parameters ....:
; Return values .: 0 if not identified or Array with index
;                      0 = Size of village (float)
;                      1 = Zoom factor based on 440 village size (float)
;                      2 = X offset of village center (int)
;                      3 = Y offset of village center (int)
;                      4 = X coordinate of stone
;                      5 = Y coordinate of stone
;                      6 = stone image file name
;                      7 = X coordinate of tree
;                      8 = Y coordinate of tree
;                      9 = tree image file name
; Author ........: Cosote (Oct 17th 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func GetVillageSize($DebugLog = False, $sStonePrefix = Default, $sTreePrefix = Default)

	If $sStonePrefix = Default Then $sStonePrefix = "stone"
	If $sTreePrefix = Default Then $sTreePrefix = "tree"

	Local $aResult = 0
	Local $sDirectory
	Local $stone[6] = [0, 0, 0, 0, 0, ""], $tree[6] = [0, 0, 0, 0, 0, ""]
	Local $x0, $y0, $d0, $x, $y, $x1, $y1, $right, $bottom, $a

	Local $iAdditionalY = 75
	Local $iAdditionalX = 100

	If isOnBuilderBase(True) Then
		$sDirectory = $g_sImgZoomOutDirBB
	Else
		$sDirectory = $g_sImgZoomOutDir
	EndIf

	Local $aStoneFiles = _FileListToArray($sDirectory, $sStonePrefix & "*.*", $FLTA_FILES)
	If @error Then
		SetLog("Error: Missing stone files (" & @error & ")", $COLOR_ERROR)
		Return $aResult
	EndIf
	; use stoneBlueStacks2A stones first
	Local $iNewIdx = 1
	For $i = 1 To $aStoneFiles[0]
		If StringInStr($aStoneFiles[$i], "stoneBlueStacks2A") = 1 Then
			Local $s = $aStoneFiles[$iNewIdx]
			$aStoneFiles[$iNewIdx] = $aStoneFiles[$i]
			$aStoneFiles[$i] = $s
			$iNewIdx += 1
		EndIf
	Next
	Local $aTreeFiles = _FileListToArray($sDirectory, $sTreePrefix & "*.*", $FLTA_FILES)
	If @error Then
		SetLog("Error: Missing tree (" & @error & ")", $COLOR_ERROR)
		Return $aResult
	EndIf
	Local $i, $findImage, $sArea, $a

	For $i = 1 To $aStoneFiles[0]
		$findImage = $aStoneFiles[$i]
		$a = StringRegExp($findImage, ".*-(\d+)-(\d+)-(\d*,*\d+)_.*[.](xml|png|bmp)$", $STR_REGEXPARRAYMATCH)
		If UBound($a) = 4 Then

			$x0 = $a[0]
			$y0 = $a[1]
			$d0 = StringReplace($a[2], ",", ".")

			$x1 = $x0 - $iAdditionalX
			$y1 = $y0 - $iAdditionalY
			$right = $x0 + $iAdditionalX
			$bottom = $y0 + $iAdditionalY
			$sArea = Int($x1) & "," & Int($y1) & "|" & Int($right) & "," & Int($y1) & "|" & Int($right) & "," & Int($bottom) & "|" & Int($x1) & "," & Int($bottom)
			;SetDebugLog("GetVillageSize check for image " & $findImage)
			$a = decodeSingleCoord(findImage($findImage, $sDirectory & $findImage, $sArea, 1, True))
			If UBound($a) = 2 Then
				$x = Int($a[0])
				$y = Int($a[1])
				;SetDebugLog("Found stone image at " & $x & ", " & $y & ": " & $findImage)
				$stone[0] = $x ; x center of stone found
				$stone[1] = $y ; y center of stone found
				$stone[2] = $x0 ; x ref. center of stone
				$stone[3] = $y0 ; y ref. center of stone
				$stone[4] = $d0 ; distance to village map in pixel
				$stone[5] = $findImage
				ExitLoop
			EndIf

		Else
			;SetDebugLog("GetVillageSize ignore image " & $findImage & ", reason: " & UBound($a), $COLOR_WARNING)
		EndIf
	Next

	If $stone[0] = 0 Then
		SetDebugLog("GetVillageSize cannot find stone", $COLOR_WARNING)
		Return $aResult
	EndIf

	For $i = 1 To $aTreeFiles[0]
		$findImage = $aTreeFiles[$i]
		$a = StringRegExp($findImage, ".*-(\d+)-(\d+)-(\d*,*\d+)_.*[.](xml|png|bmp)$", $STR_REGEXPARRAYMATCH)
		If UBound($a) = 4 Then

			$x0 = $a[0]
			$y0 = $a[1]
			$d0 = StringReplace($a[2], ",", ".")

			$x1 = $x0 - $iAdditionalX
			$y1 = $y0 - $iAdditionalY
			$right = $x0 + $iAdditionalX
			$bottom = $y0 + $iAdditionalY
			$sArea = Int($x1) & "," & Int($y1) & "|" & Int($right) & "," & Int($y1) & "|" & Int($right) & "," & Int($bottom) & "|" & Int($x1) & "," & Int($bottom)
			;SetDebugLog("GetVillageSize check for image " & $findImage)
			$a = decodeSingleCoord(findImage($findImage, $sDirectory & "\" & $findImage, $sArea, 1, False))
			If UBound($a) = 2 Then
				$x = Int($a[0])
				$y = Int($a[1])
				;SetDebugLog("Found tree image at " & $x & ", " & $y & ": " & $findImage)
				$tree[0] = $x ; x center of tree found
				$tree[1] = $y ; y center of tree found
				$tree[2] = $x0 ; x ref. center of tree
				$tree[3] = $y0 ; y ref. center of tree
				$tree[4] = $d0 ; distance to village map in pixel
				$tree[5] = $findImage
				ExitLoop
			EndIf

		Else
			;SetDebugLog("GetVillageSize ignore image " & $findImage & ", reason: " & UBound($a), $COLOR_WARNING)
		EndIf
	Next

	If $tree[0] = 0 Then
		SetDebugLog("GetVillageSize cannot find tree", $COLOR_WARNING)
		Return $aResult
	EndIf

	; calculate village size, see https://en.wikipedia.org/wiki/Pythagorean_theorem
	Local $a = $tree[0] - $stone[0]
	Local $b = $stone[1] - $tree[1]
	Local $c = Sqrt($a * $a + $b * $b) - $stone[4] - $tree[4]


	; initial reference village had a width of 473.60282919315 (and not 440) and stone located at 226, 567, so center on that reference and used zoom factor on that size
	;Local $z = $c / 473.60282919315 ; don't use size of 440, as beta already using reference village
	Local $z = $c / 458 ; 2019-01-02 Update village measuring as outer edges didn't align anymore

	Local $stone_x_exp = $stone[2]
	Local $stone_y_exp = $stone[3]
	ConvertVillagePos($stone_x_exp, $stone_y_exp, $z) ; expected x, y position of stone
	$x = $stone[0] - $stone_x_exp
	$y = $stone[1] - $stone_y_exp

	If $DebugLog Then SetDebugLog("GetVillageSize measured: " & $c & ", Zoom factor: " & $z & ", Offset: " & $x & ", " & $y, $COLOR_INFO)

	Dim $aResult[10]
	$aResult[0] = $c
	$aResult[1] = $z
	$aResult[2] = $x
	$aResult[4] = $stone[0]
	$aResult[3] = $y
	$aResult[5] = $stone[1]
	$aResult[6] = $stone[5]
	$aResult[7] = $tree[0]
	$aResult[8] = $tree[1]
	$aResult[9] = $tree[5]
	Return $aResult
EndFunc   ;==>GetVillageSize

Func UpdateGlobalVillageOffset($x, $y)

	Local $updated = False

	If $g_sImglocRedline <> "" Then

		Local $newReadLine = ""
		Local $aPoints = StringSplit($g_sImglocRedline, "|", $STR_NOCOUNT)

		For $sPoint In $aPoints

			Local $aPoint = GetPixel($sPoint, ",")
			$aPoint[0] += $x
			$aPoint[1] += $y

			If StringLen($newReadLine) > 0 Then $newReadLine &= "|"
			$newReadLine &= ($aPoint[0] & "," & $aPoint[1])

		Next

		; set updated red line
		$g_sImglocRedline = $newReadLine

		$updated = True
	EndIf

	If $g_aiTownHallDetails[0] <> 0 And $g_aiTownHallDetails[1] <> 0 Then
		$g_aiTownHallDetails[0] += $x
		$g_aiTownHallDetails[1] += $y
		$updated = True
	EndIf
	If $g_iTHx <> 0 And $g_iTHy <> 0 Then
		$g_iTHx += $x
		$g_iTHy += $y
		$updated = True
	EndIf

	ConvertInternalExternArea()

	Return $updated

EndFunc   ;==>UpdateGlobalVillageOffset
