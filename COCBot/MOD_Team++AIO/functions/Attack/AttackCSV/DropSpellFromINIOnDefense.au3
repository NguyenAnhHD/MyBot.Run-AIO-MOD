; #FUNCTION# ====================================================================================================================
; Name ..........: DropSpellFromINIOnDefense
; Description ...:
; Syntax ........: DropSpellFromINIOnDefense($Defense, $options, $qtaMin, $qtaMax, $troopName, $delayPointmin,
;                  $delayPointmax, $delayDropMin, $delayDropMax, $sleepafterMin, $sleepAfterMax[, $debug = False])
; Parameters ....: $Defense             -
;                  $options             -
;                  $qtaMin              -
;                  $qtaMax              -
;                  $troopName           -
;                  $delayPointmin       -
;                  $delayPointmax       -
;                  $delayDropMin        -
;                  $delayDropMax        -
;                  $sleepafterMin       -
;                  $sleepAfterMax       -
;                  $debug               - [optional] Default is False.
; Return values .: None
; Author ........: MR.ViPER
; Modified ......: MR.ViPER (19-9-2016), MR.ViPER (2-12-2016), MR.ViPER (27-4-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func DropSpellFromINIOnDefense($Defense, $options, $qtaMin, $qtaMax, $troopName, $delayPointmin, $delayPointmax, $delayDropMin, $delayDropMax, $sleepafterMin, $sleepAfterMax, $debug = False)
	If $debugDropSCommand = 1 Then SetLog("Func DropSpellFromINIOnDefense(" & $Defense & ", " & $options & ")", $COLOR_DEBUG) ;Debug
	debugAttackCSV("drop using Defense " & $Defense & " and using " & $qtaMin & "-" & $qtaMax & " of " & $troopName)
	debugAttackCSV(" - delay for multiple troops in same point: " & $delayPointmin & "-" & $delayPointmax)
	debugAttackCSV(" - delay when  change deploy point : " & $delayDropMin & "-" & $delayDropMax)
	debugAttackCSV(" - delay after drop all troops : " & $sleepafterMin & "-" & $sleepAfterMax)
	Local $FullDefenseName = GetFullDefenseName($Defense)
	;Qty to drop
	Local $qty = $qtaMin
	If $qtaMin <> $qtaMax Then
		$qty = Random($qtaMin, $qtaMax, 1)
	EndIf
	debugAttackCSV(">> qty to deploy: " & $qty)

	;number of troop to drop in one point...
	Local $qtyxpoint = Int($qty)
	debugAttackCSV(">> qty x point: " & $qtyxpoint)

	; Get the integer index of the troop name specified
	Local $iTroopIndex = TroopIndexLookup($troopName)
	If $iTroopIndex = -1 Then
		Setlog("CSV troop name '" & $troopName & "' is unrecognized.")
		Return
	EndIf

	;search slot where is the troop...
	Local $troopPosition = -1
	For $i = 0 To UBound($g_avAttackTroops) - 1
		If $g_avAttackTroops[$i][0] = $iTroopIndex Then
			$troopPosition = $i
		EndIf
	Next

	Local $usespell = True
	Switch $iTroopIndex
		Case $eLSpell
			If $g_abAttackUseLightSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eHSpell
			If $g_abAttackUseHealSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eRSpell
			If $g_abAttackUseRageSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eJSpell
			If $g_abAttackUseJumpSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eFSpell
			If $g_abAttackUseFreezeSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eCSpell
			If $g_abAttackUseCloneSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $ePSpell
			If $g_abAttackUsePoisonSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eESpell
			If $g_abAttackUseEarthquakeSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eHaSpell
			If $g_abAttackUseHasteSpell[$g_iMatchMode] = 0 Then $usespell = False
		Case $eSkSpell
			If $g_abAttackUseSkeletonSpell[$g_iMatchMode] = 0 Then $usespell = False
	EndSwitch

	If $troopPosition = -1 Or $usespell = False Then
		If $usespell = True Then
			Setlog("No troop found in your attack troops list")
			debugAttackCSV("No troop found in your attack troops list")
		Else
			If $g_iDebugSetLog = 1 Then SetLog("discard use spell", $COLOR_DEBUG) ;Debug
		EndIf

	Else

		;Local $SuspendMode = SuspendAndroid()

		SelectDropTroop($troopPosition) ; select the troop...
		;drop

		Local $tempquant = 0, $delayDrop = $delayDropMin

		If $delayDropMin <> $delayDropMax Then
			$delayDrop = Random($delayDropMin, $delayDropMax, 1)
		EndIf

		Local $delayDropLast = $delayDrop
		;$pixel = Execute("$" & Eval("vector" & $j) & "[" & $index - 1 & "]")

		Local $DefenseResult = AssignPixelOfDefense($Defense, $options)
		Local $pixel[2] = [$DefenseResult[4], $DefenseResult[5]]
		If $DefenseResult[1] = False Then ; If Defense didn't located
			CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
			ReleaseClicks()
			Return
		EndIf
		If IsArray($pixel) Then
			If UBound($pixel) >= 2 Then
				If $pixel[1] <= 0 Then ; If Defense didn't located
					CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
					ReleaseClicks()
					Return
				EndIf
			EndIf
		EndIf
		If $DefenseResult[3] <> "" Then SetLog($DefenseResult[3])

		If $debugDropSCommand = 1 And IsArray($pixel) Then SetLog("$pixel[0] = " & $pixel[0] & " $pixel[1] = " & $pixel[1])
		Local $qty2 = $qtyxpoint

		;delay time between 2 drops in same point
		Local $delayPoint = $delayPointmin
		If $delayPointmin <> $delayPointmax Then
			$delayPoint = Random($delayPointmin, $delayPointmax, 1)
		EndIf

		Local $plural = 0
		If $qty2 > 1 Then $plural = 1

		Switch $iTroopIndex
			Case $eLSpell To $eSkSpell
				If $debug = True Then
					Setlog("Drop Spell AttackClick( " & $pixel[0] & ", " & $pixel[1] & " , " & $qty2 & ", " & $delayPoint & ",#0666)")
				Else
					AttackClick($pixel[0], $pixel[1], $qty2, $delayPoint, $delayDropLast, "#0667")
					If $qty2 > 0 And $DefenseResult[1] = True Then Setlog(" » Dropping " & $qty2 & " of " & NameOfTroop($iTroopIndex, $plural) & _
							IIf($DefenseResult[2] = True, " Between ", "") & IIf($DefenseResult[2] = True, $FullDefenseName, " On " & $FullDefenseName) & IIf($DefenseResult[2] = True, "(s)", ""))
				EndIf
			Case Else
				Setlog("Error parsing line")
		EndSwitch
		debugAttackCSV($troopName & " qty " & $qty2 & " in (" & $pixel[0] & "," & $pixel[1] & ") delay " & $delayPoint)
		;;;;if $j <> $numbersOfVectors Then _sleep(5) ;little delay by passing from a vector to another vector

		ReleaseClicks()
		;SuspendAndroid($SuspendMode)

		;sleep time after deploy all troops
		Local $sleepafter = Int($sleepafterMin)
		If $sleepafterMin <> $sleepAfterMax Then
			$sleepafter = Random($sleepafterMin, $sleepAfterMax, 1)
		EndIf
		If $sleepafter > 0 And IsKeepClicksActive() = False Then
			debugAttackCSV(">> delay after drop all troops: " & $sleepafter)
			If $sleepafter <= 1000 Then ; check SLEEPAFTER value is less than 1 second?
				If _Sleep($sleepafter) Then Return
				CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
			Else ; $sleepafter is More than 1 second, then improve pause/stop button response with max 1 second delays
				For $z = 1 To Int($sleepafter / 1000) ; Check hero health every second while while sleeping
					If _Sleep(980) Then Return ; sleep 1 second minus estimated herohealthcheck time when heroes not activiated
					CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
				Next
				If _Sleep(Mod($sleepafter, 1000)) Then Return ; $sleepafter must be integer for MOD function return correct value!
				CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
			EndIf
		EndIf
	EndIf

EndFunc   ;==>DropSpellFromINIOnDefense

Func GetFullDefenseName($Defense)
	If $debugDropSCommand = 1 Then SetLog("Func GetFullDefenseName(" & $Defense & ")", $COLOR_DEBUG) ;Debug
	Select
		Case $Defense = "EAGLE"
			Return "Eagle"
		Case $Defense = "INFERNO"
			Return "Inferno Tower"
		Case $Defense = "ADEFENSE"
			Return "Air Defense"
		Case $Defense = "TH"
			Return "Town Hall"
		Case Else
			Return "Unknown Defense"
	EndSelect
EndFunc   ;==>GetFullDefenseName

Func AssignPixelOfDefense($Defense, $options, $forceReLocate = False)
	If $debugDropSCommand = 1 Then SetLog("Func AssignPixelOfDefense(" & $Defense & ", " & $options & ", " & $forceReLocate & ")", $COLOR_DEBUG) ;Debug
	Local $LocateResult
	Switch $forceReLocate
		Case True
			ResetDefensesLocation($Defense)
			$LocateResult = LocateDefense($Defense, $options)
		Case Else
			$LocateResult = LocateDefense($Defense, $options)
	EndSwitch

	Switch $Defense
		Case "EAGLE"
			_ArrayMerge($LocateResult, $PixelEaglePos) ; Merging Arrays To Keep Return 1D Array And More Clear, [4] = $X  AND [5] = $Y
			Return $LocateResult
		Case "INFERNO"
			_ArrayMerge($LocateResult, $PixelInfernoPos) ; Merging Arrays To Keep Return 1D Array And More Clear, [4] = $X  AND [5] = $Y
			Return $LocateResult
		Case "ADEFENSE"
			_ArrayMerge($LocateResult, $PixelADefensePos) ; Merging Arrays To Keep Return 1D Array And More Clear, [4] = $X  AND [5] = $Y
			Return $LocateResult
		Case "TH"
			_ArrayMerge($LocateResult, $PixelTHPos) ; Merging Arrays To Keep Return 1D Array And More Clear, [4] = $X  AND [5] = $Y
			Return $LocateResult
	EndSwitch
EndFunc   ;==>AssignPixelOfDefense

Func ResetDefensesLocation($Defense = "")
	If $debugDropSCommand = 1 Then SetLog("Func ResetDefensesLocation(" & $Defense & ")", $COLOR_DEBUG) ;Debug
	Switch $Defense
		Case ""
			$PixelEaglePos[0] = -1
			$PixelEaglePos[1] = -1
			$PixelInfernoPos[0] = -1
			$PixelInfernoPos[1] = -1
			$PixelADefensePos[0] = -1
			$PixelADefensePos[1] = -1
			$PixelTHPos[0] = -1
			$PixelTHPos[1] = -1
		Case "EAGLE"
			$PixelEaglePos[0] = -1
			$PixelEaglePos[1] = -1
		Case "INFERNO"
			$PixelInfernoPos[0] = -1
			$PixelInfernoPos[1] = -1
		Case "ADEFENSE"
			$PixelADefensePos[0] = -1
			$PixelADefensePos[1] = -1
		Case "TH"
			$PixelTHPos[0] = -1
			$PixelTHPos[1] = -1
		Case "STORED"
			; Eagle
			$storedEaglePos = ""
			; Inferno Tower
			$storedInfernoPos = ""
			; Air Defense
			$storedADefensePos = ""
			; Town Hall
			$storedTHPos = ""
	EndSwitch
EndFunc   ;==>ResetDefensesLocation

Func LocateDefense($Defense, $options)
	If $debugDropSCommand = 1 Then SetLog("Func LocateDefense(" & $Defense & ", " & $options & ")", $COLOR_DEBUG) ;Debug
	Local $Result[4] = [False, False, False, ""]
	; [0] = Will be TRUE if Defense Found
	; [1] = Will be TRUE if Defense Found AND Matched With Side Condition
	; [2] = Will be TRUE if Inferno Tower was near to the other inferno tower AND was possible to drop Spell Between them
	; [3] = Any Text To Send An Extra SetLog with The Text, IF Empty ("") it wont send Extra SetLog

	Local $ParsedOptions = ParseCommandOptions($options)
	Local $RandomizeDropPoint = $ParsedOptions[0] ; Only Will Be TRUE or FALSE
	Local $SideCondition = $ParsedOptions[1] ; Can Be S or O or E
	Local $DropBetween = $ParsedOptions[2] ; Only Can Be TRUE or FALSE
	Local $useStoredPosition = $ParsedOptions[3] ; Only Can Be TRUE or FALSE

	Local $hTimer = TimerInit()
	Local $return
	Local $reLocated = False
	Local $Counter = -1
	Local $curMainSide = StringSplit($MAINSIDE, "-", 2)[0]
	Switch $Defense
		Case "EAGLE"
			Local $directory = @ScriptDir & "\imgxml\WeakBase\Eagle"
			If $useStoredPosition = True Then
				$return = GetStoredPositions($Defense)
			Else
				$return = returnAllMatchesDefense($directory)
			EndIf
			$reLocated = True
			Local $splitedPositions = StringSplit($return, "|", 2)
			If Not (UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2) Then DebugImageSave("EagleDetection_NotDetected_", True)
			Local $theEagleSide = ""
			Local $NotdetectedEagle = True
			For $eachPos In $splitedPositions
				Local $splitedEachPos = StringSplit($eachPos, ",", 2)
				If IsArray($splitedEachPos) And UBound($splitedEachPos) > 1 Then
					$Counter += 1
					If $debugDropSCommand = 1 Then SetLog("$SideCondition = " & $SideCondition, $COLOR_DEBUG) ;Debug
					Select
						Case $SideCondition = "AnySide"
							$PixelEaglePos[0] = $splitedEachPos[0]
							$PixelEaglePos[1] = $splitedEachPos[1]
							$NotdetectedEagle = False
							ExitLoop
						Case $SideCondition = "SameSide" Or $SideCondition = "OtherSide"
							Local $sliced = Slice8($splitedEachPos)
							If $debugDropSCommand = 1 Then SetLog("$sliced = " & $sliced, $COLOR_BLUE)
							Switch StringLeft($sliced, 1)
								Case 1, 2
									$theEagleSide = "BOTTOM"
								Case 3, 4
									$theEagleSide = "TOP"
								Case 5, 6
									$theEagleSide = "TOP"
								Case 7, 8
									$theEagleSide = "BOTTOM"
							EndSwitch
							If $debugDropSCommand = 1 Then SetLog("$curMainSide = " & $curMainSide, $COLOR_ORANGE)
							If $debugDropSCommand = 1 Then SetLog("$theEagleSide = " & $theEagleSide, $COLOR_ORANGE)
							If $SideCondition = "SameSide" Then
								If $theEagleSide = $curMainSide Then
									$PixelEaglePos[0] = $splitedEachPos[0]
									$PixelEaglePos[1] = $splitedEachPos[1]
									$NotdetectedEagle = False
									ExitLoop
								EndIf
							Else
								If $theEagleSide <> $curMainSide Then
									$PixelEaglePos[0] = $splitedEachPos[0]
									$PixelEaglePos[1] = $splitedEachPos[1]
									$NotdetectedEagle = False
									ExitLoop
								EndIf
							EndIf
					EndSelect
				Else
					$PixelEaglePos[0] = -1
					$PixelEaglePos[1] = -1
				EndIf
			Next
			If $NotdetectedEagle = False Then
				Local $rToDecreaseX = 4
				Local $rToIncreaseY = 11
				If $RandomizeDropPoint = True Then
					$rToDecreaseX = Random(0, 8, 1)
					$rToIncreaseY = Random(0, 19, 1)
				EndIf
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseX = " & $rToDecreaseX)
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseY = " & $rToIncreaseY)
				$PixelEaglePos[0] -= $rToDecreaseX
				$PixelEaglePos[1] += $rToIncreaseY
			EndIf
			If UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2 Then
				$Result[0] = True
				Setlog(" »» Eagle located in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds")
			Else
				FlagAsUnDetected($Result)
			EndIf
			Switch $SideCondition
				Case "SameSide"
					If $NotdetectedEagle = False Then
						$Result[1] = True
						SetLog("Eagle Detected in Same Side")
					Else
						FlagAsUnDetected($Result)
						SetLog("No Eagle Detected in same side", $COLOR_ORANGE)
					EndIf
				Case "OtherSide"
					If $NotdetectedEagle = False Then
						$Result[1] = True
						SetLog("Eagle Detected in the Other Side")
					Else
						FlagAsUnDetected($Result)
						SetLog("No Eagle Detected in the other side", $COLOR_ORANGE)
					EndIf
				Case "AnySide"
					If $NotdetectedEagle = False Then
						$Result[1] = True
						SetLog("Eagle Detected")
					Else
						FlagAsUnDetected($Result)
						SetLog("No Eagle Detected at all", $COLOR_ORANGE)
					EndIf
			EndSwitch
			Return $Result
		Case "INFERNO"
			Local $directory = @ScriptDir & "\imgxml\WeakBase\Infernos"
			If $useStoredPosition = True Then
				$return = GetStoredPositions($Defense)
			Else
				$return = returnAllMatchesDefense($directory)
			EndIf
			$reLocated = True
			Local $splitedPositions = StringSplit($return, "|", 2)
			If Not (UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2) Then DebugImageSave("InfernoDetection_NotDetected_", True)
			Local $theInfernoSide = ""
			Local $NotdetectedInferno = True
			For $eachPos In $splitedPositions
				Local $splitedEachPos = StringSplit($eachPos, ",", 2)
				If IsArray($splitedEachPos) And UBound($splitedEachPos) > 1 Then
					$Counter += 1
					If $debugDropSCommand = 1 Then SetLog("$SideCondition = " & $SideCondition, $COLOR_DEBUG) ;Debug
					Select
						Case $SideCondition = "AnySide"
							$PixelInfernoPos[0] = $splitedEachPos[0]
							$PixelInfernoPos[1] = $splitedEachPos[1]
							$NotdetectedInferno = False
							ExitLoop
						Case $SideCondition = "SameSide" Or $SideCondition = "OtherSide"
							;If UBound($splitedEachPos) = 2 Then
							;If $splitedEachPos[1] >= 1 Then
							Local $sliced = Slice8($splitedEachPos)
							If $debugDropSCommand = 1 Then SetLog("$sliced = " & $sliced, $COLOR_BLUE)
							Switch StringLeft($sliced, 1)
								Case 1, 2
									$theInfernoSide = "BOTTOM"
								Case 3, 4
									$theInfernoSide = "TOP"
								Case 5, 6
									$theInfernoSide = "TOP"
								Case 7, 8
									$theInfernoSide = "BOTTOM"
							EndSwitch
							If $debugDropSCommand = 1 Then SetLog("$curMainSide = " & $curMainSide, $COLOR_ORANGE)
							If $debugDropSCommand = 1 Then SetLog("$theInfernoSide = " & $theInfernoSide, $COLOR_ORANGE)
							If $SideCondition = "SameSide" Then
								If $theInfernoSide = $curMainSide Then
									$PixelInfernoPos[0] = $splitedEachPos[0]
									$PixelInfernoPos[1] = $splitedEachPos[1]
									$NotdetectedInferno = False
									ExitLoop
								EndIf
							Else
								If $theInfernoSide <> $curMainSide Then
									$PixelInfernoPos[0] = $splitedEachPos[0]
									$PixelInfernoPos[1] = $splitedEachPos[1]
									$NotdetectedInferno = False
									ExitLoop
								EndIf
							EndIf
					EndSelect
				Else
					$PixelInfernoPos[0] = -1
					$PixelInfernoPos[1] = -1
				EndIf
			Next
			Local $isNearToTheOtherOne = IsInfernoTowersNearToTheOtherOne($splitedPositions, $DropBetween)
			If $NotdetectedInferno = True And $isNearToTheOtherOne[4] = True Then
				If $debugDropSCommand = 1 Then SetLog("Near To The Other One Is True But No Inferno Towers Detected!!!, Disabling Drop Between...")
				$isNearToTheOtherOne[4] = False
			EndIf
			If $isNearToTheOtherOne[4] = True And $NotdetectedInferno = False Then
				If $isNearToTheOtherOne[0] = True Then
					$PixelInfernoPos[0] += (($isNearToTheOtherOne[2] / 2) + 0 + IIf($RandomizeDropPoint = True, Random(0, 5, 1), 0)) ; Was 7
				Else
					$PixelInfernoPos[0] -= (($isNearToTheOtherOne[2] / 2) - 0 - IIf($RandomizeDropPoint = True, Random(0, 5, 1), 0)) ; Was 7
				EndIf
				If $isNearToTheOtherOne[1] = True Then
					$PixelInfernoPos[1] += (($isNearToTheOtherOne[3] / 2) + IIf($RandomizeDropPoint = True, 7, 9) + IIf($RandomizeDropPoint = True, Random(1, 3, 1), 0)) ; Was 9
				Else
					$PixelInfernoPos[1] -= (($isNearToTheOtherOne[3] / 2) - IIf($RandomizeDropPoint = True, 7, 9) - IIf($RandomizeDropPoint = True, Random(1, 3, 1), 0)) ; Was 9
				EndIf
			EndIf
			If $debugDropSCommand = 1 Then SetLog("$isNearToTheOtherOne[4] = " & $isNearToTheOtherOne[4], $COLOR_BLUE)
			If $NotdetectedInferno = False And $isNearToTheOtherOne[4] = False Then
				Local $rToDecreaseX = 4
				Local $rToIncreaseY = 11
				If $RandomizeDropPoint = True Then
					$rToDecreaseX = Random(0, 8, 1)
					$rToIncreaseY = Random(0, 19, 1)
				EndIf
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseX = " & $rToDecreaseX)
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseY = " & $rToIncreaseY)
				$PixelInfernoPos[0] -= $rToDecreaseX
				$PixelInfernoPos[1] += $rToIncreaseY
			EndIf
			If UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2 Then
				$Result[0] = True
				Setlog(" »» " & UBound($splitedPositions) & "x Inferno Tower(s) located in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds")
			Else
				FlagAsUnDetected($Result)
			EndIf
			Switch $SideCondition
				Case "SameSide"
					If $NotdetectedInferno = False Then
						If $isNearToTheOtherOne[4] = False Then
							$Result[1] = True
							SetLog("Inferno Tower Detected in Same Side")
						EndIf
						If $isNearToTheOtherOne[4] = True Then
							$Result[1] = True
							$Result[2] = True
							;SetLog("Dropping Between Two Inferno Tower(s) In the Same Side...", $COLOR_BLUE)
						EndIf
					Else
						FlagAsUnDetected($Result)
						SetLog("No Inferno Tower Detected in same side", $COLOR_ORANGE)
					EndIf
				Case "OtherSide"
					If $NotdetectedInferno = False Then
						If $isNearToTheOtherOne[4] = False Then
							$Result[1] = True
							SetLog("Inferno Tower Detected in the Other Side")
						EndIf
						If $isNearToTheOtherOne[4] = True Then
							$Result[1] = True
							$Result[2] = True
							;SetLog("Dropping Between Two Inferno Tower(s) In the Other Side...", $COLOR_BLUE)
						EndIf
					Else
						FlagAsUnDetected($Result)
						SetLog("No Inferno Tower Detected in the other side", $COLOR_ORANGE)
					EndIf
				Case "AnySide"
					If $NotdetectedInferno = False Then
						If $isNearToTheOtherOne[4] = False Then
							$Result[1] = True
							SetLog("Inferno Tower Detected")
						EndIf
						If $isNearToTheOtherOne[4] = True Then
							$Result[1] = True
							$Result[2] = True
							;SetLog("Dropping Between Two Inferno Tower(s)...", $COLOR_BLUE)
						EndIf
					Else
						FlagAsUnDetected($Result)
						SetLog("No Inferno Tower Detected at all", $COLOR_ORANGE)
					EndIf
			EndSwitch
			Return $Result
		Case "ADEFENSE"
			Local $directory = @ScriptDir & "\imgxml\WeakBase\ADefense"
			If $useStoredPosition = True Then
				$return = GetStoredPositions($Defense)
			Else
				$return = returnAllMatchesDefense($directory)
			EndIf
			$reLocated = True
			Local $splitedPositions = StringSplit($return, "|", 2)
			If Not (UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2) Then DebugImageSave("AirDefenseDetection_NotDetected_", True)
			Local $theADefenseSide = ""
			Local $NotdetectedADefense = True
			For $eachPos In $splitedPositions
				Local $splitedEachPos = StringSplit($eachPos, ",", 2)
				If IsArray($splitedEachPos) And UBound($splitedEachPos) > 1 Then
					$Counter += 1
					If $debugDropSCommand = 1 Then SetLog("$SideCondition = " & $SideCondition, $COLOR_DEBUG) ;Debug
					Select
						Case $SideCondition = "AnySide"
							$PixelADefensePos[0] = $splitedEachPos[0]
							$PixelADefensePos[1] = $splitedEachPos[1]
							$NotdetectedADefense = False
							ExitLoop
						Case $SideCondition = "SameSide" Or $SideCondition = "OtherSide"
							;If UBound($splitedEachPos) = 2 Then
							;If $splitedEachPos[1] >= 1 Then
							Local $sliced = Slice8($splitedEachPos)
							If $debugDropSCommand = 1 Then SetLog("$sliced = " & $sliced, $COLOR_BLUE)
							Switch StringLeft($sliced, 1)
								Case 1, 2
									$theADefenseSide = "BOTTOM"
								Case 3, 4
									$theADefenseSide = "TOP"
								Case 5, 6
									$theADefenseSide = "TOP"
								Case 7, 8
									$theADefenseSide = "BOTTOM"
							EndSwitch
							If $debugDropSCommand = 1 Then SetLog("$curMainSide = " & $curMainSide, $COLOR_ORANGE)
							If $debugDropSCommand = 1 Then SetLog("$theADefenseSide = " & $theADefenseSide, $COLOR_ORANGE)
							If $SideCondition = "SameSide" Then
								If $theADefenseSide = $curMainSide Then
									$PixelADefensePos[0] = $splitedEachPos[0]
									$PixelADefensePos[1] = $splitedEachPos[1]
									$NotdetectedADefense = False
									ExitLoop
								EndIf
							Else
								If $theADefenseSide <> $curMainSide Then
									$PixelADefensePos[0] = $splitedEachPos[0]
									$PixelADefensePos[1] = $splitedEachPos[1]
									$NotdetectedADefense = False
									ExitLoop
								EndIf
							EndIf
					EndSelect
				Else
					$PixelADefensePos[0] = -1
					$PixelADefensePos[1] = -1
				EndIf
			Next
			If $NotdetectedADefense = False Then
				Local $rToDecreaseX = 4
				Local $rToIncreaseY = 11
				If $RandomizeDropPoint = True Then
					$rToDecreaseX = Random(0, 8, 1)
					$rToIncreaseY = Random(0, 19, 1)
				EndIf
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseX = " & $rToDecreaseX)
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseY = " & $rToIncreaseY)
				$PixelADefensePos[0] -= $rToDecreaseX
				$PixelADefensePos[1] += $rToIncreaseY
			EndIf
			If UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2 Then
				$Result[0] = True
				Setlog(" »» " & UBound($splitedPositions) & "x Air Defense(s) located in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds")
			Else
				FlagAsUnDetected($Result)
			EndIf
			Switch $SideCondition
				Case "SameSide"
					If $NotdetectedADefense = False Then
						$Result[1] = True
						SetLog("Air Defense Detected in Same Side")
					Else
						FlagAsUnDetected($Result)
						SetLog("No Air Defense Detected in same side", $COLOR_ORANGE)
					EndIf
				Case "OtherSide"
					If $NotdetectedADefense = False Then
						$Result[1] = True
						SetLog("Air Defense Detected in the Other Side")
					Else
						FlagAsUnDetected($Result)
						SetLog("No Air Defense Detected in the other side", $COLOR_ORANGE)
					EndIf
				Case "AnySide"
					If $NotdetectedADefense = False Then
						$Result[1] = True
						SetLog("Air Defense Detected")
					Else
						FlagAsUnDetected($Result)
						SetLog("No Air Defense Detected at all", $COLOR_ORANGE)
					EndIf
			EndSwitch
			Return $Result
		Case "TH"
			Local $xdirectory = "imglocth-bundle"
			Local $xdirectoryb = "imglocth2-bundle"
			Local $directory = $xdirectory
			If $useStoredPosition = True Then
				$return = GetStoredPositions($Defense)
			Else
				If $g_iDebugSetLog = 1 Then SetLog("DROPS Trying to Find TownHall", $COLOR_DEBUG)
				$return = returnAllMatchesDefense($directory)
				If $return = "" Then
					$directory = $xdirectoryb
					$return = returnAllMatchesDefense($directory)
				EndIf
			EndIf
			$reLocated = True
			Local $splitedPositions = StringSplit($return, "|", 2)
			If Not (UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2) Then DebugImageSave("DropSTHDetection_NotDetected_", True)
			Local $theTHSide = ""
			Local $NotdetectedTH = True
			For $eachPos In $splitedPositions
				Local $splitedEachPos = StringSplit($eachPos, ",", 2)
				If IsArray($splitedEachPos) And UBound($splitedEachPos) > 1 Then
					$Counter += 1
					If $debugDropSCommand = 1 Then SetLog("$SideCondition = " & $SideCondition, $COLOR_DEBUG) ;Debug
					Select
						Case $SideCondition = "AnySide"
							$PixelTHPos[0] = $splitedEachPos[0]
							$PixelTHPos[1] = $splitedEachPos[1]
							$NotdetectedTH = False
							ExitLoop
						Case $SideCondition = "SameSide" Or $SideCondition = "OtherSide"
							Local $sliced = Slice8($splitedEachPos)
							If $debugDropSCommand = 1 Then SetLog("$sliced = " & $sliced, $COLOR_BLUE)
							Switch StringLeft($sliced, 1)
								Case 1, 2
									$theTHSide = "BOTTOM"
								Case 3, 4
									$theTHSide = "TOP"
								Case 5, 6
									$theTHSide = "TOP"
								Case 7, 8
									$theTHSide = "BOTTOM"
							EndSwitch
							If $debugDropSCommand = 1 Then SetLog("$curMainSide = " & $curMainSide, $COLOR_ORANGE)
							If $debugDropSCommand = 1 Then SetLog("$theTHSide = " & $theTHSide, $COLOR_ORANGE)
							If $SideCondition = "SameSide" Then
								If $theTHSide = $curMainSide Then
									$PixelTHPos[0] = $splitedEachPos[0]
									$PixelTHPos[1] = $splitedEachPos[1]
									$NotdetectedTH = False
									ExitLoop
								EndIf
							Else
								If $theTHSide <> $curMainSide Then
									$PixelTHPos[0] = $splitedEachPos[0]
									$PixelTHPos[1] = $splitedEachPos[1]
									$NotdetectedTH = False
									ExitLoop
								EndIf
							EndIf
					EndSelect
				Else
					$PixelTHPos[0] = -1
					$PixelTHPos[1] = -1
				EndIf
			Next
			If $NotdetectedTH = False Then
				Local $rToDecreaseX = 4
				Local $rToIncreaseY = 11
				If $RandomizeDropPoint = True Then
					$rToDecreaseX = Random(0, 8, 1)
					$rToIncreaseY = Random(0, 19, 1)
				EndIf
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseX = " & $rToDecreaseX)
				If $debugDropSCommand = 1 Then SetLog("$rToDecreaseY = " & $rToIncreaseY)
				$PixelTHPos[0] -= $rToDecreaseX
				$PixelTHPos[1] += $rToIncreaseY
			EndIf
			If UBound($splitedPositions) >= 1 And StringLen($splitedPositions[0]) > 2 Then
				$Result[0] = True
				Setlog(" »» DROPS: TH located in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds")
			Else
				FlagAsUnDetected($Result)
			EndIf
			Switch $SideCondition
				Case "SameSide"
					If $NotdetectedTH = False Then
						$Result[1] = True
						SetLog("TH Detected in Same Side")
					Else
						FlagAsUnDetected($Result)
						SetLog("No TH Detected in same side", $COLOR_ORANGE)
					EndIf
				Case "OtherSide"
					If $NotdetectedTH = False Then
						$Result[1] = True
						SetLog("TH Detected in the Other Side")
					Else
						FlagAsUnDetected($Result)
						SetLog("No TH Detected in the other side", $COLOR_ORANGE)
					EndIf
				Case "AnySide"
					If $NotdetectedTH = False Then
						$Result[1] = True
						SetLog("TH Detected")
					Else
						FlagAsUnDetected($Result)
						SetLog("No TH Detected at all", $COLOR_ORANGE)
					EndIf
			EndSwitch
			Return $Result
	EndSwitch
	Return $Result
EndFunc   ;==>LocateDefense

Func FlagAsUnDetected(ByRef $Result)
	For $i = 0 To (UBound($Result) - 1)
		If Not $i = (UBound($Result) - 1) Then ; If index was for Additional SetLog
			$Result[$i] = False
		Else
			$Result[$i] = ""
		EndIf
	Next
EndFunc   ;==>FlagAsUnDetected

Func ParseCommandOptions($options)
	If $debugDropSCommand = 1 Then SetLog("Func ParseCommandOptions(" & $options & ")", $COLOR_DEBUG) ;Debug
	Local $Result[4] = [False, "", True, False]
	;	[0] = IF True, Change Drop Position by a Low Random Number
	; 	[1] = Side
	;	[2] = IF True, Drop Spell Between Both 2 Inferno Towers IF Both of them was going to be affected by ONE Spell EVEN, Else Drop on one of them
	;	[3] = IF True, Store positions of the defense at first of attack, and when reached the command, use that position (Will not verify if the defense already there)
	Local $splitedOptions = StringSplit($options, ",", 2)
	For $Opt In $splitedOptions
		Local $optSplited = StringSplit($Opt, ":", 2)
		Local $optArg = $optSplited[0]
		Local $optValue = $optSplited[1]
		Switch $optArg
			Case "R"
				If $optValue = "T" Then
					$Result[0] = True
				Else
					$Result[0] = False
				EndIf
			Case "B"
				If $optValue = "T" Then
					$Result[2] = True ; Drop Between
				Else
					$Result[2] = False ; DON'T Drop Between
				EndIf
			Case "S"
				Switch $optValue
					Case "S"
						$Result[1] = "SameSide"
					Case "O"
						$Result[1] = "OtherSide"
					Case "A"
						$Result[1] = "AnySide"
				EndSwitch
			Case "L"
				If $optValue = "T" Then
					$Result[3] = True
				Else
					$Result[3] = False
				EndIf
		EndSwitch
	Next
	Return $Result
EndFunc   ;==>ParseCommandOptions

Func IsInfernoTowersNearToTheOtherOne($positions, $DropBetween)
	If $debugDropSCommand = 1 Then SetLog("Func IsInfernoTowersNearToTheOtherOne(" & $positions & ", " & $DropBetween & ")", $COLOR_DEBUG) ;Debug
	Local $Result[5] = [False, False, 0, 0, False]
	; [0] = $xDiff was started with "-" at first
	; [1] = $yDiff was started with "-" at first
	; [2] = $xDiff
	; [3] = $yDiff
	; [4] = True OR False, The Result
	; ---
	If UBound($positions) < 2 Or $DropBetween = False Then
		If $debugDropSCommand = 1 Then SetLog("UBound($positions) < 2 OR $DropBetween = False")
		If $debugDropSCommand = 1 Then SetLog("UBound($positions) = " & UBound($positions))
		If $debugDropSCommand = 1 Then SetLog("$DropBetween = " & $DropBetween)
		Return $Result
	EndIf
	Local $allowedXDiff = 74, $allowedYDiff = 53 ; xDiff was 64,		yDiff was 53
	If IsArray(StringSplit($positions[0], ",", 2)) And IsArray(StringSplit($positions[1], ",", 2)) Then Return $Result
	Local $firstInfernoPosition[2] = [StringSplit($positions[0], ",", 2)[0], StringSplit($positions[0], ",", 2)[1]]
	Local $secondInfernoPosition[2] = [StringSplit($positions[1], ",", 2)[0], StringSplit($positions[1], ",", 2)[1]]
	;MsgBox(0, "ArrayToString", _ArrayToString($firstInfernoPosition, ",") & @CRLF & _ArrayToString($secondInfernoPosition, ","))		; Should be uncommented Only when you want to debug it
	Local $xDiff = $firstInfernoPosition[0] - $secondInfernoPosition[0], $yDiff = $firstInfernoPosition[1] - $secondInfernoPosition[1]
	If StringLeft(String($xDiff), 1) = "-" Then
		$xDiff = $secondInfernoPosition[0] - $firstInfernoPosition[0]
		$Result[0] = True
	EndIf
	If StringLeft(String($yDiff), 1) = "-" Then
		$yDiff = $secondInfernoPosition[1] - $firstInfernoPosition[1]
		$Result[1] = True
	EndIf
	;MsgBox(0, "Diff", "$xDiff = " & $xDiff & @CRLF & "$yDiff = " & $yDiff)		; Should be uncommented Only when you want to debug it
	$Result[2] = $xDiff
	$Result[3] = $yDiff
	If $xDiff <= $allowedXDiff And $yDiff <= $allowedYDiff Then
		$Result[4] = True
		Return $Result
	EndIf
	SetLog("Inferno Towers are so far from the other one, Cannot Drop Between", $COLOR_ORANGE)
	Return $Result
EndFunc   ;==>IsInfernoTowersNearToTheOtherOne

Func checkForDropSInCSV($sFilePath)
	Local $AvailableDropS = CheckDropSCommands($sFilePath)

	If UBound($AvailableDropS) > 0 Then
		SetLog("Initializing DropS for further uses", $COLOR_BLUE)
		For $i = 0 To (UBound($AvailableDropS) - 1)
			If StringLen($AvailableDropS[$i]) > 2 Then
				If Not IsObjLocatedDropS($AvailableDropS[$i]) Then GetAndStorePositions($AvailableDropS[$i])
			EndIf
		Next

		If _ArraySearch($AvailableDropS, "EAGLE") > -1 Then SetLog("x" & IIf(StringInStr($storedEaglePos, "|") > 0, UBound(StringSplit($storedEaglePos, "|", 2)), UBound(_StringEqualSplit($storedEaglePos))) & " Eagle(s) located", $COLOR_BLUE)
		If _ArraySearch($AvailableDropS, "INFERNO") > -1 Then SetLog("x" & IIf(StringInStr($storedInfernoPos, "|") > 0, UBound(StringSplit($storedInfernoPos, "|", 2)), UBound(_StringEqualSplit($storedInfernoPos))) & " Inferno Tower(s) located", $COLOR_BLUE)
		If _ArraySearch($AvailableDropS, "ADEFENSE") > -1 Then SetLog("x" & IIf(StringInStr($storedADefensePos, "|") > 0, UBound(StringSplit($storedADefensePos, "|", 2)), UBound(_StringEqualSplit($storedADefensePos))) & " Air Defense(s) located", $COLOR_BLUE)
		If _ArraySearch($AvailableDropS, "TH") > -1 Then SetLog("x" & IIf(StringInStr($storedTHPos, "|") > 0, UBound(StringSplit($storedTHPos, "|", 2)), UBound(_StringEqualSplit($storedTHPos))) & " Town Hall located", $COLOR_BLUE)
	EndIf
EndFunc   ;==>checkForDropSInCSV

Func CheckDropSCommands($sFilePath)
	Local $ToReturn = ""
	If $g_bRunState = False Then Return

	; Code For DeadBase
	If $g_abSearchSearchesEnable[$DB] = 1 Then
		If $g_aiAttackAlgorithm[$DB] = 1 Then ; Scripted Attack is Selected
			$ToReturn &= GetDropSCommands($DB, $sFilePath)
		EndIf
	EndIf

	Local $splitedToReturn = StringSplit($ToReturn, "|", 2)

	ArrayRemoveDuplicates($splitedToReturn) ; Remove Duplicates

	Return $splitedToReturn
EndFunc   ;==>CheckDropSCommands

Func GetDropSCommands($Mode, $sFilePath)
	Local $ToReturn = ""
	Local $fileName = ""
	If $g_bRunState = False Then Return

	Local $rownum = 0
	If FileExists($sFilePath) Then
		Local $f, $line, $acommand, $command
		Local $value1, $Troop
		$f = FileOpen($sFilePath, 0)
		; Read in lines of text until the EOF is reached
		While 1
			$line = FileReadLine($f)
			$rownum += 1
			If @error = -1 Then ExitLoop
			$acommand = StringSplit($line, "|")
			If $acommand[0] >= 8 Then
				$command = StringStripWS(StringUpper($acommand[1]), 2)
				If $command = "DROPS" Then
					Local $TheDefense = StringStripWS(StringUpper($acommand[2]), 2)
					Local $TheOptions = StringUpper($acommand[3])
					If StringInStr($TheOptions, "L:T") > 0 Then
						$ToReturn &= $TheDefense & "|"
					EndIf

				EndIf
			EndIf
		WEnd
		FileClose($f)
	EndIf
	Return $ToReturn
EndFunc   ;==>GetDropSCommands

Func IsObjLocatedDropS($Obj)
	Switch $Obj
		Case "EAGLE"
			Return VerifyMMPOResult($storedEaglePos)
		Case "INFERNO"
			Return VerifyMMPOResult($storedInfernoPos)
		Case "ADEFENSE"
			Return VerifyMMPOResult($storedADefensePos)
		Case "TH"
			Return VerifyMMPOResult($storedTHPos)
		Case Else
			Return False
	EndSwitch
EndFunc   ;==>IsObjLocatedDropS

Func GetStoredPositions($Defense)
	Switch $Defense
		Case "EAGLE"
			Return $storedEaglePos
		Case "INFERNO"
			Return $storedInfernoPos
		Case "ADEFENSE"
			Return $storedADefensePos
		Case "TH"
			Return $storedTHPos
	EndSwitch
EndFunc   ;==>GetStoredPositions

Func GetAndStorePositions($Defense)
	Local $imgSearchResult = ""
	Local $directory
	Local $xdirectory = "imglocth-bundle"
	Local $xdirectoryb = "imglocth2-bundle"
	Switch $Defense
		Case "EAGLE"
			$directory = @ScriptDir & "\imgxml\WeakBase\Eagle"
			$imgSearchResult = returnAllMatchesDefense($directory)
			$storedEaglePos = $imgSearchResult
		Case "INFERNO"
			$directory = @ScriptDir & "\imgxml\WeakBase\Infernos"
			$imgSearchResult = returnAllMatchesDefense($directory)
			$storedInfernoPos = $imgSearchResult
		Case "ADEFENSE"
			$directory = @ScriptDir & "\imgxml\WeakBase\ADefense"
			$imgSearchResult = returnAllMatchesDefense($directory)
			$storedADefensePos = $imgSearchResult
		Case "TH"
			$directory = $xdirectory
			$imgSearchResult = returnAllMatchesDefense($directory)
			If $imgSearchResult = "" Then
				$directory = $xdirectoryb
				$imgSearchResult = returnAllMatchesDefense($directory)
			EndIf
			$storedTHPos = $imgSearchResult
	EndSwitch
EndFunc   ;==>GetAndStorePositions
