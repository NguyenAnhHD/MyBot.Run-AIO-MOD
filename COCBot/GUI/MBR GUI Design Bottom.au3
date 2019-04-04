; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the bottom panel
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GKevinOD (2014)
; Modified ......: DkEd, Hervidero (2015), CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hBtnStart = 0, $g_hBtnStop = 0, $g_hBtnPause = 0, $g_hBtnResume = 0, $g_hBtnSearchMode = 0, $g_hBtnMakeScreenshot = 0, $g_hBtnHide = 0, $g_hBtnEmbed = 0, _
	$g_hChkBackgroundMode = 0, $g_hLblDonate = 0, $g_hBtnAttackNowDB = 0, $g_hBtnAttackNowLB = 0, $g_hBtnAttackNowTS = 0
Global $g_hPicTwoArrowShield = 0, $g_hLblVersion = 0, $g_hLblMod = 0, $g_hPicArrowLeft = 0, $g_hPicArrowRight = 0
Global $g_hGrpVillage = 0
Global $g_hLblResultGoldNow = 0, $g_hLblResultGoldHourNow = 0, $g_hPicResultGoldNow = 0, $g_hPicResultGoldTemp = 0
Global $g_hLblResultElixirNow = 0, $g_hLblResultElixirHourNow = 0, $g_hPicResultElixirNow = 0, $g_hPicResultElixirTemp = 0
Global $g_hLblResultDENow = 0, $g_hLblResultDEHourNow = 0, $g_hPicResultDENow = 0, $g_hPicResultDETemp = 0
Global $g_hLblResultTrophyNow = 0, $g_hPicResultTrophyNow = 0, $g_hLblResultRuntimeNow = 0, $g_hPicResultRuntimeNow = 0, $g_hLblResultBuilderNow = 0, $g_hPicResultBuilderNow = 0
Global $g_hLblResultAttackedHourNow = 0, $g_hPicResultAttackedHourNow = 0, $g_hLblResultGemNow = 0, $g_hPicResultGemNow = 0, $g_hLblResultSkippedHourNow = 0, $g_hPicResultSkippedHourNow = 0
Global $g_hLblVillageReportTemp = 0

; GLOBALS FOR NEW GAME STATUS DISPALY
Global $g_hPicHeroGray[3] = [0, 0, 0], $g_hPicHeroBlue[3] = [0, 0, 0], $g_hPicHeroRed[3] = [0, 0, 0], $g_hPicHeroGreen[3] = [0, 0, 0], _
	$g_hPicLabGray = 0, $g_hPicLabRed = 0, $g_hPicLabGreen = 0, $g_hLblLabTime = 0

; Enable/Disable GUI while botting - Team AiO MOD++
Global $g_hBtnEnableGUI = 0, $g_hBtnDisableGUI = 0

