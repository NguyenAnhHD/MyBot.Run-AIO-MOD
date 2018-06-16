; #FUNCTION# ====================================================================================================================
; Name ..........: CheckStopForWar
; Description ...: This file contains the Sequence that runs all MBR Bot
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func CheckStopForWar()

	If ProfileSwitchAccountEnabled() Then CheckStopForWarAllAccounts()

	If Not $g_bStopForWar Then Return

	Local $bCurrentWar = False, $aResult[3], $bStopAction = False

	If ProfileSwitchAccountEnabled() Then ; Load Timer of Current Account
		$g_iStartTimerToRecheck = $g_aiStartTimerToRecheck[$g_iCurAccount]
		$g_iTimerToRecheck = $g_aiTimerToRecheck[$g_iCurAccount]
		$g_sCheckOrStop = $g_asCheckOrStop[$g_iCurAccount]
	EndIf

	If $g_bFirstStart Then $g_iStartTimerToRecheck = 0

	If $g_iStartTimerToRecheck <> 0 Then
		Local $iCheckTimer = TimerDiff($g_iStartTimerToRecheck)
		If $iCheckTimer < $g_iTimerToRecheck * 60 * 1000 Then Return
		If $g_sCheckOrStop = "Time to stop" Then SetLog("Should be time to stop for war now. Let's have a look", $COLOR_INFO)
	EndIf

	$bCurrentWar = CheckWarTime($aResult)
	If @error Then Return
	Local $iBattleStartTime = $aResult[0]
	Local $iBattleEndTime = $aResult[1]
	Local $bInWar = $aResult[2]

	If Not $bCurrentWar Then
		$g_iStartTimerToRecheck = TimerInit()
		$g_iTimerToRecheck = 6 * 60 ; 360 minutes = 6 hours
		$g_sCheckOrStop = "Time to re-check"
		SetLog("Will come back to check in 6 hours", $COLOR_INFO)

		If ProfileSwitchAccountEnabled() Then SaveTimerCurrentAccount()
		Return
	Else
		If Not $bInWar Then
			$g_iStartTimerToRecheck = TimerInit()
			$g_iTimerToRecheck = $iBattleStartTime >= 0 ? $iBattleStartTime + 24 * 60 : $iBattleEndTime
			If $g_iTimerToRecheck > 0 Then
				SetLog("Will come back to check after current war finish in " & Int($g_iTimerToRecheck / 60) & "h " & Mod($g_iTimerToRecheck, 60) & "m", $COLOR_INFO)
				$g_sCheckOrStop = "Time to re-check"
			Else
				$g_iStartTimerToRecheck = 0 ; remove timer
			EndIf

			If ProfileSwitchAccountEnabled() Then SaveTimerCurrentAccount()
			Return
		Else
			Local $iBattleTime = $iBattleStartTime >= 0 ? $iBattleStartTime : 24 * 60 - $iBattleEndTime ; check battle start time
			If $g_bDebugSetlog Then SetDebugLog("$iBattleTime: " & $iBattleTime & " minutes")

			$g_iTimerToRecheck = $iBattleTime + $g_bStopBeforeBattle ? (-$g_iStopTime * 60) : $g_iStopTime * 60
			If $g_bDebugSetlog Then SetDebugLog("$g_iTimerToRecheck: " & $g_iTimerToRecheck & " minutes")
			If $g_iTimerToRecheck > 0 Then
				$g_iStartTimerToRecheck = TimerInit()
				SetLog("Will stop for war preparation in " & Int($g_iTimerToRecheck / 60) & "h " & Mod($g_iTimerToRecheck, 60) & "m", $COLOR_INFO)
				$g_sCheckOrStop = "Time to stop"
			Else
				$g_iStartTimerToRecheck = 0 ; remove timer
				$g_sCheckOrStop = ""

				$iBattleTime = $iBattleEndTime >= 0 ? $iBattleEndTime : $iBattleStartTime + 24 * 60 ; check battle end time
				Local $iSleepTime = $iBattleTime - $g_iReturnTime * 60

				If $iSleepTime >= 60 Then
					SetLog("Stop and prepare for war now", $COLOR_INFO)
					$bStopAction = True
				Else
					SetLog("It's time to stop for war. But stop time window is too tight, just skip and continue", $COLOR_INFO)
					SetLog("Will come back to check in 6 hours", $COLOR_INFO)
					$g_iStartTimerToRecheck = TimerInit()
					$g_iTimerToRecheck = 6 * 60 ; 360 minutes = 6 hours
					$g_sCheckOrStop = "Time to re-check"
				EndIf
			EndIf
			If ProfileSwitchAccountEnabled() Then SaveTimerCurrentAccount()
			If $bStopAction Then StopAndPrepareForWar($iSleepTime) ; quit function here
		EndIf
	EndIf

