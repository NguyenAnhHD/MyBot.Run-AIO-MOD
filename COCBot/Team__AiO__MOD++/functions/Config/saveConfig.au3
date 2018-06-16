; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_MOD()
	; <><><> Team AiO MOD++ (2018) <><><>
	ApplyConfig_MOD(GetApplyConfigSaveAction())
	; CSV Deploy Speed - Team AiO MOD++
	_Ini_Add("CSV Speed", "cmbCSVSpeed[LB]", _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$LB]))
	_Ini_Add("CSV Speed", "cmbCSVSpeed[DB]", _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$DB]))

	; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
	_Ini_Add("general", "EnableAuto", $g_bEnableAuto ? 1 : 0)
	_Ini_Add("general", "AutoDock", $g_iChkAutoDock ? 1 : 0)
	_Ini_Add("general", "AutoHide", $g_iChkAutoHideEmulator ? 1 : 0)
	_Ini_Add("general", "AutoMinimize", $g_iChkAutoMinimizeBot ? 1 : 0)

	; Check Collector Outside - Team AiO MOD++
	_Ini_Add("search", "DBMeetCollOutside", $g_bDBMeetCollOutside)
	_Ini_Add("search", "TxtDBMinCollOutsidePercent", GUICtrlRead($g_hTxtDBMinCollOutsidePercent))
	_Ini_Add("search", "DBCollectorsNearRedline", $g_bDBCollectorsNearRedline ? 1 : 0)
	_Ini_Add("search", "CmbRedlineTiles", _GUICtrlComboBox_GetCurSel($g_hCmbRedlineTiles))
	_Ini_Add("search", "SkipCollectorCheck", $g_bSkipCollectorCheck ? 1 : 0)
	_Ini_Add("search", "TxtSkipCollectorGold", GUICtrlRead($g_hTxtSkipCollectorGold))
	_Ini_Add("search", "TxtSkipCollectorElixir", GUICtrlRead($g_hTxtSkipCollectorElixir))
	_Ini_Add("search", "TxtSkipCollectorDark", GUICtrlRead($g_hTxtSkipCollectorDark))
	_Ini_Add("search", "SkipCollectorCheckTH", $g_bSkipCollectorCheckTH ? 1 : 0)
	_Ini_Add("search", "CmbSkipCollectorCheckTH", _GUICtrlComboBox_GetCurSel($g_hCmbSkipCollectorCheckTH))

	; ClanHop - Team AiO MOD++
	_Ini_Add("donate", "chkClanHop", $g_bChkClanHop)

	; Bot Humanization - Team AiO MOD++
	_Ini_Add("Bot Humanization", "chkUseBotHumanization", $g_ichkUseBotHumanization)
	_Ini_Add("Bot Humanization", "chkUseAltRClick", $g_ichkUseAltRClick)
	_Ini_Add("Bot Humanization", "chkCollectAchievements", $g_ichkCollectAchievements)
	_Ini_Add("Bot Humanization", "chkLookAtRedNotifications", $g_ichkLookAtRedNotifications)
	For $i = 0 To 12
		_Ini_Add("Bot Humanization", "cmbPriority[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "cmbMaxSpeed[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbMaxSpeed[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "cmbPause[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPause[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "humanMessage[" & $i & "]", GUICtrlRead($g_ahumanMessage[$i]))
	Next
	_Ini_Add("Bot Humanization", "cmbMaxActionsNumber", _GUICtrlComboBox_GetCurSel($g_cmbMaxActionsNumber))
	_Ini_Add("Bot Humanization", "challengeMessage", GUICtrlRead($g_challengeMessage))

	; Goblin XP - Team AiO MOD++
	_Ini_Add("GoblinXP", "EnableSuperXP", $ichkEnableSuperXP)
	_Ini_Add("GoblinXP", "SkipZoomOutXP", $ichkSkipZoomOutXP)
	_Ini_Add("GoblinXP", "FastGoblinXP", $ichkFastGoblinXP)
	_Ini_Add("GoblinXP", "SXTraining",  $irbSXTraining)
	_Ini_Add("GoblinXP", "SXBK", $ichkSXBK)
	_Ini_Add("GoblinXP", "SXAQ", $ichkSXAQ)
	_Ini_Add("GoblinXP", "SXGW", $ichkSXGW)
	_Ini_Add("GoblinXP", "MaxXptoGain", GUICtrlRead($txtMaxXPtoGain))

	; GTFO - Team AiO MOD++
	_Ini_Add("GTFO", "chkUseGTFO", $g_bChkUseGTFO)
	_Ini_Add("GTFO", "txtMinSaveGTFO_Elixir",$g_iTxtMinSaveGTFO_Elixir)
	_Ini_Add("GTFO", "txtMinSaveGTFO_DE", $g_iTxtMinSaveGTFO_DE)
	_Ini_Add("GTFO", "chkUseKickOut", $g_bChkUseKickOut)
	_Ini_Add("GTFO", "txtDonatedCap", $g_iTxtDonatedCap)
	_Ini_Add("GTFO", "txtReceivedCap", $g_iTxtReceivedCap)
	_Ini_Add("GTFO", "chkKickOutSpammers", $g_bChkKickOutSpammers)
	_Ini_Add("GTFO", "txtKickLimit", $g_iTxtKickLimit)

	; Max logout time - Team AiO MOD++
	_Ini_Add("TrainLogout", "TrainLogoutMaxTime", $g_bTrainLogoutMaxTime)
	_Ini_Add("TrainLogout", "TrainLogoutMaxTimeTXT", $g_iTrainLogoutMaxTime)

	; Request CC Troops at first - Team AiO MOD++
	_Ini_Add("planned", "ReqCCFirst", $g_bReqCCFirst)

	; CheckCC Troops - Team AiO MOD++
	_Ini_Add("CheckCC", "Enable", $g_bChkCC)
	_Ini_Add("CheckCC", "Troop Capacity", $g_iCmbCastleCapacityT)
	_Ini_Add("CheckCC", "Spell Capacity", $g_iCmbCastleCapacityS)
	For $i = 0 To 4
		_Ini_Add("CheckCC", "ExpectSlot" & $i, $g_aiCmbCCSlot[$i])
		_Ini_Add("CheckCC", "ExpectQty" & $i, $g_aiTxtCCSlot[$i])
	Next

	; Check Grand Warden Mode - Team AiO MOD++
	_Ini_Add("other", "chkCheckWardenMode", $g_bCheckWardenMode ? 1 : 0)
	_Ini_Add("other", "cmbCheckWardenMode", $g_iCheckWardenMode)

	; Unit/Wave Factor - Team AiO MOD++
	_Ini_Add("SetSleep", "EnableGiantSlot", $g_iChkGiantSlot)
	_Ini_Add("SetSleep", "CmbGiantSlot", _GUICtrlComboBox_GetCurSel($g_hCmbGiantSlot))
	_Ini_Add("SetSleep", "EnableUnitFactor", $g_iChkUnitFactor)
	_Ini_Add("SetSleep", "UnitFactor", GUICtrlRead($g_hTxtUnitFactor))
	_Ini_Add("SetSleep", "EnableWaveFactor", $g_iChkWaveFactor)
	_Ini_Add("SetSleep", "WaveFactor", GUICtrlRead($g_hTxtWaveFactor))

	; Restart Search Legend league - Team AiO MOD++
	_Ini_Add("other", "ChkSearchTimeout", $g_bIsSearchTimeout)
	_Ini_Add("other", "SearchTimeout", $g_iSearchTimeout)

	; Stop on Low battery - Team AiO MOD++
	_Ini_Add("other", "ChkStopOnBatt", $g_bStopOnBatt)
	_Ini_Add("other", "StopOnBatt", $g_iStopOnBatt)

	; Attack Log - Team AiO MOD++
	_Ini_Add("attack", "ColorfulAttackLog", $g_bColorfulAttackLog ? 1 : 0)

	; Stop For War - Team AiO MOD++
	_Ini_Add("war preparation", "Enable", $g_bStopForWar ? 1 : 0)
	_Ini_Add("war preparation", "Stop Time", $g_iStopTime)
	_Ini_Add("war preparation", "Stop Before", $g_bStopBeforeBattle ? 1 : 0)
	_Ini_Add("war preparation", "Return Time", $g_iReturnTime)
	_Ini_Add("war preparation", "Train War Troop", $g_bTrainWarTroop ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Troop", $g_bUseQuickTrainWar ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army1", $g_aChkArmyWar[0] ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army2", $g_aChkArmyWar[1] ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army3", $g_aChkArmyWar[2] ? 1 : 0)

	For $i = 0 To $eTroopCount - 1
		_Ini_Add("war preparation", $g_asTroopShortNames[$i], $g_aiWarCompTroops[$i])
	Next
	For $j = 0 To $eSpellCount - 1
		_Ini_Add("war preparation", $g_asSpellShortNames[$j], $g_aiWarCompSpells[$j])
	Next

	_Ini_Add("war preparation", "RequestCC War", $g_bRequestCCForWar ? 1 : 0)
	_Ini_Add("war preparation", "RequestCC War Text", $g_sTxtRequestCCForWar)

	; Request troops for defense - Team AiO MOD++
	_Ini_Add("RequestDefense", "RequestDefenseEnable", $g_bRequestTroopsEnableDefense ? 1 : 0)
	_Ini_Add("RequestDefense", "txtRequestDefense", $g_sRequestTroopsTextDefense)
	_Ini_Add("RequestDefense", "RequestDefenseEarly", $g_iRequestDefenseEarly)

EndFunc   ;==>SaveConfig_MOD
