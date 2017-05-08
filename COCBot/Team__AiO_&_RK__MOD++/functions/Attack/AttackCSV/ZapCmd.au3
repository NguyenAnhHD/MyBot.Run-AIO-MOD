; #FUNCTION# ====================================================================================================================
; Name ..........: Zap Command
; Description ...: Drop Spells and Zap Dark Elixir Drills With Command in Attack CSV
; Syntax ........:
; Parameters ....:
; Return values .: None
; Author ........: MR.ViPER (17-11-2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Global $ZDrillsPos[3][3] = [[-1, -1, ""], [-1, -1, ""], [-1, -1, ""]]
Global $ZMaxDrills = 3, $ZMaxLSpell = 2, $ZMaxESpell = 1
Global $ZDrillsDroppedSpells[3][2] = [[-1, -1], [-1, -1], [-1, -1]]
Global $ZOffsetDrill[2] = [0, +14]
Global $ZRandomDrop[2] = [3, 3]
Global $iIndexDrillToZapOn = -1
Global $CanZap = True

Func ZapCmd($DeploySide, $bLightning, $iLightning, $bEarthQuake, $iEarthQuake, $bCheck, $iMinDE, $DelayEachDrop)
	debugAttackCSV("Ini ZapCmd")
	debugAttackCSV("Parameter $DeploySide: " & $DeploySide)
	debugAttackCSV("Parameter $bLightning: " & $bLightning)
	debugAttackCSV("Parameter $iLightning: " & $iLightning)
	debugAttackCSV("Parameter $bEarthQuake: " & $bEarthQuake)
	debugAttackCSV("Parameter $iEarthQuake: " & $iEarthQuake)
	debugAttackCSV("Parameter $iEarthQuake: " & $iEarthQuake)
	debugAttackCSV("Parameter $bCheck: " & $bCheck)
	debugAttackCSV("Parameter $iMinDE: " & $iMinDE)
	debugAttackCSV("Parameter $DelayEachDrop: " & $DelayEachDrop)
	If $CanZap = False Then Return True

	If $bLightning = False And $bEarthQuake = False Then
		SetLog("Lightning and EarthQuake Both are Disabled In Command", $COLOR_RED)
		EndDropCommand(50, 150)
		Return False
	EndIf

	If $g_abAttackUseLightSpell[$g_iMatchMode] = 0 Then
		SetLog("Lightning is Un-checked in GUI, Exiting Zap", $COLOR_RED)
		$CanZap = False
		EndDropCommand(50, 150)
		Return False
	EndIf

	If CheckMinDE($iMinDE) = False Then
		$CanZap = False
		SetLog("DE Less Than Minimum Value, Skipping Zap Command")
		EndDropCommand(50, 150)
		Return False
	EndIf

	Local $rGetZDrillToDrop = GetZDrillToDrop($DeploySide, $bCheck, $bLightning, $iLightning, $bEarthQuake, $iEarthQuake)
	If $rGetZDrillToDrop[0] = -1 Then
		SetLog("No Drills Found With Conditions", $COLOR_ORANGE)
		EndDropCommand(50, 150)
		Return False
	EndIf
	If $rGetZDrillToDrop[2] = -1 And $rGetZDrillToDrop[3] = -1 Then
		SetLog("Limit Reach of dropping Spells on This Drill", $COLOR_BLUE)
		EndDropCommand(50, 150)
		Return False
	EndIf
	Local $rFindTroopInAttBar = -1
	If $bLightning Then
		$rFindTroopInAttBar = FindTroopInAttBar("LSpell")
		If $rFindTroopInAttBar <> -1 Then
			SelectDropTroop($rFindTroopInAttBar) ; select the troop...
			For $k = 1 To $rGetZDrillToDrop[2]
				If $CanZap = False Then Return True
				If $ZDrillsDroppedSpells[$iIndexDrillToZapOn][0] >= $ZMaxLSpell Then ExitLoop
				If $rGetZDrillToDrop[0] < 1 Then ExitLoop
				If CheckMinDE($iMinDE) = False Then
					$CanZap = False
					SetLog("DE Less Than Minimum Value, Exiting Zap Command")
					EndDropCommand(50, 150)
					Return True
				EndIf
				SetLog("ZapCmd | Dropping x1 Lightning On " & GetNumOrdinal($iIndexDrillToZapOn + 1) & " Drill", $COLOR_BLUE)
				AttackClick($rGetZDrillToDrop[0], $rGetZDrillToDrop[1], 1, 50, 50, "#0667")
				Zapped($iIndexDrillToZapOn, False, 1)
				If $DelayEachDrop > 0 Then
					If _Sleep($DelayEachDrop) Then Return True
				EndIf
				If $bCheck Then $rGetZDrillToDrop = GetZDrillToDrop($DeploySide, $bCheck, $bLightning, $iLightning, $bEarthQuake, $iEarthQuake)
				If CheckZDrillResult($rGetZDrillToDrop, True) = False Then Return True
			Next
		EndIf
	EndIf
	$rFindTroopInAttBar = -1
	If $bEarthQuake Then
		$rFindTroopInAttBar = FindTroopInAttBar("ESpell")
		If $rFindTroopInAttBar <> -1 Then
			SelectDropTroop($rFindTroopInAttBar) ; select the troop...
			For $k = 1 To $rGetZDrillToDrop[3]
				If $CanZap = False Then Return True
				If $ZDrillsDroppedSpells[$iIndexDrillToZapOn][1] >= $ZMaxESpell Then ExitLoop
				If $rGetZDrillToDrop[0] < 1 Then ExitLoop
				If CheckMinDE($iMinDE) = False Then
					$CanZap = False
					SetLog("DE Less Than Minimum Value, Exiting Zap Command")
					EndDropCommand(50, 150)
					Return True
				EndIf
				SetLog("ZapCmd | Dropping x1 EarthQuake On " & GetNumOrdinal($iIndexDrillToZapOn + 1) & " Drill", $COLOR_BLUE)
				AttackClick($rGetZDrillToDrop[0], $rGetZDrillToDrop[1], 1, 50, 50, "#0667")
				Zapped($iIndexDrillToZapOn, True, 1)
				If $DelayEachDrop > 0 Then
					If _Sleep($DelayEachDrop) Then Return True
				EndIf
				If $bCheck Then $rGetZDrillToDrop = GetZDrillToDrop($DeploySide, $bCheck, $bLightning, $iLightning, $bEarthQuake, $iEarthQuake)
				If CheckZDrillResult($rGetZDrillToDrop, True) = False Then Return True
			Next
		EndIf
	EndIf
EndFunc   ;==>ZapCmd

Func Zapped($iDrillIndex, $bIsEarthQuake, $Quantity = 1)
	debugAttackCSV("Ini Zapped")
	debugAttackCSV("Parameter $iDrillIndex: " & $iDrillIndex)
	debugAttackCSV("Parameter $bIsEarthQuake: " & $bIsEarthQuake)
	debugAttackCSV("Parameter $Quantity: " & $Quantity)
	If $iDrillIndex < 0 Then Return True
	If $ZDrillsDroppedSpells[$iDrillIndex][0] < 0 Then $ZDrillsDroppedSpells[$iDrillIndex][0] = 0
	If $ZDrillsDroppedSpells[$iDrillIndex][1] < 0 Then $ZDrillsDroppedSpells[$iDrillIndex][1] = 0
	Switch $bIsEarthQuake
		Case True
			; EarthQuake Spell
			$ZDrillsDroppedSpells[$iDrillIndex][1] += $Quantity
		Case Else
			; Lightning Spell
			$ZDrillsDroppedSpells[$iDrillIndex][0] += $Quantity
	EndSwitch
	Return True
EndFunc   ;==>Zapped

Func ZInit($Values)
	debugAttackCSV("Ini ZInit")
	debugAttackCSV("Parameter $Values: " & $Values)
	ResetZapCmd()
	Local $SplitedValues = StringSplit($Values, "|", 2)
	Local $Locate = $SplitedValues[0]
	$ZMaxDrills = $SplitedValues[1]
	$ZMaxLSpell = $SplitedValues[2]
	$ZMaxESpell = $SplitedValues[3]
	If $Locate Then
		AssignZDrills()
	EndIf
EndFunc   ;==>ZInit

Func ParseZapCommand($Values)
	debugAttackCSV("Ini ParseZapCommand")
	debugAttackCSV("Parameter $Values: " & $Values)
	Local $SplitedValues = StringSplit($Values, "|", 2)
	Local $DeploySide = $SplitedValues[0]
	Local $bLightning = $SplitedValues[1] = "TRUE" Or $SplitedValues[1] = "T" Or $SplitedValues[1] = "1"
	Local $iLightning = $SplitedValues[2]
	Local $bEarthQuake = $SplitedValues[3] = "TRUE" Or $SplitedValues[3] = "T" Or $SplitedValues[3] = "1"
	Local $iEarthQuake = $SplitedValues[4]
	Local $bCheck = $SplitedValues[5] = "A" Or $SplitedValues[4] = "Always"
	Local $iMinDE = $SplitedValues[6]
	Local $iDelayEachDrop = Int($SplitedValues[7])
	;MsgBox(0, "Values", "$DeploySide = " & $DeploySide & @CRLF & "$bLightning = " & $bLightning & @CRLF & "$iLightning = " & $iLightning & @CRLF & "$bEarthQuake = " & $bEarthQuake & @CRLF & "$iEarthQuake = " & $iEarthQuake & @CRLF & "$bCheck = " & $bCheck & @CRLF & "$iMinDE = " & $iMinDE)
	ZapCmd($DeploySide, $bLightning, $iLightning, $bEarthQuake, $iEarthQuake, $bCheck, $iMinDE, $iDelayEachDrop)
EndFunc   ;==>ParseZapCommand

Func GetNumOrdinal($iNum)
	debugAttackCSV("Ini GetNumOrdinal")
	debugAttackCSV("Parameter $iNum: " & $iNum)
	Switch $iNum
		Case 1
			Return "1st"
		Case 2
			Return "2nd"
		Case 3
			Return "3rd"
		Case Else
			Return $iNum
	EndSwitch
EndFunc   ;==>GetNumOrdinal

Func FindTroopInAttBar($troopName)
	debugAttackCSV("Ini FindTroopInAttBar")
	debugAttackCSV("Parameter $troopName: " & $troopName)

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

	If $troopPosition = -1 Then
		Setlog("No troop found in your attack troops list")
		debugAttackCSV("No troop found in your attack troops list")
		Return -1
	EndIf
	Return $troopPosition
EndFunc   ;==>FindTroopInAttBar

Func CheckMinDE($iMinDE, $showlog = False)
	debugAttackCSV("Ini CheckMinDE")
	debugAttackCSV("Parameter $iMinDE: " & $iMinDE)
	debugAttackCSV("Parameter $showlog: " & $showlog)
	Local $iAvailableDark
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(31, 144, True), Hex(0x282020, 6), 10) Or _ColorCheck(_GetPixelColor(31, 144, True), Hex(0x0F0617, 6), 5) Then ; check if the village have a Dark Elixir Storage/Drill
		$iAvailableDark = getDarkElixirVillageSearch(48, 126)
		If $showlog = True Then SetLog("Available Dark: " & $iAvailableDark & ", Min Dark To Zap: " & $iMinDE, $COLOR_BLUE)
		Return Not (Number($iMinDE, 2) > Number($iAvailableDark, 2))
	Else
		Return False
	EndIf

