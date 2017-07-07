; #FUNCTION# ====================================================================================================================
; Name ..........: FORECAST GUI Design
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: AwesomeGamer 2015
; Modified ......: rulesss, Eloy
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; ======================================================== FORECAST =============================================================
Func ForecastGUI()
	Local $sTxtTip = ""
	Local $xStart = 0, $yStart = 0
	Local $x = $xStart + 10, $y = $yStart + 25
	$ieForecast = GUICtrlCreateObj($oIE, $x , $y , 430, 310)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

$y += + 318
	$chkForecastBoost = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastBoost", "Boost When >"), $x, $y, -1, -1)
		$sTxtTip = GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastBoost_Info_01", "Boost Barracks,Heroes, when the loot index.")
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetOnEvent(-1, "chkForecastBoost")
	$txtForecastBoost = GUICtrlCreateInput("6.0", $x + 100, $y + 2, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
		$sTxtTip = GetTranslatedFileIni("MOD GUI Design - Forecast", "BtnForecastBoost_Info_02", "Minimum loot index for boosting.")
		GUICtrlSetLimit(-1, 3)
		GUICtrlSetTip(-1, $sTxtTip)
		_GUICtrlEdit_SetReadOnly(-1, True)
		GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += - 27
	$chkForecastHopingSwitchMax = GUICtrlCreateCheckbox("", $x + 150, $y + 27, 13, 13)
		$sTxtTip = "" ; Information
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetOnEvent(-1, "chkForecastHopingSwitchMax")
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch", "Switch to"), $x + 168, $y + 27, -1, -1)
	$cmbForecastHopingSwitchMax = GUICtrlCreateCombo("", $x + 218, $y + 25, 95, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		$sTxtTip = "" ; Information
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$lblForecastHopingSwitchMax = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch_01", "When Index <"), $x + 316, $y + 28, -1, -1)
	$txtForecastHopingSwitchMax = GUICtrlCreateInput("2.5", $x + 400, $y + 26, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
		$sTxtTip = "" ; Information
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlSetLimit(-1, 3)
		GUICtrlSetData(-1, 2.5)
		GUICtrlSetTip(-1, $sTxtTip)
		_GUICtrlEdit_SetReadOnly(-1, True)
	$chkForecastHopingSwitchMin = GUICtrlCreateCheckbox("", $x + 150, $y + 55, 13, 13)
		$sTxtTip = "" ; Information
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetOnEvent(-1, "chkForecastHopingSwitchMin")
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch", -1), $x + 168, $y + 55, -1, -1)
	$cmbForecastHopingSwitchMin = GUICtrlCreateCombo("", $x + 218, $y + 53, 95, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		$sTxtTip = "" ; Information
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$lblForecastHopingSwitchMin = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch_02", "When Index >"), $x + 316, $y + 58, -1, -1)
	$txtForecastHopingSwitchMin = GUICtrlCreateInput("2.5", $x + 400, $y + 54, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
		$sTxtTip = "" ; Information
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlSetLimit(-1, 3)
		GUICtrlSetData(-1, 2.5)
		GUICtrlSetTip(-1, $sTxtTip)
		_GUICtrlEdit_SetReadOnly(-1, True)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	setupProfileComboBox()
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$chkForecastPause = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastPause", "Halt when below"), $x, $y + 50, -1, -1)
		$sTxtTip = GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastPause_Info_01", "Halt attacks when the loot index is below the specified value.")
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetOnEvent(-1, "chkForecastPause")
	$txtForecastPause = GUICtrlCreateInput("2.0", $x + 100, $y + 50, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
		$sTxtTip = GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastPause_Info_02", "Minimum loot index for halting attacks.")
		GUICtrlSetLimit(-1, 3)
		GUICtrlSetTip(-1, $sTxtTip)
		_GUICtrlEdit_SetReadOnly(-1, True)
		GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$cmbSwLang = GUICtrlCreateCombo("", $x, $y + 75, 45, 45, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "EN" & "|" & "RU" & "|" & "FR" & "|" & "DE" & "|" & "ES" & "|" & "FA" & "|" & "PT" & "|" & "IN", "EN")
		GUICtrlSetOnEvent(-1, "cmbSwLang")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc