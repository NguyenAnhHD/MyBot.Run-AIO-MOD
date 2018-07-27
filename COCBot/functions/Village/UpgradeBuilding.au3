; #FUNCTION# ====================================================================================================================
; Name ..........: UpgradeBuilding.au3
; Description ...: Upgrades buildings if loot and builders are available
; Syntax ........: UpgradeBuilding(), UpgradeNormal($inum), UpgradeHero($inum)
; Parameters ....: $inum = array index [0-3]
; Return values .:
; Author ........: KnowJack (April-2015)
; Modified ......: KnowJack (Jun/Aug-2015),Sardo 2015-08,Monkeyhunter(2106-2)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_aiUpgradeLevel[$g_iUpgradeSlots] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

Func UpgradeBuilding()

	Local $iz = 0
	Local $iUpgradeAction = -1
	Local $iAvailBldr, $iAvailGold, $iAvailElixir, $iAvailDark
	Local $Endtime, $Endperiod, $TimeAdd
	Local $iUpGrdEndTimeDiff = 0
	Local $aCheckFrequency[10] = [5, 15, 20, 30, 60, 60, 120, 240, 240, 240] ; Dwell Time in minutes between each repeat upgrade check TH3-12
	;  $aCheckFrequency[($g_iTownHallLevel < 3 ? 0 : $g_iTownHallLevel - 3)]  ; returns dwell time based on user THlevel, range from 3=[0] to 11=[7]
	Local $iDTDiff
	Local $bChkAllRptUpgrade = False
	Local $sTime

	Static Local $sNextCheckTime = _DateAdd("n", -1, _NowCalc()) ; initialize with date/time of NOW minus one minute
	If @error Then _logErrorDateAdd(@error)

	$g_iUpgradeMinGold = Number($g_iUpgradeMinGold)
	$g_iUpgradeMinElixir = Number($g_iUpgradeMinElixir)
	$g_iUpgradeMinDark = Number($g_iUpgradeMinDark)

	; check to see if anything is enabled before wasting time.
	For $iz = 0 To UBound($g_avBuildingUpgrades, 1) - 1
		If $g_abBuildingUpgradeEnable[$iz] = True Then
			$iUpgradeAction += 2 ^ ($iz + 1)
		EndIf
	Next
	If $iUpgradeAction < 0 Then Return False
	$iUpgradeAction = 0 ; Reset action

	SetLog("Checking Upgrades", $COLOR_INFO)

	VillageReport(True, True) ; Get current loot available after training troops and update free builder status
	$iAvailGold = Number($g_aiCurrentLoot[$eLootGold])
	$iAvailElixir = Number($g_aiCurrentLoot[$eLootElixir])
	$iAvailDark = Number($g_aiCurrentLoot[$eLootDarkElixir])

	; If save wall builder is enable, make sure to reserve builder if enabled
	$iAvailBldr = $g_iFreeBuilderCount - ($g_bUpgradeWallSaveBuilder = True ? 1 : 0)

	If $iAvailBldr <= 0 Then
		SetLog("No builder available for upgrade process")
		Return False
	EndIf

	For $iz = 0 To UBound($g_avBuildingUpgrades, 1) - 1

		If $g_bDebugSetlog Then SetlogUpgradeValues($iz) ; massive debug data dump for each upgrade

		If $g_abBuildingUpgradeEnable[$iz] = False Then ContinueLoop ; Is the upgrade checkbox selected?

		If $g_avBuildingUpgrades[$iz][0] <= 0 Or $g_avBuildingUpgrades[$iz][1] <= 0 Or $g_avBuildingUpgrades[$iz][3] = "" Then ContinueLoop ; Now check to see if upgrade has locatation?

		; Check free builder in case of multiple upgrades, but skip check when time to check repeated upgrades.
		If $iAvailBldr <= 0 And $bChkAllRptUpgrade = False Then
			SetLog("No builder available for #" & $iz + 1 & ", " & $g_avBuildingUpgrades[$iz][4])
			Return False
		EndIf

		If $g_abUpgradeRepeatEnable[$iz] = True Then ; if repeated upgrade, may need to check upgrade value

			If $bChkAllRptUpgrade = False Then
				$iDTDiff = Int(_DateDiff("n", _NowCalc(), $sNextCheckTime)) ; get date/time difference for repeat upgrade check
				If @error Then _logErrorDateDiff(@error)
				If $g_bDebugSetlog Then
					SetDebugLog("Delay time between repeat upgrade checks = " & $aCheckFrequency[($g_iTownHallLevel < 3 ? 0 : $g_iTownHallLevel - 3)] & " Min", $COLOR_DEBUG)
					SetDebugLog("Delay time remaining = " & $iDTDiff & " Min", $COLOR_DEBUG)
				EndIf
				If $iDTDiff < 0 Then ; check dwell time clock to avoid checking repeats too often
					$sNextCheckTime = _DateAdd("n", $aCheckFrequency[($g_iTownHallLevel < 3 ? 0 : $g_iTownHallLevel - 3)], _NowCalc()) ; create new check date/time
					If @error Then _logErrorDateAdd(@error) ; log Date function errors
					$bChkAllRptUpgrade = True ; set flag to allow entire array of updates to get updated values if delay time is past.
					If $g_bDebugSetlog Then SetDebugLog("New delayed check time=  " & $sNextCheckTime, $COLOR_DEBUG)
				EndIf
			EndIf

			If _DateIsValid($g_avBuildingUpgrades[$iz][7]) Then ; check for valid date in upgrade array
				$iUpGrdEndTimeDiff = Int(_DateDiff("n", _NowCalc(), $g_avBuildingUpgrades[$iz][7])) ; what is difference between End time and now in minutes?
				If @error Then ; trap/log errors and zero time difference
					_logErrorDateDiff(@error)
					$iUpGrdEndTimeDiff = 0
				EndIf
				If $g_bDebugSetlog Then SetDebugLog("Difference between upgrade end and NOW= " & $iUpGrdEndTimeDiff & " Min", $COLOR_DEBUG)
			EndIf

			If $bChkAllRptUpgrade = True Or $iUpGrdEndTimeDiff < 0 Then ; when past delay time or past end time for previous upgrade then check status
				If UpgradeValue($iz, True) = False Then ; try to get new upgrade values
					If $g_bDebugSetlog Then SetlogUpgradeValues($iz) ; Debug data for when upgrade is not ready or done repeating
					SetLog("Repeat upgrade #" & $iz + 1 & " " & $g_avBuildingUpgrades[$iz][4] & " not ready yet", $COLOR_ERROR)
					ContinueLoop ; Not ready yet..
				ElseIf ($iAvailBldr <= 0) Then
					; must stop upgrade attempt if no builder here, due bypass of available builder check when $bChkAllRptUpgrade=true to get updated building values.
					SetLog("No builder available for " & $g_avBuildingUpgrades[$iz][4])
					ContinueLoop
				EndIf
			EndIf
		EndIf

		SetLog("Upgrade #" & $iz + 1 & " " & $g_avBuildingUpgrades[$iz][4] & " Selected", $COLOR_SUCCESS) ; Tell logfile which upgrade working on.
		If $g_bDebugSetlog Then SetDebugLog("-Upgrade location =  " & "(" & $g_avBuildingUpgrades[$iz][0] & "," & $g_avBuildingUpgrades[$iz][1] & ")", $COLOR_DEBUG) ;Debug
		If _Sleep($DELAYUPGRADEBUILDING1) Then Return

		Switch $g_avBuildingUpgrades[$iz][3] ;Change action based on upgrade type!
			Case "Gold"
				If $iAvailGold < $g_avBuildingUpgrades[$iz][2] + $g_iUpgradeMinGold Then ; Do we have enough Gold?
					SetLog("Insufficent Gold for #" & $iz + 1 & ", requires: " & $g_avBuildingUpgrades[$iz][2] & " + " & $g_iUpgradeMinGold, $COLOR_INFO)
					ContinueLoop
				EndIf
				If UpgradeNormal($iz) = False Then ContinueLoop
				$iUpgradeAction += 2 ^ ($iz + 1)
				SetLog("Gold used = " & $g_avBuildingUpgrades[$iz][2], $COLOR_INFO)
				$g_iNbrOfBuildingsUppedGold += 1
				$g_iCostGoldBuilding += $g_avBuildingUpgrades[$iz][2]
				UpdateStats()
				$iAvailGold -= $g_avBuildingUpgrades[$iz][2]
				$iAvailBldr -= 1
			Case "Elixir"
				If $iAvailElixir < $g_avBuildingUpgrades[$iz][2] + $g_iUpgradeMinElixir Then
					SetLog("Insufficent Elixir for #" & $iz + 1 & ", requires: " & $g_avBuildingUpgrades[$iz][2] & " + " & $g_iUpgradeMinElixir, $COLOR_INFO)
					ContinueLoop
				EndIf
				If UpgradeNormal($iz) = False Then ContinueLoop
				$iUpgradeAction += 2 ^ ($iz + 1)
				SetLog("Elixir used = " & $g_avBuildingUpgrades[$iz][2], $COLOR_INFO)
				$g_iNbrOfBuildingsUppedElixir += 1
				$g_iCostElixirBuilding += $g_avBuildingUpgrades[$iz][2]
				UpdateStats()
				$iAvailElixir -= $g_avBuildingUpgrades[$iz][2]
				$iAvailBldr -= 1
			Case "Dark"
				If $iAvailDark < $g_avBuildingUpgrades[$iz][2] + $g_iUpgradeMinDark Then
					SetLog("Insufficent Dark for #" & $iz + 1 & ", requires: " & $g_avBuildingUpgrades[$iz][2] & " + " & $g_iUpgradeMinDark, $COLOR_INFO)
					ContinueLoop
				EndIf
				If UpgradeHero($iz) = False Then ContinueLoop
				$iUpgradeAction += 2 ^ ($iz + 1)
				SetLog("Dark Elixir used = " & $g_avBuildingUpgrades[$iz][2], $COLOR_INFO)
				$g_iNbrOfHeroesUpped += 1
				$g_iCostDElixirHero += $g_avBuildingUpgrades[$iz][2]
				UpdateStats()
				$iAvailDark -= $g_avBuildingUpgrades[$iz][2]
				$iAvailBldr -= 1
			Case Else
				SetLog("Something went wrong with loot type on Upgradebuilding module on #" & $iz + 1, $COLOR_ERROR)
				ExitLoop
		EndSwitch

		$g_avBuildingUpgrades[$iz][7] = _NowCalc() ; what is date:time now
		If $g_bDebugSetlog Then SetDebugLog("Upgrade #" & $iz + 1 & " " & $g_avBuildingUpgrades[$iz][4] & " Started @ " & $g_avBuildingUpgrades[$iz][7], $COLOR_SUCCESS)
		Local $aArray = StringSplit($g_avBuildingUpgrades[$iz][6], ' ', BitOR($STR_CHRSPLIT, $STR_NOCOUNT)) ;separate days, hours
		If IsArray($aArray) Then
			Local $iRemainingTimeMin = 0
			For $i = 0 To UBound($aArray) - 1 ; step through array and compute minutes remaining
				$sTime = ""
				Select
					Case StringInStr($aArray[$i], "d", $STR_NOCASESENSEBASIC) > 0
						$sTime = StringTrimRight($aArray[$i], 1) ; removing the "d"
						$iRemainingTimeMin += (Int($sTime) * 24 * 60) - 7 ; change days to minutes and add, minus 7 minutes for early checking
					Case StringInStr($aArray[$i], "h", $STR_NOCASESENSEBASIC) > 0
						$sTime = StringTrimRight($aArray[$i], 1) ; removing the "h"
						$iRemainingTimeMin += (Int($sTime) * 60) - 3 ; change hours to minutes and add, minus 3 minutes
					Case StringInStr($aArray[$i], "m", $STR_NOCASESENSEBASIC) > 0
						$sTime = StringTrimRight($aArray[$i], 1) ; removing the "m"
						$iRemainingTimeMin += Int($sTime) ; add minutes
					Case Else
						SetLog("Upgrade #" & $iz + 1 & " OCR time invalid" & $aArray[$i], $COLOR_WARNING)
				EndSelect
				If $g_bDebugSetlog Then SetDebugLog("Upgrade Time: " & $aArray[$i] & ", Minutes= " & $iRemainingTimeMin, $COLOR_DEBUG)
			Next
			$g_avBuildingUpgrades[$iz][7] = _DateAdd('n', Floor($iRemainingTimeMin), _NowCalc()) ; add the time required to NOW to finish the upgrade
			If @error Then _logErrorDateAdd(@error)
			SetLog("Upgrade #" & $iz + 1 & " " & $g_avBuildingUpgrades[$iz][4] & " Finishes @ " & $g_avBuildingUpgrades[$iz][7], $COLOR_SUCCESS)
			GUICtrlSetData($g_hTxtUpgradeEndTime[$iz], $g_avBuildingUpgrades[$iz][7])
		Else
			SetLog("Non critical error processing upgrade time for " & "#" & $iz + 1 & ": " & $g_avBuildingUpgrades[$iz][4], $COLOR_WARNING)
		EndIf

	Next
	If $iUpgradeAction <= 0 Then
		SetLog("No Upgrades Available", $COLOR_SUCCESS)
	Else
		saveConfig()
	EndIf
	If _Sleep($DELAYUPGRADEBUILDING2) Then Return
	checkMainScreen(False) ; Check for screen errors during function
	Return $iUpgradeAction