EndFunc   ;==>CheckMinDE

Func EndDropCommand($sleepafterMin, $sleepAfterMax = Default)
	debugAttackCSV("Ini EndDropCommand")
	debugAttackCSV("Parameter $sleepafterMin: " & $sleepafterMin)
	debugAttackCSV("Parameter $sleepAfterMax: " & $sleepAfterMax)
	If $sleepAfterMax = Default Then $sleepAfterMax = $sleepafterMin
	ReleaseClicks()
	;SuspendAndroid($SuspendMode)

	;sleep time after deploy all troops
	Local $sleepafter = 0
	If $sleepafterMin <> $sleepAfterMax Then
		$sleepafter = Random($sleepafterMin, $sleepAfterMax, 1)
	Else
		$sleepafter = Int($sleepafterMin)
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
EndFunc   ;==>EndDropCommand

Func GetZDrillToDrop($Side, $bReLocate, $bLightning, $iLightning, $bEarthQuake, $iEarthQuake)
	debugAttackCSV("Ini GetZDrillToDrop")
	debugAttackCSV("Parameter $Side: " & $Side)
	debugAttackCSV("Parameter $bReLocate: " & $bReLocate)
	debugAttackCSV("Parameter $bLightning: " & $bLightning)
	debugAttackCSV("Parameter $iLightning: " & $iLightning)
	debugAttackCSV("Parameter $bEarthQuake: " & $bEarthQuake)
	debugAttackCSV("Parameter $iEarthQuake: " & $iEarthQuake)

	Local $ToReturn[4] = [-1, -1, -1, -1] ;[0]=X , [1]=Y , [2]=Possible Lightning Count To Drop, [3]=Possible EQ Count To Drop
	If $Side = 1 Or $Side = 2 Or $Side = 3 Then
		; If Side was just a number for the Drill Index
		Local $zDrillIndex = ($Side - 1)
		If $bReLocate Then AssignZDrills($zDrillIndex)
		If $ZDrillsPos[$zDrillIndex][0] < 1 And $ZDrillsPos[$zDrillIndex][1] < 1 Then Return $ToReturn
		If $ZDrillsDroppedSpells[$zDrillIndex][0] >= $ZMaxLSpell And $ZDrillsDroppedSpells[$zDrillIndex][1] >= $ZMaxESpell Then Return $ToReturn
		If $ZMaxLSpell - $ZDrillsDroppedSpells[$zDrillIndex][0] > 0 Or $ZMaxESpell - $ZDrillsDroppedSpells[$zDrillIndex][1] > 0 Then
			$ToReturn[0] = $ZDrillsPos[$zDrillIndex][0] + $ZOffsetDrill[0] + Random($ZRandomDrop[0] - ($ZRandomDrop[0] * 2), $ZRandomDrop[0], 1)
			$ToReturn[1] = $ZDrillsPos[$zDrillIndex][1] + $ZOffsetDrill[1] + Random($ZRandomDrop[1] - ($ZRandomDrop[1] * 2), $ZRandomDrop[1], 1)
			If $bLightning Then $ToReturn[2] = $iLightning
			If $bEarthQuake Then $ToReturn[3] = $iEarthQuake
		EndIf
		$iIndexDrillToZapOn = $zDrillIndex
		Return $ToReturn
	Else
		If $bReLocate Then AssignZDrills()
	EndIf
	For $i = 0 To ($ZMaxDrills - 1)
		If $ZDrillsPos[$i][0] < 1 And $ZDrillsPos[$i][1] < 1 Then ContinueLoop
		If $ZDrillsDroppedSpells[$i][0] >= $ZMaxLSpell And $ZDrillsDroppedSpells[$i][1] >= $ZMaxESpell Then ContinueLoop
		Local $pPixel[2] = [$ZDrillsPos[$i][0], $ZDrillsPos[$i][1]]
		Local $sliced = Slice8($pPixel)
		Local $theDrillSide
		Switch StringLeft($sliced, 1)
			Case 1, 2
				$theDrillSide = "BOTTOM"
			Case 3, 4
				$theDrillSide = "TOP"
			Case 5, 6
				$theDrillSide = "TOP"
			Case 7, 8
				$theDrillSide = "BOTTOM"
		EndSwitch
		Local $curMainSide = StringSplit($MAINSIDE, "-", 2)[0]
		If $Side = "Same" And $theDrillSide = $curMainSide Then
			If $ZMaxLSpell - $ZDrillsDroppedSpells[$i][0] > 0 Or $ZMaxESpell - $ZDrillsDroppedSpells[$i][1] > 0 Then
				$ToReturn[0] = $ZDrillsPos[$i][0] + $ZOffsetDrill[0] + Random($ZRandomDrop[0] - ($ZRandomDrop[0] * 2), $ZRandomDrop[0], 1)
				$ToReturn[1] = $ZDrillsPos[$i][1] + $ZOffsetDrill[1] + Random($ZRandomDrop[1] - ($ZRandomDrop[1] * 2), $ZRandomDrop[1], 1)
				If $bLightning Then $ToReturn[2] = $iLightning
				If $bEarthQuake Then $ToReturn[3] = $iEarthQuake
			EndIf
			$iIndexDrillToZapOn = $i
			Return $ToReturn
		ElseIf $Side = "Opposite" And $theDrillSide <> $curMainSide Then
			If $ZMaxLSpell - $ZDrillsDroppedSpells[$i][0] > 0 Or $ZMaxESpell - $ZDrillsDroppedSpells[$i][1] > 0 Then
				$ToReturn[0] = $ZDrillsPos[$i][0] + $ZOffsetDrill[0] + Random($ZRandomDrop[0] - ($ZRandomDrop[0] * 2), $ZRandomDrop[0], 1)
				$ToReturn[1] = $ZDrillsPos[$i][1] + $ZOffsetDrill[1] + Random($ZRandomDrop[1] - ($ZRandomDrop[1] * 2), $ZRandomDrop[1], 1)
				If $bLightning Then $ToReturn[2] = $iLightning
				If $bEarthQuake Then $ToReturn[3] = $iEarthQuake
			EndIf
			$iIndexDrillToZapOn = $i
			Return $ToReturn
		ElseIf $Side = "Any" Then
			If $ZMaxLSpell - $ZDrillsDroppedSpells[$i][0] > 0 Or $ZMaxESpell - $ZDrillsDroppedSpells[$i][1] > 0 Then
				$ToReturn[0] = $ZDrillsPos[$i][0] + $ZOffsetDrill[0] + Random($ZRandomDrop[0] - ($ZRandomDrop[0] * 2), $ZRandomDrop[0], 1)
				$ToReturn[1] = $ZDrillsPos[$i][1] + $ZOffsetDrill[1] + Random($ZRandomDrop[1] - ($ZRandomDrop[1] * 2), $ZRandomDrop[1], 1)
				If $bLightning Then $ToReturn[2] = $iLightning
				If $bEarthQuake Then $ToReturn[3] = $iEarthQuake
			EndIf
			$iIndexDrillToZapOn = $i
			Return $ToReturn
		EndIf
	Next
	$iIndexDrillToZapOn = -1
	Return $ToReturn
