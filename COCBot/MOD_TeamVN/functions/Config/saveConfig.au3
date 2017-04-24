; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: NguyenAnhHD, Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_MOD()
	; <><><> TeamVN MOD (NguyenAnhHD, Demen) <><><>
	ApplyConfig_MOD("Save")
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

	; Notify Bot Speep (Kychera) - Added By NguyenAnhHD
;~	_Ini_Add("notify", "AlertPBSleep", $g_bNotifyAlertBOTSleep ? 1 : 0)

	; ClanHop (Rhinoceros) - Added by NguyenAnhHD
;~	_Ini_Add("Others", "ClanHop", $ichkClanHop ? 1 : 0)

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