EndFunc   ;==>CheckStopForWar

Func CheckWarTime(ByRef $aResult) ; return Success + $aResult[3] = [ $iBattleStartTime, $iBattleEndTime, $bInWar] OR Failure

	$aResult[0] = -1
	$aResult[1] = -1 ; reset time (minutes)
	Local $directory = @ScriptDir & "\imgxml\WarPage"
	Local $bBattleDay_InWar = False, $sWarDay, $sTime

	If IsMainPage() Then
		$bBattleDay_InWar = _ColorCheck(_GetPixelColor(45, 500, True), "ED151D", 20) ; Red color in war button
		If $g_bDebugSetlog Then SetDebugLog("Checking battle notification, $bBattleDay_InWar = " & $bBattleDay_InWar)
		Click(40, 530) ; open war menu
		If _Sleep(1000) Then Return
	EndIf

	If IsWarMenu() Then
		If $bBattleDay_InWar Then
			$sWarDay = "Battle"
			$aResult[2] = True
		Else
			$sWarDay = QuickMIS("N1", $directory, 360, 85, 360 + 145, 85 + 28, True) ; Prepare or Battle
			$aResult[2] = QuickMIS("BC1", $directory, 795, 555, 795 + 20, 555 + 60, True) ; $bInWar
			If $g_bDebugSetlog Then SetDebugLog("$sResult QuickMIS N1/BC1: " & $sWarDay & "/ " & $aResult[2])
		EndIf

		If Not StringInStr($sWarDay, "Battle") And Not StringInStr($sWarDay, "Preparation") Then
			SetLog("Your Clan is not in active war yet.", $COLOR_INFO)
			Click(70, 680, 1, 500, "#0000") ; return home
			Return False

		Else
			$sTime = QuickMIS("OCR", $directory, 396, 65, 396 + 70, 70 + 20, True)
			If $g_bDebugSetlog Then SetDebugLog("$sResult QuickMIS OCR: " & ($bBattleDay_InWar ? $sWarDay & ", " : "") & $sTime)

			Local $iConvertedTime = ConvertOCRTime("War", $sTime, False)
			If StringInStr($sWarDay, "Preparation") Then
				$aResult[0] = $iConvertedTime ; $iBattleStartTime
				SetLog("Clan war is now in preparation. Battle will start in " & $sTime, $COLOR_INFO)
			ElseIf StringInStr($sWarDay, "Battle") Then
				$aResult[1] = $iConvertedTime ; $iBattleEndTime
				SetLog("Clan war is now in battle day. Battle will finish in " & $sTime, $COLOR_INFO)
			EndIf

			If _Max($aResult[0], $aResult[1]) < 0 Then Return False

			SetLog("You are " & ($aResult[2] ? "" : "not ") & "in war", $COLOR_INFO)

			Click(70, 680, 1, 500, "#0000") ; return home
			Return True
		EndIf

	Else
		SetLog("Error when trying to open War window.", $COLOR_WARNING)
		Return SetError(1, 0, "Error open War window")
		ClickP($aAway, 2, 0, "#0000") ;Click Away
	EndIf