EndFunc   ;==>GetZDrillToDrop

Func CheckZDrillResult($rGetZDrillToDrop, $showlog = True)
	debugAttackCSV("Ini CheckZDrillResult")
	For $i = 0 To UBound($rGetZDrillToDrop) -1
		debugAttackCSV("Parameter $rGetZDrillToDrop[" & $i & "]: " & $rGetZDrillToDrop[$i])
	Next
	debugAttackCSV("Parameter $showlog: " & $showlog)

	If $rGetZDrillToDrop[0] < 1 Then
		If $showlog Then SetLog("No Drills Found With Conditions", $COLOR_ORANGE)
		If $showlog Then EndDropCommand(50, 150)
		Return False
	EndIf
	If $rGetZDrillToDrop[2] < 0 And $rGetZDrillToDrop[3] < 0 Then
		If $showlog Then SetLog("Limit Reach of dropping Spells on This Drill", $COLOR_BLUE)
		If $showlog Then EndDropCommand(50, 150)
		Return False
	EndIf
	Return True
EndFunc   ;==>CheckZDrillResult

Func IsFirstZDetect()
	debugAttackCSV("Ini IsFirstZDetect")
	For $i = 0 To ($ZMaxDrills - 1)
		If $ZDrillsPos[$i][0] > 0 And $ZDrillsPos[$i][1] > 0 Then Return False
	Next
	Return True
