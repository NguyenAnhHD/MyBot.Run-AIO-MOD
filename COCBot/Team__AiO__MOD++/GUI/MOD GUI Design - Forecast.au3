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

Global $chkForecastBoost = 0, $txtForecastBoost = 0
Global $chkForecastPause = 0, $txtForecastPause = 0
Global $chkForecastHopingSwitchMax = 0, $cmbForecastHopingSwitchMax = 0, $txtForecastHopingSwitchMax = 0
Global $chkForecastHopingSwitchMin = 0, $cmbForecastHopingSwitchMin = 0, $txtForecastHopingSwitchMin = 0
Global $cmbSwLang = 0

Func ForecastGUI()
	Local $sTxtTip = ""
	Local $xStart = 0, $yStart = 0
	Local $x = $xStart + 10, $y = $yStart + 25
	$ieForecast = GUICtrlCreateObj($oIE, $x , $y , 430, 310)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 100 + 220
		$chkForecastBoost = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastBoost", "Boost When >"), $x, $y, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastBoost_Info_01", "Boost Barracks,Heroes, when the loot index."))
			GUICtrlSetOnEvent(-1, "chkForecastBoost")
		$txtForecastBoost = GUICtrlCreateInput("6.0", $x + 100, $y, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastBoost_Info_02", "Minimum loot index for boosting."))
			GUICtrlSetLimit(-1, 3)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetState(-1, $GUI_DISABLE)

		$chkForecastPause = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastPause", "Halt when below"), $x, $y + 30, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastPause_Info_01", "Halt attacks when the loot index is below the specified value."))
			GUICtrlSetOnEvent(-1, "chkForecastPause")
		$txtForecastPause = GUICtrlCreateInput("2.0", $x + 100, $y + 30, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastPause_Info_02", "Minimum loot index for halting attacks."))
			GUICtrlSetLimit(-1, 3)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetState(-1, $GUI_DISABLE)

		$cmbSwLang = GUICtrlCreateCombo("", $x, $y + 60, 45, 45, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "EN" & "|" & "RU" & "|" & "FR" & "|" & "DE" & "|" & "ES" & "|" & "FA" & "|" & "PT" & "|" & "IN", "EN")
			GUICtrlSetOnEvent(-1, "cmbSwLang")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 150
		$chkForecastHopingSwitchMax = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch", "Switch to"), $x, $y, -1, -1)
			$sTxtTip = GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch_Info_01", "Switch to Profile when the loot index") & " <"
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetOnEvent(-1, "chkForecastHopingSwitchMax")
		$cmbForecastHopingSwitchMax = GUICtrlCreateCombo("", $x + 68, $y - 2, 95, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch_Info_02", "When Index") & " <", $x + 175, $y + 3, -1, -1)
		$txtForecastHopingSwitchMax = GUICtrlCreateInput("2.5", $x + 250, $y, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetData(-1, 2.5)
			_GUICtrlEdit_SetReadOnly(-1, True)

		$chkForecastHopingSwitchMin = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch", -1), $x, $y + 30, -1, -1)
			$sTxtTip = GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch_Info_01", -1) & " >"
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetOnEvent(-1, "chkForecastHopingSwitchMin")
		$cmbForecastHopingSwitchMin = GUICtrlCreateCombo("", $x + 68, $y + 28, 95, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Forecast", "ForecastHopingSwitch_Info_02", -1) & " >", $x + 175, $y + 33, -1, -1)
		$txtForecastHopingSwitchMin = GUICtrlCreateInput("2.5", $x + 250, $y + 30, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetData(-1, 2.5)
			_GUICtrlEdit_SetReadOnly(-1, True)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	setupProfileComboBox()
EndFunc   ;==>ForecastGUI