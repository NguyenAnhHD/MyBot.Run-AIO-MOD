; #FUNCTION# ====================================================================================================================
; Name ..........: Auto Upgrade (v5)
; Description ...: This file contains all functions of Pico Auto Upgrade feature
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: RoroTiti
; Modified ......: 08/05/2017
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......: ---
;================================================================================================================================

Func AutoUpgrade()

	If $g_ichkAutoUpgrade = 1 Then ; check if AutoUpgrade is enabled
		getBuilderCount()
		If $g_iFreeBuilderCount <> 0 Then ; check free builders
			If ($g_bUpgradeWallSaveBuilder = 1 And $g_iFreeBuilderCount > 1) Or $g_bUpgradeWallSaveBuilder = 0 Then ; check if Save builder for walls is active
				SetLog("Starting Auto Upgrade...", $COLOR_BLUE)
				SetLog("Cleaning Yard before...", $COLOR_BLUE)
				CleanYard()
				SetLog("Cleaning Yard Finished !", $COLOR_BLUE)
				randomSleep(5000)
				clickUpgrade()
				updateStats()
				SetLog("Auto Upgrade Finished !", $COLOR_BLUE)
				randomSleep(800)
				ClickP($aAway, 1, 0, "#0167") ;Click Away
			Else
				SetLog("Only 1 builder available and he works on walls... Good Luck haha !!!", $COLOR_WARNING)
			EndIf
		Else
			SetLog("No builder available, skipping Auto Upgrade...", $COLOR_WARNING)
		EndIf
	Else
		Return
	EndIf

EndFunc   ;==>AutoUpgrade

Func clickUpgrade()

	Local $canContinueLoop = True, $i = 0

	While $canContinueLoop

		If $g_iTotalBuilderCount >= 1 Then
			getBuilderCount()
			If $g_iFreeBuilderCount <> 0 Then ; check free builders
				If ($g_bUpgradeWallSaveBuilder = True And $g_iFreeBuilderCount > 1) Or $g_bUpgradeWallSaveBuilder = False Then
					If openUpgradeTab() Then
						randomSleep(1500)
						If searchZeros() Then
							Click($g_iQuickMISX + 150, $g_iQuickMISY + 70)
							randomSleep(1500)
							launchUpgradeProcess()
							; Just in case ;)
							$i += 1
							If $i > 6 then
								PureClickP($aAway, 1, 0, "#0133") ;Click away
								ExitLoop
							EndIf
						Else
							$canContinueLoop = False
						EndIf
					EndIf
				Else
					SetLog("Only 1 builder available and he works on walls... Good Luck !!!", $COLOR_WARNING)
					Return
				EndIf
			Else
				SetLog("No builder available, skipping Auto Upgrade...", $COLOR_WARNING)
				Return
			EndIf
			PureClickP($aAway, 1, 0, "#0133") ;Click away
			randomSleep(1500)
		EndIf

	WEnd

	$canContinueLoop = True

EndFunc   ;==>clickUpgrade

Func openUpgradeTab()

	If _ColorCheck(_GetPixelColor(275, 15, True), "E8E8E0", 20) = True Then
		Click(275, 15)
		randomSleep(1500)
		Return True
	Else
		Setlog("Error when trying to open Builders menu...", $COLOR_RED)
		Return False
	EndIf

EndFunc   ;==>openUpgradeTab

Func searchZeros() ; check for zeros on the builers menu - translate upgrade available

	If QuickMIS("BC1", @ScriptDir & "\imgxml\Resources\Auto Upgrade\Price", 150, 70, 500, 300) Then
		SetLog("Upgrade found !", $COLOR_GREEN)
		Return True
	Else
		SetLog("No upgrade available !", $COLOR_WARNING)
		Return False
	EndIf

EndFunc   ;==>searchZeros

Func launchUpgradeProcess()

	If locateUpgrade() Then
		upgradeInfo(242, 520 + $g_iBottomOffsetY)
		If checkCanUpgrade() Then
			Click($g_iQuickMISX + 200, $g_iQuickMISY + 600)
			randomSleep(1500)
			getUpgradeInfo()
			updateAutoUpgradeLog()
			launchUpgrade()
		EndIf
	EndIf

EndFunc   ;==>launchUpgradeProcess

Func locateUpgrade() ; search for the upgrade building button

	If QuickMIS("BC1", @ScriptDir & "\imgxml\Resources\Auto Upgrade\Upgrade", 200, 600, 700, 700) Then
		Return True
	Else
		SetLog("No upgrade here !", $COLOR_RED)
		Return False
	EndIf

