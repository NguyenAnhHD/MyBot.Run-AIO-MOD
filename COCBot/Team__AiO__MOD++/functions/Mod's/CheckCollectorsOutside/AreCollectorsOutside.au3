; FUNCTION ====================================================================================================================
; Name ..........: AreCollectorsOutside
; Description ...: dark drills are ignored since they can be zapped
; Syntax ........:
; Parameters ....: $percent				minimum % of collectors outside of walls to all
; Return values .: True					more collectors outside than specified
;				 : False				less collectors outside than specified
; Author ........: McSlither (Jan-2016)
; Modified ......: TheRevenor (Jul 2016), Samkie (13 Jan 2017), Team AiO MOD++ (2019)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: None
; ===============================================================================================================================

Func AreCollectorsOutside($percent)
	If $g_bDBCollectorNearRedline Then Return AreCollectorsNearRedline($percent)

	SetLog("Locating Mines & Collectors", $COLOR_INFO)
	; reset variables
	Global $g_aiPixelMine[0]
	Global $g_aiPixelElixir[0]
	Global $g_aiPixelNearCollector[0]
	Global $colOutside = 0
	Global $hTimer = TimerInit()
	Global $hBitmapFirst
	_WinAPI_DeleteObject($hBitmapFirst)
	$hBitmapFirst = _CaptureRegion2()

	SuspendAndroid()
	$g_aiPixelMine = GetLocationMine()
	If (IsArray($g_aiPixelMine)) Then
		_ArrayAdd($g_aiPixelNearCollector, $g_aiPixelMine, 0, "|", @CRLF, $ARRAYFILL_FORCE_STRING)
	EndIf
	$g_aiPixelElixir = GetLocationElixir()
	If (IsArray($g_aiPixelElixir)) Then
		_ArrayAdd($g_aiPixelNearCollector, $g_aiPixelElixir, 0, "|", @CRLF, $ARRAYFILL_FORCE_STRING)
	EndIf
	ResumeAndroid()

	$g_bScanMineAndElixir = True

	Global $colNbr = UBound($g_aiPixelNearCollector)
	SetLog("Located collectors in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds")
	SetLog("[" & UBound($g_aiPixelMine) & "] Gold Mines")
	SetLog("[" & UBound($g_aiPixelElixir) & "] Elixir Collectors")

	Global $minColOutside = Round($colNbr * $percent / 100)
	Global $radiusAdjustment = 1

	If $g_iSearchTH = "-" Or $g_iSearchTH = "" Then FindTownhall(True)
	If $g_iSearchTH <> "-" Then
		$radiusAdjustment *= Number($g_iSearchTH) / 10
	Else
		If $g_iTownHallLevel > 0 Then
			$radiusAdjustment *= Number($g_iTownHallLevel) / 10
		EndIf
	EndIf
	If $g_bDebugSetlog Then SetLog("$g_iSearchTH: " & $g_iSearchTH)

	For $i = 0 To $colNbr - 1
		Global $arrPixel = $g_aiPixelNearCollector[$i]
		If UBound($arrPixel) > 0 Then
			If isOutsideEllipse($arrPixel[0], $arrPixel[1], $CollectorsEllipseWidth * $radiusAdjustment, $CollectorsEllipseHeigth * $radiusAdjustment) Then
				If $g_bDebugSetlog Then SetDebugLog("Collector (" & $arrPixel[0] & ", " & $arrPixel[1] & ") is outside", $COLOR_DEBUG)
				$colOutside += 1
			EndIf
		EndIf
		If $colOutside >= $minColOutside Then
			If $g_bDebugSetlog Then SetDebugLog("More than " & $percent & "% of the collectors are outside", $COLOR_DEBUG)
			Return True
		EndIf
	Next
	If $g_bDebugSetlog Then SetDebugLog($colOutside & " collectors found outside (out of " & $colNbr & ")", $COLOR_DEBUG)
	Return False
EndFunc   ;==>AreCollectorsOutside