EndFunc   ;==>UpgradeBuilding
;
Func UpgradeNormal($inum)

	Local $aResult, $ButtonPixel

	ClickP($aAway, 1, 0, "#0211") ;Click Away to close the upgrade window
	If _Sleep($DELAYUPGRADENORMAL1) Then Return

	BuildingClick($g_avBuildingUpgrades[$inum][0], $g_avBuildingUpgrades[$inum][1], "#0296") ; Select the item to be upgrade
	If _Sleep($DELAYUPGRADENORMAL1) Then Return ; Wait for window to open

	$aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY) ; read building name/level to check we have right bldg or if collector was not full

	If UBound($aResult) < 2 Then
		; bot stopped
		Return False
	EndIf
	If StringStripWS($aResult[1], BitOR($STR_STRIPLEADING, $STR_STRIPTRAILING)) <> StringStripWS($g_avBuildingUpgrades[$inum][4], BitOR($STR_STRIPLEADING, $STR_STRIPTRAILING)) Then ; check bldg names

		SetLog("#" & $inum + 1 & ":" & $g_avBuildingUpgrades[$inum][4] & ": Not same as :" & $aResult[1] & ":? Retry now...", $COLOR_INFO)
		ClickP($aAway, 1, 0, "#0211") ;Click Away to close window
		If _Sleep($DELAYUPGRADENORMAL1) Then Return

		BuildingClick($g_avBuildingUpgrades[$inum][0], $g_avBuildingUpgrades[$inum][1], "#0296") ; Select the item to be upgrade again in case full collector/mine
		If _Sleep($DELAYUPGRADENORMAL1) Then Return ; Wait for window to open

		$aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY) ; read building name/level to check we have right bldg or if collector was not full
		If $aResult[0] > 1 Then
			If StringStripWS($aResult[1], BitOR($STR_STRIPLEADING, $STR_STRIPTRAILING)) <> StringStripWS($g_avBuildingUpgrades[$inum][4], BitOR($STR_STRIPLEADING, $STR_STRIPTRAILING)) Then ; check bldg names
				SetLog("Found #" & $inum + 1 & ":" & $g_avBuildingUpgrades[$inum][4] & ": Not same as : " & $aResult[1] & ":, May need new location?", $COLOR_ERROR)
				Return False
			EndIf
		EndIf
	EndIf

	If QuickMIS("BC1", $g_sImgAUpgradeUpgradeBtn, 120, 630, 740, 680) Then
		Local $ButtonPixel[2]
		$ButtonPixel[0] = 120 + $g_iQuickMISX
		$ButtonPixel[1] = 630 + $g_iQuickMISY
		If $g_bDebugSetlog Then SetLog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG)

		If _Sleep($DELAYUPGRADENORMAL2) Then Return
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20, 1, 0, "#0297") ; Click Upgrade Button
		If _Sleep($DELAYUPGRADENORMAL3) Then Return ; Wait for window to open
		If $g_bDebugImageSave Then DebugImageSave("UpgradeRegBtn1")
		Local $aBldgUpgradeWinChk[4] = [687, 161 + $g_iMidOffsetY, 0xCD1419, 20] ; Red pixel on botton X to close window
		If _WaitForCheckPixel($aBldgUpgradeWinChk, $g_bCapturePixel,Default, "BldgUpgradeWinChk", Default, Default, 100) Then ; wait up to 2 seconds for hero upgrade window to open
			If _ColorCheck(_GetPixelColor(459, 490 + $g_iMidOffsetY, True), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(459, 494 + $g_iMidOffsetY), Hex(0xE70A12, 6), 20) And _
					_ColorCheck(_GetPixelColor(459, 498 + $g_iMidOffsetY, True), Hex(0xE70A12, 6), 20) Then ; Check for Red Zero = means not enough loot!

				SetLog("Upgrade Fail #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & ", No Loot!", $COLOR_ERROR)

				ClickP($aAway, 2, 0, "#0298") ;Click Away
				Return False
			Else
				Click(440, 480 + $g_iMidOffsetY, 1, 0, "#0299") ; Click upgrade buttton
				If _Sleep($DELAYUPGRADENORMAL3) Then Return
				If $g_bDebugImageSave Then DebugImageSave("UpgradeRegBtn2")
				If _ColorCheck(_GetPixelColor(573, 256 + $g_iMidOffsetY, True), Hex(0xE1090E, 6), 20) Then ; Redundant Safety Check if the use Gem window opens
					SetLog("Upgrade Fail #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & " No Loot!", $COLOR_ERROR)
					ClickP($aAway, 2, 0, "#0300") ;Click Away to close windows
					Return False
				EndIf
				SetLog("Upgrade #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & " started", $COLOR_SUCCESS)
				_GUICtrlSetImage($g_hPicUpgradeStatus[$inum], $g_sLibIconPath, $eIcnGreenLight) ; Change GUI upgrade status to done
				$g_aiPicUpgradeStatus[$inum] = $eIcnGreenLight ; Change GUI upgrade status to done
				GUICtrlSetData($g_hTxtUpgradeValue[$inum], -($g_avBuildingUpgrades[$inum][2])) ; Show Negative Upgrade value in GUI
				;$itxtUpgradeValue[$inum] = -($g_avBuildingUpgrades[$inum][2]) ; Show Negative Upgrade value in GUI
				GUICtrlSetData($g_hTxtUpgradeLevel[$inum], $g_avBuildingUpgrades[$inum][5] & "+") ; Set GUI level to match $g_avBuildingUpgrades variable
				$g_aiUpgradeLevel[$inum] = $g_avBuildingUpgrades[$inum][5] & "+" ; Set GUI level to match $g_avBuildingUpgrades variable
				If $g_abUpgradeRepeatEnable[$inum] = False Then ; Check for repeat upgrade
					GUICtrlSetState($g_hChkUpgrade[$inum], $GUI_UNCHECKED) ; Change upgrade selection box to unchecked
					$g_abBuildingUpgradeEnable[$inum] = False ; Change upgrade selection box to unchecked
					$g_avBuildingUpgrades[$inum][0] = -1 ;Reset $UpGrade position coordinate variable to blank to show its completed
					$g_avBuildingUpgrades[$inum][1] = -1
					$g_avBuildingUpgrades[$inum][3] = "" ; Reset loot type
					GUICtrlSetData($g_hTxtUpgradeLevel[$inum], $g_avBuildingUpgrades[$inum][5] & "+") ; Set GUI level to match $g_avBuildingUpgrades variable
					$g_avBuildingUpgrades[$inum][5] = $g_avBuildingUpgrades[$inum][5] & "+" ; Set GUI level to match $g_avBuildingUpgrades variable
				ElseIf $g_abUpgradeRepeatEnable[$inum] = True Then
					GUICtrlSetState($g_hChkUpgrade[$inum], $GUI_CHECKED) ; Ensure upgrade selection box is checked
					$g_abBuildingUpgradeEnable[$inum] = True ; Ensure upgrade selection box is checked
				EndIf
				ClickP($aAway, 2, 0, "#0301") ;Click Away to close windows
				If _Sleep($DELAYUPGRADENORMAL3) Then Return ; Wait for window to close

				Return True
			EndIf
		ElseIf _ColorCheck(_GetPixelColor(721, 118 + $g_iMidOffsetY, True), Hex(0xDF0408, 6), 20) Then ; Check if the building Upgrade window is open, FOR WARDEN
			If _ColorCheck(_GetPixelColor(459, 490 + $g_iMidOffsetY, True), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(459, 494 + $g_iMidOffsetY), Hex(0xE70A12, 6), 20) And _
					_ColorCheck(_GetPixelColor(459, 498 + $g_iMidOffsetY, True), Hex(0xE70A12, 6), 20) Then ; Check for Red Zero = means not enough loot!

				SetLog("Upgrade Fail #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & ", No Loot!", $COLOR_RED)

				ClickP($aAway, 2, 0, "#0298") ;Click Away
				Return False
			Else
				Click(670, 510 + $g_iMidOffsetY, 1, 0, "#0299") ; Click upgrade buttton
				If _Sleep($DELAYUPGRADENORMAL3) Then Return
				If $g_bDebugImageSave Then DebugImageSave("UpgradeRegBtn2")
				If _ColorCheck(_GetPixelColor(573, 256 + $g_iMidOffsetY, True), Hex(0xE1090E, 6), 20) Then ; Redundant Safety Check if the use Gem window opens
					SetLog("Upgrade Fail #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & " No Loot!", $COLOR_RED)
					ClickP($aAway, 2, 0, "#0300") ;Click Away to close windows
					Return False
				EndIf
				SetLog("Upgrade #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & " started", $COLOR_GREEN)
				_GUICtrlSetImage($g_hPicUpgradeStatus[$inum], $g_sLibIconPath, $eIcnGreenLight) ; Change GUI upgrade status to done
				$g_aiPicUpgradeStatus[$inum] = $eIcnGreenLight ; Change GUI upgrade status to done
				GUICtrlSetData($g_hTxtUpgradeValue[$inum], -($g_avBuildingUpgrades[$inum][2])) ; Show Negative Upgrade value in GUI
				;$itxtUpgradeValue[$inum] = -($g_avBuildingUpgrades[$inum][2]) ; Show Negative Upgrade value in GUI
				GUICtrlSetData($g_hTxtUpgradeLevel[$inum], $g_avBuildingUpgrades[$inum][5] & "+") ; Set GUI level to match $g_avBuildingUpgrades variable
				$g_aiUpgradeLevel[$inum] = $g_avBuildingUpgrades[$inum][5] & "+" ; Set GUI level to match $g_avBuildingUpgrades variable
				If $g_abUpgradeRepeatEnable[$inum] = False Then ; Check for repeat upgrade
					GUICtrlSetState($g_hChkUpgrade[$inum], $GUI_UNCHECKED) ; Change upgrade selection box to unchecked
					$g_abBuildingUpgradeEnable[$inum] = False ; Change upgrade selection box to unchecked
					$g_avBuildingUpgrades[$inum][0] = -1 ;Reset $UpGrade position coordinate variable to blank to show its completed
					$g_avBuildingUpgrades[$inum][1] = -1
					$g_avBuildingUpgrades[$inum][3] = "" ; Reset loot type
					GUICtrlSetData($g_hTxtUpgradeLevel[$inum], $g_avBuildingUpgrades[$inum][5] & "+") ; Set GUI level to match $g_avBuildingUpgrades variable
					$g_avBuildingUpgrades[$inum][5] = $g_avBuildingUpgrades[$inum][5] & "+" ; Set GUI level to match $g_avBuildingUpgrades variable
				ElseIf $g_abUpgradeRepeatEnable[$inum] = True Then
					GUICtrlSetState($g_hChkUpgrade[$inum], $GUI_CHECKED) ; Ensure upgrade selection box is checked
					$g_abBuildingUpgradeEnable[$inum] = True ; Ensure upgrade selection box is checked
				EndIf
				ClickP($aAway, 2, 0, "#0301") ;Click Away to close windows
				If _Sleep($DELAYUPGRADENORMAL3) Then Return ; Wait for window to close

				Return True
			EndIf
		Else
			SetLog("Upgrade #" & $inum + 1 & " window open fail", $COLOR_ERROR)
			ClickP($aAway, 2, 0, "#0302") ;Click Away
		EndIf
	Else
		SetLog("Upgrade #" & $inum + 1 & " Error finding button", $COLOR_ERROR)
		ClickP($aAway, 2, 0, "#0303") ;Click Away
		Return False
	EndIf
EndFunc   ;==>UpgradeNormal
;
Func UpgradeHero($inum)
	Local $ButtonPixel

	BuildingClick($g_avBuildingUpgrades[$inum][0], $g_avBuildingUpgrades[$inum][1], "#0304") ; Select the item to be upgrade
	If _Sleep($DELAYUPGRADEHERO1) Then Return ; Wait for window to open

	If QuickMIS("BC1", $g_sImgAUpgradeUpgradeBtn, 120, 630, 740, 680) Then
		Local $ButtonPixel[2]
		$ButtonPixel[0] = 120 + $g_iQuickMISX
		$ButtonPixel[1] = 630 + $g_iQuickMISY
		If $g_bDebugSetlog Then SetLog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG)

		If _Sleep($DELAYUPGRADEHERO2) Then Return
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20, 1, 0, "#0305") ; Click Upgrade Button
		If _Sleep($DELAYUPGRADEHERO3) Then Return ; Wait for window to open
		If $g_bDebugImageSave Then DebugImageSave("UpgradeDarkBtn1")
		Local $aHeroUpgradeWinChk[4] = [729, 128 + $g_iMidOffsetY, 0xCD161D, 20] ; Red pixel on botton X to close window
		If _WaitForCheckPixel($aHeroUpgradeWinChk, $g_bCapturePixel,Default, "HeroUpgradeWinChk", Default, Default, 100) Then ; wait up to 2 seconds for hero upgrade window to open
			If _ColorCheck(_GetPixelColor(691, 523 + $g_iMidOffsetY, True), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(691, 527 + $g_iMidOffsetY), Hex(0xE70A12, 6), 20) And _
					_ColorCheck(_GetPixelColor(691, 531 + $g_iMidOffsetY, True), Hex(0xE70A12, 6), 20) Then ; Check for Red Zero = means not enough loot!
				SetLog("Hero Upgrade Fail #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & " No DE!", $COLOR_ERROR)
				ClickP($aAway, 2, 0, "#0306") ;Click Away to close window
				Return False
			Else
				Click(660, 515 + $g_iMidOffsetY, 1, 0, "#0307") ; Click upgrade buttton
				ClickP($aAway, 1, 0, "#0308") ;Click Away to close windows
				If _Sleep($DELAYUPGRADEHERO1) Then Return
				If $g_bDebugImageSave Then DebugImageSave("UpgradeDarkBtn2")
				If _ColorCheck(_GetPixelColor(573, 256 + $g_iMidOffsetY, True), Hex(0xE1090E, 6), 20) Then ; Redundant Safety Check if the use Gem window opens
					SetLog("Upgrade Fail #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & " No DE!", $COLOR_ERROR)
					ClickP($aAway, 2, 0, "#0309") ;Click Away to close windows
					Return False
				EndIf
				SetLog("Hero Upgrade #" & $inum + 1 & " " & $g_avBuildingUpgrades[$inum][4] & " started", $COLOR_SUCCESS)
				_GUICtrlSetImage($g_hPicUpgradeStatus[$inum], $g_sLibIconPath, $eIcnGreenLight) ; Change GUI upgrade status to done
				$g_aiPicUpgradeStatus[$inum] = $eIcnGreenLight ; Change GUI upgrade status to done
				GUICtrlSetData($g_hTxtUpgradeValue[$inum], -($g_avBuildingUpgrades[$inum][2])) ; Show Negative Upgrade value in GUI
				;$itxtUpgradeValue[$inum] = -($g_avBuildingUpgrades[$inum][2]) ; Show Negative Upgrade value in GUI
				GUICtrlSetData($g_hTxtUpgradeLevel[$inum], $g_avBuildingUpgrades[$inum][5] & "+") ; Set GUI level to match $g_avBuildingUpgrades variable
				$g_aiUpgradeLevel[$inum] = $g_avBuildingUpgrades[$inum][5] & "+" ; Set GUI level to match $g_avBuildingUpgrades variable
				If $g_abUpgradeRepeatEnable[$inum] = False Then ; Check for repeat upgrade
					GUICtrlSetState($g_hChkUpgrade[$inum], $GUI_UNCHECKED) ; Change upgrade selection box to unchecked
					$g_abBuildingUpgradeEnable[$inum] = False ; Change upgrade selection box to unchecked
					$g_avBuildingUpgrades[$inum][0] = -1 ;Reset $UpGrade position coordinate variable to blank to show its completed
					$g_avBuildingUpgrades[$inum][1] = -1
					$g_avBuildingUpgrades[$inum][3] = "" ; Reset loot type
					GUICtrlSetData($g_hTxtUpgradeLevel[$inum], $g_avBuildingUpgrades[$inum][5] & "+") ; Set GUI level to match $g_avBuildingUpgrades variable
					$g_avBuildingUpgrades[$inum][5] = $g_avBuildingUpgrades[$inum][5] & "+" ; Set GUI level to match $g_avBuildingUpgrades variable
				ElseIf $g_abUpgradeRepeatEnable[$inum] = True Then
					GUICtrlSetState($g_hChkUpgrade[$inum], $GUI_CHECKED) ; Ensure upgrade selection box is checked
					$g_abBuildingUpgradeEnable[$inum] = True ; Ensure upgrade selection box is checked
				EndIf
				ClickP($aAway, 2, 0, "#0310") ;Click Away to close windows
				If _Sleep($DELAYUPGRADEHERO2) Then Return ; Wait for window to close
				Return True
			EndIf
		Else
			SetLog("Upgrade #" & $inum + 1 & " window open fail", $COLOR_ERROR)
			ClickP($aAway, 2, 0, "#0311") ;Click Away to close windows
		EndIf
	Else
		SetLog("Upgrade #" & $inum + 1 & " Error finding button", $COLOR_ERROR)
		ClickP($aAway, 2, 0, "#0312") ;Click Away to close windows
		Return False
	EndIf
EndFunc   ;==>UpgradeHero

Func SetlogUpgradeValues($i)
	Local $j
	For $j = 0 To UBound($g_avBuildingUpgrades, 2) - 1
		SetLog("$g_avBuildingUpgrades[" & $i & "][" & $j & "]= " & $g_avBuildingUpgrades[$i][$j], $COLOR_DEBUG)
	Next
	;SetLog("$g_hChkUpgrade= " & GUICtrlRead($g_hChkUpgrade[$i]) & "|" & $g_abBuildingUpgradeEnable[$i], $COLOR_DEBUG) ; upgrade selection box
	;SetLog("$g_hTxtUpgradeName= " & GUICtrlRead($g_hTxtUpgradeName[$i]) & "|" &  $g_avBuildingUpgrades[$i][4], $COLOR_DEBUG) ;  Unit Name
	;SetLog("$g_hTxtUpgradeLevel= " & GUICtrlRead($g_hTxtUpgradeLevel[$i]) & "|" & $g_aiUpgradeLevel[$i], $COLOR_DEBUG) ; Unit Level
	;SetLog("$g_hPicUpgradeType= " & GUICtrlRead($g_hPicUpgradeType[$i]) & "|" & $g_aiPicUpgradeStatus[$i], $COLOR_DEBUG) ; status image
	;SetLog("$g_hTxtUpgradeValue= " & GUICtrlRead($g_hTxtUpgradeValue[$i]) & "|" & $g_avBuildingUpgrades[$i][2], $COLOR_DEBUG) ; Upgrade value
	;SetLog("$g_hTxtUpgradeTime= " & GUICtrlRead($g_hTxtUpgradeTime[$i]) & "|" & $g_avBuildingUpgrades[$i][6], $COLOR_DEBUG) ; Upgrade time
	;SetLog("$g_hChkUpgradeRepeat= " & GUICtrlRead($g_hChkUpgradeRepeat[$i]) & "|" & $g_abUpgradeRepeatEnable, $COLOR_DEBUG) ; repeat box
	SetLog("$g_hChkUpgrade= " & $g_abBuildingUpgradeEnable[$i], $COLOR_DEBUG) ; upgrade selection box
	SetLog("$g_hTxtUpgradeName= " & $g_avBuildingUpgrades[$i][4], $COLOR_DEBUG) ;  Unit Name
	SetLog("$g_hTxtUpgradeLevel= " & $g_aiUpgradeLevel[$i], $COLOR_DEBUG) ; Unit Level
	SetLog("$g_hPicUpgradeType= " & $g_aiPicUpgradeStatus[$i], $COLOR_DEBUG) ; status image
	SetLog("$g_hTxtUpgradeValue= " & $g_avBuildingUpgrades[$i][2], $COLOR_DEBUG) ; Upgrade value
	SetLog("$g_hTxtUpgradeTime= " & $g_avBuildingUpgrades[$i][6], $COLOR_DEBUG) ; Upgrade time
	SetLog("$g_hTxtUpgradeEndTime= " & $g_avBuildingUpgrades[$i][7], $COLOR_DEBUG) ; Upgrade End time
	SetLog("$g_hChkUpgradeRepeat= " & $g_abUpgradeRepeatEnable, $COLOR_DEBUG) ; repeat box
EndFunc   ;==>SetlogUpgradeValues