EndFunc   ;==>IsFirstZDetect

Func AssignZDrills($iDrillToUpdate = -1)
	debugAttackCSV("Ini AssignZDrills")
	debugAttackCSV("Parameter $iDrillToUpdate: " & $iDrillToUpdate)
	Local $bIsFirstDetect = IsFirstZDetect()
	Switch $bIsFirstDetect
		Case True
			; If Was First Time To Detect Drills
			Local $aResult = GetLocDrills()
			Local $sResultPoints = ""
			Local $sResultPaths = ""
			Local $tmp
			For $i = 0 To (UBound($aResult) - 1)
				$tmp = $aResult[$i]
				$sResultPoints &= String($tmp[0]) & "|" ; Points
				Local $iToLoop = (StringInStr($tmp[0], "|") > 0) ? UBound(StringSplit($tmp[0], "|", 2)) : 1 ; Get Count of found points
				For $j = 1 To $iToLoop
					$sResultPaths &= $tmp[1] & "|" ; Path
				Next
			Next
			If StringRight($sResultPoints, 1) = "|" Then $sResultPoints = StringLeft($sResultPoints, StringLen($sResultPoints) - 1) ; Trim Last |
			If StringRight($sResultPaths, 1) = "|" Then $sResultPaths = StringLeft($sResultPaths, StringLen($sResultPaths) - 1) ; Trim Last |
			Local $AllDrills = $sResultPoints
			If Not StringInStr($AllDrills, ",") > 0 Then Return SetError(1) ; If No Drills Found
			Local $tmpSplitedPositions
			Local $tmpSplitedPaths
			If StringInStr($AllDrills, "|") > 0 Then
				$tmpSplitedPositions = StringSplit($AllDrills, "|", 2)
			Else
				$tmpSplitedPositions = _StringEqualSplit($AllDrills)
			EndIf
			If StringInStr($sResultPaths, "|") > 0 Then
				$tmpSplitedPaths = StringSplit($sResultPaths, "|", 2)
			Else
				$tmpSplitedPaths = _StringEqualSplit($sResultPaths)
			EndIf
			Local $tmpSplitedPositions2
			Local $SplitedPositions[$ZMaxDrills][3]
			For $i = 0 To ($ZMaxDrills - 1)
				If $i >= UBound($tmpSplitedPositions) Then ExitLoop
				$tmpSplitedPositions2 = StringSplit($tmpSplitedPositions[$i], ",", 2)
				$SplitedPositions[$i][0] = $tmpSplitedPositions2[0]
				$SplitedPositions[$i][1] = $tmpSplitedPositions2[1]
				$SplitedPositions[$i][2] = $tmpSplitedPaths[$i]
			Next
			For $i = 0 To ($ZMaxDrills - 1)
				If $i >= UBound($SplitedPositions) Then ExitLoop
				$ZDrillsPos[$i][0] = $SplitedPositions[$i][0]
				$ZDrillsPos[$i][1] = $SplitedPositions[$i][1]
				$ZDrillsPos[$i][2] = $SplitedPositions[$i][2]
			Next
		Case Else
			; If Was NOT First Time To Detect Drills
			Local $DrillSearch = ""
			Local $X, $Y, $X1, $Y1
			If $iDrillToUpdate >= 0 Then
				If $ZDrillsPos[$iDrillToUpdate][0] < 1 And $ZDrillsPos[$iDrillToUpdate][1] < 1 Then
					Local $aResult = GetLocDrills()
					Local $sResultPoints = ""
					Local $sResultPaths = ""
					Local $tmp
					For $i = 0 To (UBound($aResult) - 1)
						$tmp = $aResult[$i]
						$sResultPoints &= String($tmp[0]) & "|" ; Points
						$iToLoop = (StringInStr($tmp[0], "|") > 0) ? UBound(StringSplit($tmp[0], "|", 2)) : 1 ; Get Count of found points
						For $j = 1 To $iToLoop
							$sResultPaths &= $tmp[1] & "|" ; Path
						Next
					Next
					If StringRight($sResultPoints, 1) = "|" Then $sResultPoints = StringLeft($sResultPoints, StringLen($sResultPoints) - 1) ; Trim Last |
					If StringRight($sResultPaths, 1) = "|" Then $sResultPaths = StringLeft($sResultPaths, StringLen($sResultPaths) - 1) ; Trim Last |
					Local $AllDrills = $sResultPoints
					Local $tmpSplitedPositions
					Local $tmpSplitedPaths
					If StringInStr($AllDrills, "|") > 0 Then
						$tmpSplitedPositions = StringSplit($AllDrills, "|", 2)
					Else
						$tmpSplitedPositions = _StringEqualSplit($AllDrills)
					EndIf
					If StringInStr($sResultPaths, "|") > 0 Then
						$tmpSplitedPaths = StringSplit($sResultPaths, "|", 2)
					Else
						$tmpSplitedPaths = _StringEqualSplit($sResultPaths)
					EndIf
					If StringInStr($AllDrills, ",") > 0 Then
						Local $SplitedAllDrills = StringSplit($AllDrills, ",", 2)
						; Drill Found
						$ZDrillsPos[$iDrillToUpdate][0] = $SplitedAllDrills[0]
						$ZDrillsPos[$iDrillToUpdate][1] = $SplitedAllDrills[1]
						$ZDrillsPos[$iDrillToUpdate][2] = $tmpSplitedPaths[0]
					Else
						$ZDrillsPos[$iDrillToUpdate][0] = -1
						$ZDrillsPos[$iDrillToUpdate][1] = -1
						$ZDrillsPos[$iDrillToUpdate][2] = ""
					EndIf
				Else
					_CaptureRegion2()
					$DrillSearch = VerifyDrillLoc($ZDrillsPos[$iDrillToUpdate][2], $ZDrillsPos[$iDrillToUpdate][0], $ZDrillsPos[$iDrillToUpdate][1])
					If StringInStr($DrillSearch, ",") > 0 Then
						Local $SplitedDrillSearch = StringSplit($DrillSearch, ",", 2)
						; Drill Found
						$ZDrillsPos[$iDrillToUpdate][0] = $SplitedDrillSearch[0] + $X
						$ZDrillsPos[$iDrillToUpdate][1] = $SplitedDrillSearch[1] + $Y
					Else
						$ZDrillsPos[$iDrillToUpdate][0] = -1
						$ZDrillsPos[$iDrillToUpdate][1] = -1
					EndIf
				EndIf
				Return True
			EndIf
			_CaptureRegion2()
			For $i = 0 To ($ZMaxDrills - 1)
				If $ZDrillsPos[$i][0] < 1 And $ZDrillsPos[$i][1] < 1 Then ContinueLoop
				$DrillSearch = VerifyDrillLoc($ZDrillsPos[$i][2], $ZDrillsPos[$i][0], $ZDrillsPos[$i][1])
				If StringInStr($DrillSearch, ",") > 0 Then
					Local $SplitedDrillSearch = StringSplit($DrillSearch, ",", 2)
					; Drill Found
					$ZDrillsPos[$i][0] = $SplitedDrillSearch[0] + $X
					$ZDrillsPos[$i][1] = $SplitedDrillSearch[1] + $Y
				Else
					$ZDrillsPos[$i][0] = -1
					$ZDrillsPos[$i][1] = -1
					$ZDrillsPos[$i][1] = ""
				EndIf
			Next
	EndSwitch
