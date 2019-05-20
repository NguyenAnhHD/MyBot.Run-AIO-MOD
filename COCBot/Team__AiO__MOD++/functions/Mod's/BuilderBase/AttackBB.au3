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

Func AttackBuilderBase()
	Local $iSide = Random(0, 1, 1) ; randomly choose top left or top right
	Local $aBMPos = 0
	ClickP($aAway)
	SetLog("Going to Attack.", $COLOR_INFO)

	; check for troops, loot and Batlle Machine
	If Not PrepareAttackBB() Then Return
	SetDebugLog("PrepareAttackBB(): Success.")

	; search for a match
	If _Sleep(2000) Then Return
	Local $aBBFindNow = [521, 308, 0xffc246, 30] ; search button
	If _CheckPixel($aBBFindNow, True) Then
		PureClick($aBBFindNow[0], $aBBFindNow[1])
	Else
		SetLog("Could not locate search button to go find an attack.", $COLOR_ERROR)
		Return
	EndIf

	; wait for the clouds to clear
	If Not CheckBattleStarted() Then Return
	If _Sleep($DELAYRESPOND) Then Return

	; Get troops on attack bar and their quantities
	Local $aBBAttackBar = GetAttackBarBB()
	If _Sleep($DELAYRESPOND) Then Return

	; Deploy all troops
	Local $bTroopsDropped = False, $bBMDeployed = False
	SetLog($g_bBBDropOrderSet = True ? "Deploying Troops in Custom Order." : "Deploying Troops in Order of Attack Bar.", $COLOR_INFO)
	While Not $bTroopsDropped
		Local $iNumSlots = UBound($aBBAttackBar, 1)
		If $g_bBBDropOrderSet Then
			Local $asBBDropOrder = StringSplit($g_sBBDropOrder, "|")
			For $i = 0 To $g_iBBTroopCount - 1 ; loop through each name in the drop order
				Local $j = 0, $bDone = False
				While $j < $iNumSlots And Not $bDone
					If $aBBAttackBar[$j][0] = $asBBDropOrder[$i + 1] Then
						DeployBBTroop($aBBAttackBar[$j][0], $aBBAttackBar[$j][1], $aBBAttackBar[$j][2], $aBBAttackBar[$j][4], $iSide)
						If $j = $iNumSlots -1 Or $aBBAttackBar[$j][0] <> $aBBAttackBar[$j + 1][0] Then
							$bDone = True
							If _Sleep($g_iBBNextTroopDelay) Then Return ; wait before next troop
						Else
							If _Sleep($DELAYRESPOND) Then Return ; we are still on same troop so lets drop them all down a bit faster
						EndIf
					EndIf
					$j += 1
				WEnd
			Next
		Else
			For $i = 0 To $iNumSlots - 1
				DeployBBTroop($aBBAttackBar[$i][0], $aBBAttackBar[$i][1], $aBBAttackBar[$i][2], $aBBAttackBar[$i][4], $iSide)
				If $i = $iNumSlots -1 Or $aBBAttackBar[$i][0] <> $aBBAttackBar[$i + 1][0] Then
					If _Sleep($g_iBBNextTroopDelay) Then Return ; wait before next troop
				Else
					If _Sleep($DELAYRESPOND) Then Return ; we are still on same troop so lets drop them all down a bit faster
				EndIf
			Next
		EndIf
		$aBBAttackBar = GetAttackBarBB(True)
		If $aBBAttackBar = "" Then $bTroopsDropped = True
	WEnd
	SetLog("All Troops Deployed", $COLOR_SUCCESS)

	; place hero and activate ability
	SetLog("Deploying Battle Machine.", $COLOR_INFO)
	While Not $bBMDeployed And $g_bBBMachineReady
		$aBMPos = GetMachinePos()
		If IsArray($aBMPos) Then
			Local $iPoint = Random(0, 9, 1)
			If $iSide Then
				PureClick($g_apTR[$iPoint][0], $g_apTR[$iPoint][1])
			Else
				PureClick($g_apTL[$iPoint][0], $g_apTL[$iPoint][1])
			EndIf
			If _Sleep(500) Then Return ; wait before clicking ability
			PureClickP($aBMPos)
		Else
			$bBMDeployed = True
		EndIf
	WEnd
	SetLog("Battle Machine Deployed", $COLOR_SUCCESS)

	; Continue with abilities until death
	Local $bMachineAlive = True
	while $bMachineAlive
		If _Sleep($g_iBBMachAbilityTime) Then Return ; wait for machine to be available
		Local $timer = __TimerInit() ; give a bit of time to check if hero is dead because of the random lightning strikes through graphic
		$aBMPos = GetMachinePos()
		While __TimerDiff($timer) < 3000 And Not IsArray($aBMPos) ; give time to find
			$aBMPos = GetMachinePos()
		WEnd

		If Not IsArray($aBMPos) Then ; if machine wasnt found then it is dead, if not we hit ability
			$bMachineAlive = False
		Else
			PureClickP($aBMPos)
		EndIf
	WEnd
	SetLog("Battle Machine Dead")

	; wait for end of battle
	SetLog("Waiting for end of battle.", $COLOR_INFO)
	If Not Okay() Then Return
	SetLog("Battle Ended.")
	If _Sleep(3000) Then Return

	; wait for ok after both attacks are finished
	SetLog("Waiting for opponent.", $COLOR_INFO)
	Okay()
	SetLog("Done.", $COLOR_SUCCESS)
	ZoomOut()
