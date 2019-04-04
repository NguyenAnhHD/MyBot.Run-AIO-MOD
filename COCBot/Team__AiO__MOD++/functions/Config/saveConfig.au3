; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_MOD()
	; <><><> Team AiO MOD++ (2018) <><><>
	ApplyConfig_MOD(GetApplyConfigSaveAction())
	; CSV Deploy Speed - Team AiO MOD++
	_Ini_Add("attack", "cmbCSVSpeedLB", $icmbCSVSpeed[$LB])
	_Ini_Add("attack", "cmbCSVSpeedDB", $icmbCSVSpeed[$DB])

	; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
	_Ini_Add("general", "EnableAuto", $g_bEnableAuto ? 1 : 0)
	_Ini_Add("general", "AutoDock", $g_bChkAutoDock ? 1 : 0)
	_Ini_Add("general", "AutoHide", $g_bChkAutoHideEmulator ? 1 : 0)
	_Ini_Add("general", "AutoMinimize", $g_bChkAutoMinimizeBot ? 1 : 0)

	; Max logout time - Team AiO MOD++
	_Ini_Add("other", "chkTrainLogoutMaxTime", $g_bTrainLogoutMaxTime)
	_Ini_Add("other", "txtTrainLogoutMaxTime", $g_iTrainLogoutMaxTime)

	; Restart Search Legend league - Team AiO MOD++
	_Ini_Add("other", "ChkSearchTimeout", $g_bIsSearchTimeout)
	_Ini_Add("other", "SearchTimeout", $g_iSearchTimeout)

	; ClanHop - Team AiO MOD++
	_Ini_Add("donate", "chkClanHop", $g_bChkClanHop)

EndFunc   ;==>SaveConfig_MOD
