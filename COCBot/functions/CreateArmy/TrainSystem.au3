; #FUNCTION# ====================================================================================================================
; Name ..........: Train Revamp Oct 2016
; Description ...:
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Mr.Viper(10-2016), ProMac(10-2016), CodeSlinger69 (01-2018)
; Modified ......: ProMac (11-2016), Boju (11-2016), MR.ViPER (12-2016), CodeSlinger69 (01-2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func TrainSystem()

	If Not $g_bTrainEnabled Then ; check for training disabled in halt mode
		If $g_bDebugSetlogTrain Then SetLog("Halt mode - training disabled", $COLOR_DEBUG)
		Return
	EndIf

	$g_sTimeBeforeTrain = _NowCalc()
	StartGainCost()

	;Test for Train/Donate Only and Fullarmy
	If ($g_iCommandStop = 3 Or $g_iCommandStop = 0) And $g_bIsFullArmywithHeroesAndSpells Then
		SetLog("You are in halt attack mode and your Army is prepared!", $COLOR_DEBUG) ;Debug
		If $g_bFirstStart Then $g_bFirstStart = False
		DoubleTrain($g_bQuickTrainEnable)
		Return
	EndIf

	If $g_abDonateOnly[$g_iCurAccount] And ProfileSwitchAccountEnabled() And $g_bIsFullArmywithHeroesAndSpells Then
		SetLog("Donate Only mode and your Army is prepared!", $COLOR_DEBUG) ;Debug
		If $g_bFirstStart Then $g_bFirstStart = False
		DoubleTrain($g_bQuickTrainEnable)
		Return
	EndIf

    If $g_bDoubleTrain Then
        DoubleTrain($g_bQuickTrainEnable)
        Return
    EndIf

	If Not $g_bQuickTrainEnable Then
		TrainCustomArmy()
		Return
	EndIf

	If $g_bDebugSetlogTrain Then SetLog(" - Initial Quick train Function")

	If $g_bDebugSetlogTrain Then SetLog(" - Line Open Army Window")

	CheckIfArmyIsReady()

	If Not $g_bRunState Then Return

	If $g_bIsFullArmywithHeroesAndSpells Or ($g_CurrentCampUtilization = 0 And $g_bFirstStart) Then

		If $g_bIsFullArmywithHeroesAndSpells Then SetLog(" - Your Army is Full, let's make troops before Attack!", $COLOR_INFO)
		If ($g_CurrentCampUtilization = 0 And $g_bFirstStart) Then
			SetLog(" - Your Army is Empty, let's make troops before Attack!", $COLOR_ACTION1)
			SetLog(" - Go to Train Army Tab and select your Quick Army position!", $COLOR_ACTION1)
		EndIf

		DeleteQueued("Troops")
		If _Sleep(250) Then Return
		DeleteQueued("Spells")
		If _Sleep(500) Then Return

		CheckCamp()

		ResetVariables("donated")

		If $g_bFirstStart Then $g_bFirstStart = False

		If _Sleep(700) Then Return
	Else

		If $g_bDonationEnabled And $g_bChkDonate Then MakingDonatedTroops()

		CheckIsFullQueuedAndNotFullArmy()
		If Not $g_bRunState Then Return
		If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop, plus improve pause response
		CheckIsEmptyQueuedAndNotFullArmy()
		If Not $g_bRunState Then Return
		If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop, plus improve pause response
		If $g_bFirstStart Then $g_bFirstStart = False
	EndIf

	TrainSiege()

	ClickP($aAway, 2, 0, "#0346") ;Click Away
	If _Sleep(1000) Then Return ; Delay AFTER the click Away Prevents lots of coc restarts
	SetLog("Army Window Closed", $COLOR_INFO)

	EndGainCost("Train")

	checkAttackDisable($g_iTaBChkIdle) ; Check for Take-A-Break after opening train page

EndFunc   ;==>TrainSystem

Func CheckCamp($bOpenArmyWindow = False, $bCloseArmyWindow = False)
	If $bOpenArmyWindow Then
		OpenArmyOverview(True, "CheckCamp()")
		If _Sleep(500) Then Return
	EndIf

	Local $iReturnCamp = TestMaxCamp()

	If $iReturnCamp = 1 Then
		If Not OpenQuickTrainTab(True, "CheckCamp()") Then Return
		If _Sleep(1000) Then Return
		TrainArmyNumber($g_bQuickTrainArmy)
		If _Sleep(700) Then Return
	EndIf
	If $iReturnCamp = 0 Then
		; The number of troops is not correct
		; Just in case!!
		CheckIsFullQueuedAndNotFullArmy()
		CheckIsEmptyQueuedAndNotFullArmy()
	EndIf

	If $bCloseArmyWindow Then
		ClickP($aAway, 2, 0, "#0346") ;Click Away
		If _Sleep(250) Then Return
	EndIf
EndFunc   ;==>CheckCamp

Func TestMaxCamp()
	Local $ToReturn = 0
	If Not OpenTroopsTab(True, "TestMaxCamp()") Then Return
	If _Sleep(250) Then Return
	Local $ArmyCamp = GetOCRCurrent(48, 160)
	If UBound($ArmyCamp) = 3 Then
		; [2] is the [0] - [1] | Or is empty or full
		If $ArmyCamp[2] = 0 Or $ArmyCamp[0] = 0 Or ($ArmyCamp[0] = $ArmyCamp[2]) Then
			$ToReturn = 1
		Else
			; The number of troops is not correct
			If $ArmyCamp[1] > 560 Then SetLog(" Your CoC is outdated!!! ", $COLOR_ERROR)
			SetLog(" - Your army is: " & $ArmyCamp[0], $COLOR_ACTION)
			$ToReturn = 0
		EndIf
	EndIf

	Return $ToReturn
EndFunc   ;==>TestMaxCamp

Func TrainCustomArmy()
	If Not $g_bRunState Then Return

	If $g_bDebugSetlogTrain Then SetLog(" == Initial Custom Train == ", $COLOR_ACTION)

	;If $bDonateTrain = -1 Then SetbDonateTrain()
	If $g_iActiveDonate = -1 Then PrepareDonateCC()

	CheckIfArmyIsReady()

	If ThSnipesSkiptrain() Then Return

	If Not $g_bRunState Then Return
	Local $rWhatToTrain = WhatToTrain(True, False) ; r in First means Result! Result of What To Train Function

	Local $rRemoveExtraTroops = RemoveExtraTroops($rWhatToTrain)

	If $rRemoveExtraTroops = 1 Or $rRemoveExtraTroops = 2 Then
		CheckIfArmyIsReady()

		;Test for Train/Donate Only and Fullarmy
		If ($g_iCommandStop = 3 Or $g_iCommandStop = 0) And $g_bIsFullArmywithHeroesAndSpells Then
			SetLog("You are in halt attack mode and your Army is prepared!", $COLOR_DEBUG) ;Debug
			If $g_bFirstStart Then $g_bFirstStart = False
			Return
		EndIf

	EndIf


	If Not $g_bRunState Then Return

	If $rRemoveExtraTroops = 2 Then
		$rWhatToTrain = WhatToTrain(False, False)
		TrainUsingWhatToTrain($rWhatToTrain)
	EndIf


	If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop

	If IsQueueEmpty("Troops") Then
		If Not $g_bRunState Then Return
		If Not OpenArmyTab(False, "TrainRevampOldStyle()") Then Return

		$rWhatToTrain = WhatToTrain(False, False)
		TrainUsingWhatToTrain($rWhatToTrain)
	Else
		If Not $g_bRunState Then Return
		If Not OpenArmyTab(False, "TrainRevampOldStyle()") Then Return
	EndIf
	If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop

	$rWhatToTrain = WhatToTrain(False, False)
	If DoWhatToTrainContainSpell($rWhatToTrain) Then
		If IsQueueEmpty("Spells") Then
			TrainUsingWhatToTrain($rWhatToTrain, True)
		Else
			If Not OpenArmyTab(False, "TrainRevampOldStyle()") Then Return
		EndIf
	EndIf

	TrainSiege()

	If _Sleep(250) Then Return
	If Not $g_bRunState Then Return
	ClickP($aAway, 2, 0, "#0346") ;Click Away
	If _Sleep(250) Then Return

	EndGainCost("Train")

	checkAttackDisable($g_iTaBChkIdle) ; Check for Take-A-Break after opening train page
EndFunc   ;==>TrainCustomArmy

Func CheckIfArmyIsReady()

	If Not $g_bRunState Then Return

	Local $bFullArmyCC = False
	Local $iTotalSpellsToBrew = 0
	Local $bFullArmyHero = False
	Local $bFullSiege = False
	$g_bWaitForCCTroopSpell = False ; reset for waiting CC in SwitchAcc

	If Not OpenArmyOverview(False, "CheckIfArmyIsReady()") Then Return
	If _Sleep(250) Then Return
	If Not OpenArmyTab(True, "CheckIfArmyIsReady()") Then Return
	If _Sleep(250) Then Return

	CheckArmyCamp(False, False, False, True)

	If $g_bDebugSetlogTrain Then
		SetLog(" - $g_CurrentCampUtilization : " & $g_CurrentCampUtilization)
		SetLog(" - $g_iTotalCampSpace : " & $g_iTotalCampSpace)
	EndIf

	$g_bFullArmySpells = False
	; Local Variable to check the occupied space by the Spells to Brew ... can be different of the Spells Factory Capacity ( $g_iTotalSpellValue )
	For $i = 0 To $eSpellCount - 1
		$iTotalSpellsToBrew += $g_aiArmyCompSpells[$i] * $g_aiSpellSpace[$i]
	Next

	If Number($g_iCurrentSpells) = Number($g_iTotalTrainSpaceSpell) Or Number($g_iCurrentSpells) >= Number($g_iTotalSpellValue) Or (Number($g_iCurrentSpells) >= Number($iTotalSpellsToBrew) And $g_bQuickTrainEnable = False) Then
		$g_bFullArmySpells = True
	EndIf

	$g_bCheckSpells = CheckSpells()

	$bFullArmyHero = (BitAND($g_aiSearchHeroWaitEnable[$DB], $g_iHeroAvailable) = $g_aiSearchHeroWaitEnable[$DB] And $g_abAttackTypeEnable[$DB]) Or _
			(BitAND($g_aiSearchHeroWaitEnable[$LB], $g_iHeroAvailable) = $g_aiSearchHeroWaitEnable[$LB] And $g_abAttackTypeEnable[$LB]) Or _
			($g_aiSearchHeroWaitEnable[$DB] = $eHeroNone And $g_aiSearchHeroWaitEnable[$LB] = $eHeroNone)

	If $g_bDebugSetlogTrain Then
		Setlog("Heroes are Ready: " & String($bFullArmyHero))
		Setlog("Heroes Available Num: " & $g_iHeroAvailable) ;  	$eHeroNone = 0, $eHeroKing = 1, $eHeroQueen = 2, $eHeroWarden = 4
		Setlog("Search Hero Wait Enable [$DB] Num: " & $g_aiSearchHeroWaitEnable[$DB]) ; 	what you are waiting for : 1 is King , 3 is King + Queen , etc etc
		Setlog("Search Hero Wait Enable [$LB] Num: " & $g_aiSearchHeroWaitEnable[$LB])
		Setlog("Dead Base BitAND: " & BitAND($g_aiSearchHeroWaitEnable[$DB], $g_iHeroAvailable))
		Setlog("Live Base BitAND: " & BitAND($g_aiSearchHeroWaitEnable[$LB], $g_iHeroAvailable))
		Setlog("Are you 'not' waiting for Heroes: " & String($g_aiSearchHeroWaitEnable[$DB] = $eHeroNone And $g_aiSearchHeroWaitEnable[$LB] = $eHeroNone))
		Setlog("Is Wait for Heroes Active : " & IsWaitforHeroesActive())
	EndIf

	$bFullArmyCC = IsFullClanCastle()
	$bFullSiege = CheckSiegeMachine()

	; If Drop Trophy with Heroes is checked and a Hero is Available or under the trophies range, then set $g_bFullArmyHero to True
	If Not IsWaitforHeroesActive() And $g_bDropTrophyUseHeroes Then $bFullArmyHero = True
	If Not IsWaitforHeroesActive() And Not $g_bDropTrophyUseHeroes And Not $bFullArmyHero Then
		If $g_iHeroAvailable > 0 Or Number($g_aiCurrentLoot[$eLootTrophy]) <= Number($g_iDropTrophyMax) Then
			$bFullArmyHero = True
		Else
			SetLog("Waiting for Heroes to drop trophies!", $COLOR_ACTION)
		EndIf
	EndIf

	If $g_bFullArmy And $g_bCheckSpells And $bFullArmyHero And $bFullArmyCC And $bFullSiege Then
		$g_bIsFullArmywithHeroesAndSpells = True
		If $g_bFirstStart Then $g_bFirstStart = False
	Else
		If $g_bDebugSetlog Then
			SetDebugLog(" $g_bFullArmy: " & String($g_bFullArmy), $COLOR_DEBUG)
			SetDebugLog(" $g_bCheckSpells: " & String($g_bCheckSpells), $COLOR_DEBUG)
			SetDebugLog(" $bFullArmyHero: " & String($bFullArmyHero), $COLOR_DEBUG)
			SetDebugLog(" $bFullSiege: " & String($bFullSiege), $COLOR_DEBUG)
			SetDebugLog(" $bFullArmyCC: " & String($bFullArmyCC), $COLOR_DEBUG)
		EndIf
		$g_bIsFullArmywithHeroesAndSpells = False
	EndIf
	If $g_bFullArmy And $g_bCheckSpells And $bFullArmyHero Then ; Force Switch while waiting for CC in SwitchAcc
		If Not $bFullArmyCC Then $g_bWaitForCCTroopSpell = True
	EndIf

	Local $sLogText = ""
	If Not $g_bFullArmy Then $sLogText &= " Troops,"
	If Not $g_bCheckSpells Then $sLogText &= " Spells,"
	If Not $bFullArmyHero Then $sLogText &= " Heroes,"
	If Not $bFullSiege Then $sLogText &= " Siege Machine,"
	If Not $bFullArmyCC Then $sLogText &= " Clan Castle,"
	If StringRight($sLogText, 1) = "," Then $sLogText = StringTrimRight($sLogText, 1) ; Remove last "," as it is not needed

	If $g_bIsFullArmywithHeroesAndSpells Then
		If $g_bNotifyTGEnable And $g_bNotifyAlertCampFull Then PushMsg("CampFull")
		SetLog("Chief, is your Army ready? Yes, it is!", $COLOR_SUCCESS)
	Else
		SetLog("Chief, is your Army ready? No, not yet!", $COLOR_ACTION)
		If $sLogText <> "" Then SetLog(@TAB & "Waiting for " & $sLogText, $COLOR_ACTION)
	EndIf

	; Force to Request CC troops or Spells
	If Not $bFullArmyCC Then $g_bCanRequestCC = True
	If $g_bDebugSetlog Then
		SetDebugLog(" $g_bFullArmy: " & String($g_bFullArmy), $COLOR_DEBUG)
		SetDebugLog(" $bCheckCC: " & String($bFullArmyCC), $COLOR_DEBUG)
		SetDebugLog(" $g_bIsFullArmywithHeroesAndSpells: " & String($g_bIsFullArmywithHeroesAndSpells), $COLOR_DEBUG)
		SetDebugLog(" $g_iTownHallLevel: " & Number($g_iTownHallLevel), $COLOR_DEBUG)
	EndIf

EndFunc   ;==>CheckIfArmyIsReady

Func CheckSpells()
	If Not $g_bRunState Then Return

	Local $bToReturn = False

	If (Not $g_abSearchSpellsWaitEnable[$DB] And Not $g_abSearchSpellsWaitEnable[$LB]) Or ($g_bFullArmySpells And ($g_abSearchSpellsWaitEnable[$DB] Or $g_abSearchSpellsWaitEnable[$LB])) Then
		Return True
	EndIf

	If (($g_abAttackTypeEnable[$DB] And $g_abSearchSpellsWaitEnable[$DB]) Or ($g_abAttackTypeEnable[$LB] And $g_abSearchSpellsWaitEnable[$LB])) And $g_iTownHallLevel >= 5 Then
		$bToReturn = $g_bFullArmySpells
	Else
		$bToReturn = True
	EndIf

	Return $bToReturn
EndFunc   ;==>CheckSpells

Func CheckSiegeMachine()

	If Not $g_bRunState Then Return

	Local $bToReturn = True

	If IsWaitforSiegeMachine() Then
		For $i = $eSiegeWallWrecker To $eSiegeMachineCount - 1
			If $g_aiCurrentSiegeMachines[$i] < $g_aiArmyCompSiegeMachine[$i] Then $bToReturn = False
			If $g_bDebugSetlogTrain Then
				SetLog("$g_aiCurrentSiegeMachines[" & $g_asSiegeMachineNames[$i] & "]: " & $g_aiCurrentSiegeMachines[$i])
				SetLog("$g_aiArmyCompSiegeMachine[" & $g_asSiegeMachineNames[$i] & "]: " & $g_aiArmyCompSiegeMachine[$i])
			EndIf
		Next
	Else
		$bToReturn = True
	EndIf

	Return $bToReturn
EndFunc   ;==>CheckSiegeMachine

Func TrainUsingWhatToTrain($rWTT, $bSpellsOnly = False)
	If Not $g_bRunState Then Return

	If UBound($rWTT) = 1 And $rWTT[0][0] = "Arch" And $rWTT[0][1] = 0 Then ; If was default Result of WhatToTrain
		Return True
	EndIf

	If Not $bSpellsOnly Then
		If Not OpenTroopsTab(True, "TrainUsingWhatToTrain()") Then Return
	Else
		If Not OpenSpellsTab(True, "TrainUsingWhatToTrain()") Then Return
	EndIf

	; Loop through needed troops to Train
	Switch $g_bIsFullArmywithHeroesAndSpells
		Case False
			For $i = 0 To (UBound($rWTT) - 1)
				If Not $g_bRunState Then Return
				If $rWTT[$i][1] > 0 Then ; If Count to Train Was Higher Than ZERO
					If IsSpellToBrew($rWTT[$i][0]) Then
						If $bSpellsOnly Then BrewUsingWhatToTrain($rWTT[$i][0], $rWTT[$i][1])
						ContinueLoop
					Else
						If $bSpellsOnly Then ContinueLoop
					EndIf
					Local $NeededSpace = CalcNeededSpace($rWTT[$i][0], $rWTT[$i][1])
					Local $LeftSpace = LeftSpace()
					If Not $g_bRunState Then Return
					If $NeededSpace <= $LeftSpace Then ; If Needed Space was Equal Or Lower Than Left Space
						If Not DragIfNeeded($rWTT[$i][0]) Then
							Return False
						EndIf

						Local $iTroopIndex = TroopIndexLookup($rWTT[$i][0], "TrainUsingWhatToTrain#1")

						Local $sTroopName = ($rWTT[$i][1] > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
						If CheckValuesCost($rWTT[$i][0], $rWTT[$i][1]) Then
							SetLog("Training " & $rWTT[$i][1] & "x " & $sTroopName, $COLOR_SUCCESS)
							TrainIt($iTroopIndex, $rWTT[$i][1], $g_iTrainClickDelay)
						Else
							SetLog("No resources to Train " & $rWTT[$i][1] & "x " & $sTroopName, $COLOR_ACTION)
							$g_bOutOfElixir = True
						EndIf
					Else ; If Needed Space was Higher Than Left Space
						Local $CountToTrain = 0
						Local $CanAdd = True
						Do
							$NeededSpace = CalcNeededSpace($rWTT[$i][0], $CountToTrain)
							If $NeededSpace <= $LeftSpace Then
								$CountToTrain += 1
							Else
								$CanAdd = False
							EndIf
						Until $CanAdd = False
						If $CountToTrain > 0 Then
							If DragIfNeeded($rWTT[$i][0]) = False Then
								Return False
							EndIf
						EndIf

						Local $iTroopIndex = TroopIndexLookup($rWTT[$i][0], "TrainUsingWhatToTrain#2")

						Local $sTroopName = ($CountToTrain > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
						If CheckValuesCost($rWTT[$i][0], $CountToTrain) Then
							SetLog("Training " & $CountToTrain & "x " & $sTroopName, $COLOR_SUCCESS)
							TrainIt($iTroopIndex, $CountToTrain, $g_iTrainClickDelay)
						Else
							SetLog("No resources to Train " & $CountToTrain & "x " & $sTroopName, $COLOR_ACTION)
							$g_bOutOfElixir = True
						EndIf
					EndIf
				EndIf
				If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop
			Next
		Case True
			For $i = 0 To (UBound($rWTT) - 1)
				If Not $g_bRunState Then Return
				If $rWTT[$i][1] > 0 Then ; If Count to Train Was Higher Than ZERO
					If IsSpellToBrew($rWTT[$i][0]) Then
						If $bSpellsOnly Then BrewUsingWhatToTrain($rWTT[$i][0], $rWTT[$i][1])
						ContinueLoop
					Else
						If $bSpellsOnly Then ContinueLoop
					EndIf
					Local $NeededSpace = CalcNeededSpace($rWTT[$i][0], $rWTT[$i][1])
					Local $LeftSpace = LeftSpace(True)
					If Not $g_bRunState Then Return
					$LeftSpace = ($LeftSpace[1] * 2) - $LeftSpace[0]
					If $NeededSpace <= $LeftSpace Then ; If Needed Space was Equal Or Lower Than Left Space
						If Not DragIfNeeded($rWTT[$i][0]) Then
							Return False
						EndIf

						Local $iTroopIndex = TroopIndexLookup($rWTT[$i][0], "TrainUsingWhatToTrain#3")

						Local $sTroopName = ($rWTT[$i][1] > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
						If CheckValuesCost($rWTT[$i][0], $rWTT[$i][1]) Then
							SetLog("Training " & $rWTT[$i][1] & "x " & $sTroopName, $COLOR_SUCCESS)
							TrainIt($iTroopIndex, $rWTT[$i][1], $g_iTrainClickDelay)
						Else
							SetLog("No resources to Train " & $rWTT[$i][1] & "x " & $sTroopName, $COLOR_ACTION)
							$g_bOutOfElixir = True
						EndIf
					Else ; If Needed Space was Higher Than Left Space
						Local $CountToTrain = 0
						Local $CanAdd = True
						Do
							$NeededSpace = CalcNeededSpace($rWTT[$i][0], $CountToTrain)
							If $NeededSpace <= $LeftSpace Then
								$CountToTrain += 1
							Else
								$CanAdd = False
							EndIf
						Until $CanAdd = False
						If $CountToTrain > 0 Then
							If Not DragIfNeeded($rWTT[$i][0]) Then
								Return False
							EndIf
						EndIf

						Local $iTroopIndex = TroopIndexLookup($rWTT[$i][0], "TrainUsingWhatToTrain#4")

						Local $sTroopName = ($CountToTrain > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
						If CheckValuesCost($rWTT[$i][0], $CountToTrain) Then
							SetLog("Training " & $CountToTrain & "x " & $sTroopName, $COLOR_SUCCESS)
							TrainIt($iTroopIndex, $CountToTrain, $g_iTrainClickDelay)
						Else
							SetLog("No resources to Train " & $CountToTrain & "x " & $sTroopName, $COLOR_ACTION)
							$g_bOutOfElixir = True
						EndIf
					EndIf
				EndIf
				If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop
			Next
	EndSwitch

	Return True
EndFunc   ;==>TrainUsingWhatToTrain

Func BrewUsingWhatToTrain($Spell, $Quantity) ; it's job is a bit different with 'TrainUsingWhatToTrain' Function, It's being called by TrainusingWhatToTrain Func
	Local $iSpellIndex = TroopIndexLookup($Spell, "BrewUsingWhatToTrain")
	Local $sSpellName = $g_asSpellNames[$iSpellIndex - $eLSpell]

	If $Quantity <= 0 Then Return False
	If $Quantity = 9999 Then
		SetLog("Brewing " & $sSpellName & " Spell Cancelled " & @CRLF & _
				"                  Reason: Enough as set in GUI " & @CRLF & _
				"                               This Spell not used in Attack")
		Return True
	EndIf
	If Not $g_bRunState Then Return
	If Not OpenSpellsTab(False, "BrewUsingWhatToTrain()") Then Return

	Select
		Case $g_bIsFullArmywithHeroesAndSpells = False
			If Not _ColorCheck(_GetPixelColor(230, 208, True), Hex(0x677CB5, 6), 30) Then RemoveExtraTroopsQueue()
			Local $NeededSpace = CalcNeededSpace($Spell, $Quantity)
			Local $LeftSpace = LeftSpace()
			If Not $g_bRunState Then Return
			If $NeededSpace <= $LeftSpace Then ; If Needed Space was Equal Or Lower Than Left Space
				If CheckValuesCost($Spell, $Quantity) Then
					SetLog("Brewing " & $Quantity & "x " & $sSpellName & ($Quantity > 1 ? " Spells" : " Spell"), $COLOR_SUCCESS)
					TrainIt($iSpellIndex, $Quantity, $g_iTrainClickDelay)
				Else
					SetLog("No resources to Brew " & $Quantity & "x " & $sSpellName & ($Quantity > 1 ? " Spells" : " Spell"), $COLOR_ACTION)
					$g_bOutOfElixir = True
				EndIf

			EndIf
		Case $g_bIsFullArmywithHeroesAndSpells = True
			Local $NeededSpace = CalcNeededSpace($Spell, $Quantity)
			Local $LeftSpace = LeftSpace(True)
			If Not $g_bRunState Then Return
			$LeftSpace = ($LeftSpace[1] * 2) - $LeftSpace[0]
			If $NeededSpace <= $LeftSpace Then ; If Needed Space was Equal Or Lower Than Left Space
				If CheckValuesCost($Spell, $Quantity) Then
					SetLog("Brewing " & $Quantity & "x " & $sSpellName & ($Quantity > 1 ? " Spells" : " Spell"), $COLOR_SUCCESS)
					TrainIt($iSpellIndex, $Quantity, $g_iTrainClickDelay)
				Else
					SetLog("No resources to Brew " & $Quantity & "x " & $sSpellName & ($Quantity > 1 ? " Spells" : " Spell"), $COLOR_ACTION)
					$g_bOutOfElixir = True
				EndIf
			EndIf
	EndSelect
EndFunc   ;==>BrewUsingWhatToTrain

Func TotalSpellsToBrewInGUI()
	Local $iTotalSpellsInGUI = 0
	If $g_iTotalSpellValue = 0 Then Return $iTotalSpellsInGUI
	If Not $g_bRunState Then Return
	For $i = 0 To $eSpellCount - 1
		$iTotalSpellsInGUI += $g_aiArmyCompSpells[$i] * $g_aiSpellSpace[$i]
	Next
	Return $iTotalSpellsInGUI
EndFunc   ;==>TotalSpellsToBrewInGUI

Func HowManyTimesWillBeUsed($Spell) ;ONLY ONLY ONLY FOR SPELLS, TO SEE IF NEEDED TO BREW, DON'T USE IT TO GET EXACT COUNT
	Local $ToReturn = -1
	If Not $g_bRunState Then Return

	If $g_bForceBrewSpells Then ; If Force Brew Spells Before Attack Is Enabled
		$ToReturn = 2
		Return $ToReturn
	EndIf

	; Code For DeadBase
	If $g_abAttackTypeEnable[$DB] Then
		If $g_aiAttackAlgorithm[$DB] = 1 Then ; Scripted Attack is Selected
			If IsGUICheckedForSpell($Spell, $DB) Then
				$ToReturn = CountCommandsForSpell($Spell, $DB)
				If $ToReturn = 0 Then $ToReturn = -1
			Else ; Spell not selected to be used in GUI so bot will not use Spell
				$ToReturn = -1
			EndIf
		Else ; Scripted Attack is NOT selected, And Starndard attacks not using Spells YET So The spell will not be used in attack
			$ToReturn = -1
		EndIf
	EndIf

	; Code For ActiveBase
	If $g_abAttackTypeEnable[$LB] Then
		If $g_aiAttackAlgorithm[$LB] = 1 Then ; Scripted Attack is Selected
			If IsGUICheckedForSpell($Spell, $LB) Then
				$ToReturn = CountCommandsForSpell($Spell, $LB)
				If $ToReturn = 0 Then $ToReturn = -1
			EndIf
		EndIf
	EndIf

	Return $ToReturn
EndFunc   ;==>HowManyTimesWillBeUsed

Func CountCommandsForSpell($Spell, $Mode)
	Local $ToReturn = 0
	Local $filename = ""
	If Not $g_bRunState Then Return
	If $Mode = $DB Then
		$filename = $g_sAttackScrScriptName[$DB]
	Else
		$filename = $g_sAttackScrScriptName[$LB]
	EndIf

	Local $rownum = 0
	If FileExists($g_sCSVAttacksPath & "\" & $filename & ".csv") Then
		Local $f, $line, $acommand, $command
		Local $value1, $Troop
		$f = FileOpen($g_sCSVAttacksPath & "\" & $filename & ".csv", 0)
		; Read in lines of text until the EOF is reached
		While 1
			$line = FileReadLine($f)
			$rownum += 1
			If @error = -1 Then ExitLoop
			$acommand = StringSplit($line, "|")
			If $acommand[0] >= 8 Then
				$command = StringStripWS(StringUpper($acommand[1]), 2)
				$Troop = StringStripWS(StringUpper($acommand[5]), 2)
				If $Troop = $Spell Then $ToReturn += 1
			EndIf
		WEnd
		FileClose($f)
	Else
		$ToReturn = 0
	EndIf
	Return $ToReturn
EndFunc   ;==>CountCommandsForSpell

Func IsGUICheckedForSpell($Spell, $Mode)
	Local $sSpell = ""
	Local $aVal = 0

	If Not $g_bRunState Then Return
	Switch TroopIndexLookup($Spell, "IsGUICheckedForSpell")
		Case $eLSpell
			$sSpell = "Lightning"
			$aVal = $g_abAttackUseLightSpell
		Case $eHSpell
			$sSpell = "Heal"
			$aVal = $g_abAttackUseHealSpell
		Case $eRSpell
			$sSpell = "Rage"
			$aVal = $g_abAttackUseRageSpell
		Case $eJSpell
			$sSpell = "Jump"
			$aVal = $g_abAttackUseJumpSpell
		Case $eFSpell
			$sSpell = "Freeze"
			$aVal = $g_abAttackUseFreezeSpell
		Case $eCSpell
			$sSpell = "Clone"
			$aVal = $g_abAttackUseCloneSpell
		Case $ePSpell
			$sSpell = "Poison"
			$aVal = $g_abAttackUsePoisonSpell
		Case $eESpell
			$sSpell = "Earthquake"
			$aVal = $g_abAttackUseEarthquakeSpell
		Case $eHaSpell
			$sSpell = "Haste"
			$aVal = $g_abAttackUseHasteSpell
		Case $eSkSpell
			$sSpell = "Skeleton"
			$aVal = $g_abAttackUseSkeletonSpell
		Case $eBtSpell
			$sSpell = "Bat"
			$aVal = $g_abAttackUseBatSpell
	EndSwitch

	If IsArray($aVal) Then Return $aVal[$Mode]
	Return False
EndFunc   ;==>IsGUICheckedForSpell

Func DragIfNeeded($Troop)

	If Not $g_bRunState Then Return
	Local $bCheckPixel = False

	If IsDarkTroop($Troop) Then
		If _ColorCheck(_GetPixelColor(834, 403, True), Hex(0xD3D3CB, 6), 5) Then $bCheckPixel = True
		If $g_bDebugSetlogTrain Then SetLog("DragIfNeeded Dark Troops: " & $bCheckPixel)
		For $i = 1 To 3
			If Not $bCheckPixel Then
				ClickDrag(715, 445 + $g_iMidOffsetY, 220, 445 + $g_iMidOffsetY, 2000)
				If _Sleep(1500) Then Return
				If _ColorCheck(_GetPixelColor(834, 403, True), Hex(0xD3D3CB, 6), 5) Then $bCheckPixel = True
			Else
				Return True
			EndIf
		Next
	Else
		If _ColorCheck(_GetPixelColor(22, 403, True), Hex(0xD3D3CB, 6), 5) Then $bCheckPixel = True
		If $g_bDebugSetlogTrain Then SetLog("DragIfNeeded Normal Troops: " & $bCheckPixel)
		For $i = 1 To 3
			If Not $bCheckPixel Then
				ClickDrag(220, 445 + $g_iMidOffsetY, 725, 445 + $g_iMidOffsetY, 2000)
				If _Sleep(1500) Then Return
				If _ColorCheck(_GetPixelColor(22, 403, True), Hex(0xD3D3CB, 6), 5) Then $bCheckPixel = True
			Else
				Return True
			EndIf
		Next
	EndIf
	Local $iIndex = TroopIndexLookup($Troop, "DragIfNeeded")
	If $iIndex <> -1 And $iIndex < UBound($g_asTroopNames) Then SetLog("Failed to Verify Troop " & $g_asTroopNames[$iIndex] & " Position or Failed to Drag Successfully", $COLOR_ERROR)
	Return False
EndFunc   ;==>DragIfNeeded

Func DoWhatToTrainContainSpell($rWTT)
	For $i = 0 To (UBound($rWTT) - 1)
		If Not $g_bRunState Then Return
		If IsSpellToBrew($rWTT[$i][0]) Then
			If $rWTT[$i][1] > 0 Then Return True
		EndIf
	Next
	Return False
EndFunc   ;==>DoWhatToTrainContainSpell

Func IsElixirTroop($Troop)
	Local $iIndex = TroopIndexLookup($Troop, "IsElixirTroop")
	If $iIndex >= $eBarb And $iIndex <= $eMine Then Return True
	Return False
EndFunc   ;==>IsElixirTroop

Func IsDarkTroop($Troop)
	Local $iIndex = TroopIndexLookup($Troop, "IsDarkTroop")
	If $iIndex >= $eMini And $iIndex <= $eIceG Then Return True
	Return False
EndFunc   ;==>IsDarkTroop

Func IsElixirSpell($Spell)
	Local $iIndex = TroopIndexLookup($Spell, "IsElixirSpell")
	If $iIndex >= $eLSpell And $iIndex <= $eCSpell Then Return True
	Return False
EndFunc   ;==>IsElixirSpell

Func IsDarkSpell($Spell)
	Local $iIndex = TroopIndexLookup($Spell, "IsDarkSpell")
	If $iIndex >= $ePSpell And $iIndex <= $eBtSpell Then Return True
	Return False
EndFunc   ;==>IsDarkSpell

Func IsSpellToBrew($sName)
	Local $iIndex = TroopIndexLookup($sName, "IsSpellToBrew")
	If $iIndex >= $eLSpell And $iIndex <= $eBtSpell Then Return True
	Return False
EndFunc   ;==>IsSpellToBrew

Func CalcNeededSpace($Troop, $Quantity)
	If Not $g_bRunState Then Return -1

	Local $iIndex = TroopIndexLookup($Troop, "CalcNeededSpace")
	If $iIndex = -1 Then Return -1

	If $iIndex >= $eBarb And $iIndex <= $eIceG Then
		Return Number($g_aiTroopSpace[$iIndex] * $Quantity)
	EndIf

	If $iIndex >= $eLSpell And $iIndex <= $eBtSpell Then
		Return Number($g_aiSpellSpace[$iIndex - $eLSpell] * $Quantity)
	EndIf

	Return -1
EndFunc   ;==>CalcNeededSpace

Func RemoveExtraTroops($toRemove)
	Local $CounterToRemove = 0, $iResult = 0
	; Army Window should be open and should be in Tab 'Army tab'

	; 1 Means Removed Troops without Deleting Troops Queued
	; 2 Means Removed Troops And Also Deleted Troops Queued
	; 3 Means Didn't removed troop... Everything was well

	If UBound($toRemove) = 1 And $toRemove[0][0] = "Arch" And $toRemove[0][1] = 0 Then Return 3

	If $g_bIsFullArmywithHeroesAndSpells Or ($g_iCommandStop = 3 Or $g_iCommandStop = 0) = True And Not $g_iActiveDonate Then Return 3


	If UBound($toRemove) > 0 Then ; If needed to remove troops
		Local $rGetSlotNumber = GetSlotNumber() ; Get all available Slot numbers with troops assigned on them
		Local $rGetSlotNumberSpells = GetSlotNumber(True) ; Get all available Slot numbers with Spells assigned on them

		; Check if Troops to remove are already in Train Tab Queue!! If was, Will Delete All Troops Queued Then Check Everything Again...
		If Not IsQueueEmpty("Troops") Then
			If Not OpenTroopsTab(True, "RemoveExtraTroops()") Then Return
			For $i = 0 To (UBound($toRemove) - 1)
				If Not $g_bRunState Then Return
				If IsSpellToBrew($toRemove[$i][0]) Then ExitLoop
				$CounterToRemove += 1
				If IsAlreadyTraining($toRemove[$i][0]) Then
					SetLog($g_asTroopNames[TroopIndexLookup($toRemove[$i][0])] & " Is in Train Tab Queue By Mistake!", $COLOR_INFO)
					DeleteQueued("Troops")
					$iResult = 2
				EndIf
			Next
		EndIf

		If Not IsQueueEmpty("Spells") Then
			If TotalSpellsToBrewInGUI() > 0 Then
				If Not OpenSpellsTab(True, "RemoveExtraTroops()") Then Return
				For $i = $CounterToRemove To (UBound($toRemove) - 1)
					If Not $g_bRunState Then Return
					If IsAlreadyTraining($toRemove[$i][0], True) Then
						SetLog($g_asSpellNames[TroopIndexLookup($toRemove[$i][0]) - $eLSpell] & " Is in Spells Tab Queue By Mistake!", $COLOR_INFO)
						DeleteQueued("Spells")
						$iResult = 2
					EndIf
				Next
			EndIf
		EndIf

		If Not OpenArmyTab(False, "RemoveExtraTroops()") Then Return
		$toRemove = WhatToTrain(True, False)

		$rGetSlotNumber = GetSlotNumber() ; Get all available Slot numbers with troops assigned on them
		$rGetSlotNumberSpells = GetSlotNumber(True)

		SetLog("Troops To Remove: ", $COLOR_INFO)
		$CounterToRemove = 0
		; Loop through Troops needed to get removed Just to write some Logs
		For $i = 0 To (UBound($toRemove) - 1)
			If IsSpellToBrew($toRemove[$i][0]) Then ExitLoop
			$CounterToRemove += 1
			SetLog(" - " & $g_asTroopNames[TroopIndexLookup($toRemove[$i][0])] & ": " & $toRemove[$i][1] & "x", $COLOR_SUCCESS)
		Next

		If TotalSpellsToBrewInGUI() > 0 Then
			If $CounterToRemove <= UBound($toRemove) Then
				SetLog("Spells To Remove: ", $COLOR_INFO)
				For $i = $CounterToRemove To (UBound($toRemove) - 1)
					SetLog(" - " & $g_asSpellNames[TroopIndexLookup($toRemove[$i][0]) - $eLSpell] & ": " & $toRemove[$i][1] & "x", $COLOR_SUCCESS)
				Next
			EndIf
		EndIf

		If Not _CheckPixel($aButtonEditArmy, True) Then ; If no 'Edit Army' Button found in army tab to edit troops
			SetLog("Cannot find/verify 'Edit Army' Button in Army tab", $COLOR_WARNING)
			Return False ; Exit function
		EndIf
		ClickP($aButtonEditArmy, 1) ; Click Edit Army Button
		If _Sleep(500) Then Return
		If Not $g_bRunState Then Return

		; Loop through troops needed to get removed
		$CounterToRemove = 0
		For $j = 0 To (UBound($toRemove) - 1)
			If IsSpellToBrew($toRemove[$j][0]) Then ExitLoop
			$CounterToRemove += 1
			For $i = 0 To (UBound($rGetSlotNumber) - 1) ; Loop through All available slots
				; $toRemove[$j][0] = Troop name, E.g: Barb, $toRemove[$j][1] = Quantity to remove
				If $toRemove[$j][0] = $rGetSlotNumber[$i] Then ; If $toRemove Troop Was the same as The Slot Troop
					Local $pos = GetSlotRemoveBtnPosition($i + 1) ; Get positions of - Button to remove troop
					ClickRemoveTroop($pos, $toRemove[$j][1], $g_iTrainClickDelay) ; Click on Remove button as much as needed
				EndIf
			Next
		Next

		If TotalSpellsToBrewInGUI() > 0 Then
			For $j = $CounterToRemove To (UBound($toRemove) - 1)
				For $i = 0 To (UBound($rGetSlotNumberSpells) - 1) ; Loop through All available slots
					; $toRemove[$j][0] = Troop name, E.g: Barb, $toRemove[$j][1] = Quantity to remove
					If $toRemove[$j][0] = $rGetSlotNumberSpells[$i] Then ; If $toRemove Troop Was the same as The Slot Troop
						Local $pos = GetSlotRemoveBtnPosition($i + 1, True) ; Get positions of - Button to remove troop
						ClickRemoveTroop($pos, $toRemove[$j][1], $g_iTrainClickDelay) ; Click on Remove button as much as needed
					EndIf
				Next
			Next
		EndIf

		If _Sleep(400) Then Return

		; Click Okay & confirm
		Local $counter = 0
		While Not _CheckPixel($aButtonRemoveTroopsOK1, True) ; If no 'Okay' button found in army tab to save changes
			If _Sleep(200) Then Return
			$counter += 1
			If $counter <= 5 Then ContinueLoop
			SetLog("Cannot find/verify 'Okay' Button in Army tab", $COLOR_WARNING)
			ClickP($aAway, 2, 0, "#0346") ; Click Away, Necessary! due to possible errors/changes
			If _Sleep(400) Then OpenArmyOverview(True, "RemoveExtraTroops()") ; Open Army Window AGAIN
			Return False ; Exit Function
		WEnd

		ClickP($aButtonRemoveTroopsOK1, 1) ; Click on 'Okay' button to save changes

		If _Sleep(400) Then Return

		$counter = 0
		While Not _CheckPixel($aButtonRemoveTroopsOK2, True) ; If no 'Okay' button found to verify that we accept the changes
			If _Sleep(200) Then Return
			$counter += 1
			If $counter <= 5 Then ContinueLoop
			SetLog("Cannot find/verify 'Okay #2' Button in Army tab", $COLOR_WARNING)
			ClickP($aAway, 2, 0, "#0346") ;Click Away
			Return False ; Exit function
		WEnd

		ClickP($aButtonRemoveTroopsOK2, 1) ; Click on 'Okay' button to Save changes... Last button

		SetLog("All Extra troops removed", $COLOR_SUCCESS)
		If _Sleep(200) Then Return
		If $iResult = 0 Then $iResult = 1
	Else ; If No extra troop found
		SetLog("No extra troop to remove, great", $COLOR_SUCCESS)
		$iResult = 3
	EndIf

	Return $iResult
EndFunc   ;==>RemoveExtraTroops

Func DeleteInvalidTroopInArray(ByRef $aTroopArray)
	Local $iCounter = 0

	Switch (UBound($aTroopArray, 2) > 0) ; If Array Is 2D Array
		Case True
			Local $bIsValid = True, $i2DBound = UBound($aTroopArray, 2)
			For $i = 0 To (UBound($aTroopArray) - 1)
				If $aTroopArray[$i][0] Then
					If TroopIndexLookup($aTroopArray[$i][0], "DeleteInvalidTroopInArray#1") = -1 Or $aTroopArray[$i][0] = "" Then $bIsValid = False

					If $bIsValid Then
						For $j = 0 To (UBound($aTroopArray, 2) - 1)
							$aTroopArray[$iCounter][$j] = $aTroopArray[$i][$j]
						Next
						$iCounter += 1
					EndIf
				EndIf
			Next
			ReDim $aTroopArray[$iCounter][$i2DBound]
		Case Else
			For $i = 0 To (UBound($aTroopArray) - 1)
				If TroopIndexLookup($aTroopArray[$i], "DeleteInvalidTroopInArray#2") = -1 Or $aTroopArray[$i] = "" Then
					$aTroopArray[$iCounter] = $aTroopArray[$i]
					$iCounter += 1
				EndIf
			Next
			ReDim $aTroopArray[$iCounter]
	EndSwitch
EndFunc   ;==>DeleteInvalidTroopInArray

Func RemoveExtraTroopsQueue() ; Will remove All Extra troops in queue If there's a Low Opacity red color on them
	;Local Const $DecreaseBy = 70
	;Local $x = 834
	If $g_bIsFullArmywithHeroesAndSpells Then Return True

	Local Const $y = 186, $yRemoveBtn = 200, $xDecreaseRemoveBtn = 10
	Local $bColorCheck = False, $bGotRemoved = False
	For $x = 834 To 58 Step -70
		If Not $g_bRunState Then Return
		$bColorCheck = _ColorCheck(_GetPixelColor($x, $y, True), Hex(0xD7AFA9, 6), 20)
		If $bColorCheck Then
			$bGotRemoved = True
			Do
				Click($x - $xDecreaseRemoveBtn, $yRemoveBtn, 2, $g_iTrainClickDelay)
				If _Sleep(20) Then Return
				$bColorCheck = _ColorCheck(_GetPixelColor($x, $y, True), Hex(0xD7AFA9, 6), 20)
			Until $bColorCheck = False

		ElseIf Not $bColorCheck And $bGotRemoved Then
			ExitLoop
		EndIf
	Next

	Return True
EndFunc   ;==>RemoveExtraTroopsQueue

Func IsAlreadyTraining($Troop, $bSpells = False)
	If Not $g_bRunState Then Return

	If $bSpells Then
		If IsQueueEmpty("Troops") Then Return False ; If No troops were in Queue

		Local $QueueTroops = CheckQueueTroops(False, False) ; Get Troops that they're currently training...
		For $i = 0 To (UBound($QueueTroops) - 1)
			If $QueueTroops[$i] = $Troop Then Return True
		Next
	Else
		If IsQueueEmpty("Spells", False, $g_bForceBrewSpells = True ? False : True) Then Return False ; If No Spells were in Queue

		Local $QueueSpells = CheckQueueSpells(False, False) ; Get Troops that they're currently training...
		For $i = 0 To (UBound($QueueSpells) - 1)
			If $QueueSpells[$i] = $Troop Then Return True
		Next
	EndIf

	Return False
EndFunc   ;==>IsAlreadyTraining

Func IsQueueEmpty($sType = "Troops", $bSkipTabCheck = False, $removeExtraTroopsQueue = True)
	Local $iArrowX, $iArrowY

	If Not $g_bRunState Then Return

	If $sType = "Troops" Then
		$iArrowX = $aGreenArrowTrainTroops[0] ; aada82  170 218 130    | y + 3 = 6ab320 106 179 32
		$iArrowY = $aGreenArrowTrainTroops[1]
	ElseIf $sType = "Spells" Then
		$iArrowX = $aGreenArrowBrewSpells[0] ; a0d077  160 208 119    | y + 3 = 74be2c 116 190 44
		$iArrowY = $aGreenArrowBrewSpells[1]
	EndIf

	If Not _ColorCheck(_GetPixelColor($iArrowX, $iArrowY, True), Hex(0xa0d077, 6), 30) And Not _ColorCheck(_GetPixelColor($iArrowX, $iArrowY + 4, True), Hex(0x6ab320, 6), 30) Then
		Return True ; Check Green Arrows at top first, if not there -> Return
	ElseIf _ColorCheck(_GetPixelColor($iArrowX, $iArrowY, True), Hex(0xa0d077, 6), 30) And _ColorCheck(_GetPixelColor($iArrowX, $iArrowY + 4, True), Hex(0x6ab320, 6), 30) And Not $removeExtraTroopsQueue Then
		If Not WaitforPixel($iArrowX - 11, $iArrowY - 1, $iArrowX - 9, $iArrowY + 1, Hex(0xa0d077, 6), 30, 2) Then Return False ; check if boost arrow
	EndIf

	If Not $bSkipTabCheck Then
		If $sType = "Troops" Then
			If Not OpenTroopsTab(True, "IsQueueEmpty()") Then Return
		Else
			If Not OpenSpellsTab(True, "IsQueueEmpty()") Then Return
		EndIf
	EndIf

	If Not $g_bIsFullArmywithHeroesAndSpells Then
		If $removeExtraTroopsQueue Then
			If Not _ColorCheck(_GetPixelColor(230, 208, True), Hex(0x677CB5, 6), 30) Then RemoveExtraTroopsQueue()
		EndIf
	EndIf

	If $removeExtraTroopsQueue Then
		If _ColorCheck(_GetPixelColor(230, 208, True), Hex(0x677CB5, 6), 20) Then Return True ; If No troops were in Queue Return True
	Else
		If _ColorCheck(_GetPixelColor(820, 208, True), Hex(0xD0D0C8, 6), 20) Then Return True ; check gray background at 1st training slot
	EndIf

	Return False
EndFunc   ;==>IsQueueEmpty

Func ClickRemoveTroop($pos, $iTimes, $iSpeed)
	$pos[0] = Random($pos[0] - 3, $pos[0] + 10, 1)
	$pos[1] = Random($pos[1] - 5, $pos[1] + 5, 1)
	If Not $g_bRunState Then Return
	If _Sleep(400) Then Return
	If $iTimes <> 1 Then
		If FastCaptureRegion() Then
			For $i = 0 To ($iTimes - 1)
				PureClick($pos[0], $pos[1], 1, $iSpeed) ;Click once.
				If _Sleep($iSpeed, False) Then ExitLoop
			Next
		Else
			PureClick($pos[0], $pos[1], $iTimes, $iSpeed) ;Click $iTimes.
			If _Sleep($iSpeed, False) Then Return
		EndIf
	Else
		PureClick($pos[0], $pos[1], 1, $iSpeed)

		If _Sleep($iSpeed, False) Then Return
	EndIf
EndFunc   ;==>ClickRemoveTroop

Func GetSlotRemoveBtnPosition($iSlot, $bSpells = False)
	Local $iRemoveY = Not $bSpells ? 270 : 417
	Local $iRemoveX = Number((74 * $iSlot) - 4)

	Local Const $aResult[2] = [$iRemoveX, $iRemoveY]
	Return $aResult
EndFunc   ;==>GetSlotRemoveBtnPosition

Func GetSlotNumber($bSpells = False)
	Select
		Case $bSpells = False
			Local Const $Orders = [$eBarb, $eArch, $eGiant, $eGobl, $eWall, $eBall, $eWiza, $eHeal, $eDrag, $ePekk, $eBabyD, $eMine, $eEDrag, _
					$eMini, $eHogs, $eValk, $eGole, $eWitc, $eLava, $eBowl, $eIceG] ; Set Order of troop display in Army Tab

			Local $allCurTroops[UBound($Orders)]

			; Code for Elixir Troops to Put Current Troops into an array by Order
			For $i = 0 To $eTroopCount - 1
				If Not $g_bRunState Then Return
				If $g_aiCurrentTroops[$i] > 0 Then
					For $j = 0 To (UBound($Orders) - 1)
						If TroopIndexLookup($g_asTroopShortNames[$i], "GetSlotNumber#1") = $Orders[$j] Then
							$allCurTroops[$j] = $g_asTroopShortNames[$i]
						EndIf
					Next
				EndIf
			Next

			_ArryRemoveBlanks($allCurTroops)

			Return $allCurTroops
		Case $bSpells = True

			; Set Order of Spells display in Army Tab
			Local Const $SpellsOrders = [$eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell, $eCSpell, $ePSpell, $eESpell, $eHaSpell, $eSkSpell, $eBtSpell]

			Local $allCurSpells[UBound($SpellsOrders)]

			; Code for Spells to Put Current Spells into an array by Order
			For $i = 0 To $eSpellCount - 1
				If Not $g_bRunState Then Return
				If $g_aiCurrentSpells[$i] > 0 Then
					For $j = 0 To (UBound($SpellsOrders) - 1)
						If TroopIndexLookup($g_asSpellShortNames[$i], "GetSlotNumber#2") = $SpellsOrders[$j] Then
							$allCurSpells[$j] = $g_asSpellShortNames[$i]
						EndIf
					Next
				EndIf
			Next

			_ArryRemoveBlanks($allCurSpells)

			Return $allCurSpells
	EndSelect
EndFunc   ;==>GetSlotNumber

Func WhatToTrain($ReturnExtraTroopsOnly = False, $bSetLog = True)
	If Not OpenArmyTab(False, "WhatToTrain()") Then Return
	Local $ToReturn[1][2] = [["Arch", 0]]

	If $g_bIsFullArmywithHeroesAndSpells And Not $ReturnExtraTroopsOnly Then
		If $g_iCommandStop = 3 Or $g_iCommandStop = 0 Then
			If $g_bFirstStart Then $g_bFirstStart = False
			Return $ToReturn
		EndIf
		SetLog(" - Your Army is Full, let's make troops before Attack!", $COLOR_INFO)
		; Elixir Troops
		For $i = 0 To $eTroopCount - 1
			Local $troopIndex = $g_aiTrainOrder[$i]
			If $g_aiArmyCompTroops[$troopIndex] > 0 Then
				$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
				$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompTroops[$troopIndex]
				ReDim $ToReturn[UBound($ToReturn) + 1][2]
			EndIf
		Next

		; Spells
		For $i = 0 To $eSpellCount - 1
			Local $BrewIndex = $g_aiBrewOrder[$i]
			If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
			If $g_aiArmyCompSpells[$BrewIndex] > 0 Then
				If HowManyTimesWillBeUsed($g_asSpellShortNames[$BrewIndex]) > 0 Then
					$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
					$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompSpells[$BrewIndex]
					ReDim $ToReturn[UBound($ToReturn) + 1][2]
				Else
					getArmySpells(False, False, False, False)
					If $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex] > 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex]
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					Else
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = 9999
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			EndIf
		Next
		Return $ToReturn
	EndIf

	; Get Current available troops
	getArmyTroops(False, False, False, False)
	getArmySpells(False, False, False, False)

	Switch $ReturnExtraTroopsOnly
		Case False
			; Check Elixir Troops needed quantity to Train
			For $ii = 0 To $eTroopCount - 1
				Local $troopIndex = $g_aiTrainOrder[$ii]
				If $g_aiArmyCompTroops[$troopIndex] > 0 Then
					$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
					$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex]
					ReDim $ToReturn[UBound($ToReturn) + 1][2]
				EndIf
			Next

			; Check Spells needed quantity to Brew
			For $i = 0 To $eSpellCount - 1
				Local $BrewIndex = $g_aiBrewOrder[$i]
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $g_aiArmyCompSpells[$BrewIndex] > 0 Then
					$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
					$ToReturn[UBound($ToReturn) - 1][1] = $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex]
					ReDim $ToReturn[UBound($ToReturn) + 1][2]
				EndIf
			Next
		Case Else
			; Check Elixir Troops Extra Quantity
			For $ii = 0 To $eTroopCount - 1
				Local $troopIndex = $g_aiTrainOrder[$ii]
				If $g_aiCurrentTroops[$troopIndex] > 0 Then
					If $g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex] < 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asTroopShortNames[$troopIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next

			; Check Spells Extra Quantity
			For $i = 0 To $eSpellCount - 1
				Local $BrewIndex = $g_aiBrewOrder[$i]
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $g_aiCurrentSpells[$BrewIndex] > 0 Then
					If $g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex] < 0 Then
						$ToReturn[UBound($ToReturn) - 1][0] = $g_asSpellShortNames[$BrewIndex]
						$ToReturn[UBound($ToReturn) - 1][1] = Abs($g_aiArmyCompSpells[$BrewIndex] - $g_aiCurrentSpells[$BrewIndex])
						ReDim $ToReturn[UBound($ToReturn) + 1][2]
					EndIf
				EndIf
			Next
	EndSwitch
	DeleteInvalidTroopInArray($ToReturn)
	Return $ToReturn
EndFunc   ;==>WhatToTrain

Func TestTroopsCoords()
	Local $iCount = 3
	$g_bRunState = True
	For $i = 0 To $eTroopCount - 1
		DragIfNeeded($g_asTroopShortNames[$i])
		TrainIt(TroopIndexLookup($g_asTroopShortNames[$i], "TestTroopsCoords"), $iCount, $g_iTrainClickDelay)
	Next
	$g_bRunState = False
EndFunc   ;==>TestTroopsCoords

Func TestSpellsCoords()
	Local $iCount = 1
	$g_bRunState = True
	For $i = 0 To $eSpellCount - 1
		TrainIt(TroopIndexLookup($g_asTroopShortNames[$i]), $iCount, $g_iTrainClickDelay)
	Next
	$g_bRunState = False
EndFunc   ;==>TestSpellsCoords

Func LeftSpace($bReturnAll = False)
	; Need to be in 'Train Tab'
	Local $aRemainTrainSpace = GetOCRCurrent(48, 160)
	If Not $g_bRunState Then Return

	If Not $bReturnAll Then
		Return Number($aRemainTrainSpace[2])
	Else
		Return $aRemainTrainSpace
	EndIf
EndFunc   ;==>LeftSpace

Func IsArmyWindow($bSetLog = False, $iTabNumber = 0)

	Local $i = 0
	Local $_TabNumber[4][4] = [[114, 115, 0xF8F8F8, 5], [284, 115, 0xF8F8F8, 5], [460, 115, 0xF8F8F8, 5], [702, 115, 0xF8F8F8, 5]] ; Grey pixel on the tab name when is selected
	Local $CheckIT[4] = [$_TabNumber[$iTabNumber][0], $_TabNumber[$iTabNumber][1], $_TabNumber[$iTabNumber][2], $_TabNumber[$iTabNumber][3]]

	Local $txt = ""
	Switch $iTabNumber
		Case $ArmyTAB
			$txt = "Army Window"
		Case $TrainTroopsTAB
			$txt = "Train Troops Window"
		Case $BrewSpellsTAB
			$txt = "Brew Spells Window"
		Case $QuickTrainTAB
			$txt = "Quick Train Window"
	EndSwitch

	If _CheckPixel($aIsTrainPgChk1, True) Then
		While $i < 1
			If Not $g_bRunState Then Return
			If $g_bDebugSetlogTrain Then SetLog("$CheckIT[0]: " & $CheckIT[0])
			If $g_bDebugSetlogTrain Then SetLog("$CheckIT[1]: " & $CheckIT[1])
			If $g_bDebugSetlogTrain Then SetLog("$CheckIT[2]: " & Hex($CheckIT[2], 6))
			If $g_bDebugSetlogTrain Then SetLog("$CheckIT[3]: " & $CheckIT[3])
			If _ColorCheck(_GetPixelColor($CheckIT[0], $CheckIT[1], True), Hex($CheckIT[2], 6), $CheckIT[3]) Then ExitLoop

			If _Sleep($DELAYISTRAINPAGE2) Then ExitLoop
			$i += 1
		WEnd
	Else
		$i = 1
		If $bSetLog Or $g_bDebugSetlogTrain Then SetLog("Cannot find Red X | TAB " & $txt, $COLOR_ERROR) ; in case of $i > 10 in while loop
	EndIf

	If $i < 1 Then
		If ($g_bDebugSetlog Or $g_bDebugClick) Or $bSetLog Or $g_bDebugSetlogTrain Then SetLog("**" & $txt & " OK**", $COLOR_DEBUG) ;Debug
		Return True
	Else
		If $bSetLog Or $g_bDebugSetlogTrain Then SetLog("You are not in " & $txt & " | TAB " & $iTabNumber, $COLOR_ERROR) ; in case of $i > 10 in while loop
		If $g_bDebugImageSave Then DebugImageSave("IsTrainPage")
		Return False
	EndIf

EndFunc   ;==>IsArmyWindow

Func CheckQueueTroops($bGetQuantity = True, $bSetLog = True, $x = 839, $bQtyWSlot = False)
	Local $aResult[1] = [""]
	If $bSetLog Then SetLog("Checking Troops Queue...", $COLOR_INFO)

	Local $Dir = @ScriptDir & "\imgxml\ArmyOverview\TroopQueued"

	Local $aSearchResult = SearchArmy($Dir, 18, 182, $x, 261, $bGetQuantity ? "Queue" : "")

	ReDim $aResult[UBound($aSearchResult)]

	If $aSearchResult[0][0] = "" Then
		Setlog("No Troops detected!", $COLOR_ERROR)
		Return
	EndIf

	For $i = 0 To (UBound($aSearchResult) - 1)
		If Not $g_bRunState Then Return
		$aResult[$i] = $aSearchResult[$i][0]
	Next

	If $bGetQuantity Then
		Local $aQuantities[UBound($aResult)][2]
		Local $aQueueTroop[$eTroopCount]
		For $i = 0 To (UBound($aQuantities) - 1)
			$aQuantities[$i][0] = $aSearchResult[$i][0]
			$aQuantities[$i][1]	= $aSearchResult[$i][3]
			Local $iTroopIndex = TroopIndexLookup($aQuantities[$i][0])
			If $iTroopIndex >= 0 And $iTroopIndex < $eTroopCount Then
				If $bSetLog Then SetLog("  - " & $g_asTroopNames[TroopIndexLookup($aQuantities[$i][0], "CheckQueueTroops")] & ": " & $aQuantities[$i][1] & "x", $COLOR_SUCCESS)
				$aQueueTroop[$iTroopIndex] += $aQuantities[$i][1]
			Else
				; TODO check what to do with others
				SetDebugLog("Unsupport troop index: " & $iTroopIndex)
			EndIf
		Next
		If $bQtyWSlot Then Return $aQuantities
		Return $aQueueTroop
	EndIf

	_ArrayReverse($aResult)
	Return $aResult
EndFunc   ;==>CheckQueueTroops

Func CheckQueueSpells($bGetQuantity = True, $bSetLog = True, $x = 839, $bQtyWSlot = False)
	Local $aResult[1] = [""], $sImageDir = "trainwindow-SpellsInQueue-bundle"
	;$hTimer = TimerInit()
	If $bSetLog Then SetLog("Checking Spells Queue...", $COLOR_INFO)

	Local $aSearchResult = SearchArmy($sImageDir, 18, 215, $x, 230, $bGetQuantity ? "Queue" : "")
	ReDim $aResult[UBound($aSearchResult)]

	If $aSearchResult[0][0] = "" Then
		Setlog("No Spells detected!", $COLOR_ERROR)
		Return
	EndIf

	For $i = 0 To (UBound($aSearchResult) - 1)
		If Not $g_bRunState Then Return
		$aResult[$i] = $aSearchResult[$i][0]
	Next

	If $bGetQuantity Then
		Local $aQuantities[UBound($aResult)][2]
		Local $aQueueSpell[$eSpellCount]
		For $i = 0 To (UBound($aQuantities) - 1)
			If Not $g_bRunState Then Return
			$aQuantities[$i][0] = $aSearchResult[$i][0]
			$aQuantities[$i][1] = $aSearchResult[$i][3]
			If $bSetLog Then SetLog("  - " & $g_asSpellNames[TroopIndexLookup($aQuantities[$i][0], "CheckQueueSpells") - $eLSpell] & ": " & $aQuantities[$i][1] & "x", $COLOR_SUCCESS)
			$aQueueSpell[TroopIndexLookup($aQuantities[$i][0]) - $eLSpell] += $aQuantities[$i][1]
		Next
		If $bQtyWSlot Then Return $aQuantities
		Return $aQueueSpell
	EndIf

	_ArrayReverse($aResult)
	Return $aResult
EndFunc   ;==>CheckQueueSpells

Func SearchArmy($sImageDir = "", $x = 0, $y = 0, $x1 = 0, $y1 = 0, $sArmyType = "", $bSkipReceivedTroopsCheck = False)
	; Setup arrays, including default return values for $return
	Local $aResult[1][4], $aCoordArray[1][2], $aCoords, $aCoordsSplit, $aValue

	For $iCount = 0 To 10
		If Not $g_bRunState Then Return $aResult
		If Not getReceivedTroops(162, 200, $bSkipReceivedTroopsCheck) Then
			; Perform the search
			_CaptureRegion2($x, $y, $x1, $y1)
			Local $res = DllCallMyBot("SearchMultipleTilesBetweenLevels", "handle", $g_hHBitmap2, "str", $sImageDir, "str", "FV", "Int", 0, "str", "FV", "Int", 0, "Int", 1000)

			If $res[0] <> "" Then
				; Get the keys for the dictionary item.
				Local $aKeys = StringSplit($res[0], "|", $STR_NOCOUNT)

				; Redimension the result array to allow for the new entries
				ReDim $aResult[UBound($aKeys)][4]
				Local $iResultAddDup = 0

				; Loop through the array
				For $i = 0 To UBound($aKeys) - 1
					; Get the property values
					$aResult[$i + $iResultAddDup][0] = RetrieveImglocProperty($aKeys[$i], "objectname")
					; Get the coords property
					$aValue = RetrieveImglocProperty($aKeys[$i], "objectpoints")
					$aCoords = decodeMultipleCoords($aValue, 50) ; dedup coords by x on 50 pixel
					$aCoordsSplit = $aCoords[0]
					If UBound($aCoordsSplit) = 2 Then
						; Store the coords into a two dimensional array
						$aCoordArray[0][0] = $aCoordsSplit[0] + $x ; X coord.
						$aCoordArray[0][1] = $aCoordsSplit[1] + $y ; Y coord.
					Else
						$aCoordArray[0][0] = -1
						$aCoordArray[0][1] = -1
					EndIf
					; Store the coords array as a sub-array
					$aResult[$i + $iResultAddDup][1] = Number($aCoordArray[0][0])
					$aResult[$i + $iResultAddDup][2] = Number($aCoordArray[0][1])
					SetDebugLog($aResult[$i + $iResultAddDup][0] & " | $aCoordArray: " & $aCoordArray[0][0] & "-" & $aCoordArray[0][1])
					; If 1 troop type appears at more than 1 slot
					Local $iMultipleCoords = UBound($aCoords)
					If $iMultipleCoords > 1 Then
						SetDebugLog($aResult[$i + $iResultAddDup][0] & " detected " & $iMultipleCoords & " times!")
						For $j = 1 To $iMultipleCoords - 1
							Local $aCoordsSplit2 = $aCoords[$j]
							If UBound($aCoordsSplit2) = 2 Then
								; add slot
								$iResultAddDup += 1
								ReDim $aResult[UBound($aKeys) + $iResultAddDup][4]
								$aResult[$i + $iResultAddDup][0] = $aResult[$i + $iResultAddDup - 1][0] ; same objectname
								$aResult[$i + $iResultAddDup][1] = $aCoordsSplit2[0] + $x
								$aResult[$i + $iResultAddDup][2] = $aCoordsSplit2[1]
								SetDebugLog($aResult[$i + $iResultAddDup][0] & " | $aCoordArray: " & $aResult[$i + $iResultAddDup][1] & "-" & $aResult[$i + $iResultAddDup][2])
							EndIf
						Next
					EndIf
				Next
				ExitLoop
			EndIf
			ExitLoop
		Else
			If $iCount = 1 Then SetLog("You have received castle troops! Wait 5's...")
			If _Sleep($DELAYTRAIN8) Then Return $aResult
		EndIf
	Next

	_ArraySort($aResult, 0, 0, 0, 1) ; Sort By X position , will be the Slot 0 to $i

	While 1
		If UBound($aResult) < 2 Then ExitLoop
		For $i = 1 To UBound($aResult) - 1
			If $aResult[$i][0] = $aResult[$i - 1][0] And Abs($aResult[$i][1] - $aResult[$i - 1][1]) <= 50 Then
				SetDebugLog("Double detection " & $aResult[$i][0] & " at " & $i - 1 & ": " & $aResult[$i][1] & " & " & $aResult[$i - 1][1])
				_ArrayDelete($aResult, $i)
				ContinueLoop 2
			EndIf
		Next
		ExitLoop
	WEnd

	If $sArmyType = "Troops" Then
		For $i = 0 To UBound($aResult) - 1
			$aResult[$i][3] = Number(getBarracksNewTroopQuantity(Slot($aResult[$i][1], "troop"), 196)) ; coc-newarmy
		Next
	EndIf
	If $sArmyType = "Spells" Then
		For $i = 0 To UBound($aResult) - 1
			$aResult[$i][3] = Number(getBarracksNewTroopQuantity(Slot($aResult[$i][1], "spells"), 341)) ; coc-newarmy
			;SetLog("$aResult: " & $aResult[$i][0] & "|" & $aResult[$i][1] & "|" & $aResult[$i][2] & "|" & $aResult[$i][3])
		Next
	EndIf
	If $sArmyType = "CCSpells" Then
		For $i = 0 To UBound($aResult) - 1
			$aResult[$i][3] = Number(getBarracksNewTroopQuantity(Slot($aResult[$i][1], "troop"), 498)) ; coc-newarmy
		Next
	EndIf
	If $sArmyType = "Heroes" Then
		For $i = 0 To UBound($aResult) - 1
			If StringInStr($aResult[$i][0], "Kingqueued") Then
				$aResult[$i][3] = getRemainTHero(619, 414)
			ElseIf StringInStr($aResult[$i][0], "Queenqueued") Then
				$aResult[$i][3] = getRemainTHero(693, 414)
			ElseIf StringInStr($aResult[$i][0], "Wardenqueued") Then
				$aResult[$i][3] = getRemainTHero(767, 414)
			Else
				$aResult[$i][3] = 0
			EndIf
		Next
	EndIf

	If $sArmyType = "Queue" Then
		_ArraySort($aResult, 1, 0, 0, 1) ; reverse the queued slots from right to left
		Local $xSlot
		For $i = 0 To UBound($aResult) - 1
			$xSlot = Int(Number($aResult[$i][1]) / 71) * 71 - 6
			$aResult[$i][3] = Number(getQueueTroopsQuantity($xSlot, 192))
			SetDebugLog($aResult[$i][0] & " (" & $xSlot & ") x" & $aResult[$i][3])
		Next
	EndIf

	Return $aResult
EndFunc   ;==>SearchArmy

Func ResetVariables($sArmyType = "")

	If $sArmyType = "troops" Or $sArmyType = "all" Then
		For $i = 0 To $eTroopCount - 1
			If Not $g_bRunState Then Return
			$g_aiCurrentTroops[$i] = 0
			If _Sleep($DELAYTRAIN6) Then Return ; '20' just to Pause action
		Next
	EndIf
	If $sArmyType = "Spells" Or $sArmyType = "all" Then
		For $i = 0 To $eSpellCount - 1
			If Not $g_bRunState Then Return
			$g_aiCurrentSpells[$i] = 0
			If _Sleep($DELAYTRAIN6) Then Return ; '20' just to Pause action
		Next
	EndIf
	If $sArmyType = "SiegeMachines" Or $sArmyType = "all" Then
		For $i = 0 To $eSiegeMachineCount - 1
			If Not $g_bRunState Then Return
			$g_aiCurrentSiegeMachines[$i] = 0
			If _Sleep($DELAYTRAIN6) Then Return ; '20' just to Pause action
		Next
	EndIf
	If $sArmyType = "donated" Or $sArmyType = "all" Then
		For $i = 0 To $eTroopCount - 1
			If Not $g_bRunState Then Return
			$g_aiDonateTroops[$i] = 0
			If _Sleep($DELAYTRAIN6) Then Return ; '20' just to Pause action
		Next
		For $i = 0 To $eSpellCount - 1 ; fixed making wrong donated spells
			If Not $g_bRunState Then Return
			$g_aiDonateSpells[$i] = 0
			If _Sleep($DELAYTRAIN6) Then Return
		Next
		For $i = 0 To $eSiegeMachineCount - 1
			If Not $g_bRunState Then Return
			$g_aiDonateSiegeMachines[$i] = 0
			If _Sleep($DELAYTRAIN6) Then Return
		Next
	EndIf

EndFunc   ;==>ResetVariables

Func TrainArmyNumber($Army, $iMultiClick = 1)

	Local $a_TrainArmy[3][4] = [[784, 368, 0x73BC2F, 10], [784, 486, 0x73BC2F, 10], [784, 602, 0x73BC2F, 10]]
	SetLog("Using Quick Train Tab", $COLOR_INFO)
	If Not $g_bRunState Then Return

	For $Num = 0 To 2
		If $Army[$Num] Then
			Local $iClick = 2, $sLog = ""
			If $Num = 2 Then $iClick = $iMultiClick
			If $iClick > 2 Then $sLog = ", Multi-click x" & $iClick & " times"

			If _ColorCheck(_GetPixelColor($a_TrainArmy[$Num][0], $a_TrainArmy[$Num][1], True), Hex($a_TrainArmy[$Num][2], 6), $a_TrainArmy[$Num][3]) Then
				Click($a_TrainArmy[$Num][0], $a_TrainArmy[$Num][1], $iClick)
				SetLog(" - Making the Army " & $Num + 1 & $sLog, $COLOR_INFO)
				If _Sleep(500) Then Return
			Else
				SetLog(" - Error Clicking On Army: " & $Num + 1 & "| Pixel was :" & _GetPixelColor($a_TrainArmy[$Num][0], $a_TrainArmy[$Num][1], True), $COLOR_ACTION)
				SetLog(" - Please 'edit' the Army " & $Num + 1 & " before start the BOT!!!", $COLOR_ERROR)
			EndIf
		EndIf
	Next

EndFunc   ;==>TrainArmyNumber

Func DeleteQueued($sArmyTypeQueued, $iOffsetQueued = 802)

	If $sArmyTypeQueued = "Troops" Then
		If Not OpenTroopsTab(True, "DeleteQueued()") Then Return
	ElseIf $sArmyTypeQueued = "Spells" Then
		If Not OpenSpellsTab(True, "DeleteQueued()") Then Return
	Else
		Return
	EndIf
	If _Sleep(500) Then Return
	Local $x = 0

	While Not IsQueueEmpty($sArmyTypeQueued, True, False)
		If $x = 0 Then SetLog(" - Delete " & $sArmyTypeQueued & " Queued!", $COLOR_INFO)
		If _Sleep(20) Then Return
		If Not $g_bRunState Then Return
		Click($iOffsetQueued + 24, 202, 2, 50)
		$x += 1
		If $x = 290 Then ExitLoop
	WEnd
EndFunc   ;==>DeleteQueued

Func MakingDonatedTroops($sType = "All")
	Local $avDefaultTroopGroup[$eTroopCount][6]
	For $i = 0 To $eTroopCount - 1
		$avDefaultTroopGroup[$i][0] = $g_asTroopShortNames[$i]
		$avDefaultTroopGroup[$i][1] = $i
		$avDefaultTroopGroup[$i][2] = $g_aiTroopSpace[$i]
		$avDefaultTroopGroup[$i][3] = $g_aiTroopTrainTime[$i]
		$avDefaultTroopGroup[$i][4] = 0
		$avDefaultTroopGroup[$i][5] = $i >= $eMini ? "d" : "e"
	Next

	; notes $avDefaultTroopGroup[19][5]
	; notes $avDefaultTroopGroup[19][0] = TroopName | [1] = TroopNamePosition | [2] = TroopHeight | [3] = Times | [4] = qty | [5] = marker for DarkTroop or ElixerTroop]
	; notes ClickDrag(616, 445 + $g_iMidOffsetY, 400, 445 + $g_iMidOffsetY, 2000) ; Click drag for dark Troops
	; notes	ClickDrag(400, 445 + $g_iMidOffsetY, 616, 445 + $g_iMidOffsetY, 2000) ; Click drag for Elixer Troops
	; notes $RemainTrainSpace[0] = Current Army  | [1] = Total Army Capacity  | [2] = Remain Space for the current Army

	Local $RemainTrainSpace
	Local $Plural = 0
	Local $areThereDonTroop = 0
	Local $areThereDonSpell = 0
	Local $areThereDonSiegeMachine = 0

	For $j = 0 To $eTroopCount - 1
		If $sType <> "Troops" And $sType <> "All" Then ExitLoop
		If Not $g_bRunState Then Return
		$areThereDonTroop += $g_aiDonateTroops[$j]
	Next

	For $j = 0 To $eSpellCount - 1
		If $sType <> "Spells" And $sType <> "All" Then ExitLoop
		If Not $g_bRunState Then Return
		$areThereDonSpell += $g_aiDonateSpells[$j]
	Next

	For $j = 0 To $eSiegeMachineCount - 1
		If $sType <> "Siege" And $sType <> "All" Then ExitLoop
		If Not $g_bRunState Then Return
		$areThereDonSiegeMachine += $g_aiDonateSiegeMachines[$j]
	Next
	If $areThereDonSpell = 0 And $areThereDonTroop = 0 And $areThereDonSiegeMachine = 0 Then Return

	SetLog("  making donated troops", $COLOR_ACTION1)
	If $areThereDonTroop > 0 Then
		; Load $g_aiDonateTroops[$i] Values into $avDefaultTroopGroup[19][5]
		For $i = 0 To UBound($avDefaultTroopGroup) - 1
			For $j = 0 To $eTroopCount - 1
				If $g_asTroopShortNames[$j] = $avDefaultTroopGroup[$i][0] Then
					$avDefaultTroopGroup[$i][4] = $g_aiDonateTroops[$j]
					$g_aiDonateTroops[$j] = 0
				EndIf
			Next
		Next

		If Not OpenTroopsTab(True, "MakingDonatedTroops()") Then Return

		For $i = 0 To UBound($avDefaultTroopGroup, 1) - 1
			If Not $g_bRunState Then Return
			$Plural = 0
			If $avDefaultTroopGroup[$i][4] > 0 Then
				$RemainTrainSpace = GetOCRCurrent(48, 160)
				If $RemainTrainSpace[2] < 0 Then $RemainTrainSpace[2] = $RemainTrainSpace[1] * 2 - $RemainTrainSpace[0] ; remain train space to full double army
				If $RemainTrainSpace[2] = 0 Then ExitLoop ; army camps full

				Local $iTroopIndex = TroopIndexLookup($avDefaultTroopGroup[$i][0], "MakingDonatedTroops")

				If $avDefaultTroopGroup[$i][2] * $avDefaultTroopGroup[$i][4] <= $RemainTrainSpace[2] Then ; Troopheight x donate troop qty <= avaible train space
					;Local $pos = GetTrainPos(TroopIndexLookup($avDefaultTroopGroup[$i][0]))
					Local $howMuch = $avDefaultTroopGroup[$i][4]
					If $avDefaultTroopGroup[$i][5] = "e" Then
						TrainIt($iTroopIndex, $howMuch, $g_iTrainClickDelay)
						;PureClick($pos[0], $pos[1], $howMuch, 500)
					Else
						ClickDrag(715, 445 + $g_iMidOffsetY, 220, 445 + $g_iMidOffsetY, 2000) ; Click drag for dark Troops
						TrainIt($iTroopIndex, $howMuch, $g_iTrainClickDelay)
						;PureClick($pos[0], $pos[1], $howMuch, 500)
						ClickDrag(220, 445 + $g_iMidOffsetY, 725, 445 + $g_iMidOffsetY, 2000) ; Click drag for Elixer Troops
					EndIf
					If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop
					Local $sTroopName = ($avDefaultTroopGroup[$i][4] > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
					SetLog(" - Trained " & $avDefaultTroopGroup[$i][4] & " " & $sTroopName, $COLOR_ACTION)
					$avDefaultTroopGroup[$i][4] = 0
					If _Sleep(1000) Then Return ; Needed Delay, OCR was not picking up Troop Changes
				Else
					For $z = 0 To $RemainTrainSpace[2] - 1
						$RemainTrainSpace = GetOCRCurrent(48, 160)
						If $RemainTrainSpace[0] = $RemainTrainSpace[1] Then ; army camps full
							;Camps Full All Donate Counters should be zero!!!!
							For $j = 0 To UBound($avDefaultTroopGroup, 1) - 1
								$avDefaultTroopGroup[$j][4] = 0
							Next
							ExitLoop (2) ;
						EndIf
						If $avDefaultTroopGroup[$i][2] <= $RemainTrainSpace[2] And $avDefaultTroopGroup[$i][4] > 0 Then
							;TrainIt(TroopIndexLookup($g_asTroopShortNames[$i]), 1, $g_iTrainClickDelay)
							;Local $pos = GetTrainPos(TroopIndexLookup($avDefaultTroopGroup[$i][0]))
							Local $howMuch = 1
							If $iTroopIndex >= $eBarb And $iTroopIndex <= $eMine Then ; elixir troop
								TrainIt($iTroopIndex, $howMuch, $g_iTrainClickDelay)
								;PureClick($pos[0], $pos[1], $howMuch, 500)
							Else ; dark elixir troop
								ClickDrag(715, 445 + $g_iMidOffsetY, 220, 445 + $g_iMidOffsetY, 2000) ; Click drag for dark Troops
								TrainIt($iTroopIndex, $howMuch, $g_iTrainClickDelay)
								;PureClick($pos[0], $pos[1], $howMuch, 500)
								ClickDrag(220, 445 + $g_iMidOffsetY, 725, 445 + $g_iMidOffsetY, 2000) ; Click drag for Elixer Troops
							EndIf
							If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop
							Local $sTroopName = ($avDefaultTroopGroup[$i][4] > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
							SetLog(" - Trained " & $avDefaultTroopGroup[$i][4] & " " & $sTroopName, $COLOR_ACTION)
							$avDefaultTroopGroup[$i][4] -= 1
							If _Sleep(1000) Then Return ; Needed Delay, OCR was not picking up Troop Changes
						Else
							ExitLoop
						EndIf
					Next
				EndIf
			EndIf
		Next
		;Top Off any remianing space with archers
		If $sType = "All" Then
			$RemainTrainSpace = GetOCRCurrent(48, 160)
			If $RemainTrainSpace[0] < $RemainTrainSpace[1] Then ; army camps full
				Local $howMuch = $RemainTrainSpace[2]
				TrainIt($eTroopArcher, $howMuch, $g_iTrainClickDelay)
				;PureClick($TrainArch[0], $TrainArch[1], $howMuch, 500)
				If $RemainTrainSpace[2] > 0 Then $Plural = 1
				SetLog(" - Trained " & $howMuch & " archer(s)!", $COLOR_ACTION)
				If _Sleep(1000) Then Return ; Needed Delay, OCR was not picking up Troop Changes
			EndIf
		EndIf
	EndIf

	If $areThereDonSpell > 0 Then
		;Train Donated Spells
		If Not OpenSpellsTab(True, "MakingDonatedTroops()") Then Return

		For $i = 0 To $eSpellCount - 1
			If Not $g_bRunState Then Return
			If $g_aiDonateSpells[$i] > 0 Then
				Local $pos = GetTrainPos($i + $eLSpell)
				Local $howMuch = $g_aiDonateSpells[$i]
				TrainIt($eLSpell + $i, $howMuch, $g_iTrainClickDelay)
				;PureClick($pos[0], $pos[1], $howMuch, 500)
				If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop
				SetLog(" - Brewed " & $howMuch & " " & $g_asSpellNames[$i] & ($howMuch > 1 ? " Spells" : " Spell"), $COLOR_ACTION)
				$g_aiDonateSpells[$i] -= $howMuch

				If _Sleep(1000) Then Return
				$RemainTrainSpace = GetOCRCurrent(48, 160)
				SetLog(" - Current Capacity: " & $RemainTrainSpace[0] & "/" & ($RemainTrainSpace[1]))
			EndIf
		Next
	EndIf

	If $areThereDonSiegeMachine > 0 Then
		;Train Donated Sieges
		If Not OpenSiegeMachinesTab(True, "MakingDonatedTroops()") Then Return

		For $iSiegeIndex = $eSiegeWallWrecker To $eSiegeMachineCount - 1
			If Not $g_bRunState Then Return
			If $g_aiDonateSiegeMachines[$iSiegeIndex] > 0 Then
				Local $aCheckIsAvailableSiege[4] = [58, 556, 0x47717E, 10]
				Local $aCheckIsAvailableSiege1[4] = [229, 556, 0x47717E, 10]
				Local $aCheckIsAvailableSiege2[4] = [400, 556, 0x47717E, 10]
				Local $checkPixel
                If $iSiegeIndex = $eSiegeWallWrecker Then $checkPixel = $aCheckIsAvailableSiege
                If $iSiegeIndex = $eSiegeBattleBlimp Then $checkPixel = $aCheckIsAvailableSiege1
                If $iSiegeIndex = $eSiegeStoneSlammer Then $checkPixel = $aCheckIsAvailableSiege2
				Local $HowMany = $g_aiDonateSiegeMachines[$iSiegeIndex]
				If _CheckPixel($checkPixel, True, Default, $g_asSiegeMachineNames[$iSiegeIndex]) Then
					;PureClick($pos[0], $pos[1], $howMuch, 500)
					If _Sleep($DELAYRESPOND) Then Return ; add 5ms delay to catch TrainIt errors, and force return to back to main loop
					PureClick($checkPixel[0], $checkPixel[1], $HowMany, $g_iTrainClickDelay)
					Local $sSiegeName = $HowMany >= 2 ? $g_asSiegeMachineNames[$iSiegeIndex] & "s" : $g_asSiegeMachineNames[$iSiegeIndex] & ""
					SetLog(" - Trained " & $HowMany & " " & $g_asSiegeMachineNames[$iSiegeIndex] & ($HowMany > 1 ? " SiegeMachines" : " SiegeMachine"), $COLOR_ACTION)
					$g_aiDonateSiegeMachines[$iSiegeIndex] -= $HowMany
				EndIf
			EndIf
		Next
		; Get Siege Capacities
		Local $sSiegeInfo = getArmyCapacityOnTrainTroops(57, 160) ; OCR read Siege built and total
		If $g_bDebugSetlogTrain Then SetLog("OCR $sSiegeInfo = " & $sSiegeInfo, $COLOR_DEBUG)
		Local $aGetSiegeCap = StringSplit($sSiegeInfo, "#", $STR_NOCOUNT) ; split the built Siege number from the total Siege number
		SetLog("Total Siege Workshop Capacity: " & $aGetSiegeCap[0] & "/" & $aGetSiegeCap[1])
		If Number($aGetSiegeCap[0]) = 0 Then Return
	EndIf

	Return True

EndFunc   ;==>MakingDonatedTroops

Func GetOCRCurrent($x_start, $y_start)

	Local $aResult[3] = [0, 0, 0]
	If Not $g_bRunState Then Return $aResult

	; [0] = Current Army  | [1] = Total Army Capacity  | [2] = Remain Space for the current Army
	Local $iOCRResult = getArmyCapacityOnTrainTroops($x_start, $y_start)

	If StringInStr($iOCRResult, "#") Then
		Local $aTempResult = StringSplit($iOCRResult, "#", $STR_NOCOUNT)
		$aResult[0] = Number($aTempResult[0])
		$aResult[1] = Number($aTempResult[1])
		; Case to use this function os Spells will be <= 22 , 11*2
		If $aResult[1] <= 22 Then
			If $g_bDebugSetlogTrain Then SetLog("$g_iTotalSpellValue: " & $g_iTotalSpellValue, $COLOR_DEBUG)
			$aResult[1] = $g_iTotalSpellValue
			$aResult[2] = $g_iTotalSpellValue - $aResult[0]
			; May 2018 Update the Army Camp Value on Train page is DOUBLE Value
		ElseIf $aResult[1] <> $g_iTotalCampSpace Then
			If $g_bDebugSetlogTrain Then SetLog("$g_iTotalCampSpace: " & $g_iTotalCampSpace, $COLOR_DEBUG)
			$aResult[1] = $g_iTotalCampSpace
			$aResult[2] = $g_iTotalCampSpace - $aResult[0]
		EndIf
		$aResult[2] = $aResult[1] - $aResult[0]
	Else
		SetLog("DEBUG | ERROR on GetOCRCurrent", $COLOR_ERROR)
	EndIf

	Return $aResult

EndFunc   ;==>GetOCRCurrent

Func CheckIsFullQueuedAndNotFullArmy()

	SetLog(" - Checking: FULL Queue and Not Full Army", $COLOR_INFO)
	Local $CheckTroop[4] = [824, 243, 0x94A522, 20] ; the green check symbol [bottom right] at slot 0 troop
	If Not $g_bRunState Then Return

	If Not OpenTroopsTab(True, "CheckIsFullQueuedAndNotFullArmy()") Then Return

	Local $aArmyCamp = GetOCRCurrent(48, 160)
	If UBound($aArmyCamp) = 3 And $aArmyCamp[2] < 0 Then
		If _ColorCheck(_GetPixelColor($CheckTroop[0], $CheckTroop[1], True), Hex($CheckTroop[2], 6), $CheckTroop[3]) Then
			SetLog(" - Conditions met: FULL Queue and Not Full Army")
			DeleteQueued("Troops")
			If _Sleep(500) Then Return
			$aArmyCamp = GetOCRCurrent(48, 160)
			Local $ArchToMake = $aArmyCamp[2]
			If IsArmyWindow(False, $TrainTroopsTAB) Then TrainIt($eArch, $ArchToMake, $g_iTrainClickDelay) ; PureClick($TrainArch[0], $TrainArch[1], $ArchToMake, 500)
			SetLog("Trained " & $ArchToMake & " archer(s)!")
		Else
			SetLog(" - Conditions NOT met: FULL queue and Not Full Army")
		EndIf
	EndIf

EndFunc   ;==>CheckIsFullQueuedAndNotFullArmy

Func CheckIsEmptyQueuedAndNotFullArmy()

	SetLog(" - Checking: Empty Queue and Not Full Army", $COLOR_ACTION1)
	Local $CheckTroop[4] = [825, 204, 0xCFCFC8, 15] ; the gray background at slot 0 troop
	Local $CheckTroop1[2] = [310, 127] ; the Green Arrow on Troop Training tab
	If Not $g_bRunState Then Return

	If Not OpenTroopsTab(True, "CheckIsEmptyQueuedAndNotFullArmy()") Then Return

	Local $aArmyCamp = GetOCRCurrent(48, 160)
	If UBound($aArmyCamp) = 3 And $aArmyCamp[2] > 0 Then
		If _ColorCheck(_GetPixelColor($CheckTroop[0], $CheckTroop[1], True), Hex($CheckTroop[2], 6), $CheckTroop[3]) Then
			If Not _ColorCheck(_GetPixelColor($CheckTroop1[0], $CheckTroop1[1], True), Hex(0xA0D077, 6), 30) And Not _ColorCheck(_GetPixelColor($CheckTroop1[0], $CheckTroop1[1] + 4, True), Hex(0x6AB320, 6), 30) Then
				SetLog(" - Conditions met: Empty Queue and Not Full Army")
				If _Sleep(500) Then Return
				$aArmyCamp = GetOCRCurrent(48, 160)
				Local $ArchToMake = $aArmyCamp[2]
				If IsArmyWindow(False, $TrainTroopsTAB) Then TrainIt($eArch, $ArchToMake, $g_iTrainClickDelay) ;PureClick($TrainArch[0], $TrainArch[1], $ArchToMake, 500)
				SetLog(" - Trained " & $ArchToMake & " archer(s)!")
			Else
				SetLog(" - Conditions NOT met: Empty queue and Not Full Army")
			EndIf
		EndIf
	EndIf
EndFunc   ;==>CheckIsEmptyQueuedAndNotFullArmy

Func getReceivedTroops($x_start, $y_start, $bSkipCheck = False) ; Check if 'you received Castle Troops from' , will proceed with a Sleep until the message disappear
	If $bSkipCheck Or Not $g_bRunState Then Return False
	Local $iOCRResult = ""

	$iOCRResult = getOcrAndCapture("coc-DonTroops", $x_start, $y_start, 120, 27, True) ; X = 162  Y = 200

	If IsString($iOCRResult) <> "" Or IsString($iOCRResult) <> " " Then
		If StringInStr($iOCRResult, "you") Then ; If exist Minutes or only Seconds
			Return True
		Else
			Return False
		EndIf
	Else
		Return False
	EndIf

EndFunc   ;==>getReceivedTroops

Func TestTrainRevamp2()
	$g_bRunState = True

	$g_bDebugOcr = True
	SetLog("Start......OpenArmy Window.....")

	Local $timer = __TimerInit()

	getArmyTroops(False, False, False, False)

	SetLog("Imgloc Troops Time: " & Round(__TimerDiff($timer) / 1000, 2) & "'s")

	SetLog("End......OpenArmy Window.....")
	$g_bDebugOcr = False
	$g_bRunState = False
EndFunc   ;==>TestTrainRevamp2

Func IIf($Condition, $IfTrue, $IfFalse)
	If $Condition = True Then
		Return $IfTrue
	Else
		Return $IfFalse
	EndIf
EndFunc   ;==>IIf

#cs - SuperXP / GoblinXP - Team AiO MOD++
Func _ArryRemoveBlanks(ByRef $aArray)
	Local $iCounter = 0
	For $i = 0 To UBound($aArray) - 1
		If $aArray[$i] <> "" Then
			$aArray[$iCounter] = $aArray[$i]
			$iCounter += 1
		EndIf
	Next
	ReDim $aArray[$iCounter]
EndFunc   ;==>_ArryRemoveBlanks
#ce - SuperXP / GoblinXP - Team AiO MOD++

Func ValidateSearchArmyResult($aSearchResult, $iIndex = 0)
	If IsArray($aSearchResult) Then
		If UBound($aSearchResult) > 0 Then
			If StringLen($aSearchResult[$iIndex][0]) > 0 Then Return True
		EndIf
	EndIf
	Return False
EndFunc   ;==>ValidateSearchArmyResult

Func CheckValuesCost($Troop = "Arch", $troopQuantity = 1, $DebugLogs = 0)

	; Local Variables
	Local $TempColorToCheck = ""
	Local $nElixirCurrent = 0, $nDarkCurrent = 0, $bLocalDebugOCR = 0

	If _Sleep(1000) Then Return ; small delay
	If Not $g_bRunState Then Return

	; 	DEBUG
	If $g_bDebugSetlogTrain Or $DebugLogs Then
		$bLocalDebugOCR = $g_bDebugOcr
		$g_bDebugOcr = True ; enable the OCR debug
		$TempColorToCheck = _GetPixelColor(223, 594, True)
		SetLog("CheckValuesCost|ColorToCheck: " & $TempColorToCheck)
	EndIf

	; Let??s UPDATE the current Elixir and Dark elixir each Troop train on 'Bottom train Window Page'
	If _ColorCheck(_GetPixelColor(223, 594, True), Hex(0xE8E8E0, 6), 20) Then ; Gray background window color
		; Village without Dark Elixir
		$nElixirCurrent = getResourcesValueTrainPage(307, 594) ; ELIXIR
	Else
		; Village with Elixir and Dark Elixir
		$nElixirCurrent = getResourcesValueTrainPage(232, 594) ; ELIXIR
		$nDarkCurrent = getResourcesValueTrainPage(385, 594) ; DARK ELIXIR
	EndIf

	; 	DEBUG
	If $g_bDebugSetlogTrain Or $DebugLogs Then
		SetLog("- Current resources:")
		SetLog(" - Elixir: " & _NumberFormat($nElixirCurrent) & " / Dark Elixir: " & _NumberFormat($nDarkCurrent), $COLOR_INFO)
		$g_bDebugOcr = $bLocalDebugOCR ; disable OCR Debug
	EndIf

	Local $troopCost = 0
	Local $iTroopIndex = TroopIndexLookup($Troop, "CheckValuesCost")

	; Return the Cost of Troops or Spells
	If $iTroopIndex >= $eBarb And $iTroopIndex <= $eIceG Then
		$troopCost = $g_aiTroopCostPerLevel[$iTroopIndex][$g_aiTrainArmyTroopLevel[$iTroopIndex]]
	ElseIf $iTroopIndex >= $eLSpell And $iTroopIndex <= $eBtSpell Then
		$troopCost = $g_aiSpellCostPerLevel[$iTroopIndex - $eLSpell][$g_aiTrainArmySpellLevel[$iTroopIndex - $eLSpell]]
	EndIf

	;	DEBUG
	If $g_bDebugSetlogTrain Or $DebugLogs Then SetLog("Individual Cost " & $Troop & "= " & $troopCost)

	; Cost of the Troop&Spell x the quantities
	$troopCost *= $troopQuantity

	; 	DEBUG
	If $g_bDebugSetlogTrain Or $DebugLogs Then SetLog("Total Cost " & $Troop & "= " & $troopCost)

	If IsDarkTroop($Troop) Then
		; If is Dark Troop
		If $g_bDebugSetlogTrain Or $DebugLogs Then SetLog("Dark Troop " & $Troop & " Is Dark Troop")
		If $troopCost <= $nDarkCurrent Then
			Return True
		EndIf
		Return False
	ElseIf IsElixirSpell($Troop) Then
		; If is Elixir Spell
		If $g_bDebugSetlogTrain Or $DebugLogs Then SetLog("Spell " & $Troop & " Is Elixir Spell")
		If $troopCost <= $nElixirCurrent Then
			Return True
		EndIf
		Return False
	ElseIf IsDarkSpell($Troop) Then
		; If is Dark Spell
		If $g_bDebugSetlogTrain Or $DebugLogs Then SetLog("Dark Spell " & $Troop & " Is Dark Spell")
		If $troopCost <= $nDarkCurrent Then
			Return True
		EndIf
		Return False
	Else
		; If Isn't Dark Troop And Spells, Then is Elixir Troop : )
		If $troopCost <= $nElixirCurrent Then
			If $g_bDebugSetlogTrain Or $DebugLogs Then SetLog("Troop " & $Troop & " Is Elixir Troop")
			Return True
		EndIf
		Return False
	EndIf


EndFunc   ;==>CheckValuesCost

Func ThSnipesSkiptrain()
	Local $iTemp = 0
	; Check if the User will use TH snipes

	If IsSearchModeActive($TS) And $g_bIsFullArmywithHeroesAndSpells Then
		For $i = 0 To $eTroopCount - 1
			If $g_aiArmyCompTroops[$i] > 0 Then $iTemp += 1
		Next
		If $iTemp = 1 Then Return False ; 	make troops before battle ( is using only one troop kind )
		If $iTemp > 1 Then
			SetLog("Skipping Training before Attack due to THSnipes!", $COLOR_INFO)
			Return True ;	not making troops before battle
		EndIf
	Else
		Return False ; 	Proceeds as usual
	EndIf
EndFunc   ;==>ThSnipesSkiptrain