EndFunc   ;==>locateUpgrade

Func upgradeInfo($iXstart, $iYstart) ; note the upgrade name and level into the log

	$g_sBldgText = getNameBuilding($iXstart, $iYstart) ; Get Unit name and level with OCR
	If $g_sBldgText = "" Then ; try a 2nd time after a short delay if slow PC
		If _Sleep(1500) Then Return
		$g_sBldgText = getNameBuilding($iXstart, $iYstart) ; Get Unit name and level with OCR
	EndIf
	Local $aString = StringSplit($g_sBldgText, "(") ; Spilt the name and building level
	If $aString[0] = 2 Then ; If we have name and level then use it
		If $aString[1] <> "" Then $g_aUpgradeName[1] = $aString[1] ; check for bad read and store name in result[]
		If $aString[2] <> "" Then ; check for bad read of level
			$g_sBldgLevel = $aString[2] ; store level text
			$aString = StringSplit($g_sBldgLevel, ")") ;split off the closing parenthesis
			If $aString[0] = 2 Then ; Check If we have "level XX" cleaned up
				If $aString[1] <> "" Then $g_sBldgLevel = $aString[1] ; store "level XX"
			EndIf
			$aString = StringSplit($g_sBldgLevel, " ") ;split off the level number
			If $aString[0] = 2 Then ; If we have level number then use it
				If $aString[2] <> "" Then $g_aUpgradeName[2] = Number($aString[2]) ; store bldg level
			EndIf
		EndIf
	EndIf
	If $g_aUpgradeName[1] <> "" Then $g_aUpgradeName[0] = 1
	If $g_aUpgradeName[2] <> "" Then $g_aUpgradeName[0] += 1

EndFunc   ;==>upgradeInfo

Func checkCanUpgrade()

	If StringInStr($g_sBldgText, "Town") And $g_ichkIgnoreTH = 1 Then
		SetLog("We must ignore Town Hall...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Barbar") And $g_ichkIgnoreKing = 1 Then
		SetLog("We must ignore Barbarian King...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Queen") And $g_ichkIgnoreQueen = 1 Then
		SetLog("We must ignore Archer Queen...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Warden") And $g_ichkIgnoreWarden = 1 Then
		SetLog("We must ignore Grand Warden...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Castle") And $g_ichkIgnoreCC = 1 Then
		SetLog("We must ignore Clan Castle...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Laboratory") And $g_ichkIgnoreLab = 1 Then
		SetLog("We must ignore Laboratory...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Barracks") And Not StringInStr($g_sBldgText, "Dark") And $g_ichkIgnoreBarrack = 1 Then
		SetLog("We must ignore Barracks...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Dark Barracks") And $g_ichkIgnoreDBarrack = 1 Then
		SetLog("We must ignore Drak Barracks...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Factory") And Not StringInStr($g_sBldgText, "Dark") And $g_ichkIgnoreFactory = 1 Then
		SetLog("We must ignore Spell Factory...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Dark Spell Factory") And $g_ichkIgnoreDFactory = 1 Then
		SetLog("We must ignore Dark Spell Factory...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Mine") And $g_ichkIgnoreGColl = 1 Then
		SetLog("We must ignore Gold Mines...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Collector") And $g_ichkIgnoreEColl = 1 Then
		SetLog("We must ignore Elixir Collectors...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Drill") And $g_ichkIgnoreDColl = 1 Then
		SetLog("We must ignore Dark Elixir Drills...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Laboratory") And $g_bAutoLabUpgradeEnable = True Then
		SetLog("Auto Laboratory upgrade mode is active, Lab upgrade must be ignored...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Barbar") And $g_bUpgradeKingEnable = True Then
		SetLog("Barabarian King upgrade selected, skipping upgrade...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Queen") And $g_bUpgradeQueenEnable = True Then
		SetLog("Archer Queen upgrade selected, skipping upgrade...", $COLOR_WARNING)
		Return False
	ElseIf StringInStr($g_sBldgText, "Warden") And $g_bUpgradeWardenEnable = True Then
		SetLog("Grand Warden upgrade selected, skipping upgrade...", $COLOR_WARNING)
		Return False
	Else
		SetLog("This upgrade no need to be ignored !", $COLOR_WARNING)
		Return True
	EndIf

EndFunc   ;==>checkCanUpgrade

