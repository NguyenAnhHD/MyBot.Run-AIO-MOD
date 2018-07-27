; #FUNCTION# ====================================================================================================================
; Name ..........: QuickMIS
; Description ...: A function to easily use ImgLoc, without headache :P !!!
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: RoroTiti
; Modified ......: ---
; Remarks .......: This file is part of MyBotRun. Copyright 2017
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......: ---
;================================================================================================================================

Func QuickMIS($ValueReturned, $directory, $Left = 0, $Top = 0, $Right = $g_iGAME_WIDTH, $Bottom = $g_iGAME_HEIGHT, $bNeedCapture = True, $Debug = False, $OcrDecode = 3, $OcrSpace = 12)
	If ($ValueReturned <> "BC1") And ($ValueReturned <> "CX") And ($ValueReturned <> "N1") And ($ValueReturned <> "NX") And ($ValueReturned <> "Q1") And ($ValueReturned <> "QX") And ($ValueReturned <> "OCR") Then
		SetLog("Bad parameters during QuickMIS call for MultiSearch...", $COLOR_RED)
		Return
	EndIf

	If $bNeedCapture Then _CaptureRegion2($Left, $Top, $Right, $Bottom)
	Local $Res = DllCallMyBot("SearchMultipleTilesBetweenLevels", "handle", $g_hHBitmap2, "str", $directory, "str", "FV", "Int", 0, "str", "FV", "Int", 0, "Int", 1000)
	If @error Then _logErrorDLLCall($g_sLibMyBotPath, @error)
	If $g_bDebugImageSave Then DebugImageSave("QuickMIS_" & $ValueReturned, False)

	If IsArray($Res) Then
		;If $Debug Then _ArrayDisplay($Res)
		If $g_bDebugSetlog Then SetDebugLog("DLL Call succeeded " & $Res[0], $COLOR_PURPLE)

		If $Res[0] = "" Or $Res[0] = "0" Then
			If $g_bDebugSetlog Then SetDebugLog("No Button found")
			Switch $ValueReturned
				Case "BC1"
					Return False
				Case "CX"
					Return -1
				Case "N1"
					Return "none"
				Case "NX"
					Return "none"
				Case "Q1"
					Return 0
				Case "QX"
					Return 0
				Case "OCR"
					Return "none"
			EndSwitch

		ElseIf StringInStr($Res[0], "-1") <> 0 Then
			SetLog("DLL Error", $COLOR_RED)

		Else
			Switch $ValueReturned

				Case "BC1" ; coordinates of first/one image found + boolean value

					Local $Result = "" , $Name = ""
					Local $KeyValue = StringSplit($Res[0], "|", $STR_NOCOUNT)
					For $i = 0 To UBound($KeyValue) - 1
						Local $DLLRes = DllCallMyBot("GetProperty", "str", $KeyValue[$i], "str", "objectpoints")
						$Result &= $DLLRes[0] & "|"
					Next
					If StringRight($Result, 1) = "|" Then $Result = StringLeft($Result, (StringLen($Result) - 1))
					Local $aCords = decodeMultipleCoords($Result, 60, 10, 1)
					Local $aCord = $aCords[0] ; sorted by Y
					$g_iQuickMISX = $aCord[0]
					$g_iQuickMISY = $aCord[1]

					$Name = RetrieveImglocProperty($KeyValue[0], "objectname")

					If $g_bDebugSetlog Or $Debug Then
						SetDebugLog($ValueReturned & " Found: " & $Result & ", using " & $g_iQuickMISX & "," & $g_iQuickMISY, $COLOR_PURPLE)
						If $g_bDebugImageSave Then DebugQuickMIS($Left, $Top, "BC1_detected[" & $Name & "_" & $g_iQuickMISX + $Left & "x" & $g_iQuickMISY + $Top & "]")
					EndIf

					Return True

				Case "CX" ; coordinates of each image found - eg: $Array[0] = [X1, Y1] ; $Array[1] = [X2, Y2]

					Local $Result = ""
					Local $KeyValue = StringSplit($Res[0], "|", $STR_NOCOUNT)
					For $i = 0 To UBound($KeyValue) - 1
						Local $DLLRes = DllCallMyBot("GetProperty", "str", $KeyValue[$i], "str", "objectpoints")
						$Result &= $DLLRes[0] & "|"
					Next
					If StringRight($Result, 1) = "|" Then $Result = StringLeft($Result, (StringLen($Result) - 1))
					If $g_bDebugSetlog Then SetDebugLog($ValueReturned & " Found: " & $Result, $COLOR_PURPLE)
					Local $CoordsInArray = StringSplit($Result, "|", $STR_NOCOUNT)
					Return $CoordsInArray

				Case "N1" ; name of first file found

					Local $MultiImageSearchResult = StringSplit($Res[0], "|")
					Local $FilenameFound = StringSplit($MultiImageSearchResult[1], "_")
					Return $FilenameFound[1]

				Case "NX" ; names of all files found

					Local $AllFilenamesFound = ""
					Local $MultiImageSearchResult = StringSplit($Res[0], "|")
					For $i = 1 To $MultiImageSearchResult[0]
						Local $FilenameFound = StringSplit($MultiImageSearchResult[$i], "_")
						$AllFilenamesFound &= $FilenameFound[1] & "|"
					Next
					If StringRight($AllFilenamesFound, 1) = "|" Then $AllFilenamesFound = StringLeft($AllFilenamesFound, (StringLen($AllFilenamesFound) - 1))
					Return $AllFilenamesFound

				Case "Q1" ; quantity of first/one tiles found

					Local $Result = ""
					Local $KeyValue = StringSplit($Res[0], "|", $STR_NOCOUNT)
					For $i = 0 To UBound($KeyValue) - 1
						Local $DLLRes = DllCallMyBot("GetProperty", "str", $KeyValue[$i], "str", "totalobjects")
						$Result &= $DLLRes[0] & "|"
					Next
					If StringRight($Result, 1) = "|" Then $Result = StringLeft($Result, (StringLen($Result) - 1))
					If $g_bDebugSetlog Then SetDebugLog($ValueReturned & " Found: " & $Result, $COLOR_PURPLE)
					Local $QuantityInArray = StringSplit($Result, "|", $STR_NOCOUNT)
					Return $QuantityInArray[0]

				Case "QX" ; quantity of files found

					Local $MultiImageSearchResult = StringSplit($Res[0], "|", $STR_NOCOUNT)
					Return UBound($MultiImageSearchResult)

				Case "OCR" ; Names of all files found, put together as a string in accordance with their coordinates left - right

					Local $sOCRString = ""
					Local $aResults[1][2] = [[-1, ""]] ; X_Coord & Name

					Local $KeyValue = StringSplit($Res[0], "|", $STR_NOCOUNT)
					For $i = 0 To UBound($KeyValue) - 1
						Local $DLLRes = DllCallMyBot("GetProperty", "str", $KeyValue[$i], "str", "objectpoints")
						Local $Name = RetrieveImglocProperty($KeyValue[$i], "objectname")

						Local $aCoords = StringSplit($DLLRes[0], "|", $STR_NOCOUNT)

						For $j = 0 To UBound($aCoords) - 1 ; In case found 1 char multiple times, $j > 0
							Local $aXY = StringSplit($aCoords[$j], ",", $STR_NOCOUNT)
							ReDim $aResults[UBound($aResults) + 1][2]
							$aResults[UBound($aResults) - 2][0] = Number($aXY[0])
							$aResults[UBound($aResults) - 2][1] = $Name
						Next
					Next

					_ArrayDelete($aResults, UBound($aResults) - 1)
					_ArraySort($aResults)

					For $i = 0 To UBound($aResults) - 1
						If $g_bDebugSetlog Then SetDebugLog($i & ". $Name = " & $aResults[$i][1] & ", Coord = " & $aResults[$i][0])
						If $i >= 1 Then
							If $aResults[$i][1] = $aResults[$i - 1][1] And Abs($aResults[$i][0] - $aResults[$i - 1][0]) <= $OcrDecode Then ContinueLoop
							If Abs($aResults[$i][0] - $aResults[$i - 1][0]) > $OcrSpace Then $sOCRString &= " "
						EndIf
						$sOCRString &= $aResults[$i][1]
					Next
					If $g_bDebugSetlog Then SetDebugLog("QuickMIS " & $ValueReturned & ", $sOCRString: " & $sOCRString)
					Return $sOCRString
			EndSwitch
		EndIf
	EndIf
EndFunc   ;==>QuickMIS

Func DebugQuickMIS($x, $y, $DebugText)

	_CaptureRegion2()
	Local $subDirectory = $g_sProfileTempDebugPath & "QuickMIS"
	DirCreate($subDirectory)
	Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
	Local $Time = @HOUR & "." & @MIN & "." & @SEC
	Local $filename = String($Date & "_" & $Time & "_" & $DebugText & "_.png")
	Local $editedImage = _GDIPlus_BitmapCreateFromHBITMAP($g_hHBitmap2)
	Local $hGraphic = _GDIPlus_ImageGetGraphicsContext($editedImage)
	Local $hPenRED = _GDIPlus_PenCreate(0xFFFF0000, 3) ; Create a pencil Color FF0000/RED

	_GDIPlus_GraphicsDrawRect($hGraphic, $g_iQuickMISX - 5 + $x, $g_iQuickMISY - 5 + $y, 10, 10, $hPenRED)

	_GDIPlus_ImageSaveToFile($editedImage, $subDirectory & "\" & $filename)
	_GDIPlus_PenDispose($hPenRED)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_BitmapDispose($editedImage)

EndFunc   ;==>DebugQuickMIS