EndFunc   ;==>AssignZDrills

Func VerifyDrillLoc($filePath, $X, $Y)
	debugAttackCSV("Ini VerifyDrillLoc")
	debugAttackCSV("Parameter $filePath: " & $filePath)
	debugAttackCSV("Parameter $X: " & $X)
	debugAttackCSV("Parameter $Y: " & $Y)
	Local $searchResult = ""
	$searchResult = ReCheckTile($filePath, String($X & "," & $Y), False)
	Return $searchResult
EndFunc   ;==>VerifyDrillLoc

Func GetLocDrills()
	debugAttackCSV("Ini GetLocDrills")
	Local $cDiamondImgLoc = "ECD", $rdImgLoc = "ECD"
	Return findMultiple($dDarkDrills, $cDiamondImgLoc, $rdImgLoc, 0, 1000, 0, "objectpoints,filepath")
EndFunc   ;==>GetLocDrills

Func ResetZapCmd()
	debugAttackCSV("Ini ResetZapCmd")
	$ZMaxDrills = 3 ; Reset Max Drills To Find/Drop On
	$ZMaxLSpell = 2 ; Reset Max Possible Lightning Spells To Drop On Each Drill
	$ZMaxESpell = 1 ; Reset Max Possible EarthQuake Spells To Drop On Each Drill

	$iIndexDrillToZapOn = -1
	$CanZap = True

	; Reset Drills Positions
	For $i = 0 To (UBound($ZDrillsPos) - 1)
		$ZDrillsPos[$i][0] = -1 ; X
		$ZDrillsPos[$i][1] = -1 ; Y
		$ZDrillsPos[$i][2] = "" ; Path
	Next

	; Reset Dropped Spells Count On Each Drill
	For $i = 0 To (UBound($ZDrillsDroppedSpells) - 1)
		$ZDrillsDroppedSpells[$i][0] = -1 ; Lightning Spell
		$ZDrillsDroppedSpells[$i][1] = -1 ; EarthQuake Spell
	Next
EndFunc   ;==>ResetZapCmd

