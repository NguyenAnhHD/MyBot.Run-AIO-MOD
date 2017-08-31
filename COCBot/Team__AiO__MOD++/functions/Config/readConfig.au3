; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
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

Func ReadConfig_MOD()
	; <><><> Team AiO MOD++ (2017) <><><>

	; Unit/Wave Factor (rulesss & kychera) - Added by Eloy
	IniReadS($iChkUnitFactor, $g_sProfileConfigPath, "SetSleep", "EnableUnitFactor", 0, "Int")
	IniReadS($iTxtUnitFactor, $g_sProfileConfigPath, "SetSleep", "UnitFactor", 10 ,"Int")

	IniReadS($iChkWaveFactor, $g_sProfileConfigPath, "SetSleep", "EnableWaveFactor", 0, "Int")
	IniReadS($iTxtWaveFactor, $g_sProfileConfigPath, "SetSleep", "WaveFactor", 100 ,"Int")

	IniReadS($iChkGiantSlot, $g_sProfileConfigPath, "SetSleep", "EnableGiantSlot", 0, "Int")
	IniReadS($iCmbGiantSlot , $g_sProfileConfigPath, "SetSleep", "CmbGiantSlot", 0 ,"Int")

	; Custom Drop Order
	IniReadS($g_bCustomTrainDropOrderEnable, $g_sProfileConfigPath, "DropOrder", "chkTroopDropOrder", $g_bCustomTrainDropOrderEnable, "Bool")
	For $p = 0 To UBound($icmbDropTroops) - 1
		IniReadS($icmbDropTroops[$p], $g_sProfileConfigPath, "DropOrder", "cmbDropTroops[" & $p & "]", $icmbDropTroops[$p] , "Int")
	Next

	; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
	IniReadS($ichkAutoHide, $g_sProfileConfigPath, "general", "AutoHide", 0, "int")
	IniReadS($ichkAutoHideDelay, $g_sProfileConfigPath, "general", "AutoHideDelay", 10, "int")

	; Check Collector Outside (McSlither) - Added by NguyenAnhHD
	IniReadS($ichkDBMeetCollOutside, $g_sProfileConfigPath, "search", "DBMeetCollOutside", 0, "int")
	IniReadS($iDBMinCollOutsidePercent, $g_sProfileConfigPath, "search", "DBMinCollOutsidePercent", 50, "int")

	; CSV Deploy Speed - Added by NguyenAnhHD
	IniReadS($icmbCSVSpeed[$LB], $g_sProfileConfigPath, "CSV Speed", "cmbCSVSpeed[LB]", $icmbCSVSpeed[$LB], "Int")
	IniReadS($icmbCSVSpeed[$DB], $g_sProfileConfigPath, "CSV Speed", "cmbCSVSpeed[DB]", $icmbCSVSpeed[$DB], "Int")
	For $i = $DB To $LB
		If $icmbCSVSpeed[$i] < 5 Then
			$g_CSVSpeedDivider[$i] = 0.5 + $icmbCSVSpeed[$i] * 0.25        ; $g_CSVSpeedDivider = 0.5, 0.75, 1, 1.25, 1.5
		Else
			$g_CSVSpeedDivider[$i] = 2 + $icmbCSVSpeed[$i] - 5            ; $g_CSVSpeedDivider = 2, 3, 4, 5
		EndIf
	Next

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

	; SmartTrain
	IniReadS($ichkSmartTrain, $g_sProfileConfigPath, "SmartTrain", "Enable", 0, "int")
	IniReadS($ichkPreciseTroops, $g_sProfileConfigPath, "SmartTrain", "PreciseTroops", 0, "int")
	IniReadS($ichkFillArcher, $g_sProfileConfigPath, "SmartTrain", "ChkFillArcher", 0, "int")
	IniReadS($iFillArcher, $g_sProfileConfigPath, "SmartTrain", "FillArcher", 5, "int")
	IniReadS($ichkFillEQ, $g_sProfileConfigPath, "SmartTrain", "FillEQ", 0, "int")
	$g_bChkMultiClick = (IniRead($g_sProfileConfigPath, "other", "ChkMultiClick", "0") = "1")

	; Bot Humanization
	IniReadS($g_ichkUseBotHumanization, $g_sProfileConfigPath, "Bot Humanization", "chkUseBotHumanization", $g_ichkUseBotHumanization, "Int")
	IniReadS($g_ichkUseAltRClick, $g_sProfileConfigPath, "Bot Humanization", "chkUseAltRClick", $g_ichkUseAltRClick, "Int")
	IniReadS($g_ichkCollectAchievements, $g_sProfileConfigPath, "Bot Humanization", "chkCollectAchievements", $g_ichkCollectAchievements, "Int")
	IniReadS($g_ichkLookAtRedNotifications, $g_sProfileConfigPath, "Bot Humanization", "chkLookAtRedNotifications", $g_ichkLookAtRedNotifications, "Int")
	For $i = 0 To 12
		IniReadS($g_iacmbPriority[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPriority[" & $i & "]", $g_iacmbPriority[$i], "Int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbMaxSpeed[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbMaxSpeed[" & $i & "]", $g_iacmbMaxSpeed[$i], "Int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbPause[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPause[" & $i & "]", $g_iacmbPause[$i], "Int")
	Next
	For $i = 0 To 1
		IniReadS($g_iahumanMessage[$i], $g_sProfileConfigPath, "Bot Humanization", "humanMessage[" & $i & "]", $g_iahumanMessage[$i])
	Next
	IniReadS($g_icmbMaxActionsNumber, $g_sProfileConfigPath, "Bot Humanization", "cmbMaxActionsNumber", $g_icmbMaxActionsNumber, "Int")
	IniReadS($g_ichallengeMessage, $g_sProfileConfigPath, "Bot Humanization", "challengeMessage", $g_ichallengeMessage)

	; Auto Upgrade
	IniReadS($g_ichkAutoUpgrade, $g_sProfileConfigPath, "Auto Upgrade", "chkAutoUpgrade", 0, "Int")
	For $i = 0 To 12
		IniReadS($g_ichkUpgradesToIgnore[$i], $g_sProfileConfigPath, "Auto Upgrade", "chkUpgradesToIgnore[" & $i & "]", $g_ichkUpgradesToIgnore[$i], "Int")
	Next
	For $i = 0 To 2
		IniReadS($g_ichkResourcesToIgnore[$i], $g_sProfileConfigPath, "Auto Upgrade", "chkResourcesToIgnore[" & $i & "]", $g_ichkResourcesToIgnore[$i], "Int")
	Next
	IniReadS($g_iSmartMinGold, $g_sProfileConfigPath, "Auto Upgrade", "SmartMinGold", 150000, "Int")
	IniReadS($g_iSmartMinElixir, $g_sProfileConfigPath, "Auto Upgrade", "SmartMinElixir", 150000, "Int")
	IniReadS($g_iSmartMinDark, $g_sProfileConfigPath, "Auto Upgrade", "SmartMinDark", 1500, "Int")

	; Request CC Troops at first
	$g_bReqCCFirst = (IniRead($g_sProfileConfigPath, "planned", "ReqCCFirst", 0) = 1)

	; Goblin XP
	IniReadS($ichkEnableSuperXP, $g_sProfileConfigPath, "GoblinXP", "EnableSuperXP", 0, "int")
	IniReadS($irbSXTraining, $g_sProfileConfigPath, "GoblinXP", "SXTraining", 1, "int")
	IniReadS($itxtMaxXPtoGain, $g_sProfileConfigPath, "GoblinXP", "MaxXptoGain", 500, "int")
	IniReadS($ichkSXBK, $g_sProfileConfigPath, "GoblinXP", "SXBK", $eHeroNone)
	IniReadS($ichkSXAQ, $g_sProfileConfigPath, "GoblinXP", "SXAQ", $eHeroNone)
	IniReadS($ichkSXGW, $g_sProfileConfigPath, "GoblinXP", "SXGW", $eHeroNone)

	; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
	$g_bChkClanHop = (IniRead($g_sProfileConfigPath, "donate", "chkClanHop", "0") = "1")

	; Max logout time (mandryd)
	IniReadS($TrainLogoutMaxTime, $g_sProfileConfigPath, "TrainLogout", "TrainLogoutMaxTime", 0, "int")
	IniReadS($TrainLogoutMaxTimeTXT, $g_sProfileConfigPath, "TrainLogout", "TrainLogoutMaxTimeTXT", 4, "int")

	; ExtendedAttackBar
	IniReadS($g_abChkExtendedAttackBar[$DB], $g_sProfileConfigPath, "attack", "ExtendedAttackBarDB", False, "Bool")
	IniReadS($g_abChkExtendedAttackBar[$LB], $g_sProfileConfigPath, "attack", "ExtendedAttackBarLB", False, "Bool")

EndFunc

; SwitchAcc (Demen) - Added By Demen
Func ReadConfig_SwitchAcc()
	IniReadS($ichkSwitchAcc, $profile, "SwitchAcc", "Enable", 0, "int")
	IniReadS($ichkTrain, $profile, "SwitchAcc", "Pre-train", 0, "int")
	IniReadS($icmbTotalCoCAcc, $profile, "SwitchAcc", "Total Coc Account", -1, "int")
	IniReadS($g_iTrainTimeToSkip, $profile, "SwitchAcc", "Train Time To Skip", 1, "int")
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
