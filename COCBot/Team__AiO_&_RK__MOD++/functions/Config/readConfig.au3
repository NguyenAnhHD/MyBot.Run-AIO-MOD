; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
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

Func ReadConfig_MOD()
	; <><><> Team AiO & RK MOD++ (2017) <><><>

	; Multi Finger (LunaEclipse) - Added by Eloy
	IniReadS($iMultiFingerStyle, $g_sProfileConfigPath, "MultiFinger", "Select", 2, "int")

	; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
	IniReadS($iChkUnitFactor, $g_sProfileConfigPath, "SetSleep", "EnableUnitFactor", 0, "Int")
	IniReadS($iTxtUnitFactor, $g_sProfileConfigPath, "SetSleep", "UnitFactor", 10 ,"Int")

	IniReadS($iChkWaveFactor, $g_sProfileConfigPath, "SetSleep", "EnableWaveFactor", 0, "Int")
	IniReadS($iTxtWaveFactor, $g_sProfileConfigPath, "SetSleep", "WaveFactor", 100 ,"Int")

	IniReadS($iChkGiantSlot, $g_sProfileConfigPath, "SetSleep", "EnableGiantSlot", 0, "Int")
	IniReadS($iCmbGiantSlot , $g_sProfileConfigPath, "SetSleep", "CmbGiantSlot", 0 ,"Int")

    ; Background by Kychera
    IniReadS($iBackGr, $g_sProfileConfigPath, "background", "BackGr", 0, "Int")
    IniReadS($ichkPic, $g_sProfileConfigPath, "background", "chkPic", 1, "Int")
    ; Transparent Gui by Kychera
    IniReadS($iSldTransLevel, $g_sProfileConfigPath, "TransLevel", "Level", 0, "Int")

	; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
	IniReadS($ichkAutoHide, $g_sProfileConfigPath, "general", "AutoHide", 0, "int")
	IniReadS($ichkAutoHideDelay, $g_sProfileConfigPath, "general", "AutoHideDelay", 10, "int")

	; Check Collector Outside (McSlither) - Added by NguyenAnhHD
	IniReadS($ichkDBMeetCollOutside, $g_sProfileConfigPath, "search", "DBMeetCollOutside", 0, "int")
	IniReadS($iDBMinCollOutsidePercent, $g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", 50, "int")

	; Switch Profile (IceCube) - Added by NguyenAnhHD
	IniReadS($ichkGoldSwitchMax, $g_sProfileConfigPath, "profiles", "chkGoldSwitchMax", 0, "int")
	IniReadS($icmbGoldMaxProfile, $g_sProfileConfigPath, "profiles", "cmbGoldMaxProfile", 0, "int")
	IniReadS($itxtMaxGoldAmount, $g_sProfileConfigPath, "profiles", "txtMaxGoldAmount", 6000000, "int")
	IniReadS($ichkGoldSwitchMin, $g_sProfileConfigPath, "profiles", "chkGoldSwitchMin", 0, "int")
	IniReadS($icmbGoldMinProfile, $g_sProfileConfigPath, "profiles", "cmbGoldMinProfile", 0, "int")
	IniReadS($itxtMinGoldAmount, $g_sProfileConfigPath, "profiles", "txtMinGoldAmount", 500000, "int")

	IniReadS($ichkElixirSwitchMax, $g_sProfileConfigPath, "profiles", "chkElixirSwitchMax", 0, "int")
	IniReadS($icmbElixirMaxProfile, $g_sProfileConfigPath, "profiles", "cmbElixirMaxProfile", 0, "int")
	IniReadS($itxtMaxElixirAmount, $g_sProfileConfigPath, "profiles", "txtMaxElixirAmount", 6000000, "int")
	IniReadS($ichkElixirSwitchMin, $g_sProfileConfigPath, "profiles", "chkElixirSwitchMin", 0, "int")
	IniReadS($icmbElixirMinProfile, $g_sProfileConfigPath, "profiles", "cmbElixirMinProfile", 0, "int")
	IniReadS($itxtMinElixirAmount, $g_sProfileConfigPath, "profiles", "txtMinElixirAmount", 500000, "int")

	IniReadS($ichkDESwitchMax, $g_sProfileConfigPath, "profiles", "chkDESwitchMax", 0, "int")
	IniReadS($icmbDEMaxProfile, $g_sProfileConfigPath, "profiles", "cmbDEMaxProfile", 0, "int")
	IniReadS($itxtMaxDEAmount, $g_sProfileConfigPath, "profiles", "txtMaxDEAmount", 200000, "int")
	IniReadS($ichkDESwitchMin, $g_sProfileConfigPath, "profiles", "chkDESwitchMin", 0, "int")
	IniReadS($icmbDEMinProfile, $g_sProfileConfigPath, "profiles", "cmbDEMinProfile", 0, "int")
	IniReadS($itxtMinDEAmount, $g_sProfileConfigPath, "profiles", "txtMinDEAmount", 10000, "int")

	IniReadS($ichkTrophySwitchMax, $g_sProfileConfigPath, "profiles", "chkTrophySwitchMax", 0, "int")
	IniReadS($icmbTrophyMaxProfile, $g_sProfileConfigPath, "profiles", "cmbTrophyMaxProfile", 0, "int")
	IniReadS($itxtMaxTrophyAmount, $g_sProfileConfigPath, "profiles", "txtMaxTrophyAmount", 3000, "int")
	IniReadS($ichkTrophySwitchMin, $g_sProfileConfigPath, "profiles", "chkTrophySwitchMin", 0, "int")
	IniReadS($icmbTrophyMinProfile, $g_sProfileConfigPath, "profiles", "cmbTrophyMinProfile", 0, "int")
	IniReadS($itxtMinTrophyAmount, $g_sProfileConfigPath, "profiles", "txtMinTrophyAmount", 1000, "int")

	; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
	$g_iCmbCSVSpeed[$DB] = Int(IniRead($g_sProfileConfigPath, "DeploymentSpeed", "DB", 2))
	$g_iCmbCSVSpeed[$LB] = Int(IniRead($g_sProfileConfigPath, "DeploymentSpeed", "LB", 2))

	; Smart Upgrade (Roro-Titi) - Added by NguyenAnhHD
	IniReadS($ichkSmartUpgrade, $g_sProfileConfigPath, "upgrade", "chkSmartUpgrade", 0, "int")
	IniReadS($ichkIgnoreTH, $g_sProfileConfigPath, "upgrade", "chkIgnoreTH", 0, "int")
	IniReadS($ichkIgnoreKing, $g_sProfileConfigPath, "upgrade", "chkIgnoreKing", 0, "int")
	IniReadS($ichkIgnoreQueen, $g_sProfileConfigPath, "upgrade", "chkIgnoreQueen", 0, "int")
	IniReadS($ichkIgnoreWarden, $g_sProfileConfigPath, "upgrade", "chkIgnoreWarden", 0, "int")
	IniReadS($ichkIgnoreCC, $g_sProfileConfigPath, "upgrade", "chkIgnoreCC", 0, "int")
	IniReadS($ichkIgnoreLab, $g_sProfileConfigPath, "upgrade", "chkIgnoreLab", 0, "int")
	IniReadS($ichkIgnoreBarrack, $g_sProfileConfigPath, "upgrade", "chkIgnoreBarrack", 0, "int")
	IniReadS($ichkIgnoreDBarrack, $g_sProfileConfigPath, "upgrade", "chkIgnoreDBarrack", 0, "int")
	IniReadS($ichkIgnoreFactory, $g_sProfileConfigPath, "upgrade", "chkIgnoreFactory", 0, "int")
	IniReadS($ichkIgnoreDFactory, $g_sProfileConfigPath, "upgrade", "chkIgnoreDFactory", 0, "int")
	IniReadS($ichkIgnoreGColl, $g_sProfileConfigPath, "upgrade", "chkIgnoreGColl", 0, "int")
	IniReadS($ichkIgnoreEColl, $g_sProfileConfigPath, "upgrade", "chkIgnoreEColl", 0, "int")
	IniReadS($ichkIgnoreDColl, $g_sProfileConfigPath, "upgrade", "chkIgnoreDColl", 0, "int")
	IniReadS($iSmartMinGold, $g_sProfileConfigPath, "upgrade", "SmartMinGold", 200000, "int")
	IniReadS($iSmartMinElixir, $g_sProfileConfigPath, "upgrade", "SmartMinElixir", 200000, "int")
	IniReadS($iSmartMinDark, $g_sProfileConfigPath, "upgrade", "SmartMinDark", 1500, "int")

	; Upgrade Management (MMHK) - Added by NguyenAnhHD
	$g_ibUpdateNewUpgradesOnly = (IniRead($g_sProfileConfigPath, "upgrade", "UpdateNewUpgradesOnly", 0) = 1)

	; SimpleTrain (Demen) - Added By Demen
	IniReadS($ichkSimpleTrain, $g_sProfileConfigPath, "SimpleTrain", "Enable", 0, "int")
	IniReadS($ichkPreciseTroops, $g_sProfileConfigPath, "SimpleTrain", "PreciseTroops", 0, "int")
	IniReadS($ichkFillArcher, $g_sProfileConfigPath, "SimpleTrain", "ChkFillArcher", 0, "int")
	IniReadS($iFillArcher, $g_sProfileConfigPath, "SimpleTrain", "FillArcher", 5, "int")
	IniReadS($ichkFillEQ, $g_sProfileConfigPath, "SimpleTrain", "FillEQ", 0, "int")

	; CoC Stats - Added by NguyenAnhHD
	IniReadS($ichkCoCStats, $g_sProfileConfigPath, "Stats", "chkCoCStats", 0, "int")
	IniReadS($MyApiKey, $g_sProfileConfigPath, "Stats", "txtAPIKey", "")

	; Bot Humanization (Roro-Titi) - Added by NguyenAnhHD
	IniReadS($g_ichkUseBotHumanization, $g_sProfileConfigPath, "Humanization", "chkUseBotHumanization", 0, "int")
	IniReadS($g_ichkUseAltRClick, $g_sProfileConfigPath, "Humanization", "chkUseAltRClick", 0, "int")
	IniReadS($g_ichkCollectAchievements, $g_sProfileConfigPath, "Humanization", "chkCollectAchievements", 0, "int")
	IniReadS($g_ichkLookAtRedNotifications, $g_sProfileConfigPath, "Humanization", "chkLookAtRedNotifications", 0, "int")
	For $i = 0 To 12
		IniReadS($g_iacmbPriority[$i], $g_sProfileConfigPath, "Humanization", "cmbPriority[" & $i & "]", 0, "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbMaxSpeed[$i], $g_sProfileConfigPath, "Humanization", "cmbMaxSpeed[" & $i & "]", 1, "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbPause[$i], $g_sProfileConfigPath, "Humanization", "cmbPause[" & $i & "]", 0, "int")
	Next
	For $i = 0 To 1
		$g_iahumanMessage[$i] = IniRead($g_sProfileConfigPath, "Humanization", "humanMessage[" & $i & "]", "")
	Next
	IniReadS($g_icmbMaxActionsNumber, "Humanization", "cmbMaxActionsNumber", 1, "int")

	; Goblin XP (Mr.Viper) - Added by NguyenAnhHD
	IniReadS($ichkEnableSuperXP, $g_sProfileConfigPath, "attack", "EnableSuperXP", 0, "int")
	IniReadS($irbSXTraining, $g_sProfileConfigPath, "attack", "SXTraining", 1, "int")
	IniReadS($itxtMaxXPtoGain, $g_sProfileConfigPath, "attack", "MaxXptoGain", 500, "int")
	IniReadS($ichkSXBK, $g_sProfileConfigPath, "attack", "SXBK", $eHeroNone)
	IniReadS($ichkSXAQ, $g_sProfileConfigPath, "attack", "SXAQ", $eHeroNone)
	IniReadS($ichkSXGW, $g_sProfileConfigPath, "attack", "SXGW", $eHeroNone)

	; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
	$g_bChkClanHop = (IniRead($g_sProfileConfigPath, "donate", "chkClanHop", "0") = "1")

	; Move the Request CC Troops - Added By rulesss
	$g_bReqCCFirst = (IniRead($g_sProfileConfigPath, "planned", "ReqCCFirst", 0) = 1)

	; Android Settings (LunaEclipse)- modification (rulesss,kychera)
	 IniReadS($g_iChkAndroid, $g_sProfileConfigPath, "Android", "ChkEmulator", 0, "int")
     $sAndroid = IniRead($g_sProfileConfigPath, "Android", "Emulator", "<No Emulators>")
     $sAndroidInstance = IniRead($g_sProfileConfigPath, "Android", "Instance", "")
	 ;Request russian by kychera
	 IniReadS($ichkRusLang2, $g_sProfileConfigPath, "Lang", "chkRusLang2", 0, "int")

	 ;Notify alert bot sleep by kychera
	 IniReadS($iNotifyAlertConnect, $g_sProfileConfigPath, "notify", "AlertConnect", 0, "int")
	 IniReadS($iNotifyAlertBOTSleep, $g_sProfileConfigPath, "notify", "AlertPBSleep", 0, "int")

	 ; Misc Battle Settings - Added by rulesss
	 IniReadS($g_bAndroidAdbClicksEnabled , $g_sProfileConfigPath, "Fast Clicks", "UseADBFastClicks", 0, "int")

	 ;Enabele\Disabele Watchdog by rulesss,kychera
	 IniReadS($iChkLaunchWatchdog, $g_sProfileConfigPath, "Other", "chkLaunchWatchdog", 1, "Int")
	 
	 ;Custom drop troops by kychera
	 IniReadS($g_bCustomTrainDropOrderEnable, $g_sProfileConfigPath, "troop2", "chkTroopDropOrder", False, "Bool")
	For $p = 0 To UBound($icmbDropTroops) - 1
		IniReadS($icmbDropTroops[$p], $g_sProfileConfigPath, "troop2", $g_asTroopNamesPluralDrop[$p] , -1)
	Next
	
	;Max logout time( mandryd) - Added by rulesss
	IniReadS($TrainLogoutMaxTime, $g_sProfileConfigPath, "TrainLogout", "TrainLogoutMaxTime", 0, "int")
	IniReadS($TrainLogoutMaxTimeTXT, $g_sProfileConfigPath, "TrainLogout", "TrainLogoutMaxTimeTXT", 4, "int")
EndFunc

; SwitchAcc (Demen) - Added By Demen
Func ReadConfig_SwitchAcc()
	IniReadS($ichkSwitchAcc, $profile, "SwitchAcc", "Enable", 0, "int")
	IniReadS($ichkTrain, $profile, "SwitchAcc", "Pre-train", 0, "int")
	IniReadS($icmbTotalCoCAcc, $profile, "SwitchAcc", "Total Coc Account", -1, "int")
	IniReadS($ichkSmartSwitch, $profile, "SwitchAcc", "Smart Switch", 0, "int")
	IniReadS($ichkForceSwitch, $profile, "SwitchAcc", "Force Switch", 0, "int")
	IniReadS($iForceSwitch, $profile, "SwitchAcc", "Force Switch Search", 100, "int")
	IniReadS($ichkForceStayDonate, $profile, "SwitchAcc", "Force Stay Donate", 0, "int")
	IniReads($ichkCloseTraining, $profile, "SwitchAcc", "Sleep Combo", 0, "int") ; Sleep Combo, 1 = Close CoC, 2 = Close Android, 0 = No sleep
	For $i = 0 To 7
		IniReadS($aMatchProfileAcc[$i], $profile, "SwitchAcc", "MatchProfileAcc." & $i + 1, "-1")
		IniReadS($aProfileType[$i], $profile, "SwitchAcc", "ProfileType." & $i + 1, "-1")
		IniReadS($aAccPosY[$i], $profile, "SwitchAcc", "AccLocation." & $i + 1, "-1")
	Next
EndFunc ;==>ReadConfig_SwitchAcc

; Forecast - Added By Eloy (modification rulesss,kychera)
Func ReadConfig_Forecast()

	IniReadS($iChkForecastBoost, $g_sProfileConfigPath, "forecast", "chkForecastBoost", 0, "Int")
	IniReadS($iChkForecastPause, $g_sProfileConfigPath, "forecast", "chkForecastPause", 0, "Int")
	IniReadS($iTxtForecastBoost, $g_sProfileConfigPath, "forecast", "txtForecastBoost", 6, "Int")
	IniReadS($iTxtForecastPause, $g_sProfileConfigPath, "forecast", "txtForecastPause", 2, "Int")
	IniReadS($ichkForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMax", 0, "Int")
	IniReadS($icmbForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMax", 0, "Int")
	IniReadS($itxtForecastHopingSwitchMax, $g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMax", 2, "Int")
	IniReadS($ichkForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "chkForecastHopingSwitchMin", 0, "Int")
	IniReadS($icmbForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "cmbForecastHopingSwitchMin", 0, "Int")
	IniReadS($itxtForecastHopingSwitchMin, $g_sProfileConfigPath, "profiles", "txtForecastHopingSwitchMin", 2, "Int")
	IniReadS($icmbSwLang, $g_sProfileConfigPath, "Lang", "cmbSwLang", 1, "int")

EndFunc ;==>ReadConfig_Forecast