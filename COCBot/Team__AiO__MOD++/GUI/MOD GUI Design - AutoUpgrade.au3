; #FUNCTION# ====================================================================================================================
; Name ..........: Auto Upgrade
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Roro-Titi
; Modified ......: Team AiO MOD++ (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $g_chkAutoUpgrade = 0, $g_FirstAutoUpgradeLabel = 0, $g_AutoUpgradeLog = 0
Global $g_SmartMinGold = 0, $g_SmartMinElixir = 0, $g_SmartMinDark = 0
Global $g_chkResourcesToIgnore[3] = [0, 0, 0]
Global $g_chkUpgradesToIgnore[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

Func CreateAutoUpgradeGUI()

	Local $x = 25, $y = 45
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Group_01", "Auto Upgrade"), $x - 20, $y - 20, 442, 400)

	$g_chkAutoUpgrade = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "chkAutoUpgrade", "Enable Auto Upgrade"), $x - 5, $y, -1, -1)
		_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "chkAutoUpgrade_Info_01", "Check box to enable automatically starting Upgrades from builders menu"))
		GUICtrlSetOnEvent(-1, "chkAutoUpgrade")

	$g_FirstAutoUpgradeLabel = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Label_01", "Save"), $x, $y + 32, -1, -1)
	$g_SmartMinGold = GUICtrlCreateInput("150000", $x + 33, $y + 29, 60, 21, BitOR($ES_CENTER, $ES_NUMBER))
	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnGold, $x + 98, $y + 32, 16, 16)
	$g_SmartMinElixir = GUICtrlCreateInput("150000", $x + 118, $y + 29, 60, 21, BitOR($ES_CENTER, $ES_NUMBER))
	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnElixir, $x + 183, $y + 32, 16, 16)
	$g_SmartMinDark = GUICtrlCreateInput("1500", $x + 203, $y + 29, 60, 21, BitOR($ES_CENTER, $ES_NUMBER))
	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnDark, $x + 268, $y + 32, 16, 16)
	GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Label_02", "after launching upgrade"), $x + 290, $y + 32, -1, -1)

	$g_chkResourcesToIgnore[0] = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Ignore_01", "Ignore Gold Upgrades"), $x, $y + 55, -1, -1)
	GUICtrlSetOnEvent(-1, "chkResourcesToIgnore")
	$g_chkResourcesToIgnore[1] = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Ignore_02", "Ignore Elixir Upgrades"), $x + 130, $y + 55, -1, -1)
	GUICtrlSetOnEvent(-1, "chkResourcesToIgnore")
	$g_chkResourcesToIgnore[2] = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Ignore_03", "Ignore Dark Elixir Upgrades"), $x + 258, $y + 55, -1, -1)
	GUICtrlSetOnEvent(-1, "chkResourcesToIgnore")

	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Group_02", "Upgrades to ignore"), $x - 15, $y + 85, 432, 155)

	Local $x = 21, $y = 100
	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnTH11, $x + 5, $y + 50, 40, 40)
	$g_chkUpgradesToIgnore[0] = GUICtrlCreateCheckbox("", $x + 20, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnKing, $x + 95, $y + 50, 40, 40)
	$g_chkUpgradesToIgnore[1] = GUICtrlCreateCheckbox("", $x + 110, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueen, $x + 140, $y + 50, 40, 40)
	$g_chkUpgradesToIgnore[2] = GUICtrlCreateCheckbox("", $x + 155, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnWarden, $x + 185, $y + 50, 40, 40)
	$g_chkUpgradesToIgnore[3] = GUICtrlCreateCheckbox("", $x + 200, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnCC, $x + 275, $y + 50, 40, 40)
	$g_chkUpgradesToIgnore[4] = GUICtrlCreateCheckbox("", $x + 290, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnLaboratory, $x + 365, $y + 50, 40, 40)
	$g_chkUpgradesToIgnore[5] = GUICtrlCreateCheckbox("", $x + 380, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnBarrack, $x + 5, $y + 120, 40, 40)
	$g_chkUpgradesToIgnore[6] = GUICtrlCreateCheckbox("", $x + 20, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnDarkBarrack, $x + 50, $y + 120, 40, 40)
	$g_chkUpgradesToIgnore[7] = GUICtrlCreateCheckbox("", $x + 65, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnSpellFactory, $x + 140, $y + 120, 40, 40)
	$g_chkUpgradesToIgnore[8] = GUICtrlCreateCheckbox("", $x + 155, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnDarkSpellFactory, $x + 185, $y + 120, 40, 40)
	$g_chkUpgradesToIgnore[9] = GUICtrlCreateCheckbox("", $x + 200, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnMine, $x + 275, $y + 120, 40, 40)
	$g_chkUpgradesToIgnore[10] = GUICtrlCreateCheckbox("", $x + 290, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnCollector, $x + 320, $y + 120, 40, 40)
	$g_chkUpgradesToIgnore[11] = GUICtrlCreateCheckbox("", $x + 335, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnDrill, $x + 365, $y + 120, 40, 40)
	$g_chkUpgradesToIgnore[12] = GUICtrlCreateCheckbox("", $x + 380, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkUpgradesToIgnore")

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_AutoUpgradeLog = GUICtrlCreateEdit("", 10, 287, 432, 124, BitOR($GUI_SS_DEFAULT_EDIT, $ES_READONLY))
	GUICtrlSetData(-1, GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "AutoUpgradeLog", "------------------------------------------------ AUTO UPGRADE LOG ------------------------------------------------"))

	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc   ;==>CreateAutoUpgradeGUI