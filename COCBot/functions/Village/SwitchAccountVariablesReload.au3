; #FUNCTION# ====================================================================================================================
; Name ..........: SwitchAccountVariablesReload
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

Func SwitchAccountVariablesReload($sType = "Load")

	; Empty arrays
	Local $aiZero[8] = [0, 0, 0, 0, 0, 0, 0, 0], $aiTrue[8] = [1, 1, 1, 1, 1, 1, 1, 1]
	Local $aiZero83[8][3] = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
	Local $aiZero84[8][4] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
	Local $aiZero86[8][6] = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]
	Local $asEmpty[8] = ["", "", "", "", "", "", "", ""]

	; FirstRun
	Static $aiFirstRun = $aiTrue

	; Bottom & Multi-Stats
	Static $aiSkippedVillageCount = $aiZero
	Static $aiAttackedCount = $aiZero

	; Gain Stats
	Static $aiStatsTotalGain = $aiZero84, $aiStatsStartedWith = $aiZero84, $aiStatsLastAttack = $aiZero84, $aiStatsBonusLast = $aiZero84

	; Misc Stats
	Static $aiNbrOfOoS = $aiZero
	Static $aiDroppedTrophyCount = $aiZero
	Static $aiSearchCost = $aiZero, $aiTrainCostElixir = $aiZero, $aiTrainCostDElixir = $aiZero, $aiTrainCostGold = $aiZero ; search and train troops cost
	Static $aiGoldFromMines = $aiZero, $aiElixirFromCollectors = $aiZero, $aiDElixirFromDrills = $aiZero ; number of resources gain by collecting mines, collectors, drills
	Static $aiCostGoldWall = $aiZero, $aiCostElixirWall = $aiZero, $aiCostGoldBuilding = $aiZero, $aiCostElixirBuilding = $aiZero, $aiCostDElixirHero = $aiZero ; wall, building and hero upgrade costs
	Static $aiNbrOfWallsUppedGold = $aiZero, $aiNbrOfWallsUppedElixir = $aiZero, $aiNbrOfBuildingsUppedGold = $aiZero, $aiNbrOfBuildingsUppedElixir = $aiZero, $aiNbrOfHeroesUpped = $aiZero ; number of wall, building, hero upgrades with gold, elixir, delixir
	Static $aiNbrOfWallsUpped = $aiZero

	; Attack Stats
	Static $aiAttackedVillageCount = $aiZero86 ; number of attack villages for DB, LB, TB, TS
	Static $aiTotalGoldGain = $aiZero86, $aiTotalElixirGain = $aiZero86, $aiTotalDarkGain = $aiZero86, $aiTotalTrophyGain = $aiZero86 ; total resource gains for DB, LB, TB, TS
	Static $aiNbrOfDetectedMines = $aiZero86, $aiNbrOfDetectedCollectors = $aiZero86, $aiNbrOfDetectedDrills = $aiZero86 ; number of mines, collectors, drills detected for DB, LB, TB
	Static $aiSmartZapGain = $aiZero, $aiNumEQSpellsUsed = $aiZero, $aiNumLSpellsUsed = $aiZero ; smart zap

	; Builder time and count
	Static $asNextBuilderReadyTime = $asEmpty
	Static $aiFreeBuilderCount = $aiZero, $aiTotalBuilderCount = $aiZero

	; Lab time
	Static $asLabUpgradeTime = $asEmpty, $aiLabStatus = $aiZero, $aiLabElixirCost = $aiZero, $aiLabDElixirCost = $aiZero
	Static $asStarLabUpgradeTime = $asEmpty

	; Hero State
	Static $aiHeroAvailable = $aiZero
	Static $aiHeroUpgradingBit = $aiZero
	Static $aiHeroUpgrading = $aiZero83

	; First time switch account
	Switch $sType
		Case "Reset"
			$aiFirstRun = $aiTrue

			$g_asTrainTimeFinish = $asEmpty
			For $i = 0 To $g_iTotalAcc
				GUICtrlSetData($g_ahLblTroopTime[$i], "")
			Next
			$g_ahTimerSinceSwitched = $aiZero
			$g_ahTimerSinceSwitched[$g_iCurAccount] = $g_hTimerSinceStarted

			; Multi-Stats
			$aiSkippedVillageCount = $aiZero
			$aiAttackedCount = $aiZero

			; Gain Stats
			$aiStatsTotalGain = $aiZero84
			$aiStatsStartedWith = $aiZero84
			$aiStatsLastAttack = $aiZero84
			$aiStatsBonusLast = $aiZero84

			; Misc Stats
			$aiNbrOfOoS = $aiZero
			$aiDroppedTrophyCount = $aiZero
			$aiSearchCost = $aiZero
			$aiTrainCostElixir = $aiZero
			$aiTrainCostDElixir = $aiZero
			$aiTrainCostGold = $aiZero
			$aiGoldFromMines = $aiZero
			$aiElixirFromCollectors = $aiZero
			$aiDElixirFromDrills = $aiZero

			$aiCostGoldWall = $aiZero
			$aiCostElixirWall = $aiZero
			$aiCostGoldBuilding = $aiZero
			$aiCostElixirBuilding = $aiZero
			$aiCostDElixirHero = $aiZero
			$aiNbrOfWallsUppedGold = $aiZero
			$aiNbrOfWallsUppedElixir = $aiZero
			$aiNbrOfBuildingsUppedGold = $aiZero
			$aiNbrOfBuildingsUppedElixir = $aiZero
			$aiNbrOfHeroesUpped = $aiZero
			$aiNbrOfWallsUpped = $aiZero

			; Attack Stats
			$aiAttackedVillageCount = $aiZero86
			$aiTotalGoldGain = $aiZero86
			$aiTotalElixirGain = $aiZero86
			$aiTotalDarkGain = $aiZero86
			$aiTotalTrophyGain = $aiZero86
			$aiNbrOfDetectedMines = $aiZero86
			$aiNbrOfDetectedCollectors = $aiZero86
			$aiNbrOfDetectedDrills = $aiZero86
			$aiSmartZapGain = $aiZero
			$aiNumEQSpellsUsed = $aiZero
			$aiNumLSpellsUsed = $aiZero

			; Builder time and count
			$asNextBuilderReadyTime = $asEmpty
			$aiFreeBuilderCount = $aiZero
			$aiTotalBuilderCount = $aiZero
			; Lab time
			$asLabUpgradeTime = $asEmpty
			$aiLabElixirCost = $aiZero
			$aiLabDElixirCost = $aiZero
			$aiLabStatus = $aiZero
			$asStarLabUpgradeTime = $asEmpty

			; Hero State
			$aiHeroAvailable = $aiZero
			$aiHeroUpgradingBit = $aiZero
			$aiHeroUpgrading = $aiZero83

		Case "Save"
			$aiFirstRun[$g_iCurAccount] = $g_iFirstRun

			; Multi-Stats
			$aiSkippedVillageCount[$g_iCurAccount] = $g_iSkippedVillageCount
			$aiAttackedCount[$g_iCurAccount] = $g_aiAttackedCount

			; Gain Stats
			For $i = 0 To 3
				$aiStatsTotalGain[$g_iCurAccount][$i] = $g_iStatsTotalGain[$i]
				$aiStatsStartedWith[$g_iCurAccount][$i] = $g_iStatsStartedWith[$i]
				$aiStatsLastAttack[$g_iCurAccount][$i] = $g_iStatsLastAttack[$i]
				$aiStatsBonusLast[$g_iCurAccount][$i] = $g_iStatsBonusLast[$i]
			Next

			; Misc Stats
			$aiNbrOfOoS[$g_iCurAccount] = $g_iNbrOfOoS
			$aiDroppedTrophyCount[$g_iCurAccount] = $g_iDroppedTrophyCount
			$aiSearchCost[$g_iCurAccount] = $g_iSearchCost
			$aiTrainCostElixir[$g_iCurAccount] = $g_iTrainCostElixir
			$aiTrainCostDElixir[$g_iCurAccount] = $g_iTrainCostDElixir
			$aiTrainCostGold[$g_iCurAccount] = $g_iTrainCostGold
			$aiGoldFromMines[$g_iCurAccount] = $g_iGoldFromMines
			$aiElixirFromCollectors[$g_iCurAccount] = $g_iElixirFromCollectors
			$aiDElixirFromDrills[$g_iCurAccount] = $g_iDElixirFromDrills

			$aiCostGoldWall[$g_iCurAccount] = $g_iCostGoldWall
			$aiCostElixirWall[$g_iCurAccount] = $g_iCostElixirWall
			$aiCostGoldBuilding[$g_iCurAccount] = $g_iCostGoldBuilding
			$aiCostElixirBuilding[$g_iCurAccount] = $g_iCostElixirBuilding
			$aiCostDElixirHero[$g_iCurAccount] = $g_iCostDElixirHero
			$aiNbrOfWallsUppedGold[$g_iCurAccount] = $g_iNbrOfWallsUppedGold
			$aiNbrOfWallsUppedElixir[$g_iCurAccount] = $g_iNbrOfWallsUppedElixir
			$aiNbrOfBuildingsUppedGold[$g_iCurAccount] = $g_iNbrOfBuildingsUppedGold
			$aiNbrOfBuildingsUppedElixir[$g_iCurAccount] = $g_iNbrOfBuildingsUppedElixir
			$aiNbrOfHeroesUpped[$g_iCurAccount] = $g_iNbrOfHeroesUpped
			$aiNbrOfWallsUpped[$g_iCurAccount] = $g_iNbrOfWallsUpped

			; Attack Stats
			For $i = 0 To 5
				$aiAttackedVillageCount[$g_iCurAccount][$i] = $g_aiAttackedVillageCount[$i]
				$aiTotalGoldGain[$g_iCurAccount][$i] = $g_aiTotalGoldGain[$i]
				$aiTotalElixirGain[$g_iCurAccount][$i] = $g_aiTotalElixirGain[$i]
				$aiTotalDarkGain[$g_iCurAccount][$i] = $g_aiTotalDarkGain[$i]
				$aiTotalTrophyGain[$g_iCurAccount][$i] = $g_aiTotalTrophyGain[$i]
				$aiNbrOfDetectedMines[$g_iCurAccount][$i] = $g_aiNbrOfDetectedMines[$i]
				$aiNbrOfDetectedCollectors[$g_iCurAccount][$i] = $g_aiNbrOfDetectedCollectors[$i]
				$aiNbrOfDetectedDrills[$g_iCurAccount][$i] = $g_aiNbrOfDetectedDrills[$i]
			Next
			$aiSmartZapGain[$g_iCurAccount] = $g_iSmartZapGain
			$aiNumEQSpellsUsed[$g_iCurAccount] = $g_iNumEQSpellsUsed
			$aiNumLSpellsUsed[$g_iCurAccount] = $g_iNumLSpellsUsed

			; Builder time and count
			$asNextBuilderReadyTime[$g_iCurAccount] = $g_sNextBuilderReadyTime
			$aiFreeBuilderCount[$g_iCurAccount] = $g_iFreeBuilderCount
			$aiTotalBuilderCount[$g_iCurAccount] = $g_iTotalBuilderCount
			; Lab time
			$asLabUpgradeTime[$g_iCurAccount] = $g_sLabUpgradeTime
			$aiLabElixirCost[$g_iCurAccount] = $g_iLaboratoryElixirCost
			$aiLabDElixirCost[$g_iCurAccount] = $g_iLaboratoryDElixirCost
			If GUICtrlGetState($g_hPicLabGreen) = $GUI_ENABLE + $GUI_SHOW Then
				$aiLabStatus[$g_iCurAccount] = 1
			ElseIf GUICtrlGetState($g_hPicLabRed) = $GUI_ENABLE + $GUI_SHOW Then
				$aiLabStatus[$g_iCurAccount] = 2
			Else
				$aiLabStatus[$g_iCurAccount] = 0
			EndIf
			$asStarLabUpgradeTime[$g_iCurAccount] = $g_sStarLabUpgradeTime

			; Hero State
			$aiHeroAvailable[$g_iCurAccount] = $g_iHeroAvailable
			$aiHeroUpgradingBit[$g_iCurAccount] = $g_iHeroUpgradingBit
			For $i = 0 To 2
				$aiHeroUpgrading[$g_iCurAccount][$i] = $g_iHeroUpgrading[$i]
			Next

		Case "Load"
			$g_iFirstRun = $aiFirstRun[$g_iCurAccount]

			; Multi-Stats
			$g_iSkippedVillageCount = $aiSkippedVillageCount[$g_iCurAccount]
			$g_aiAttackedCount = $aiAttackedCount[$g_iCurAccount]

			; Gain Stats
			For $i = 0 To 3
				$g_iStatsTotalGain[$i] = $aiStatsTotalGain[$g_iCurAccount][$i]
				$g_iStatsStartedWith[$i] = $aiStatsStartedWith[$g_iCurAccount][$i]
				$g_iStatsLastAttack[$i] = $aiStatsLastAttack[$g_iCurAccount][$i]
				$g_iStatsBonusLast[$i] = $aiStatsBonusLast[$g_iCurAccount][$i]
			Next

			; Misc Stats
			$g_iNbrOfOoS = $aiNbrOfOoS[$g_iCurAccount]
			$g_iDroppedTrophyCount = $aiDroppedTrophyCount[$g_iCurAccount]
			$g_iSearchCost = $aiSearchCost[$g_iCurAccount]
			$g_iTrainCostElixir = $aiTrainCostElixir[$g_iCurAccount]
			$g_iTrainCostDElixir = $aiTrainCostDElixir[$g_iCurAccount]
			$g_iTrainCostGold = $aiTrainCostGold[$g_iCurAccount]
			$g_iGoldFromMines = $aiGoldFromMines[$g_iCurAccount]
			$g_iElixirFromCollectors = $aiElixirFromCollectors[$g_iCurAccount]
			$g_iDElixirFromDrills = $aiDElixirFromDrills[$g_iCurAccount]

			$g_iCostGoldWall = $aiCostGoldWall[$g_iCurAccount]
			$g_iCostElixirWall = $aiCostElixirWall[$g_iCurAccount]
			$g_iCostGoldBuilding = $aiCostGoldBuilding[$g_iCurAccount]
			$g_iCostElixirBuilding = $aiCostElixirBuilding[$g_iCurAccount]
			$g_iCostDElixirHero = $aiCostDElixirHero[$g_iCurAccount]
			$g_iNbrOfWallsUppedGold = $aiNbrOfWallsUppedGold[$g_iCurAccount]
			$g_iNbrOfWallsUppedElixir = $aiNbrOfWallsUppedElixir[$g_iCurAccount]
			$g_iNbrOfBuildingsUppedGold = $aiNbrOfBuildingsUppedGold[$g_iCurAccount]
			$g_iNbrOfBuildingsUppedElixir = $aiNbrOfBuildingsUppedElixir[$g_iCurAccount]
			$g_iNbrOfHeroesUpped = $aiNbrOfHeroesUpped[$g_iCurAccount]
			$g_iNbrOfWallsUpped = $aiNbrOfWallsUpped[$g_iCurAccount]

			; Attack Stats
			For $i = 0 To 5
				$g_aiAttackedVillageCount[$i] = $aiAttackedVillageCount[$g_iCurAccount][$i]
				$g_aiTotalGoldGain[$i] = $aiTotalGoldGain[$g_iCurAccount][$i]
				$g_aiTotalElixirGain[$i] = $aiTotalElixirGain[$g_iCurAccount][$i]
				$g_aiTotalDarkGain[$i] = $aiTotalDarkGain[$g_iCurAccount][$i]
				$g_aiTotalTrophyGain[$i] = $aiTotalTrophyGain[$g_iCurAccount][$i]
				$g_aiNbrOfDetectedMines[$i] = $aiNbrOfDetectedMines[$g_iCurAccount][$i]
				$g_aiNbrOfDetectedCollectors[$i] = $aiNbrOfDetectedCollectors[$g_iCurAccount][$i]
				$g_aiNbrOfDetectedDrills[$i] = $aiNbrOfDetectedDrills[$g_iCurAccount][$i]
			Next
			$g_iSmartZapGain = $aiSmartZapGain[$g_iCurAccount]
			$g_iNumEQSpellsUsed = $aiNumEQSpellsUsed[$g_iCurAccount]
			$g_iNumLSpellsUsed = $aiNumLSpellsUsed[$g_iCurAccount]

			; Builder time and count
			$g_sNextBuilderReadyTime = $asNextBuilderReadyTime[$g_iCurAccount]
			$g_iFreeBuilderCount = $aiFreeBuilderCount[$g_iCurAccount]
			$g_iTotalBuilderCount = $aiTotalBuilderCount[$g_iCurAccount]
			; Lab time
			$g_sLabUpgradeTime = $asLabUpgradeTime[$g_iCurAccount]
			GUICtrlSetData($g_hLbLLabTime, "00:00:00")
			$g_iLaboratoryElixirCost = $aiLabElixirCost[$g_iCurAccount]
			$g_iLaboratoryDElixirCost = $aiLabDElixirCost[$g_iCurAccount]
			Local $Counter = 0
			For $i = $g_hPicLabGray To $g_hPicLabRed
				GUICtrlSetState($i, $GUI_HIDE)
				If $aiLabStatus[$g_iCurAccount] = $Counter Then GUICtrlSetState($i, $GUI_SHOW)
				$Counter += 1
			Next
			$g_sStarLabUpgradeTime = $asStarLabUpgradeTime[$g_iCurAccount]

			; Hero State
			$g_iHeroAvailable = $aiHeroAvailable[$g_iCurAccount]
			$g_iHeroUpgradingBit = $aiHeroUpgradingBit[$g_iCurAccount]
			For $i = 0 To 2
				$g_iHeroUpgrading[$i] = $aiHeroUpgrading[$g_iCurAccount][$i]
			Next

			ResetVariables("donated") ; reset for new account
			$g_aiAttackedCountSwitch[$g_iCurAccount] = $aiAttackedCount[$g_iCurAccount]

			; Reset the log
			$g_hLogFile = 0

		Case "UpdateStats"
			For $i = 0 To 3
				GUICtrlSetData($g_ahLblStatsStartedWith[$i], _NumberFormat($g_iStatsStartedWith[$i], True))
				$aiStatsTotalGain[$g_iCurAccount][$i] = $g_iStatsTotalGain[$i]
			Next
			For $i = 0 To $g_iTotalAcc
				GUICtrlSetData($g_ahLblHourlyStatsGoldAcc[$i], _NumberFormat(Round($aiStatsTotalGain[$i][$eLootGold] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "k / h")
				GUICtrlSetData($g_ahLblHourlyStatsElixirAcc[$i], _NumberFormat(Round($aiStatsTotalGain[$i][$eLootElixir] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "k / h")
				GUICtrlSetData($g_ahLblHourlyStatsDarkAcc[$i], _NumberFormat(Round($aiStatsTotalGain[$i][$eLootDarkElixir] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)) & " / h")
			Next

		Case "SetTime"
			Static $DisplayLoop = 1
			Local $day = 0, $hour = 0, $min = 0, $sec = 0

			; Clock of current account
			_TicksToTime(Int(__TimerDiff($g_ahTimerSinceSwitched[$g_iCurAccount]) + $g_aiRunTime[$g_iCurAccount]), $hour, $min, $sec)
			GUICtrlSetData($g_ahLblResultRuntimeNowAcc[$g_iCurAccount], StringFormat("%02i:%02i:%02i", $hour, $min, $sec))

			; Army time, Builder time, Lab time
			For $i = 0 To $g_iTotalAcc
				; Army time of all accounts
				If _DateIsValid($g_asTrainTimeFinish[$i]) Then
					Local $iTime = _DateDiff("s", _NowCalc(), $g_asTrainTimeFinish[$i]) * 1000
					_TicksToTime(Abs($iTime), $hour, $min, $sec)
					GUICtrlSetData($g_ahLblTroopTime[$i], ($iTime < 0 ? "-" : "") & StringFormat("%02i:%02i", $min, $sec))
					Local $SetColor = $COLOR_BLACK
					If $i = $g_iCurAccount Then
						$SetColor = $COLOR_GREEN
					ElseIf $iTime < 0 Then
						$SetColor = $COLOR_RED
					EndIf
					GUICtrlSetColor($g_ahLblTroopTime[$i], $SetColor)
				EndIf

				; Builder time of all account
				If IsInt($DisplayLoop / 5) Then
					If _DateIsValid($asNextBuilderReadyTime[$i]) Then
						_TicksToDay(Int(_DateDiff("s", _NowCalc(), $asNextBuilderReadyTime[$i]) * 1000), $day, $hour, $min, $sec)
						Local $sBuilderTime = $day > 0 ? StringFormat("%2ud %02i:%02i", $day, $hour, $min, $sec) : ($hour > 0 ? StringFormat("%02i:%02i:%02i", $hour, $min, $sec) : StringFormat("%02i:%02i", $min, $sec))

						If Not IsInt($DisplayLoop / 10) Then
							GUICtrlSetData($g_ahLblResultBuilderNowAcc[$i], $aiFreeBuilderCount[$i] & "/" & $aiTotalBuilderCount[$i])
							GUICtrlSetColor($g_ahLblResultBuilderNowAcc[$i], $COLOR_BLACK)
						Else
							GUICtrlSetData($g_ahLblResultBuilderNowAcc[$i], $sBuilderTime)
							GUICtrlSetColor($g_ahLblResultBuilderNowAcc[$i], $aiFreeBuilderCount[$i] > 0 ? $COLOR_GREEN : $COLOR_BLACK)
						EndIf
					EndIf
				EndIf

				; Lab time of all account
				If _DateIsValid($asLabUpgradeTime[$i]) Then
					Local $iLabTime = _DateDiff("s", _NowCalc(), $asLabUpgradeTime[$i]) * 1000
					If $iLabTime > 0 Then
						_TicksToDay($iLabTime, $day, $hour, $min, $sec)
						GUICtrlSetData($g_hLblLabTimeStatus[$i], $day > 0 ? StringFormat("%2ud %02i:%02i:%02i", $day, $hour, $min, $sec) : ($hour > 0 ? StringFormat("%02i:%02i:%02i", $hour, $min, $sec) : StringFormat("%02i:%02i", $min, $sec)))
						Local $SetColor = $COLOR_BLACK
						If $i = $g_iCurAccount Then $SetColor = $COLOR_GREEN
						GUICtrlSetColor($g_hLblLabTimeStatus[$i], $day > 0 ? $SetColor : $COLOR_ORANGE)
					Else
						GUICtrlSetData($g_hLblLabTimeStatus[$i], "00:00:00")
						$asLabUpgradeTime[$i] = ""
					EndIf
				Else
					GUICtrlSetData($g_hLblLabTimeStatus[$i], "00:00:00")
				EndIf
			Next
			$DisplayLoop += 1
			If $DisplayLoop > 10 Then $DisplayLoop = 1

	EndSwitch

EndFunc   ;==>ResetSwitchAccVariable
