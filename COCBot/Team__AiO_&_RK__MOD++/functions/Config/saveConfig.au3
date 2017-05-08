; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: Team AiO & RK MOD++ (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_MOD()
	; <><><> Team AiO & RK MOD++ (2017) <><><>
	ApplyConfig_MOD("Save")

	; Multi Finger (LunaEclipse) - Added by Eloy
	_Ini_Add("MultiFinger", "Select", $iMultiFingerStyle)

	; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
	_Ini_Add("SetSleep", "EnableUnitFactor", $iChkUnitFactor ? 1 : 0)
	_Ini_Add("SetSleep", "EnableWaveFactor", $iChkWaveFactor ? 1 : 0)

    _Ini_Add("SetSleep", "UnitFactor", GUICtrlRead($TxtUnitFactor))
	_Ini_Add("SetSleep", "WaveFactor", GUICtrlRead($TxtWaveFactor))

	_Ini_Add("SetSleep", "EnableGiantSlot", $iChkGiantSlot ? 1 : 0)
	_Ini_Add("SetSleep", "CmbGiantSlot", _GUICtrlComboBox_GetCurSel($CmbGiantSlot))

     ;Background by Kychera
	_Ini_Add("background", "chkPic", $ichkPic ? 1 : 0)
	_Ini_Add("background", "BackGr", $iBackGr)
    ;Transparent Gui (Modified Kychera)
	_Ini_Add("TransLevel", "Level", $iSldTransLevel)

	; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
	_Ini_Add("general", "AutoHide", $ichkAutoHide ? 1 : 0)
	_Ini_Add("general", "AutoHideDelay", $ichkAutoHideDelay)

	; Check Collector Outside (McSlither) - Added by NguyenAnhHD
	_Ini_Add("search", "DBMeetCollOutside", $ichkDBMeetCollOutside ? 1 : 0)
	_Ini_Add("search", "DBMinCollOutsidePercent", $iDBMinCollOutsidePercent)

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

	; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
	_Ini_Add("DeploymentSpeed", "DB", $g_iCmbCSVSpeed[$DB])
	_Ini_Add("DeploymentSpeed", "LB", $g_iCmbCSVSpeed[$LB])

	; Smart Upgrade (Roro-Titi) - Added by NguyenAnhHD
	_Ini_Add("upgrade", "chkSmartUpgrade", $ichkSmartUpgrade ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreTH", $ichkIgnoreTH ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreKing", $ichkIgnoreKing ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreQueen", $ichkIgnoreQueen ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreWarden", $ichkIgnoreWarden ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreCC", $ichkIgnoreCC ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreLab", $ichkIgnoreLab ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreBarrack", $ichkIgnoreBarrack ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreDBarrack", $ichkIgnoreDBarrack ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreFactory", $ichkIgnoreFactory ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreDFactory", $ichkIgnoreDFactory ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreGColl", $ichkIgnoreGColl ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreEColl", $ichkIgnoreEColl ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreDColl", $ichkIgnoreDColl ? 1 : 0)
	_Ini_Add("upgrade", "SmartMinGold", $iSmartMinGold)
	_Ini_Add("upgrade", "SmartMinElixir", $iSmartMinElixir)
	_Ini_Add("upgrade", "SmartMinDark", $iSmartMinDark)

	; Upgrade Management (MMHK) - Added by NguyenAnhHD
	_Ini_Add("upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly ? 1 : 0)

	; SimpleTrain (Demen) - Added By Demen
	_Ini_Add("SimpleTrain", "Enable", $ichkSimpleTrain)
	_Ini_Add("SimpleTrain", "PreciseTroops", $ichkPreciseTroops)
	_Ini_Add("SimpleTrain", "ChkFillArcher", $ichkFillArcher)
	_Ini_Add("SimpleTrain", "FillArcher", $iFillArcher)
	_Ini_Add("SimpleTrain", "FillEQ", $ichkFillEQ)

	; CoC Stats - Added by NguyenAnhHD
	_Ini_Add("Stats", "chkCoCStats", $ichkCoCStats ? 1 : 0)
	_Ini_Add("Stats", "txtAPIKey", $MyApiKey)

	; Bot Humanization (Roro-Titi) - Added by NguyenAnhHD
	_Ini_Add("Humanization", "chkUseBotHumanization", $g_ichkUseBotHumanization)
	_Ini_Add("Humanization", "chkUseAltRClick", $g_ichkUseAltRClick)
	_Ini_Add("Humanization", "chkCollectAchievements", $g_ichkCollectAchievements)
	_Ini_Add("Humanization", "chkLookAtRedNotifications", $g_ichkLookAtRedNotifications)
	For $i = 0 To 12
		_Ini_Add("Humanization", "cmbPriority[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Humanization", "cmbMaxSpeed[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_iacmbMaxSpeed[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Humanization", "cmbPause[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPause[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Humanization", "humanMessage[" & $i & "]", GUICtrlRead($g_ahumanMessage[$i]))
	Next
	_Ini_Add("Humanization", "cmbMaxActionsNumber", _GUICtrlComboBox_GetCurSel($g_icmbMaxActionsNumber))

	; Goblin XP (Mr.Viper) - Added by NguyenAnhHD
	_Ini_Add("attack", "EnableSuperXP", $ichkEnableSuperXP)
	_Ini_Add("attack", "SXTraining", $irbSXTraining)
	_Ini_Add("attack", "SXBK", $ichkSXBK)
	_Ini_Add("attack", "SXAQ", $ichkSXAQ)
	_Ini_Add("attack", "SXGW", $ichkSXGW)
	_Ini_Add("attack", "MaxXptoGain", GUICtrlRead($txtMaxXPtoGain))

	; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
	_Ini_Add("donate", "chkClanHop", $g_bChkClanHop ? 1 : 0)

	; Move the Request CC Troops - Added by rulesss
	_Ini_Add("planned", "ReqCCFirst", $g_bReqCCFirst ? 1 : 0)

	 ; Android Settings (LunaEclipse)- modification (rulesss,kychera)
	_Ini_Add("Android", "Emulator", GUICtrlRead($CmbAndroid))
    _Ini_Add("Android", "Instance", GUICtrlRead($TxtAndroidInstance))

	;request  cyrillic by kychera
	_Ini_Add("Lang", "chkRusLang2", $ichkRusLang2 ? 1 : 0)

	;Notify alert bot sleep by kychera
	 _Ini_Add("notify", "AlertConnect", $iNotifyAlertConnect ? 1 : 0)
	 _Ini_Add("notify", "AlertPBSleep", $iNotifyAlertBOTSleep ? 1 : 0)

	 ; Misc Battle Settings - Added by rulesss
	_Ini_Add("Fast Clicks", "UseADBFastClicks", $g_bAndroidAdbClicksEnabled ? 1 : 0)

	;Enabele\Disabele Watchdog by rulesss,kychera
	_Ini_Add("Other", "chkLaunchWatchdog", $iChkLaunchWatchdog ? 1 : 0)

	;Custom drop troops
	_Ini_Add("troop2", "chkTroopDropOrder", $g_bCustomTrainDropOrderEnable ? 1 : 0)
    For $p = 0 To UBound($icmbDropTroops) - 1
		_Ini_Add("troop2", $g_asTroopNamesPluralDrop[$p], $icmbDropTroops[$p])
	Next

EndFunc

; SwitchAcc (Demen) - Added By Demen
Func SaveConfig_SwitchAcc()
	ApplyConfig_SwitchAcc("Save")

	IniWriteS($profile, "SwitchAcc", "Enable", $ichkSwitchAcc ? 1 : 0)
	IniWriteS($profile, "SwitchAcc", "Pre-train", $ichkTrain ? 1 : 0)
	IniWriteS($profile, "SwitchAcc", "Total Coc Account", $icmbTotalCoCAcc) ; 1 = 1 Acc, 2 = 2 Acc, etc.
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