Func getUpgradeInfo()

	Local $Result = QuickMIS("N1", @ScriptDir & "\imgxml\Resources\Auto Upgrade\Type", 350, 500, 740, 600)

	Switch $Result
		Case "Gold"
			$g_sUpgradeResource = 1
		Case "Elixir"
			$g_sUpgradeResource = 2
		Case "Dark"
			$g_sUpgradeResource = 3
	EndSwitch

	If StringInStr($g_sBldgText, "Barbar") Or StringInStr($g_sBldgText, "Queen") Or StringInStr($g_sBldgText, "Warden") Then ; search for heros, which have a different place for upgrade button
		$g_iUpgradeCost = Number(getResourcesBonus(598, 519 + $g_iMidOffsetY)) ; Try to read white text.
	Else
		$g_iUpgradeCost = Number(getResourcesBonus(366, 487 + $g_iMidOffsetY)) ; Try to read white text.
	EndIf

	If StringInStr($g_sBldgText, "Barbar") Or StringInStr($g_sBldgText, "Queen") Or StringInStr($g_sBldgText, "Warden") Then ; search for heros, which have a different place for upgrade button
		$g_sUpgradeDuration = getHeroUpgradeTime(464, 527 + $g_iMidOffsetY) ; Try to read white text showing time for upgrade
	Else
		$g_sUpgradeDuration = getBldgUpgradeTime(196, 304 + $g_iMidOffsetY)
	EndIf

EndFunc   ;==>getUpgradeInfo

Func launchUpgrade()

	If StringInStr($g_sBldgText, "Barbar") Or StringInStr($g_sBldgText, "Queen") Or StringInStr($g_sBldgText, "Warden") Then ; search for heros, which have a different place for upgrade button
		Click(710, 560)
	Else
		Click(480, 520)
	EndIf

EndFunc   ;==>launchUpgrade

Func updateAutoUpgradeLog()

	SetLog("We will upgrade " & $g_aUpgradeName[1] & "to level " & $g_aUpgradeName[2] + 1, $COLOR_GREEN)
	SetLog("Upgrade duration : " & $g_sUpgradeDuration, $COLOR_GREEN)
	If $g_sUpgradeResource = 1 Then
		SetLog("Upgrade cost : " & _NumberFormat($g_iUpgradeCost) & " Gold", $COLOR_GREEN)
		_GUICtrlEdit_AppendText($g_AutoUpgradeLog, @CRLF & _NowTime(4) & " - " & "Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Gold - Duration : " & $g_sUpgradeDuration)
		_FileWriteLog($g_sProfileLogsPath & "\AutoUpgradeHistory.log", "Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Gold - Duration : " & $g_sUpgradeDuration)
		NotifyPushToBoth("Auto Upgrade : Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Gold - Duration : " & $g_sUpgradeDuration)
	ElseIf $g_sUpgradeResource = 2 Then
		SetLog("Upgrade cost : " & _NumberFormat($g_iUpgradeCost) & " Elixir", $COLOR_GREEN)
		_GUICtrlEdit_AppendText($g_AutoUpgradeLog, @CRLF & _NowTime(4) & " - " & "Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Elixir - Duration : " & $g_sUpgradeDuration)
		_FileWriteLog($g_sProfileLogsPath & "\AutoUpgradeHistory.log", "Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Elixir - Duration : " & $g_sUpgradeDuration)
		NotifyPushToBoth("Auto Upgrade : Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Elixir - Duration : " & $g_sUpgradeDuration)
	ElseIf $g_sUpgradeResource = 3 Then
		SetLog("Upgrade cost : " & _NumberFormat($g_iUpgradeCost) & " Dark Elixir", $COLOR_GREEN)
		_GUICtrlEdit_AppendText($g_AutoUpgradeLog, @CRLF & _NowTime(4) & " - " & "Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Dark Elixir - Duration : " & $g_sUpgradeDuration)
		_FileWriteLog($g_sProfileLogsPath & "\AutoUpgradeHistory.log", "Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Dark Elixir - Duration : " & $g_sUpgradeDuration)
		NotifyPushToBoth("Auto Upgrade : Upgrading " & $g_aUpgradeName[1] & "from level " & $g_aUpgradeName[2] & " to level " & $g_aUpgradeName[2] + 1 & " for " & _NumberFormat($g_iUpgradeCost) & " Dark Elixir - Duration : " & $g_sUpgradeDuration)
	EndIf

EndFunc   ;==>updateAutoUpgradeLog

