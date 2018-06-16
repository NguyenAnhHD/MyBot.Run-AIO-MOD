; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True, redraws bot window after config was applied
; Return values .: NA
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ApplyConfig_MOD($TypeReadSave)
	; <><><> Team AiO MOD++ (2018) <><><>
	Switch $TypeReadSave
		Case "Read"
			; CSV Deploy Speed - Team AiO MOD++
			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$LB], $icmbCSVSpeed[$LB])
			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$DB], $icmbCSVSpeed[$DB])

			; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
			GUICtrlSetState($g_hChkEnableAuto, $g_bEnableAuto = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableAuto()
			If $g_iChkAutoDock Then
				GUICtrlSetState($g_hChkAutoDock, $GUI_CHECKED)
				GUICtrlSetState($g_hChkAutoHideEmulator, $GUI_UNCHECKED)
			ElseIf $g_iChkAutoHideEmulator Then
				GUICtrlSetState($g_hChkAutoHideEmulator, $GUI_CHECKED)
				GUICtrlSetState($g_hChkAutoDock, $GUI_UNCHECKED)
			EndIf
			btnEnableAuto()
			GUICtrlSetState($g_hChkAutoMinimizeBot, $g_iChkAutoMinimizeBot = True ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Check Collector Outside - Team AiO MOD++
			GUICtrlSetState($g_hChkDBMeetCollOutside, $g_bDBMeetCollOutside = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDBMinCollOutsidePercent, $g_iTxtDBMinCollOutsidePercent)
			GUICtrlSetState($g_hChkDBCollectorsNearRedline, $g_bDBCollectorsNearRedline = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbRedlineTiles, $g_iCmbRedlineTiles)
			GUICtrlSetState($g_hChkSkipCollectorCheck, $g_bSkipCollectorCheck = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSkipCollectorGold, $g_iTxtSkipCollectorGold)
			GUICtrlSetData($g_hTxtSkipCollectorElixir, $g_iTxtSkipCollectorElixir)
			GUICtrlSetData($g_hTxtSkipCollectorDark, $g_iTxtSkipCollectorDark)
			GUICtrlSetState($g_hChkSkipCollectorCheckTH, $g_bSkipCollectorCheckTH = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbSkipCollectorCheckTH, $g_iCmbSkipCollectorCheckTH)
			chkDBMeetCollOutside()

			; ClanHop - Team AiO MOD++
			GUICtrlSetState($g_hChkClanHop, $g_bChkClanHop = True ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Bot Humanization - Team AiO MOD++
			GUICtrlSetState($g_chkUseBotHumanization, $g_ichkUseBotHumanization = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkUseAltRClick, $g_ichkUseAltRClick = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkCollectAchievements, $g_ichkCollectAchievements = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_chkLookAtRedNotifications, $g_ichkLookAtRedNotifications = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUseBotHumanization()
			For $i = 0 To 12
				_GUICtrlComboBox_SetCurSel($g_acmbPriority[$i], $g_iacmbPriority[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbMaxSpeed[$i], $g_iacmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbPause[$i], $g_iacmbPause[$i])
			Next
			For $i = 0 To 1
				GUICtrlSetData($g_ahumanMessage[$i], $g_iahumanMessage[$i])
			Next
			_GUICtrlComboBox_SetCurSel($g_cmbMaxActionsNumber, $g_icmbMaxActionsNumber)
			GUICtrlSetData($g_challengeMessage, $g_ichallengeMessage)
			cmbStandardReplay()
			cmbWarReplay()

			; Goblin XP - Team AiO MOD++
			GUICtrlSetState($chkEnableSuperXP, $ichkEnableSuperXP = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableSuperXP()
			GUICtrlSetState($chkSkipZoomOutXP, $ichkSkipZoomOutXP = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkFastGoblinXP, $ichkFastGoblinXP = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($rbSXTraining, ($irbSXTraining = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($rbSXIAttacking, ($irbSXTraining = 2) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($txtMaxXPtoGain, $itxtMaxXPtoGain)
			GUICtrlSetState($chkSXBK, $ichkSXBK = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkSXAQ, $ichkSXAQ = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($chkSXGW, $ichkSXGW = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)

			; GTFO - Team AiO MOD++
			GUICtrlSetState($g_hChkUseGTFO, $g_bChkUseGTFO = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtMinSaveGTFO_Elixir, $g_iTxtMinSaveGTFO_Elixir)
			GUICtrlSetData($g_hTxtMinSaveGTFO_DE, $g_iTxtMinSaveGTFO_DE)
			ApplyGTFO()

			GUICtrlSetState($g_hChkUseKickOut, $g_bChkUseKickOut = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDonatedCap, $g_iTxtDonatedCap)
			GUICtrlSetData($g_hTxtReceivedCap, $g_iTxtReceivedCap)
			GUICtrlSetState($g_hChkKickOutSpammers, $g_bChkKickOutSpammers = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtKickLimit, $g_iTxtKickLimit)
			ApplyKickOut()

			; Max logout time - Team AiO MOD++
			GUICtrlSetState($g_hChkTrainLogoutMaxTime, $g_bTrainLogoutMaxTime = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTrainLogoutMaxTime()
			GUICtrlSetData($g_hTxtTrainLogoutMaxTime, $g_iTrainLogoutMaxTime)

			; Request CC Troops at first - Team AiO MOD++
			GUICtrlSetState($g_hChkReqCCFirst, $g_bReqCCFirst = True ? $GUI_CHECKED : $GUI_UNCHECKED)

			; CheckCC Troops - Team AiO MOD++
			GUICtrlSetState($g_hChkTroopsCC, $g_bChkCC = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbCastleCapacityT, $g_iCmbCastleCapacityT)
			_GUICtrlComboBox_SetCurSel($g_hCmbCastleCapacityS, $g_iCmbCastleCapacityS)
			For $i = 0 To 4
				_GUICtrlComboBox_SetCurSel($g_ahCmbCCSlot[$i], $g_aiCmbCCSlot[$i])
				GUICtrlSetData($g_ahTxtCCSlot[$i], $g_aiTxtCCSlot[$i])
			Next
			GUIControlCheckCC()

			; Check Grand Warden Mode - Team AiO MOD++
			GUICtrlSetState($g_hChkCheckWardenMode, $g_bCheckWardenMode ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkCheckWardenMode()
			_GUICtrlComboBox_SetCurSel($g_hCmbCheckWardenMode, $g_iCheckWardenMode)

			; Classic Four Finger - Team AiO MOD++
			cmbStandardDropSidesAB()
			Bridge()

			; Unit/Wave Factor - Team AiO MOD++
			GUICtrlSetState($g_hChkGiantSlot, $g_iChkGiantSlot = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGiantSlot, $g_iCmbGiantSlot)
			chkGiantSlot()
			GUICtrlSetState($g_hChkUnitFactor, $g_iChkUnitFactor = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtUnitFactor, $g_iTxtUnitFactor)
			chkUnitFactor()
			GUICtrlSetState($g_hChkWaveFactor, $g_iChkWaveFactor = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtWaveFactor, $g_iTxtWaveFactor)
			chkWaveFactor()

			; Restart Search Legend league - Team AiO MOD++
			GUICtrlSetState($g_hChkSearchTimeout, $g_bIsSearchTimeout = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSearchTimeout, $g_iSearchTimeout)
			chkSearchTimeout()

			; Stop on Low battery - Team AiO MOD++
			GUICtrlSetState($g_hChkStopOnBatt, $g_bStopOnBatt = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtStopOnBatt, $g_iStopOnBatt)
			chkStopOnBatt()

			; Attack Log - Team AiO MOD++
			GUICtrlSetState($g_hChkColorfulAttackLog, $g_bColorfulAttackLog ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Stop For War - Team AiO MOD++
			GUICtrlSetState($g_hChkStopForWar, $g_bStopForWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbStopTime, $g_iStopTime)
			_GUICtrlComboBox_SetCurSel($g_CmbStopBeforeBattle, $g_bStopBeforeBattle ? 0 : 1)
			_GUICtrlComboBox_SetCurSel($g_hCmbReturnTime, $g_iReturnTime)

			GUICtrlSetState($g_hChkTrainWarTroop, $g_bTrainWarTroop ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseQuickTrainWar, $g_bUseQuickTrainWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[0], $g_aChkArmyWar[0] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[1], $g_aChkArmyWar[1] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[2], $g_aChkArmyWar[2] ? $GUI_CHECKED : $GUI_UNCHECKED)

			For $i = 0 To $eTroopCount - 1
				GUICtrlSetData($g_ahTxtTrainWarTroopCount[$i], $g_aiWarCompTroops[$i])
			Next
			For $j = 0 To $eSpellCount - 1
				GUICtrlSetData($g_ahTxtTrainWarSpellCount[$j], $g_aiWarCompSpells[$j])
			Next
			GUICtrlSetState($g_hChkRequestCCForWar, $g_bRequestCCForWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtRequestCCForWar, $g_sTxtRequestCCForWar)
			ReadConfig_600_52_2()
			ChkStopForWar()

			; Request troops for defense - Team AiO MOD++
			GUICtrlSetState($g_hChkRequestTroopsEnableDefense, $g_bRequestTroopsEnableDefense ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkRequestDefense()
			GUICtrlSetData($g_hTxtRequestCCDefense, $g_sRequestTroopsTextDefense)
			GUICtrlSetData($g_hTxtRequestDefenseEarly, $g_iRequestDefenseEarly)

		Case "Save"
			; CSV Deploy Speed - Team AiO MOD++
			$icmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$LB])
			$icmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$DB])

			; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
			$g_bEnableAuto = (GUICtrlRead($g_hChkEnableAuto) = $GUI_CHECKED)
			$g_iChkAutoDock = (GUICtrlRead($g_hChkAutoDock) = $GUI_CHECKED)
			$g_iChkAutoHideEmulator = (GUICtrlRead($g_hChkAutoHideEmulator) = $GUI_CHECKED)
			$g_iChkAutoMinimizeBot = (GUICtrlRead($g_hChkAutoMinimizeBot) = $GUI_CHECKED)

			; Check Collector Outside - Team AiO MOD++
			$g_bDBMeetCollOutside = (GUICtrlRead($g_hChkDBMeetCollOutside) = $GUI_CHECKED)
			$g_iTxtDBMinCollOutsidePercent = GUICtrlRead($g_hTxtDBMinCollOutsidePercent)
			$g_bDBCollectorsNearRedline = GUICtrlRead($g_hChkDBCollectorsNearRedline) = $GUI_CHECKED ? 1 : 0
			$g_iCmbRedlineTiles = _GUICtrlComboBox_GetCurSel($g_hCmbRedlineTiles)
			$g_bSkipCollectorCheck = GUICtrlRead($g_hChkSkipCollectorCheck) = $GUI_CHECKED ? 1 : 0
			$g_iTxtSkipCollectorGold = GUICtrlRead($g_hTxtSkipCollectorGold)
			$g_iTxtSkipCollectorElixir = GUICtrlRead($g_hTxtSkipCollectorElixir)
			$g_iTxtSkipCollectorDark = GUICtrlRead($g_hTxtSkipCollectorDark)
			$g_bSkipCollectorCheckTH = GUICtrlRead($g_hChkSkipCollectorCheckTH) = $GUI_CHECKED ? 1 : 0
			$g_iCmbSkipCollectorCheckTH = _GUICtrlComboBox_GetCurSel($g_hCmbSkipCollectorCheckTH)

			; ClanHop - Team AiO MOD++
			$g_bChkClanHop = (GUICtrlRead($g_hChkClanHop) = $GUI_CHECKED)

			; Bot Humanization - Team AiO MOD++
			$g_ichkUseBotHumanization = GUICtrlRead($g_chkUseBotHumanization) = $GUI_CHECKED ? 1 : 0
			$g_ichkUseAltRClick = GUICtrlRead($g_chkUseAltRClick) = $GUI_CHECKED ? 1 : 0
			$g_ichkCollectAchievements = GUICtrlRead($g_chkCollectAchievements) = $GUI_CHECKED ? 1 : 0
			$g_ichkLookAtRedNotifications = GUICtrlRead($g_chkLookAtRedNotifications) = $GUI_CHECKED ? 1 : 0
			For $i = 0 To 12
				$g_iacmbPriority[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i])
			Next
			For $i = 0 To 1
				$g_iacmbMaxSpeed[$i] = _GUICtrlComboBox_GetCurSel($g_acmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				$g_iacmbPause[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPause[$i])
			Next
			For $i = 0 To 1
				$g_iahumanMessage[$i] = GUICtrlRead($g_ahumanMessage[$i])
			Next
			$g_icmbMaxActionsNumber = _GUICtrlComboBox_GetCurSel($g_icmbMaxActionsNumber)
			$g_ichallengeMessage = GUICtrlRead($g_challengeMessage)

			; Goblin XP - Team AiO MOD++
			$ichkEnableSuperXP = GUICtrlRead($chkEnableSuperXP) = $GUI_CHECKED ? 1 : 0
			$ichkSkipZoomOutXP = GUICtrlRead($chkSkipZoomOutXP) = $GUI_CHECKED ? 1 : 0
			$ichkFastGoblinXP = GUICtrlRead($chkFastGoblinXP) = $GUI_CHECKED ? 1 : 0
			$irbSXTraining = GUICtrlRead($rbSXTraining) = $GUI_CHECKED ? 1 : 2
			$ichkSXBK = (GUICtrlRead($chkSXBK) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
			$ichkSXAQ = (GUICtrlRead($chkSXAQ) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
			$ichkSXGW = (GUICtrlRead($chkSXGW) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
			$itxtMaxXPtoGain = Int(GUICtrlRead($txtMaxXPtoGain))

			; GTFO - Team AiO MOD++
			$g_bChkUseGTFO = (GUICtrlRead($g_hChkUseGTFO) = $GUI_CHECKED)
			$g_iTxtMinSaveGTFO_Elixir = Number(GUICtrlRead($g_hTxtMinSaveGTFO_Elixir))
			$g_iTxtMinSaveGTFO_DE = Number( GUICtrlRead($g_hTxtMinSaveGTFO_DE))

			$g_bChkUseKickOut = (GUICtrlRead($g_hChkUseKickOut) = $GUI_CHECKED)
			$g_iTxtDonatedCap = Number(GUICtrlRead($g_hTxtDonatedCap))
			$g_iTxtReceivedCap = Number(GUICtrlRead($g_hTxtReceivedCap))
			$g_bChkKickOutSpammers = (GUICtrlRead($g_hChkKickOutSpammers) = $GUI_CHECKED)
			$g_iTxtKickLimit = Number(GUICtrlRead($g_hTxtKickLimit))

			; Max logout time - Team AiO MOD++
			$g_bTrainLogoutMaxTime = (GUICtrlRead($g_hChkTrainLogoutMaxTime) = $GUI_CHECKED)
			$g_iTrainLogoutMaxTime = GUICtrlRead($g_hTxtTrainLogoutMaxTime)

			; Request CC Troops at first - Team AiO MOD++
			$g_bReqCCFirst = (GUICtrlRead($g_hChkReqCCFirst) = $GUI_CHECKED)

			; CheckCC Troops - Team AiO MOD++
			$g_bChkCC = (GUICtrlRead($g_hChkTroopsCC) = $GUI_CHECKED)
			$g_iCmbCastleCapacityT = _GUICtrlComboBox_GetCurSel($g_hCmbCastleCapacityT)
			$g_iCmbCastleCapacityS = _GUICtrlComboBox_GetCurSel($g_hCmbCastleCapacityS)
			For $i = 0 To 4
				$g_aiCmbCCSlot[$i] = _GUICtrlComboBox_GetCurSel($g_ahCmbCCSlot[$i])
				$g_aiTxtCCSlot[$i] = GUICtrlRead($g_ahTxtCCSlot[$i])
			Next

			; Check Grand Warden Mode - Team AiO MOD++
			$g_bCheckWardenMode = (GUICtrlRead($g_hChkCheckWardenMode) = $GUI_CHECKED)
			$g_iCheckWardenMode = _GUICtrlComboBox_GetCurSel($g_hCmbCheckWardenMode)

			; Unit/Wave Factor - Team AiO MOD++
			$g_iChkGiantSlot = GUICtrlRead($g_hChkGiantSlot) = $GUI_CHECKED ? 1 : 0
			$g_iCmbGiantSlot = _GUICtrlComboBox_GetCurSel($g_hCmbGiantSlot)
			$g_iChkUnitFactor = GUICtrlRead($g_hChkUnitFactor) = $GUI_CHECKED ? 1 : 0
			$g_iTxtUnitFactor = GUICtrlRead($g_hTxtUnitFactor)
			$g_iChkWaveFactor = GUICtrlRead($g_hChkWaveFactor) = $GUI_CHECKED ? 1 : 0
			$g_iTxtWaveFactor = GUICtrlRead($g_hTxtWaveFactor)

			; Restart Search Legend league - Team AiO MOD++
			$g_bIsSearchTimeout = (GUICtrlRead($g_hChkSearchTimeout) = $GUI_CHECKED)
			$g_iSearchTimeout = GUICtrlRead($g_hTxtSearchTimeout)

			; Stop on Low battery - Team AiO MOD++
			$g_bStopOnBatt = (GUICtrlRead($g_hChkStopOnBatt) = $GUI_CHECKED)
			$g_iStopOnBatt = GUICtrlRead($g_hTxtStopOnBatt)

			; Attack Log - Team AiO MOD++
			$g_bColorfulAttackLog = (GUICtrlRead($g_hChkColorfulAttackLog) = $GUI_CHECKED)

			; Stop For War - Team AiO MOD++
			$g_bStopForWar = GUICtrlRead($g_hChkStopForWar)  = $GUI_CHECKED

			$g_iStopTime = _GUICtrlComboBox_GetCurSel($g_hCmbStopTime)
			$g_bStopBeforeBattle = _GUICtrlComboBox_GetCurSel($g_CmbStopBeforeBattle) = 0
			$g_iReturnTime = _GUICtrlComboBox_GetCurSel($g_hCmbReturnTime)

			$g_bTrainWarTroop = GUICtrlRead($g_hChkTrainWarTroop) = $GUI_CHECKED
			$g_bUseQuickTrainWar = GUICtrlRead($g_hChkUseQuickTrainWar) = $GUI_CHECKED
			$g_aChkArmyWar[0] = GUICtrlRead($g_ahChkArmyWar[0]) = $GUI_CHECKED
			$g_aChkArmyWar[1] = GUICtrlRead($g_ahChkArmyWar[1]) = $GUI_CHECKED
			$g_aChkArmyWar[2] = GUICtrlRead($g_ahChkArmyWar[2]) = $GUI_CHECKED
			For $i = 0 To $eTroopCount - 1
				$g_aiWarCompTroops[$i] = GUICtrlRead($g_ahTxtTrainWarTroopCount[$i])
			Next
			For $j = 0 To $eSpellCount - 1
				$g_aiWarCompSpells[$j] = GUICtrlRead($g_ahTxtTrainWarSpellCount[$j])
			Next

			$g_bRequestCCForWar = GUICtrlRead($g_hChkRequestCCForWar) = $GUI_CHECKED
			$g_sTxtRequestCCForWar = GUICtrlRead($g_hTxtRequestCCForWar)

			; Request troops for defense - Team AiO MOD++
			$g_bRequestTroopsEnableDefense = (GUICtrlRead($g_hChkRequestTroopsEnableDefense) = $GUI_CHECKED)
			$g_sRequestTroopsTextDefense = GUICtrlRead($g_hTxtRequestCCDefense)
			$g_iRequestDefenseEarly = GUICtrlRead($g_hTxtRequestDefenseEarly)

	EndSwitch
EndFunc   ;==>ApplyConfig_MOD
