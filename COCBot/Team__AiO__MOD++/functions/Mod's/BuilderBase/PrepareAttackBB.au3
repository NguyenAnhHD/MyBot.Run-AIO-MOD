; #FUNCTION# ====================================================================================================================
; Name ..........: PrepareAttackBB
; Description ...: This file controls attacking preperation of the builders base
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Chilly-Chill (04-2019)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func PrepareAttackBB()
	If Not $g_bChkEnableBBAttack Then Return

	If $g_bChkBBTrophyRange Then
		If ($g_aiCurrentLootBB[$eLootTrophyBB] > $g_iTxtBBTrophyUpperLimit Or $g_aiCurrentLootBB[$eLootTrophyBB] < $g_iTxtBBTrophyLowerLimit) Then
			SetLog("Trophies out of range.")
			SetDebugLog("Current Trophies: " & $g_aiCurrentLootBB[$eLootTrophyBB] & " Lower Limit: " & $g_iTxtBBTrophyLowerLimit & " Upper Limit: " & $g_iTxtBBTrophyUpperLimit)
			_Sleep(1500)
			Return False
		EndIf
	EndIf

	If Not ClickAttack() Then Return False

	If Not CheckArmyReady() Then
		_Sleep(1500)
		ClickP($aAway)
		Return False
	EndIf

	If $g_bChkBBAttIfLootAvail Then
		If Not CheckLootAvail() Then
			_Sleep(1500)
			ClickP($aAway)
			Return False
		EndIf
	EndIf

	$g_bBBMachineReady = CheckMachReady()
	If $g_bChkBBWaitForMachine And Not $g_bBBMachineReady Then
		SetLog("Battle Machine is not ready.")
		_Sleep(1500)
		ClickP($aAway)
		Return False
	EndIf

	Return True ; returns true if all checks succeed
EndFunc

Func ClickAttack()
	Local $aColors = [[0xF5CC90, 86, 0], [0xFFFFFF, 15, 72], [0xFFFFFF, 26, 72]] ; coordinates of pixels relative to the 1st pixel
	Local $ButtonPixel = _MultiPixelSearch(8, 620, 120, 730, 1, 1, Hex(0xA2490F, 6), $aColors, 20)
	Local $bRet = False

	If IsArray($ButtonPixel) Then
		SetDebugLog("ButtonPixelLocation = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG) ;Debug
		SetDebugLog("Pixel color found #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & _
									", #2: " & _GetPixelColor($ButtonPixel[0] + 86, $ButtonPixel[1], True) & _
									", #3: " & _GetPixelColor($ButtonPixel[0] + 15, $ButtonPixel[1] + 72, True) & _
									", #4: " & _GetPixelColor($ButtonPixel[0] + 26, $ButtonPixel[1] + 72, True), $COLOR_DEBUG)
		PureClick($ButtonPixel[0] + 40, $ButtonPixel[1] + 40) ; Click fight Button
		$bRet = True
	Else
		SetLog("Can not find button for Builders Base Attack button", $COLOR_ERROR)
		If $g_bDebugImageSave Then DebugImageSave("BB_AttackButton_")
	EndIf
	Return $bRet
EndFunc

Func CheckLootAvail()
	Local $aColors = [[0x0F0F0F, 36, 0], [0x646464, 14, 6], [0x464646, 14, 16]]
	Local $bRet = False
	Local $ButtonPixel = _MultiPixelSearch(480, 670, 545, 705, 1, 1, Hex(0x0A0A0A, 6), $aColors, 20)

	If IsArray($ButtonPixel) Then
		SetDebugLog("ButtonPixelLocation = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG) ;Debug
		SetDebugLog("Pixel color found #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & _
									", #2: " & _GetPixelColor($ButtonPixel[0] + 36, $ButtonPixel[1], True) & _
									", #3: " & _GetPixelColor($ButtonPixel[0] + 14, $ButtonPixel[1] + 6, True) & _
									", #4: " & _GetPixelColor($ButtonPixel[0] + 14, $ButtonPixel[1] + 16, True), $COLOR_DEBUG)
		$bRet = True
		SetLog("Loot is available.")
	Else
		SetLog("No loot available.")
		If $g_bDebugImageSave Then DebugImageSave("BB_CheckLootAvail_")
	EndIf

	Return $bRet
EndFunc

Func CheckMachReady()
	Local $aCoords = decodeSingleCoord(findImage("BBMachReady", $g_sImgBBMachReady, GetDiamondFromRect("113,388,170,448"), 1, True))
	Local $bRet = False

	If IsArray($aCoords) And UBound($aCoords) = 2 Then
		$bRet = True
		SetLog("Battle Machine ready.")
	Else
		If $g_bDebugImageSave Then DebugImageSave("BB_CheckMachReady_")
	EndIf

	Return $bRet
EndFunc

Func CheckArmyReady()
	Local $i = 0
	Local $bReady = True, $bNeedTrain = False, $bTraining = False
	Local $sSearchDiamond = GetDiamondFromRect("114,384,190,450") ; start of trained troops bar untill a bit after the 'r' "in Your Troops"

	If _Sleep($DELAYCHECKFULLARMY2) Then Return False ; wait for window
	While $i < 6 And $bReady ; wait for fight preview window
		Local $aNeedTrainCoords = decodeSingleCoord(findImage("NeedTrainBB", $g_sImgBBNeedTrainTroops, $sSearchDiamond, 1, True))
		Local $aTroopsTrainingCoords = decodeSingleCoord(findImage("TroopsTrainingBB", $g_sImgBBTroopsTraining, $sSearchDiamond, 1, False)) ; shouldnt need to capture again as it is the same diamond

		If IsArray($aNeedTrainCoords) And UBound($aNeedTrainCoords) = 2 Then
			$bReady = False
			$bNeedTrain = True
		EndIf
		If IsArray($aTroopsTrainingCoords) And UBound($aTroopsTrainingCoords) = 2 Then
			$bReady = False
			$bTraining = True
		EndIf

		$i += 1
	WEnd
	If Not $bReady Then
		SetLog("Army is not ready.")
		If $bTraining Then SetLog("Troops are training.")
		If $bNeedTrain Then SetLog("Troops need to be trained in the training tab.")
		If $g_bDebugImageSave Then DebugImageSave("FindIfArmyReadyBB")
	Else
		SetLog("Army is ready.")
	EndIf

	Return $bReady
EndFunc