; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: Team AiO MOD++ (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_MOD()
	; <><><> Team AiO MOD++ (2017) <><><>
	ApplyConfig_MOD("Save")

	; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
	_Ini_Add("SetSleep", "EnableUnitFactor", $iChkUnitFactor ? 1 : 0)
	_Ini_Add("SetSleep", "EnableWaveFactor", $iChkWaveFactor ? 1 : 0)

	_Ini_Add("SetSleep", "UnitFactor", GUICtrlRead($TxtUnitFactor))
	_Ini_Add("SetSleep", "WaveFactor", GUICtrlRead($TxtWaveFactor))

	_Ini_Add("SetSleep", "EnableGiantSlot", $iChkGiantSlot ? 1 : 0)
	_Ini_Add("SetSleep", "CmbGiantSlot", _GUICtrlComboBox_GetCurSel($CmbGiantSlot))

	; Custom Drop Order
	_Ini_Add("DropOrder", "chkTroopDropOrder", $g_bCustomTrainDropOrderEnable)
	For $p = 0 To UBound($icmbDropTroops) - 1
		_Ini_Add("DropOrder", "cmbDropTroops[" & $p & "]", _GUICtrlComboBox_GetCurSel($cmbDropTroops[$p]))
	Next

	; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
	_Ini_Add("general", "AutoHide", $ichkAutoHide ? 1 : 0)
	_Ini_Add("general", "AutoHideDelay", $ichkAutoHideDelay)

	; Check Collector Outside (McSlither) - Added by NguyenAnhHD
	_Ini_Add("search", "DBMeetCollOutside", $ichkDBMeetCollOutside ? 1 : 0)
	_Ini_Add("search", "DBMinCollOutsidePercent", $iDBMinCollOutsidePercent)

	; CSV Deploy Speed - Added by NguyenAnhHD
	_Ini_Add("CSV Speed", "cmbCSVSpeed[LB]", _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$LB]))
	_Ini_Add("CSV Speed", "cmbCSVSpeed[DB]", _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$DB]))

	; Switch Profile (IceCube) - Added by NguyenAnhHD
	_Ini_Add("profiles", "chkGoldSwitchMax", $ichkGoldSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMaxProfile", $icmbGoldMaxProfile)
	_Ini_Add("profiles", "txtMaxGoldAmount", $itxtMaxGoldAmount)
	_Ini_Add("profiles", "chkGoldSwitchMin", $ichkGoldSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMinProfile", $icmbGoldMinProfile)
	_Ini_Add("profiles", "txtMinGoldAmount", $itxtMinGoldAmount)

	_Ini_Add("profiles", "chkElixirSwitchMax", $ichkElixirSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMaxProfile", $icmbElixirMaxProfile)
	_Ini_Add("profiles", "txtMaxElixirAmount", $itxtMaxElixirAmount)
	_Ini_Add("profiles", "chkElixirSwitchMin", $ichkElixirSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMinProfile", $icmbElixirMinProfile)
	_Ini_Add("profiles", "txtMinElixirAmount", $itxtMinElixirAmount)

	_Ini_Add("profiles", "chkDESwitchMax", $ichkDESwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMaxProfile", $icmbDEMaxProfile)
	_Ini_Add("profiles", "txtMaxDEAmount", $itxtMaxDEAmount)
	_Ini_Add("profiles", "chkDESwitchMin", $ichkDESwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMinProfile", $icmbDEMinProfile)
	_Ini_Add("profiles", "txtMinDEAmount", $itxtMinDEAmount)

	_Ini_Add("profiles", "chkTrophySwitchMax", $ichkTrophySwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMaxProfile", $icmbTrophyMaxProfile)
	_Ini_Add("profiles", "txtMaxTrophyAmount", $itxtMaxTrophyAmount)
	_Ini_Add("profiles", "chkTrophySwitchMin", $ichkTrophySwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMinProfile", $icmbTrophyMinProfile)
	_Ini_Add("profiles", "txtMinTrophyAmount", $itxtMinTrophyAmount)

	; SmartTrain (Demen) - Added By Demen
	_Ini_Add("SmartTrain", "Enable", $ichkSmartTrain)
	_Ini_Add("SmartTrain", "PreciseTroops", $ichkPreciseTroops)
	_Ini_Add("SmartTrain", "ChkFillArcher", $ichkFillArcher)
	_Ini_Add("SmartTrain", "FillArcher", $iFillArcher)
	_Ini_Add("SmartTrain", "FillEQ", $ichkFillEQ)
	_Ini_Add("other", "ChkMultiClick", $g_bChkMultiClick ? 1 : 0)

	; Bot Humanization
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

	; Auto Upgrade
	_Ini_Add("Auto Upgrade", "chkAutoUpgrade", $g_ichkAutoUpgrade)
	For $i = 0 To 12
		_Ini_Add("Auto Upgrade", "chkUpgradesToIgnore[" & $i & "]", $g_ichkUpgradesToIgnore[$i])
	Next
	For $i = 0 To 2
		_Ini_Add("Auto Upgrade", "chkResourcesToIgnore[" & $i & "]", $g_ichkResourcesToIgnore[$i])
	Next
	_Ini_Add("Auto Upgrade", "SmartMinGold", GUICtrlRead($g_SmartMinGold))
	_Ini_Add("Auto Upgrade", "SmartMinElixir", GUICtrlRead($g_SmartMinElixir))
	_Ini_Add("Auto Upgrade", "SmartMinDark", GUICtrlRead($g_SmartMinDark))

	; Request CC Troops at first
	_Ini_Add("planned", "ReqCCFirst", $g_bReqCCFirst ? 1 : 0)

	; Goblin XP
	_Ini_Add("GoblinXP", "EnableSuperXP", $ichkEnableSuperXP)
	_Ini_Add("GoblinXP", "SXTraining",  $irbSXTraining)
	_Ini_Add("GoblinXP", "SXBK", $ichkSXBK)
	_Ini_Add("GoblinXP", "SXAQ", $ichkSXAQ)
	_Ini_Add("GoblinXP", "SXGW", $ichkSXGW)
	_Ini_Add("GoblinXP", "MaxXptoGain", GUICtrlRead($txtMaxXPtoGain))

	; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
	_Ini_Add("donate", "chkClanHop", $g_bChkClanHop ? 1 : 0)

	; Max logout time (mandryd)
	_Ini_Add("TrainLogout", "TrainLogoutMaxTime", $TrainLogoutMaxTime ? 1 : 0)
	_Ini_Add("TrainLogout", "TrainLogoutMaxTimeTXT", $TrainLogoutMaxTimeTXT)

	; ExtendedAttackBar
	_Ini_Add("attack", "ExtendedAttackBarDB", $g_abChkExtendedAttackBar[$DB] ? 1 : 0)
	_Ini_Add("attack", "ExtendedAttackBarLB", $g_abChkExtendedAttackBar[$LB] ? 1 : 0)

EndFunc

; SwitchAcc (Demen) - Added By Demen
Func SaveConfig_SwitchAcc()
	ApplyConfig_SwitchAcc("Save")

	IniWriteS($profile, "SwitchAcc", "Enable", $ichkSwitchAcc ? 1 : 0)
	IniWriteS($profile, "SwitchAcc", "Pre-train", $ichkTrain ? 1 : 0)
	IniWriteS($profile, "SwitchAcc", "Total Coc Account", $icmbTotalCoCAcc) ; 1 = 1 Acc, 2 = 2 Acc, etc.
	IniWriteS($profile, "SwitchAcc", "Train Time To Skip", $g_iTrainTimeToSkip)
	IniWriteS($profile, "SwitchAcc", "Smart Switch", $ichkSmartSwitch ? 1 : 0)
	IniWriteS($profile, "SwitchAcc", "Force Switch", $ichkForceSwitch ? 1 : 0)
	IniWriteS($profile, "SwitchAcc", "Force Switch Search", $iForceSwitch)
	IniWriteS($profile, "SwitchAcc", "Force Stay Donate", $ichkForceStayDonate ? 1 : 0)
	IniWriteS($profile, "SwitchAcc", "Sleep Combo", $ichkCloseTraining) ; 0 = No Sleep, 1 = Close CoC, 2 = Close Android
	For $i = 1 To 8
		IniWriteS($profile, "SwitchAcc", "MatchProfileAcc." & $i, _GUICtrlComboBox_GetCurSel($cmbAccountNo[$i - 1]) + 1) ; 1 = Acc 1, 2 = Acc 2, etc.
		IniWriteS($profile, "SwitchAcc", "ProfileType." & $i, _GUICtrlComboBox_GetCurSel($cmbProfileType[$i - 1]) + 1) ; 1 = Active, 2 = Donate, 3 = Idle
	Next
EndFunc   ;==>SaveConfig_SwitchAcc

; Forecast - Added By Eloy (modification rulesss,kychera)
Func SaveConfig_Forecast()

	_Ini_Add("forecast", "txtForecastBoost", GUICtrlRead($txtForecastBoost))
	_Ini_Add("forecast", "txtForecastPause", GUICtrlRead($txtForecastPause))
	_Ini_Add("profiles", "cmbForecastHopingSwitchMax", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMax))
	_Ini_Add("profiles", "txtForecastHopingSwitchMax", GUICtrlRead($txtForecastHopingSwitchMax))
	_Ini_Add("profiles", "cmbForecastHopingSwitchMin", _GUICtrlComboBox_GetCurSel($cmbForecastHopingSwitchMin))
	_Ini_Add("profiles", "txtForecastHopingSwitchMin", GUICtrlRead($txtForecastHopingSwitchMin))
	_Ini_Add("forecast", "chkForecastBoost", $iChkForecastBoost ? 1 : 0)
	_Ini_Add("forecast", "chkForecastPause", $iChkForecastPause ? 1 : 0)
	_Ini_Add("profiles", "chkForecastHopingSwitchMax", $ichkForecastHopingSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "chkForecastHopingSwitchMin", $ichkForecastHopingSwitchMin ? 1 : 0)
	_Ini_Add("Lang", "cmbSwLang", _GUICtrlComboBox_GetCurSel($cmbSwLang))

EndFunc   ;==>SaveConfig_Forecast
