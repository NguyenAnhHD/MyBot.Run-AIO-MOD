; #FUNCTION# ====================================================================================================================
; Name ..........: BoostBarracks.au3
; Description ...:
; Syntax ........: BoostBarracks(), BoostSpellFactory()
; Parameters ....:
; Return values .: None
; Author ........: MR.ViPER (9/9/2016)
; Modified ......: MR.ViPER (17/10/2016), Fliegerfaust (21/12/2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func BoostBarracks()
	Return BoostTrainBuilding("Barracks", $g_iCmbBoostBarracks, $g_hCmbBoostBarracks)
EndFunc   ;==>BoostBarracks

Func BoostSpellFactory()
	Return BoostTrainBuilding("Spell Factory", $g_iCmbBoostSpellFactory, $g_hCmbBoostSpellFactory)
EndFunc   ;==>BoostSpellFactory

Func BoostWorkshop()
	Return BoostTrainBuilding("Workshop", $g_iCmbBoostWorkshop, $g_hCmbBoostWorkshop)
EndFunc   ;==>BoostWorkshop

Func BoostTrainBuilding($sName, $iCmbBoost, $iCmbBoostCtrl)
	Local $boosted = False

	If Not $g_bTrainEnabled Or $iCmbBoost <= 0 Then Return $boosted

	Local $aHours = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)
	If Not $g_abBoostBarracksHours[$aHours[0]] Then
		SetLog("Boosting " & $sName & " isn't planned, skipping", $COLOR_INFO)
		Return $boosted
	EndIf

	Local $sIsAre = "are"
	SetLog("Boosting " & $sName, $COLOR_INFO)

	If OpenArmyOverview(True, "BoostTrainBuilding()") Then
		If $sName = "Barracks" Then
			If Not OpenTroopsTab(True, "BoostTrainBuilding()") Then Return
		ElseIf $sName = "Spell Factory" Then
			If Not OpenSpellsTab(True, "BoostTrainBuilding()") Then Return
			$sIsAre = "is"
		ElseIf $sName = "Workshop" Then
			If Not OpenSiegeMachinesTab(True, "BoostTrainBuilding()") Then Return
			$sIsAre = "is"
		Else
			SetDebugLog("BoostTrainBuilding(): $sName called with a wrong Value.", $COLOR_ERROR)
			ClickP($aAway, 1, 0, "#0161")
			_Sleep($DELAYBOOSTBARRACKS2)
			Return $boosted
		EndIf
		Local $aBoostBtn = findButton("BoostBarrack")
		If IsArray($aBoostBtn) Then
			ClickP($aBoostBtn)
			_Sleep($DELAYBOOSTBARRACKS1)
			Local $aGemWindowBtn = findButton("GEM")
			If IsArray($aGemWindowBtn) Then
				ClickP($aGemWindowBtn)
				_Sleep($DELAYBOOSTBARRACKS2)
				If IsArray(findButton("EnterShop")) Then
					SetLog("Not enough gems to boost " & $sName, $COLOR_ERROR)
				Else
					If $iCmbBoost >= 1 And $iCmbBoost <= 24 Then
						$iCmbBoost -= 1
						_GUICtrlComboBox_SetCurSel($iCmbBoostCtrl, $iCmbBoost)
						SetLog("Remaining " & $sName & " Boosts: " & $iCmbBoost, $COLOR_SUCCESS)
					ElseIf $iCmbBoost = 25 Then
						SetLog("Remain " & $sName & " Boosts: Unlimited", $COLOR_SUCCESS)
					EndIf
					$boosted = True
					; Force to get the Remain Time
					If $sName = "Barracks" Then
						$g_aiTimeTrain[0] = 0 ; reset Troop remaining time
					Else
						$g_aiTimeTrain[1] = 0 ; reset Spells remaining time
					EndIf
				EndIf
			EndIf
		Else
			If IsArray(findButton("BarrackBoosted")) Then
				SetLog($sName & " " & $sIsAre & " already boosted", $COLOR_SUCCESS)
			Else
				SetLog($sName & "boost button not found", $COLOR_ERROR)
			EndIf
		EndIf
	EndIf

	ClickP($aAway, 1, 0, "#0161")
	_Sleep($DELAYBOOSTBARRACKS2)
	Return $boosted
EndFunc   ;==>BoostTrainBuilding

