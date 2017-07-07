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

Global $g_chkAutoUpgrade = 0, $g_AutoUpgradeLog = 0
Global $g_chkIgnoreTH = 0, $g_chkIgnoreKing = 0, $g_chkIgnoreQueen = 0, $g_chkIgnoreWarden = 0, $g_chkIgnoreCC = 0, $g_chkIgnoreLab = 0
Global $g_chkIgnoreBarrack = 0, $g_chkIgnoreDBarrack = 0, $g_chkIgnoreFactory = 0, $g_chkIgnoreDFactory = 0, $g_chkIgnoreGColl = 0, $g_chkIgnoreEColl = 0, $g_chkIgnoreDColl = 0
Global $g_SmartMinGold = 0, $g_SmartMinElixir = 0, $g_SmartMinDark = 0

Func CreateAutoUpgradeGUI()

	Local $x = 25, $y = 45

	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Group_01", "Auto Upgrade"), $x - 20, $y - 20, 442, 340)

	$g_chkAutoUpgrade = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "chkAutoUpgrade", "Enable Auto Upgrade"), $x - 5, $y, -1, -1)
	_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "chkAutoUpgrade_Info_01", "Check box to enable automatically starting Upgrades from builders menu"))
	GUICtrlSetOnEvent(-1, "chkAutoUpgrade")

	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "Group_02", "Upgrades to ignore"), $x - 15, $y + 30, 432, 155)

	Local $x = 21, $y = 45

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnTH11, $x + 5, $y + 50, 40, 40)
	$g_chkIgnoreTH = GUICtrlCreateCheckbox("", $x + 20, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreTH")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnKing, $x + 95, $y + 50, 40, 40)
	$g_chkIgnoreKing = GUICtrlCreateCheckbox("", $x + 110, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreKing")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueen, $x + 140, $y + 50, 40, 40)
	$g_chkIgnoreQueen = GUICtrlCreateCheckbox("", $x + 155, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreQueen")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnWarden, $x + 185, $y + 50, 40, 40)
	$g_chkIgnoreWarden = GUICtrlCreateCheckbox("", $x + 200, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreWarden")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnCC, $x + 275, $y + 50, 40, 40)
	$g_chkIgnoreCC = GUICtrlCreateCheckbox("", $x + 290, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreCC")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnLaboratory, $x + 365, $y + 50, 40, 40)
	$g_chkIgnoreLab = GUICtrlCreateCheckbox("", $x + 380, $y + 90, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreLab")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnBarrack, $x + 5, $y + 120, 40, 40)
	$g_chkIgnoreBarrack = GUICtrlCreateCheckbox("", $x + 20, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreBarrack")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnDarkBarrack, $x + 50, $y + 120, 40, 40)
	$g_chkIgnoreDBarrack = GUICtrlCreateCheckbox("", $x + 65, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreDBarrack")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnSpellFactory, $x + 140, $y + 120, 40, 40)
	$g_chkIgnoreFactory = GUICtrlCreateCheckbox("", $x + 155, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreFactory")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnDarkSpellFactory, $x + 185, $y + 120, 40, 40)
	$g_chkIgnoreDFactory = GUICtrlCreateCheckbox("", $x + 200, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreDFactory")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnMine, $x + 275, $y + 120, 40, 40)
	$g_chkIgnoreGColl = GUICtrlCreateCheckbox("", $x + 290, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreGColl")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnCollector, $x + 320, $y + 120, 40, 40)
	$g_chkIgnoreEColl = GUICtrlCreateCheckbox("", $x + 335, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreEColl")

	GUICtrlCreateIcon($g_sLibIconPath, $eIcnDrill, $x + 365, $y + 120, 40, 40)
	$g_chkIgnoreDColl = GUICtrlCreateCheckbox("", $x + 380, $y + 160, 17, 17)
	GUICtrlSetOnEvent(-1, "chkIgnoreDColl")

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_SmartMinGold = GUICtrlCreateInput("200000", 174, 37, 57, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "SmartMin_Info_01", "Gold to save"), 236, 40, 64, 17)
	$g_SmartMinElixir = GUICtrlCreateInput("200000", 174, 57, 57, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "SmartMin_Info_02", "Elixir to save"), 236, 60, 63, 17)
	$g_SmartMinDark = GUICtrlCreateInput("1500", 302, 37, 65, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "SmartMin_Info_03", "Dark to save"), 372, 40, 65, 17)
	GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "SmartMin_Info_04", "... after launching upgrade"), 302, 60, 128, 17)

	$g_AutoUpgradeLog = GUICtrlCreateEdit("", 10, 232, 432, 124, BitOR($GUI_SS_DEFAULT_EDIT, $ES_READONLY))
	GUICtrlSetData(-1, GetTranslatedFileIni("MOD GUI Design - AutoUpgrade", "AutoUpgradeLog", "                                             ----- AUTO UPGRADE LOG -----"))

	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc   ;==>CreateAutoUpgradeGUI