EndFunc   ;==>CheckWarTime

Func StopAndPrepareForWar($iSleepTime)

	If $g_bTrainWarTroop Then
		SetLog("Let's remove all farming troops and train war troop", $COLOR_ACTION)
		If $g_bUseQuickTrainWar Then
			$g_bQuickTrainEnable = $g_bUseQuickTrainWar
			$g_bQuickTrainArmy = $g_aChkArmyWar

			Local $aiArmyCompTroopsEmpty[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			Local $aiArmyCompSpellsEmpty[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			$g_aiArmyCompTroops = $aiArmyCompTroopsEmpty
			$g_aiArmyCompSpells = $aiArmyCompSpellsEmpty
		Else
			$g_aiArmyCompTroops = $g_aiWarCompTroops
			$g_aiArmyCompSpells = $g_aiWarCompSpells
		EndIf

		; Train
		StartGainCost()
		OpenArmyOverview(False, "StopAndPrepareForWar()")

		If Not IsQueueEmpty("Troops", True, False) Then DeleteQueued("Troops")
		If Not IsQueueEmpty("Spells", True, False) Then DeleteQueued("Spells")
		If _Sleep(300) Then Return

		$g_bIsFullArmywithHeroesAndSpells = False

		If Not $g_bUseQuickTrainWar Then
			; Custom Train 1st set
			Local $aWhatToRemove = WhatToTrain(True, False)
			RemoveExtraTroops($aWhatToRemove)

			Local $rWhatToTrain = WhatToTrain(False, False)
			TrainUsingWhatToTrain($rWhatToTrain) ; troop
			If _Sleep(500) Then Return

			$rWhatToTrain = WhatToTrain(False, True)
			TrainUsingWhatToTrain($rWhatToTrain, True) ; spell
			If _Sleep(500) Then Return

			; Train 2nd set
			SetLog("Let's train 2nd set of troops & spells")
			$g_bIsFullArmywithHeroesAndSpells = True
			$g_bForceBrewSpells = True ; this is to by pass HowManyTimesWillBeUsed() in Train Revamp
			$rWhatToTrain = WhatToTrain(False, True)
			TrainUsingWhatToTrain($rWhatToTrain)
			If _Sleep(500) Then Return
			Local $TroopCamp = GetOCRCurrent(43, 160)
			SetLog("Checking troop tab: " & $TroopCamp[0] & "/" & $TroopCamp[1] * 2)

			$rWhatToTrain = WhatToTrain(False, True)
			TrainUsingWhatToTrain($rWhatToTrain, True)
			If _Sleep(750) Then Return
			Local $SpellCamp = GetOCRCurrent(43, 160)
			SetLog("Checking spell tab: " & $SpellCamp[0] & "/" & $SpellCamp[1] * 2)

		Else
			OpenArmyTab(False, "StopAndPrepareForWar()")
			If _Sleep(300) Then Return

			Local $toTrainFake[1][2] = [["Barb", 0]]
			getArmySpells(False, False, False, False)
			For $i = 0 To $eSpellCount - 1
				If $g_aiCurrentSpells[$i] = 0 Then
					$g_aiArmyCompSpells[$i] = 1 ; this is to by pass TotalSpellsToBrewInGUI() in Train Revamp
					ExitLoop
				EndIf
			Next
			RemoveExtraTroops($toTrainFake)

			OpenQuickTrainTab(False, "StopAndPrepareForWar()")
			If _Sleep(750) Then Return
			TrainArmyNumber($g_bQuickTrainArmy)
			If _Sleep(250) Then Return
			TrainArmyNumber($g_bQuickTrainArmy)

		EndIf

		If _Sleep(500) Then Return

		If $g_bRequestCCForWar Then
			OpenArmyTab(False, "StopAndPrepareForWar()")
		Else
			ClickP($aAway, 2, 0, "#0346") ;Click Away
		EndIf

		If _Sleep(500) Then Return
	EndIf

	If $g_bRequestCCForWar Then
		$g_bRequestTroopsEnable = True
		$g_bDonationEnabled = True
		$g_abRequestCCHours[@HOUR] = True
		$g_sRequestTroopsText = $g_sTxtRequestCCForWar

		SetLog("Let's request again for war", $COLOR_ACTION)
		RemoveCC()
		RequestCC()
	EndIf

	SetLog("It's war time, let's take a break", $COLOR_ACTION)

	If $g_bTrainWarTroop Then EndGainCost("Train")
	readConfig() ; release all war variables value for war troops & requestCC

	If ProfileSwitchAccountEnabled() Then
		If GUICtrlRead($g_ahChkAccount[$g_iCurAccount]) = $GUI_CHECKED Then
			Local $aActiveAccount = _ArrayFindAll($g_abAccountNo, True)
			If UBound($aActiveAccount) > 1 Then
				GUICtrlSetState($g_ahChkAccount[$g_iCurAccount], $GUI_UNCHECKED)
				chkAccount($g_iCurAccount)
				SaveConfig_600_35_2() ; Save config profile after changing botting type
				ReadConfig_600_35_2() ; Update variables
				UpdateMultiStats(False)
				SetLog("Acc [" & $g_iCurAccount + 1 & "] turned OFF and start over with another account")
				SetSwitchAccLog("   Acc. " & $g_iCurAccount + 1 & " now Idle for war", $COLOR_ACTION)

				For $i = 0 To UBound($aActiveAccount) - 1
					If $aActiveAccount[$i] <> $g_iCurAccount Then
						$g_iNextAccount = $aActiveAccount[$i]
						If $g_iGuiMode = 1 Then
							; normal GUI Mode
							_GUICtrlComboBox_SetCurSel($g_hCmbProfile, _GUICtrlComboBox_FindStringExact($g_hCmbProfile, $g_asProfileName[$g_iNextAccount]))
							cmbProfile()
							DisableGUI_AfterLoadNewProfile()
						Else
							; mini or headless GUI Mode
							saveConfig()
							$g_sProfileCurrentName = $g_asProfileName[$g_iNextAccount]
							LoadProfile(False)
						EndIf
						$g_bInitiateSwitchAcc = True
						ExitLoop
					EndIf
				Next

				runBot()
			ElseIf UBound($aActiveAccount) = 1 Then
				SetLog("This is the last active account for switching, close CoC anyway")
			EndIf
		EndIf
	EndIf

	UniversalCloseWaitOpenCoC($iSleepTime * 60 * 1000, "StopAndPrepareForWar", False, True) ; wake up & full restart

EndFunc   ;==>StopAndPrepareForWar

Func RemoveCC()

	If Not IsTrainPage() Then
		OpenArmyOverview(True, "CheckCC()")
		If _Sleep(500) Then Return
	EndIf

	Local $sCCTroop, $aCCTroop, $sCCSpell, $aCCSpell
	$sCCTroop = getOcrAndCapture("coc-ms", 302, 470, 60, 16, True, False, True) ; read CC troops 0/35
	$aCCTroop = StringSplit($sCCTroop, "#", $STR_NOCOUNT) ; split the trained troop number from the total troop number
	$sCCSpell = getOcrAndCapture("coc-ms", 530, 468, 35, 16, True, False, True) ; read CC Spells 0/2
	$aCCSpell = StringSplit($sCCSpell, "#", $STR_NOCOUNT) ; split the trained troop number from the total troop number

	Local $aPos[2] = [40, 575]
	Local $bHasCCTroopOrSpell = False
	If IsArray($aCCTroop) Then $bHasCCTroopOrSpell = Number($aCCTroop[0]) > 1
	If IsArray($aCCSpell) Then $bHasCCTroopOrSpell = Number($aCCSpell[0]) > 1

	If $bHasCCTroopOrSpell Then
		Click(Random(715, 825, 1), Random(507, 545, 1)) ; Click on Edit Army Button
		If _Sleep(500) Then Return
		For $i = 0 To 6
			If _ColorCheck(_GetPixelColor(Round(30 + 72.8 * $i, 0), 508, True), Hex(0xCFCFC8, 6), 15) Then
				ExitLoop
			Else
				$aPos[0] = 40 + 74 * $i
				ClickRemoveTroop($aPos, 35, $g_iTrainClickDelay)
			EndIf
		Next
		If Not _ColorCheck(_GetPixelColor(570, 508, True), Hex(0xCFCFC8, 6), 15) Then
			$aPos[0] = 570
			ClickRemoveTroop($aPos, 3, $g_iTrainClickDelay)
		EndIf

		For $i = 0 To 10
			If _ColorCheck(_GetPixelColor(806, 567, True), Hex(0xCEEF76, 6), 25) Then
				Click(Random(720, 815, 1), Random(558, 589, 1)) ; Click on 'Okay' button to save changes
				ExitLoop
			Else
				If $i = 10 Then
					SetLog("Cannot find/verify 'Okay' Button in Army tab", $COLOR_WARNING)
					ClickP($aAway, 2, 0)
					Return ; Exit function
				EndIf
				If _Sleep(200) Then Return
			EndIf
		Next

		For $i = 0 To 10
			If _ColorCheck(_GetPixelColor(508, 428, True), Hex(0xFFFFFF, 6), 30) Then
				Click(Random(445, 583, 1), Random(402, 455, 1)) ; Click on 'Okay' button to Save changes... Last button
				ExitLoop
			Else
				If $i = 10 Then
					SetLog("Cannot find/verify 'Okay #2' Button in Army tab", $COLOR_WARNING)
					ClickP($aAway, 2, 0)
					Return ; Exit function
				EndIf
				If _Sleep(300) Then Return
			EndIf
		Next
		SetLog("CC Troops/Spells removed", $COLOR_SUCCESS)
		If _Sleep(200) Then Return
	EndIf

	getArmyCCStatus()

	ClickP($aAway, 2, 0)
	If _Sleep(300) Then Return
EndFunc   ;==>RemoveCC

Func SaveTimerCurrentAccount()
	$g_aiStartTimerToRecheck[$g_iCurAccount] = $g_iStartTimerToRecheck
	$g_aiTimerToRecheck[$g_iCurAccount] = $g_iTimerToRecheck
	$g_asCheckOrStop[$g_iCurAccount] = $g_sCheckOrStop
EndFunc   ;==>SaveTimerCurrentAccount

Func CheckStopForWarAllAccounts()

	$g_abStopForWar[$g_iCurAccount] = $g_bStopForWar

	For $i = 0 To $g_iTotalAcc
		If $i = $g_iCurAccount Or Not $g_abStopForWar[$i] Then ContinueLoop ; not check current account
		If $g_aiStartTimerToRecheck[$i] <> 0 Then
			Local $iCheckTimer = TimerDiff($g_aiStartTimerToRecheck[$i])
			If $iCheckTimer >= $g_aiTimerToRecheck[$i] * 60 * 1000 And $g_asCheckOrStop[$i] = "Time to stop" Then
				SetLog("Account [" & $i + 1 & "] should stop for war now.", $COLOR_INFO)
				If GUICtrlRead($g_ahChkAccount[$i]) = $GUI_CHECKED Then
					GUICtrlSetState($g_ahChkAccount[$i], $GUI_UNCHECKED)
					chkAccount($i)
					SaveConfig_600_35_2() ; Save config profile after changing botting type
					ReadConfig_600_35_2() ; Update variables
					UpdateMultiStats()
					SetLog("Acc [" & $i + 1 & "] turned OFF")
					SetSwitchAccLog("   Acc. " & $i + 1 & " now Idle for war", $COLOR_ACTION)
				EndIf
			EndIf
		EndIf
	Next
EndFunc   ;==>CheckStopForWarAllAccounts
