
; #FUNCTION# ====================================================================================================================
; Name ..........: PrepareSearch
; Description ...: Goes into searching for a match, breaks shield if it has to
; Syntax ........: PrepareSearch()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #4
; Modified ......: KnowJack (Aug 2015), MonkeyHunter(2015-12)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func PrepareSearch() ;Click attack button and find match button, will break shield

	SetLog("Going to Attack...", $COLOR_INFO)

	; RestartSearchPickupHero - Check Remaining Heal Time
	If $g_bSearchRestartPickupHero Then
		For $pTroopType = $eKing To $eWarden ; check all 3 hero
			For $pMatchMode = $DB To $g_iModeCount - 1 ; check all attack modes
				If IsSpecialTroopToBeUsed($pMatchMode, $pTroopType) Then
					If Not _DateIsValid($g_asHeroHealTime[$pTroopType - $eKing]) Then
						getArmyHeroTime("All", True, True)
						ExitLoop 2
					EndIf
				EndIf
			Next
		Next
	EndIf

	ChkAttackCSVConfig()

	If IsMainPage() Then

		If _Sleep($DELAYTREASURY4) Then Return
		If _CheckPixel($aAttackForTreasury, $g_bCapturePixel, Default, "Is attack for treasury:") Then
			SetLog("It isn't attack for Treasury :-(", $COLOR_SUCCESS)
			Return
		EndIf
		If _Sleep($DELAYTREASURY4) Then Return

		If $g_bUseRandomClick = False Then
			ClickP($aAttackButton, 1, 0, "#0149") ; Click Attack Button
		Else
			ClickR($aAttackButtonRND, $aAttackButton[0], $aAttackButton[1], 1, 0)
		EndIf
	EndIf
	If _Sleep($DELAYPREPARESEARCH1) Then Return

	Local $j = 0
	While Not ( IsLaunchAttackPage())
		If _Sleep($DELAYPREPARESEARCH1) Then Return ; wait for Train Window to be ready.
		$j += 1
		If $j > 15 Then ExitLoop
	WEnd
	If $j > 15 Then
		SetLog("Launch attack Page Fail", $COLOR_ERROR)
		AndroidPageError("PrepareSearch")
		checkMainScreen()
		$g_bRestart = True
		$g_bIsClientSyncError = False
		Return
	Else
		If $g_bUseRandomClick = False Then
			ClickP($aFindMatchButton, 1, 0, "#0150") ;Click Find a Match Button
		Else
			ClickR($aFindMatchButtonRND, $aFindMatchButton[0], $aFindMatchButton[1], 1, 0)
		EndIf

		If $g_iTownHallLevel <> "" And $g_iTownHallLevel > 0 Then
			$g_iSearchCost += $g_aiSearchCost[$g_iTownHallLevel - 1]
			$g_iStatsTotalGain[$eLootGold] -= $g_aiSearchCost[$g_iTownHallLevel - 1]
		EndIf
		UpdateStats()
	EndIf


	If _Sleep($DELAYPREPARESEARCH2) Then Return

	Local $Result = getAttackDisable(346, 182) ; Grab Ocr for TakeABreak check

	If isGemOpen(True) = True Then ; Check for gem window open)
		SetLog(" Not enough gold to start searching.....", $COLOR_ERROR)
		Click(585, 252, 1, 0, "#0151") ; Click close gem window "X"
		If _Sleep($DELAYPREPARESEARCH1) Then Return
		Click(822, 32, 1, 0, "#0152") ; Click close attack window "X"
		If _Sleep($DELAYPREPARESEARCH1) Then Return
		$g_bOutOfGold = True ; Set flag for out of gold to search for attack
	EndIf

	checkAttackDisable($g_iTaBChkAttack, $Result) ;See If TakeABreak msg on screen

	If $g_bDebugSetlog Then SetDebugLog("PrepareSearch exit check $g_bRestart= " & $g_bRestart & ", $g_bOutOfGold= " & $g_bOutOfGold, $COLOR_DEBUG)

	If $g_bRestart Or $g_bOutOfGold Then ; If we have one or both errors, then return
		$g_bIsClientSyncError = False ; reset fast restart flag to stop OOS mode, and rearm, collecting resources etc.
		Return
	EndIf
	If IsAttackWhileShieldPage(False) Then ; check for shield window and then button to lose time due attack and click okay
		Local $offColors[3][3] = [[0x000000, 144, 1], [0xFFFFFF, 54, 17], [0xFFFFFF, 54, 28]] ; 2nd Black opposite button, 3rd pixel white "O" center top, 4th pixel White "0" bottom center
		Local $ButtonPixel = _MultiPixelSearch(359, 404 + $g_iMidOffsetY, 510, 445 + $g_iMidOffsetY, 1, 1, Hex(0x000000, 6), $offColors, 20) ; first vertical black pixel of Okay
		If $g_bDebugSetlog Then SetDebugLog("Shield btn clr chk-#1: " & _GetPixelColor(441, 344 + $g_iMidOffsetY, True) & ", #2: " & _
			_GetPixelColor(441 + 144, 344 + $g_iMidOffsetY, True) & ", #3: " & _GetPixelColor(441 + 54, 344 + 17 + $g_iMidOffsetY, True) & ", #4: " & _
			_GetPixelColor(441 + 54, 344 + 10 + $g_iMidOffsetY, True), $COLOR_DEBUG)
		If IsArray($ButtonPixel) Then
			If $g_bDebugSetlog Then
				SetDebugLog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG) ;Debug
				SetDebugLog("Shld Btn Pixel color found #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 144, $ButtonPixel[1], True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 54, $ButtonPixel[1] + 17, True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 54, $ButtonPixel[1] + 27, True), $COLOR_DEBUG)
			EndIf
			Click($ButtonPixel[0] + 75, $ButtonPixel[1] + 25, 1, 0, "#0153") ; Click Okay Button
		EndIf
	EndIf

EndFunc   ;==>PrepareSearch