EndFunc

; need pics for the BB searching screen.. rn just waits 30 seconds and craps out so there is room for bugs
Func CheckBattleStarted()
	Local $sSearchDiamond = GetDiamondFromRect("376,11,420,26")
	Local $timer = __TimerInit()

	While 1
		Local $aCoords = decodeSingleCoord(findImage("BBBattleStarted", $g_sImgBBBattleStarted, $sSearchDiamond, 1, True))
		If IsArray($aCoords) And UBound($aCoords) = 2 Then
			SetLog("Battle Started")
			Return True
		EndIf

		If __TimerDiff($timer) > $g_iBBBattleStartedTimeout Then
			SetLog("Battle did not start after " & String($g_iBBBattleStartedTimeout) & " seconds.")
			If $g_bDebugImageSave Then DebugImageSave("BBBattleStarted")
			Return False
		EndIf
	WEnd
EndFunc

Func GetMachinePos()
	If Not $g_bBBMachineReady Then Return

	Local $sSearchDiamond = GetDiamondFromRect("0,630,860,732")
	Local $aCoords = decodeSingleCoord(findImage("BBBattleMachinePos", $g_sImgBBBattleMachine, $sSearchDiamond, 1, True))

	If IsArray($aCoords) And UBound($aCoords) = 2 Then
		Return $aCoords
	Else
		If $g_bDebugImageSave Then DebugImageSave("BBBattleMachinePos")
	EndIf

	Return
EndFunc

Func Okay()
	Local $timer = __TimerInit()

	While 1
		Local $aCoords = decodeSingleCoord(findImage("OkayButton", $g_sImgOkButton, "FV", 1, True))
		If IsArray($aCoords) And UBound($aCoords) = 2 Then
			PureClickP($aCoords)
			Return True
		EndIf

		If __TimerDiff($timer) >= 180000 Then
			SetLog("Could not find button 'Okay'", $COLOR_ERROR)
			If $g_bDebugImageSave Then DebugImageSave("BBFindOkay")
			Return False
		EndIf

		If Mod(__TimerDiff($timer), 3000) Then
			If _Sleep($DELAYRESPOND) Then Return
		EndIf

	WEnd

	Return True
EndFunc

Func DeployBBTroop($sName, $x, $y, $iAmount, $iSide)
	SetLog("Deploying " & $sName & "x" & String($iAmount), $COLOR_ACTION)
	PureClick($x, $y) ; select troop
	If _Sleep($g_iBBSameTroopDelay) Then Return ; slow down selecting then dropping troops
	For $j = 0 To $iAmount - 1
		Local $iPoint = Random(0, 9, 1)
		If $iSide Then ; pick random point on random side
			PureClick($g_apTR[$iPoint][0], $g_apTR[$iPoint][1])
		Else
			PureClick($g_apTL[$iPoint][0], $g_apTL[$iPoint][1])
		EndIf
		If _Sleep($g_iBBSameTroopDelay) Then Return ; slow down dropping of troops
	Next
EndFunc