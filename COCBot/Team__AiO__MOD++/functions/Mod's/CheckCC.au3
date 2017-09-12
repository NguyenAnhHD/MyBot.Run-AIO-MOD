; #FUNCTION# ====================================================================================================================
; Name ..........: CheckCC & remove unexpected troops in CC
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: DEMEN
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func CheckCC($close = True)
	Local $CheckTroop[2] = [0xCFCFC8, 15] ; the gray background
	Local $directory = @ScriptDir & "\imgxml\ArmyTroops"
	Local $aToRemove[6]
	Local $aPos[2] = [70, 575]
	Local $bNeedRemoveCC = False

	If $g_bChkCCTroops = False Then Return

	ResetVariables("CCTroops")

	If Not IsArmyWindow(False, $ArmyTAB) Then
		OpenArmyWindow()
		If _Sleep(1500) Then Return
	EndIf

	For $i = 0 To 5
		If _ColorCheck(_GetPixelColor(Int(30 + 73.5 * $i), 508, True), Hex($CheckTroop[0], 6), $CheckTroop[1]) = True Then ExitLoop
		If $g_iDebugSetlog = 1 Then SetLog("SLOT : " & $i, $COLOR_DEBUG) ;Debug
		_CaptureRegion2(Int(23 + 73.5 * $i), 517, Int(95 + 73.5 * $i), 557)
		Local $Res = DllCall($g_hLibMyBot, "str", "SearchMultipleTilesBetweenLevels", "handle", $g_hHBitmap2, "str", $directory, "str", "FV", "Int", 0, "str", "FV", "Int", 0, "Int", 1000)
		If $Res[0] = "" Or $Res[0] = "0" Then
			Setlog("Some kind of error, no image file return for slot: " & $i, $COLOR_RED)
		ElseIf StringInStr($Res[0], "-1") <> 0 Then
			SetLog("DLL Error", $COLOR_RED)
		Else ; name of first file found
			Local $aResult = StringSplit($Res[0], "_") ; $aResult[1] = troop short name "Barb" or "Arch"
			Local $iQty = Number(getBarracksNewTroopQuantity(Int(35 + 73.5 * $i), 498)) ; coc-newarmy
			Local $eIndex = Eval("e" & $aResult[1])
			$g_aiCCTroops[$eIndex] += $iQty
			If $g_iDebugSetlog = 1 Then SetLog("Found: " & $aResult[1] & " x" & $iQty, $COLOR_DEBUG) ;Debug
			If $g_aiCCTroops[$eIndex] - $g_aiCCTroopsExpected[$eIndex] > 0 Then
				$aToRemove[$i] = $g_aiCCTroops[$eIndex] - $g_aiCCTroopsExpected[$eIndex]
				If $aToRemove[$i] > $iQty Then $aToRemove[$i] = $iQty
				If $g_iDebugSetlog = 1 Then SetLog("Expected: " & $aResult[1] & " x" & $g_aiCCTroopsExpected[$eIndex] & ". Should remove: x" & $aToRemove[$i], $COLOR_DEBUG) ;Debug
				$bNeedRemoveCC = True
			EndIf
		EndIf
	Next

	For $i = 0 To $eTroopCount - 1
		If $g_aiCCTroops[$i] > 0 Then Setlog($g_aiCCTroops[$i] & "x " & NameOfTroop($i, $g_aiCCTroops[$i] > 1 ? 1 : 0) & " available in Clan Castle", $COLOR_GREEN)
	Next

	If $bNeedRemoveCC Then
		SetLog("Some unexpected troops in Clan Castle, let's remove.")
		If _ColorCheck(_GetPixelColor(806, 472, True), Hex(0xD0E878, 6), 25) = False Then ; If no 'Edit Army' Button found in army tab to edit troops
			SetLog("Cannot find/verify 'Edit Army' Button in Army tab", $COLOR_ORANGE)
			Return ; Exit function
		EndIf
		Click(Random(723, 812, 1), Random(469, 513, 1)) ; Click on Edit Army Button
		If _Sleep(500) Then Return

		For $i = 0 To 5
			If $aToRemove[$i] > 0 Then
				$aPos[0] = 74 * ($i + 1) - 4
				ClickRemoveTroop($aPos, $aToRemove[$i], $g_iTrainClickDelay) ; Click on Remove button as much as needed
			EndIf
		Next

		Local $idx = 0

		While $idx <= 5
			If _ColorCheck(_GetPixelColor(806, 561, True), Hex(0xD0E878, 6), 25) Then
				Click(Random(720, 815, 1), Random(558, 589, 1)) ; Click on 'Okay' button to save changes
				ExitLoop
			Else
				If _Sleep(200) Then Return
				$idx += 1
				If $idx = 5 Then
					SetLog("Cannot find/verify 'Okay' Button in Army tab", $COLOR_ORANGE)
					Return ; Exit function
				EndIf
			EndIf
		WEnd

		$idx = 0
		While $idx <= 5
			If _ColorCheck(_GetPixelColor(508, 428, True), Hex(0xFFFFFF, 6), 30) Then
				Click(Random(445, 585, 1), Random(400, 455, 1)) ; Click on 'Okay' button to Save changes... Last button
				ExitLoop
			Else
				If _Sleep(300) Then Return
				$idx += 1
				If $idx = 5 Then
					SetLog("Cannot find/verify 'Okay #2' Button in Army tab", $COLOR_ORANGE)
					Return ; Exit function
				EndIf
			EndIf
		WEnd

		SetLog("Unexpected CC Troops removed")
		If _Sleep(200) Then Return
	EndIf
	If $close Then ClickP($aAway, 2, 0)

EndFunc   ;==>CheckCC
