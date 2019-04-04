; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
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

Func ReadConfig_MOD()
	; <><><> Team AiO MOD++ (2018) <><><>
	; CSV Deploy Speed - Team AiO MOD++
	IniReadS($icmbCSVSpeed[$LB], $g_sProfileConfigPath, "attack", "cmbCSVSpeedLB", $icmbCSVSpeed[$LB], "int")
	IniReadS($icmbCSVSpeed[$DB], $g_sProfileConfigPath, "attack", "cmbCSVSpeedDB", $icmbCSVSpeed[$DB], "int")
	For $i = $DB To $LB
		If $icmbCSVSpeed[$i] < 5 Then
			$g_CSVSpeedDivider[$i] = 0.5 + $icmbCSVSpeed[$i] * 0.25        ; $g_CSVSpeedDivider = 0.5, 0.75, 1, 1.25, 1.5
		Else
			$g_CSVSpeedDivider[$i] = 2 + $icmbCSVSpeed[$i] - 5            ; $g_CSVSpeedDivider = 2, 3, 4, 5
		EndIf
	Next

	; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
	IniReadS($g_bEnableAuto, $g_sProfileConfigPath, "general", "EnableAuto", $g_bEnableAuto, "Bool")
	IniReadS($g_bChkAutoDock, $g_sProfileConfigPath, "general", "AutoDock", $g_bChkAutoDock, "Bool")
	IniReadS($g_bChkAutoHideEmulator, $g_sProfileConfigPath, "general", "AutoHide", $g_bChkAutoHideEmulator, "Bool")
	IniReadS($g_bChkAutoMinimizeBot, $g_sProfileConfigPath, "general", "AutoMinimize", $g_bChkAutoMinimizeBot, "Bool")

	; Max logout time - Team AiO MOD++
	IniReadS($g_bTrainLogoutMaxTime, $g_sProfileConfigPath, "other", "chkTrainLogoutMaxTime", $g_bTrainLogoutMaxTime, "Bool")
	IniReadS($g_iTrainLogoutMaxTime, $g_sProfileConfigPath, "other", "txtTrainLogoutMaxTime", $g_iTrainLogoutMaxTime, "int")

	; Restart Search Legend league - Team AiO MOD++
	IniReadS($g_bIsSearchTimeout, $g_sProfileConfigPath, "other", "ChkSearchTimeout", $g_bIsSearchTimeout, "Bool")
	IniReadS($g_iSearchTimeout, $g_sProfileConfigPath, "other", "SearchTimeout", $g_iSearchTimeout, "int")

	; ClanHop - Team AiO MOD++
	IniReadS($g_bChkClanHop, $g_sProfileConfigPath, "donate", "chkClanHop", $g_bChkClanHop, "Bool")

EndFunc   ;==>ReadConfig_MOD