Func BoostTrainingPotion()
	; Verifying existent Variables to run this routine
	If AllowBoosting("Training Potion", $g_iCmbBoostTrainingPotion) = False Then Return

	SetLog("Boosting Training Potion .....", $COLOR_INFO)
	If $g_aiTownHallPos[0] = "" Or $g_aiTownHallPos[0] = -1 Then
		LocateTownHall()
		SaveConfig()
		If _Sleep($DELAYBOOSTBARRACKS2) Then Return
	EndIf

	Local Static $iLastTimeChecked[8] = [0, 0, 0, 0, 0, 0, 0, 0], $iDateCalc
	$iDateCalc = _DateDiff('n', $iLastTimeChecked[$g_iCurAccount], _NowCalc())

	If $iLastTimeChecked[$g_iCurAccount] = 0 Or $iDateCalc > 50 Then
		; Chek if the Boost is running
		If OpenArmyOverview(True, "BoostTrainingPotion()") Then
			If Not OpenTroopsTab(True, "BoostTrainingPotion()") Then Return
			Local $aBoostBtn = findButton("BoostBarrack")
			If IsArray($aBoostBtn) Then
				ClickP($aAway, 2, 0, "#0161")
				If _Sleep(1000) Then Return

				Local $bChecked = BoostPotion("Training Potion", "Town", $g_aiTownHallPos, $g_iCmbBoostTrainingPotion, $g_hCmbBoostTrainingPotion) = _NowCalc()
				If Not $bChecked Then Return False
				$g_aiTimeTrain[0] = 0 ; reset Troop remaining time
				$g_aiTimeTrain[1] = 0 ; reset Spells remaining time
				$g_aiTimeTrain[2] = 0 ; reset Heroes remaining time
				$iLastTimeChecked[$g_iCurAccount] = _NowCalc() ; Reset the Check Timer
				Return True
			Else
				SetLog("Training Potion is already Boosted", $COLOR_INFO)
			EndIf
			ClickP($aAway, 2, 0, "#0161")
		EndIf
	EndIf

	If _Sleep($DELAYBOOSTBARRACKS3) Then Return
	checkMainScreen(False) ; Check for errors during function
	Return False
EndFunc   ;==>BoostTrainingPotion

Func BoostResourcePotion()
	; Verifying existent Variables to run this routine
	If AllowBoosting("Resource Potion", $g_iCmbBoostResourcePotion) = False Then Return

	SetLog("Boosting Resource Potion .....", $COLOR_INFO)
	If $g_aiTownHallPos[0] = "" Or $g_aiTownHallPos[0] = -1 Then
		LocateTownHall()
		SaveConfig()
		If _Sleep($DELAYBOOSTBARRACKS2) Then Return
	EndIf

	Local Static $iLastTimeChecked[8] = [0, 0, 0, 0, 0, 0, 0, 0], $iDateCalc
	$iDateCalc = _DateDiff('n', $iLastTimeChecked[$g_iCurAccount], _NowCalc())
	Local $ok = False
	If $iLastTimeChecked[$g_iCurAccount] = 0 Or $iDateCalc > 50 Then
		; Chek if the Boost is running
		If UBound($g_aiResourcesPos) > 1 And $g_aiResourcesPos[0] > 0 And $g_aiResourcesPos[1] > 0 Then
			ClickP($g_aiResourcesPos, 1, 0, "#Resources")
			If _Sleep($DELAYBOOSTHEROES2) Then Return
			ForceCaptureRegion()
			Local $aResult = BuildingInfo(242, 491 + $g_iBottomOffsetY)
			If $aResult[0] > 1 Then
				Local $sN = $aResult[1] ; Store bldg name
				Local $sL = $aResult[2] ; Sotre bdlg level
				If StringInStr($sN, "Mine", $STR_NOCASESENSEBASIC) > 0 Then
					; Structure located
					SetLog("Find " & $sN & " (Level " & $sL & ") located at " & $g_aiResourcesPos[0] & ", " & $g_aiResourcesPos[1], $COLOR_SUCCESS)
					$ok = True
				ElseIf StringInStr($sN, "Collector", $STR_NOCASESENSEBASIC) > 0 Then
					; Structure located
					SetLog("Find " & $sN & " (Level " & $sL & ") located at " & $g_aiResourcesPos[0] & ", " & $g_aiResourcesPos[1], $COLOR_SUCCESS)
					$ok = True
				ElseIf StringInStr($sN, "Drill", $STR_NOCASESENSEBASIC) > 0 Then
					; Structure located
					SetLog("Find " & $sN & " (Level " & $sL & ") located at " & $g_aiResourcesPos[0] & ", " & $g_aiResourcesPos[1], $COLOR_SUCCESS)
					$ok = True
				Else
					SetLog("Cannot find " & $sN & " (Level " & $sL & ") located at " & $g_aiResourcesPos[0] & ", " & $g_aiResourcesPos[1], $COLOR_ERROR)
				EndIf
			EndIf
		EndIf
		If $ok = True Then
			Local $aCheckBoosted = findButton("Boostleft")
			If Not IsArray($aCheckBoosted) Then
				ClickP($aAway, 2, 0, "#0161")
				If _Sleep($DELAYBOOSTBARRACKS1) Then Return

				Local $bChecked = BoostPotion("Resource Potion", "Town", $g_aiTownHallPos, $g_iCmbBoostResourcePotion, $g_hCmbBoostResourcePotion) = _NowCalc()
				If Not $bChecked Then Return False
				$iLastTimeChecked[$g_iCurAccount] = _NowCalc() ; Reset the Check Timer
				Return True
			Else
				SetLog("Resource Potion is already Boosted", $COLOR_INFO)
			EndIf
			ClickP($aAway, 2, 0, "#0161")
		EndIf
	EndIf

	If _Sleep($DELAYBOOSTBARRACKS3) Then Return
	checkMainScreen(False) ; Check for errors during function
	Return False
EndFunc   ;==>BoostTrainingPotion