Func CreateBottomPanel()
	Local $sTxtTip = ""
	;~ ------------------------------------------------------
	;~ Lower part visible on all Tabs
	;~ ------------------------------------------------------

	;~ Buttons
	Local $y_bottom = 0 ; 515
	Local $x = 10, $y = $y_bottom + 10
	GUICtrlCreateGroup("https://mybot.run " & GetTranslatedFileIni("MBR GUI Design Bottom", "Group_01", "- freeware bot -"), $x - 5, $y - 10, 190, 108)
		$g_hBtnStart = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnStart", "Start Bot"), $x, $y + 2 +5, 90, 40-5)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnStart_Info_01", "Use this to START the bot."))
			GUICtrlSetOnEvent(-1, "btnStart")
			If $g_bBtnColor then GUICtrlSetBkColor(-1, 0x5CAD85)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hBtnStop = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnStop", "Stop Bot"), -1, -1, 90, 40-5)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnStop_Info_01", "Use this to STOP the bot (or ESC key)."))
			If $g_bBtnColor then GUICtrlSetBkColor(-1, 0xDB4D4D)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hBtnPause = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnPause", "Pause"), $x + 90, -1, 90, 40-5)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnPause_Info_01", "Use this to PAUSE all actions of the bot until you Resume (or Pause/Break key)."))
			If $g_bBtnColor then GUICtrlSetBkColor(-1,  0xFFA500)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hBtnResume = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnResume", "Resume"), -1, -1, 90, 40-5)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnResume_Info_01", "Use this to RESUME a paused Bot (or Pause/Break key)."))
			If $g_bBtnColor then GUICtrlSetBkColor(-1,  0xFFA500)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hBtnSearchMode = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnSearchMode", "Search Mode"), -1, -1, 90, 40-5)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnSearchMode_Info_01", "Does not attack. Searches for a Village that meets conditions."))
			GUICtrlSetOnEvent(-1, "btnSearchMode")
			If $g_bBtnColor then GUICtrlSetBkColor(-1,  0xFFA500)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hBtnMakeScreenshot = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnMakeScreenshot", "Photo"), $x , $y + 45, 40, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnMakeScreenshot_Info_01", "Click here to take a snaphot of your village and save it to a file."))
			If $g_bBtnColor then GUICtrlSetBkColor(-1, 0x5CAD85)
		$g_hBtnHide = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnHide", "Hide"), $x + 40, $y + 45, 50, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnHide_Info_01", "Use this to move the Android Window out of sight.") & @CRLF & _
							   GetTranslatedFileIni("MBR GUI Design Bottom", "BtnHide_Info_02", "(Not minimized, but hidden)"))
			If $g_bBtnColor Then GUICtrlSetBkColor(-1, 0x22C4F5)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hBtnEmbed = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnEmbed", "Dock"), $x + 90, $y + 45, 90, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnEmbed_Info_01", "Use this to embed the Android Window into Bot."))
			If $g_bBtnColor Then GUICtrlSetBkColor(-1, 0x22C4F5)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "btnEmbed")
		$g_hChkBackgroundMode = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Bottom", "ChkBackgroundMode", "Background Mode"), $x + 1, $y + 72, 90, 24)
			GUICtrlSetFont(-1, 7)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "ChkBackgroundMode_Info_01", "Check this to ENABLE the Background Mode of the Bot.") & @CRLF & _
							   GetTranslatedFileIni("MBR GUI Design Bottom", "ChkBackgroundMode_Info_02", "With this you can also hide the Android Emulator window out of sight."))
			If $g_bGuiRemote Then GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "chkBackground")
			GUICtrlSetState(-1, (($g_bAndroidAdbScreencap = True) ? ($GUI_CHECKED) : ($GUI_UNCHECKED)))

		; Enable/Disable GUI while botting - Team AiO MOD++
	    $g_hBtnEnableGUI = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnEnableGUI", "Enable GUI"), $x + 100, $y + 72, 80, 22)
		    _GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnEnableGUI_Info_01", "Enable GUI control while botting") & @CRLF & _
			 				  GetTranslatedFileIni("MBR GUI Design Bottom", "BtnEnableGUI_Info_02", "Warning: USE THIS WITH CAUTION!") & @CRLF & _
			 				  GetTranslatedFileIni("MBR GUI Design Bottom", "BtnEnableGUI_Info_03", "This function may create errors that require bot/PC restart") & @CRLF & _
			 				  GetTranslatedFileIni("MBR GUI Design Bottom", "BtnEnableGUI_Info_04", "Better to stop the Bot completely if you need to change the setting"))
		    GUICtrlSetOnEvent(-1, "btnEnableGUI")
		    GUICtrlSetState(-1, $GUI_HIDE)
	    $g_hBtnDisableGUI = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnDisableGUI", "Disable GUI"), $x + 100, $y + 72, 80, 22)
		    _GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "BtnDisableGUI_Info_01", "Disable GUI control to continue botting"))
		    GUICtrlSetOnEvent(-1, "btnDisableGUI")
		    GUICtrlSetState(-1, $GUI_HIDE)

		$g_hBtnAttackNowDB = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnAttackNowDB", "DB Attack!"), $x + 195, $y - 4, 60, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hBtnAttackNowLB = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnAttackNowLB", "LB Attack!"), $x + 195, $y + 23, 60, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hBtnAttackNowTS = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Bottom", "BtnAttackNowTS", "TH Snipe!"), $x + 195, $y + 50, 60, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hLblDonate = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Bottom", "LblDonate", "Support the Development"), $x + 293, $y + 85, 142, 18, $SS_RIGHT)
			GUICtrlSetCursor(-1, 0) ; https://www.autoitscript.com/autoit3/docs/functions/MouseGetCursor.htm
			GUICtrlSetFont(-1, 8.5, $FW_BOLD) ;, $GUI_FONTITALIC + $GUI_FONTUNDER)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Bottom", "LblDonate_Info_01", "Paypal Donate?"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	If $g_bAndroidAdbScreencap Then chkBackground() ; update background mode GUI

	$g_hPicTwoArrowShield = _GUICtrlCreateIcon($g_sLibIconPath, $eIcn2Arrow, $x + 205, $y + 7, 48, 48)

	$g_hLblVersion = GUICtrlCreateLabel($g_sModVersion, $x + 200, $y + 62, 60, 17, $SS_CENTER)
		GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
		GUICtrlSetColor(-1, 0x804001)
    $g_hLblMod = GUICtrlCreateLabel("AiO++ MOD", $x + 195, $y + 78, 70, 17, $SS_CENTER)
 		GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
		GUICtrlSetColor(-1, 0x804001)

	$g_hPicArrowLeft = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnArrowLeft, $x + 269, $y + 30, 16, 16)
		$sTxtTip = GetTranslatedFileIni("MBR GUI Design Bottom", "GrpVillage_Info_01", "Switch between village info and stats")
		_GUICtrlSetTip(-1, $sTxtTip)
	$g_hPicArrowRight = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnArrowRight, $x + 247 + 198, $y + 30, 16, 16)
		_GUICtrlSetTip(-1, $sTxtTip)

	;~ Village
	Local $x = 295, $y = $y_bottom + 20
	$g_hGrpVillage = GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Bottom", "GrpVillage", "Village"), $x - 0, $y - 20, 160, 94)
		$y = $y_bottom + 17
		$g_hLblResultGoldNow = GUICtrlCreateLabel("", $x + 10, $y + 2, 60, 15, $SS_RIGHT)
		$g_hLblResultGoldHourNow = GUICtrlCreateLabel("", $x + 10, $y + 2, 60, 15, $SS_RIGHT)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultGoldNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnGold, $x + 71, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultGoldTemp = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnGold, $x + 15, $y, 16, 16)

		$g_hLblResultElixirNow = GUICtrlCreateLabel("", $x + 10, $y + 22, 60, 15, $SS_RIGHT)
		$g_hLblResultElixirHourNow = GUICtrlCreateLabel("", $x + 10, $y + 22, 60, 15, $SS_RIGHT)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultElixirNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnElixir, $x + 71, $y + 20, 16, 16)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultElixirTemp = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnElixir, $x + 15, $y + 20, 16, 16)

		$g_hLblResultDENow = GUICtrlCreateLabel("", $x + 10, $y + 42, 60, 15, $SS_RIGHT)
		$g_hLblResultDEHourNow = GUICtrlCreateLabel("", $x + 10, $y + 42, 60, 15, $SS_RIGHT)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultDENow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDark, $x + 71, $y + 40, 16, 16)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultDETemp = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDark, $x + 15, $y + 40, 16, 16)

	$x += 75
		;trophy / runtime
		$g_hLblResultTrophyNow = GUICtrlCreateLabel("", $x + 13, $y + 2, 43, 15, $SS_RIGHT)
		$g_hPicResultTrophyNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnTrophy, $x + 59, $y , 16, 16)
		$g_hLblResultRuntimeNow = GUICtrlCreateLabel("00:00:00", $x + 13, $y + 2, 43, 15, $SS_RIGHT)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultRuntimeNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnHourGlass, $x +57, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_HIDE)

		;builders/attacked
		$g_hLblResultBuilderNow = GUICtrlCreateLabel("", $x + 16, $y + 22, 40, 15, $SS_RIGHT)
		$g_hPicResultBuilderNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBuilder, $x + 59, $y + 20, 16, 16)
		$g_hLblResultAttackedHourNow = GUICtrlCreateLabel("0", $x + 13, $y + 22, 43, 15, $SS_RIGHT)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultAttackedHourNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBldgTarget, $x +59, $y + 20, 16, 16)
			GUICtrlSetState(-1, $GUI_HIDE)

		;gems/skipped
		$g_hLblResultGemNow = GUICtrlCreateLabel("", $x + 13, $y + 42, 43, 15, $SS_RIGHT)
		$g_hPicResultGemNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnGem, $x + 59, $y + 40, 16, 16)
		$g_hLblResultSkippedHourNow = GUICtrlCreateLabel("0", $x + 13, $y + 42, 43, 15, $SS_RIGHT)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicResultSkippedHourNow = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBldgX, $x + 59, $y + 40, 16, 16)
			GUICtrlSetState(-1, $GUI_HIDE)

	;New section for royal and lab status
	$x -= 65
		$sTxtTip = GetTranslatedFileIni("MBR GUI Design Bottom", "GrpStatus_Info_01", "Gray - Not Read, Green - Ready to Use, Blue - Healing, Red - Upgrading")
		;King
		$g_hPicHeroGray[0] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnKingGrayShield, $x, $y + 59, 15, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hPicHeroBlue[0] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnKingBlueShield, $x, $y + 59, 15, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicHeroGreen[0] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnKingGreenShield, $x, $y + 59, 15, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicHeroRed[0] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnKingRedShield, $x, $y + 59, 15, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)

		;Queen
		$g_hPicHeroGray[1] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueenGrayShield, $x + 24, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
		$g_hPicHeroBlue[1] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueenBlueShield, $x + 24, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicHeroGreen[1] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueenGreenShield, $x + 24, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicHeroRed[1] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueenRedShield, $x + 24, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)


		;Grand Warden
		$g_hPicHeroGray[2] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWardenGrayShield, $x + 48, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
		$g_hPicHeroBlue[2] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWardenBlueShield, $x + 48, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicHeroGreen[2] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWardenGreenShield, $x + 48, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicHeroRed[2] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWardenRedShield, $x + 48, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)

		;Laboratory
		$sTxtTip = GetTranslatedFileIni("MBR GUI Design Bottom", "GrpStatus_Info_02", "Green - Lab is Running, Red - Lab Has Stopped")
		$g_hPicLabGray = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnLabGrayShield, $x + 72, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
		$g_hPicLabGreen = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnLabGreenShield, $x + 72, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hPicLabRed = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnLabRedShield, $x + 72, $y + 59, 15, 15)
	  		_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$g_hLblLabTime = GUICtrlCreateLabel("00:00:00", $x + 93, $y + 60, 50, 14, $SS_LEFT)

	$x = 331
		$g_hLblVillageReportTemp = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Bottom", "LblVillageReportTemp_01", "Village Report") & @CRLF & GetTranslatedFileIni("MBR GUI Design Bottom", "LblVillageReportTemp_02", "will appear here") & @CRLF & GetTranslatedFileIni("MBR GUI Design Bottom", "LblVillageReportTemp_03", "on first run."), $x , $y + 3, 88, 50, BITOR($SS_CENTER, $BS_MULTILINE))

	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc   ;==>CreateBottomPanel
