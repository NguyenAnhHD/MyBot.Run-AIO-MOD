; #FUNCTION# ====================================================================================================================
; Name ..........: DropTroopFromINI
; Description ...:
; Syntax ........: DropTroopFromINI($vectors, $indexStart, $indexEnd, $qtaMin, $qtaMax, $troopName, $delayPointmin,
;                  $delayPointmax, $delayDropMin, $delayDropMax, $sleepafterMin, $sleepAfterMax[, $debug = False])
; Parameters ....: $vectors             -
;                  $indexStart          -
;                  $indexEnd            -
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
; Author ........: Sardo (2016)
; Modified ......: MonkeyHunter (03-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func DropTroopFromINI($vectors, $indexStart, $indexEnd, $indexArray, $qtaMin, $qtaMax, $troopName, $delayPointmin, $delayPointmax, $delayDropMin, $delayDropMax, $sleepafterMin, $sleepAfterMax, $sleepBeforeMin, $sleepBeforeMax, $debug = False)
	If IsArray($indexArray) = 0 Then
		debugAttackCSV("drop using vectors " & $vectors & " index " & $indexStart & "-" & $indexEnd & " and using " & $qtaMin & "-" & $qtaMax & " of " & $troopName)
	Else
		debugAttackCSV("drop using vectors " & $vectors & " index " & _ArrayToString($indexArray, ",") & " and using " & $qtaMin & "-" & $qtaMax & " of " & $troopName)
	EndIf
	debugAttackCSV(" - delay for multiple troops in same point: " & $delayPointmin & "-" & $delayPointmax)
	debugAttackCSV(" - delay when change deploy point : " & $delayDropMin & "-" & $delayDropMax)
	debugAttackCSV(" - delay after drop all troops : " & $sleepafterMin & "-" & $sleepAfterMax)
	debugAttackCSV(" - delay before drop all troops : " & $sleepBeforeMin & "-" & $sleepBeforeMax)

	;how many vectors need to manage...
	Local $temp = StringSplit($vectors, "-")
	Local $numbersOfVectors
	If UBound($temp) > 0 Then
		$numbersOfVectors = $temp[0]
	Else
		$numbersOfVectors = 0
	EndIf

	;name of vectors...
	Local $vector1, $vector2, $vector3, $vector4
	If UBound($temp) > 0 Then
		If $temp[0] >= 1 Then $vector1 = "ATTACKVECTOR_" & $temp[1]
		If $temp[0] >= 2 Then $vector2 = "ATTACKVECTOR_" & $temp[2]
		If $temp[0] >= 3 Then $vector3 = "ATTACKVECTOR_" & $temp[3]
		If $temp[0] >= 4 Then $vector4 = "ATTACKVECTOR_" & $temp[4]
	Else
		$vector1 = $vectors
	EndIf

	;Qty to drop
	If $qtaMin <> $qtaMax Then
		Local $qty = Random($qtaMin, $qtaMax, 1)
	Else
		Local $qty = $qtaMin
	EndIf
	debugAttackCSV(">> qty to deploy: " & $qty)

	;number of troop to drop in one point...
	Local $qtyxpoint = Int($qty / ($indexEnd - $indexStart + 1))
	Local $extraunit = Mod($qty, ($indexEnd - $indexStart + 1))
	debugAttackCSV(">> qty x point: " & $qtyxpoint)
	debugAttackCSV(">> qty extra: " & $extraunit)

	; Get the integer index of the troop name specified
	Local $iTroopIndex = TroopIndexLookup($troopName, "DropTroopFromINI")
	If $iTroopIndex = -1 Then
		SetLog("CSV troop name '" & $troopName & "' is unrecognized.")
		Return
	EndIf
	Local $bHeroDrop = ($iTroopIndex = $eWarden ? True : False) ;set flag TRUE if Warden was dropped

	;search slot where is the troop...
	Local $troopPosition = -1
	Local $troopSlotConst = -1 ; $troopSlotConst = xx/22 (the unique slot number of troop) - Slot11+
	For $i = 0 To UBound($g_avAttackTroops) - 1
		If $g_avAttackTroops[$i][0] = $iTroopIndex And $g_avAttackTroops[$i][1] > 0 Then
			debugAttackCSV("Found troop position " & $i & ". " & $troopName & " x" & $g_avAttackTroops[$i][1])
			$troopSlotConst = $i
			$troopPosition = $troopSlotConst
			ExitLoop
		EndIf
	Next

	; Slot11+
	debugAttackCSV("Troop position / Total slots: " & $troopSlotConst & " / " & $g_iTotalAttackSlot)
	If $troopSlotConst >= 0 And $troopSlotConst < $g_iTotalAttackSlot - 10 Then ; can only be selected when in 1st page of troopbar
		If $g_bDraggedAttackBar Then DragAttackBar($g_iTotalAttackSlot, True) ; return drag
	ElseIf $troopSlotConst > 10 Then ; can only be selected when in 2nd page of troopbar
		If $g_bDraggedAttackBar = False Then DragAttackBar($g_iTotalAttackSlot, False) ; drag forward
	EndIf
	If $g_bDraggedAttackBar And $troopPosition > -1 Then
		$troopPosition = $troopSlotConst - ($g_iTotalAttackSlot - 10)
		debugAttackCSV("New troop position: " & $troopPosition)
	EndIf

	Local $bSelectTroop = True
	Local $bUseSpell = True
	Switch $iTroopIndex
		Case $eLSpell
			If Not $g_abAttackUseLightSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eHSpell
			If Not $g_abAttackUseHealSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eRSpell
			If Not $g_abAttackUseRageSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eJSpell
			If Not $g_abAttackUseJumpSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eFSpell
			If Not $g_abAttackUseFreezeSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eCSpell
			If Not $g_abAttackUseCloneSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $ePSpell
			If Not $g_abAttackUsePoisonSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eESpell
			If Not $g_abAttackUseEarthquakeSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eHaSpell
			If Not $g_abAttackUseHasteSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eSkSpell
			If Not $g_abAttackUseSkeletonSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eBtSpell
			If Not $g_abAttackUseBatSpell[$g_iMatchMode] Then $bUseSpell = False
		Case $eKing, $eQueen, $eWarden, $eCastle, $eWallW, $eBattleB, $eStoneS
			$bSelectTroop = False ; avoid double select
	EndSwitch

	If $troopPosition = -1 Or Not $bUseSpell Then

		If $bUseSpell Then
			SetLog("No " & GetTroopName($iTroopIndex) & " found in your attack troops list")
			debugAttackCSV("No " & GetTroopName($iTroopIndex) & " found in your attack troops list")
		Else
			If $g_bDebugSetlog Then SetDebugLog("Discard use " & GetTroopName($iTroopIndex), $COLOR_DEBUG)
		EndIf

	Else

		;Local $SuspendMode = SuspendAndroid()

		If $g_iCSVLastTroopPositionDropTroopFromINI <> $troopSlotConst Then
			ReleaseClicks()
			If $bSelectTroop Then
				SelectDropTroop($troopPosition) ; select the troop...
				ReleaseClicks()
				KeepClicks()
			EndIf
			$g_iCSVLastTroopPositionDropTroopFromINI = $troopSlotConst
		EndIf
		;sleep time Before deploy all troops
		Local $sleepBefore = 0
		If $sleepBeforeMin <> $sleepBeforeMax Then
			$sleepBefore = Random($sleepBeforeMin, $sleepBeforeMax, 1)
		Else
			$sleepBefore = Int($sleepBeforeMin)
		EndIf
		$sleepBefore = Int($sleepBefore / $g_CSVSpeedDivider[$g_iMatchMode]); CSV Deploy Speed - Team AiO MOD++

		If $sleepBefore > 50 And IsKeepClicksActive() = False Then
			debugAttackCSV("- delay Before drop all troops: " & $sleepBefore & " (x" & $g_CSVSpeedDivider[$g_iMatchMode] & " faster)")
			If $sleepBefore <= 1000 Then ; check SLEEPBefore value is less than 1 second?
				If _Sleep($sleepBefore) Then Return
				CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
			Else  ; $sleepBefore is More than 1 second, then improve pause/stop button response with max 1 second delays
				For $z = 1 To Int($sleepBefore/1000) ; Check hero health every second while while sleeping
					If _Sleep(980) Then Return ; sleep 1 second minus estimated herohealthcheck time when heroes not activiated
					CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
				Next
				If _Sleep(Mod($sleepBefore,1000)) Then Return ; $sleepBefore must be integer for MOD function return correct value!
				CheckHeroesHealth() ; check hero health == does nothing if hero not dropped
			EndIf
		EndIf
		;drop
		For $i = $indexStart To $indexEnd
			Local $delayDrop = 0
			Local $index = $i
			Local $indexMax = $indexEnd
			If IsArray($indexArray) = 1 Then
				; adjust $index and $indexMax based on array
				$index = $indexArray[$i]
				$indexMax = $indexArray[$indexEnd]
			EndIf
			If $index <> $indexMax Then
				;delay time between 2 drops in different point
				If $delayDropMin <> $delayDropMax Then
					$delayDrop = Random($delayDropMin, $delayDropMax, 1)
				Else
					$delayDrop = $delayDropMin
				EndIf
				$delayDrop = Int($delayDrop / $g_CSVSpeedDivider[$g_iMatchMode]); CSV Deploy Speed - Team AiO MOD++
				debugAttackCSV("- delay change drop point: " & $delayDrop & " (x" & $g_CSVSpeedDivider[$g_iMatchMode] & " faster)")
			EndIf

			For $j = 1 To $numbersOfVectors
				;delay time between 2 drops in different point
				Local $delayDropLast = 0
				If $j = $numbersOfVectors Then $delayDropLast = $delayDrop
				If $index <= UBound(Execute("$" & Eval("vector" & $j))) Then
					Local $pixel = Execute("$" & Eval("vector" & $j) & "[" & $index - 1 & "]")
					Local $qty2 = $qtyxpoint
					If $index < $indexStart + $extraunit Then $qty2 += 1

					;delay time between 2 drops in same point
					If $delayPointmin <> $delayPointmax Then
						Local $delayPoint = Random($delayPointmin, $delayPointmax, 1)
						$delayPoint = Int($delayPoint / $g_CSVSpeedDivider[$g_iMatchMode]); CSV Deploy Speed - Team AiO MOD++
						debugAttackCSV("- random delay deploy point: " & $delayPoint & " (x" & $g_CSVSpeedDivider[$g_iMatchMode] & " faster)")
					Else
						Local $delayPoint = $delayPointmin
						$delayPoint = Int($delayPoint / $g_CSVSpeedDivider[$g_iMatchMode]); CSV Deploy Speed - Team AiO MOD++
					EndIf
					debugAttackCSV("- delay change deploy point: " & $delayPoint & " (x" & $g_CSVSpeedDivider[$g_iMatchMode] & " faster)")

					Switch $iTroopIndex
						Case $eBarb To $eIceG ; drop normal troops
							If $debug = True Then
								SetLog("AttackClick( " & $pixel[0] & ", " & $pixel[1] & " , " & $qty2 & ", " & $delayPoint & ",#0666)")
							Else
								AttackClick($pixel[0], $pixel[1], $qty2, $delayPoint, $delayDropLast, "#0666")
							EndIf
						Case $eKing
							If $debug = True Then
								SetLog("dropHeroes(" & $pixel[0] & ", " & $pixel[1] & ", " & $troopPosition & ", -1, -1) ")
							Else
								dropHeroes($pixel[0], $pixel[1], $troopPosition, -1, -1) ; was $g_iKingSlot, Slot11+
							EndIf
						Case $eQueen
							If $debug = True Then
								SetLog("dropHeroes(" & $pixel[0] & ", " & $pixel[1] & ",-1," & $troopPosition & ", -1) ")
							Else
								dropHeroes($pixel[0], $pixel[1], -1, $troopPosition, -1) ; was $g_iQueenSlot, Slot11+
							EndIf
						Case $eWarden
							If $debug = True Then
								SetLog("dropHeroes(" & $pixel[0] & ", " & $pixel[1] & ", -1, -1," & $troopPosition & ") ")
							Else
								dropHeroes($pixel[0], $pixel[1], -1, -1, $troopPosition) ; was $g_iWardenSlot, Slot11+
							EndIf
						Case $eCastle, $eWallW, $eBattleB, $eStoneS
							If $debug = True Then
								SetLog("dropCC(" & $pixel[0] & ", " & $pixel[1] & ", " & $troopPosition & ")")
							Else
								dropCC($pixel[0], $pixel[1], $troopPosition)
							EndIf
						Case $eLSpell To $eBtSpell
							If $debug = True Then
								SetLog("Drop Spell AttackClick( " & $pixel[0] & ", " & $pixel[1] & " , " & $qty2 & ", " & $delayPoint & ",#0666)")
							Else
								AttackClick($pixel[0], $pixel[1], $qty2, $delayPoint, $delayDropLast, "#0667")
							EndIf
							; assume spells get always dropped: adjust count so CC spells can be used without recalc
							If UBound($g_avAttackTroops) > $troopSlotConst And $g_avAttackTroops[$troopSlotConst][1] > 0 And $qty2 > 0 Then ; Slot11+
								$g_avAttackTroops[$troopSlotConst][1] -= $qty2
								debugAttackCSV("Adjust quantity of spell use: " & $g_avAttackTroops[$troopSlotConst][0] & " x" & $g_avAttackTroops[$troopSlotConst][1])
							EndIf
						Case Else
							SetLog("Error parsing line")
					EndSwitch
					debugAttackCSV($troopName & " qty " & $qty2 & " in (" & $pixel[0] & "," & $pixel[1] & ") delay " & $delayPoint)
				EndIf
				;;;;if $j <> $numbersOfVectors Then _sleep(5) ;little delay by passing from a vector to another vector
			Next
		Next

		ReleaseClicks()
		;SuspendAndroid($SuspendMode)

		;sleep time after deploy all troops
		Local $sleepafter = 0
		If $sleepafterMin <> $sleepAfterMax Then
			$sleepafter = Random($sleepafterMin, $sleepAfterMax, 1)
		Else
			$sleepafter = Int($sleepafterMin)
		EndIf
		$sleepafter = Int($sleepafter / $g_CSVSpeedDivider[$g_iMatchMode]); CSV Deploy Speed - Team AiO MOD++
		If $sleepafter > 0 And IsKeepClicksActive() = False Then
			debugAttackCSV("- delay after drop all troops: " & $sleepafter & " (x" & $g_CSVSpeedDivider[$g_iMatchMode] & " faster)")
			If $sleepafter <= 1000 Then ; check SLEEPAFTER value is less than 1 second?
				If _Sleep($sleepafter) Then Return
				If $bHeroDrop = True Then ;Check hero but skip Warden if was dropped with sleepafter to short to allow icon update
					Local $bHold = $g_bCheckWardenPower ; store existing flag state, should be true?
					$g_bCheckWardenPower = False ;temp disable warden health check
					CheckHeroesHealth()
					$g_bCheckWardenPower = $bHold ; restore flag state
				Else
					CheckHeroesHealth()
				EndIf
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

EndFunc   ;==>DropTroopFromINI