Func chkAutoUpgrade()
	If GUICtrlRead($g_chkAutoUpgrade) = $GUI_CHECKED Then
		$g_ichkAutoUpgrade = 1
		For $i = $g_chkIgnoreTH To $g_AutoUpgradeLog
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
	Else
		$g_ichkAutoUpgrade = 0
		For $i = $g_chkIgnoreTH To $g_AutoUpgradeLog
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	EndIf
EndFunc   ;==>chkAutoUpgrade

Func chkIgnoreTH()
	If GUICtrlRead($g_chkIgnoreTH) = $GUI_CHECKED Then
		$g_ichkIgnoreTH = 1
	Else
		$g_ichkIgnoreTH = 0
	EndIf
EndFunc   ;==>chkIgnoreTH

Func chkIgnoreKing()
	If GUICtrlRead($g_chkIgnoreKing) = $GUI_CHECKED Then
		$g_ichkIgnoreKing = 1
	Else
		$g_ichkIgnoreKing = 0
	EndIf
EndFunc   ;==>chkIgnoreKing

Func chkIgnoreQueen()
	If GUICtrlRead($g_chkIgnoreQueen) = $GUI_CHECKED Then
		$g_ichkIgnoreQueen = 1
	Else
		$g_ichkIgnoreQueen = 0
	EndIf
EndFunc   ;==>chkIgnoreQueen

Func chkIgnoreWarden()
	If GUICtrlRead($g_chkIgnoreWarden) = $GUI_CHECKED Then
		$g_ichkIgnoreWarden = 1
	Else
		$g_ichkIgnoreWarden = 0
	EndIf
EndFunc   ;==>chkIgnoreWarden

Func chkIgnoreCC()
	If GUICtrlRead($g_chkIgnoreCC) = $GUI_CHECKED Then
		$g_ichkIgnoreCC = 1
	Else
		$g_ichkIgnoreCC = 0
	EndIf
EndFunc   ;==>chkIgnoreCC

Func chkIgnoreLab()
	If GUICtrlRead($g_chkIgnoreLab) = $GUI_CHECKED Then
		$g_ichkIgnoreLab = 1
	Else
		$g_ichkIgnoreLab = 0
	EndIf
EndFunc   ;==>chkIgnoreLab

Func chkIgnoreBarrack()
	If GUICtrlRead($g_chkIgnoreBarrack) = $GUI_CHECKED Then
		$g_ichkIgnoreBarrack = 1
	Else
		$g_ichkIgnoreBarrack = 0
	EndIf
EndFunc   ;==>chkIgnoreBarrack

Func chkIgnoreDBarrack()
	If GUICtrlRead($g_chkIgnoreDBarrack) = $GUI_CHECKED Then
		$g_ichkIgnoreDBarrack = 1
	Else
		$g_ichkIgnoreDBarrack = 0
	EndIf
EndFunc   ;==>chkIgnoreDBarrack

Func chkIgnoreFactory()
	If GUICtrlRead($g_chkIgnoreFactory) = $GUI_CHECKED Then
		$g_ichkIgnoreFactory = 1
	Else
		$g_ichkIgnoreFactory = 0
	EndIf
EndFunc   ;==>chkIgnoreFactory

Func chkIgnoreDFactory()
	If GUICtrlRead($g_chkIgnoreDFactory) = $GUI_CHECKED Then
		$g_ichkIgnoreDFactory = 1
	Else
		$g_ichkIgnoreDFactory = 0
	EndIf
EndFunc   ;==>chkIgnoreDFactory

Func chkIgnoreGColl()
	If GUICtrlRead($g_chkIgnoreGColl) = $GUI_CHECKED Then
		$g_ichkIgnoreGColl = 1
	Else
		$g_ichkIgnoreGColl = 0
	EndIf
EndFunc   ;==>chkIgnoreGColl

Func chkIgnoreEColl()
	If GUICtrlRead($g_chkIgnoreEColl) = $GUI_CHECKED Then
		$g_ichkIgnoreEColl = 1
	Else
		$g_ichkIgnoreEColl = 0
	EndIf
EndFunc   ;==>chkIgnoreEColl

Func chkIgnoreDColl()
	If GUICtrlRead($g_chkIgnoreDColl) = $GUI_CHECKED Then
		$g_ichkIgnoreDColl = 1
	Else
		$g_ichkIgnoreDColl = 0
	EndIf
EndFunc   ;==>chkIgnoreDColl
