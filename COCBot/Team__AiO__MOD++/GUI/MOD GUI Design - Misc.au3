; #FUNCTION# ====================================================================================================================
; Name ..........: Misc MOD
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: NguyenAnhHD
; Modified ......: Team AiO MOD++ (2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hLblGFTO = 0, $g_hChkUseGTFO = 0, $g_hTxtMinSaveGTFO_Elixir = 0, $g_hTxtMinSaveGTFO_DE = 0
Global $g_hLblKickout = 0, $g_hChkUseKickOut = 0, $g_hTxtDonatedCap = 0, $g_hTxtReceivedCap = 0, $g_hChkKickOutSpammers = 0, $g_hTxtKickLimit = 0
Global $g_hLblInitialDonated = 0, $g_hLblCurrentDonated = 0

Func MiscMODGUI()

	Local $x = 25, $y = 45
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - Misc", "Group_01", "Special Kickass Donation"), $x - 20, $y - 20, $g_iSizeWGrpTab2, 130)

	$x -= 17
		$g_hLblGFTO = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "LblGTFO", "Lightning Fast Troops'n'Spells Donation"), $x, $y, 436, 22, BitOR($SS_CENTER, $SS_CENTERIMAGE))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Misc", "LblGTFO_Info_01", "This is a Standalone feature!") & @CRLF & _
							   GetTranslatedFileIni("MOD GUI Design - Misc", "LblGTFO_Info_02", "Just Set your custom train, correct capacities") & @CRLF & _
							   GetTranslatedFileIni("MOD GUI Design - Misc", "LblGTFO_Info_03", "And This feature!"))
			GUICtrlSetBkColor($g_hLblGFTO, 0x3498DB) ; Blue
			GUICtrlSetFont($g_hLblGFTO, 12)

	$y += 30
		$g_hChkUseGTFO = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Misc", "ChkUseGTFO", "Enable it (at your own risks...)"), $x + 20, $y, -1, 17)
		GUICtrlSetOnEvent(-1, "ApplyGTFO")

	$y += 5
	$x -= 15
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "LblMinSaveGTFO_01", "Exit SKD when Elixir") & " <", $x + 25, $y + 25, -1, -1)
		$g_hTxtMinSaveGTFO_Elixir = GUICtrlCreateInput("200000", $x + 160, $y + 22, 56, 21, BitOR($ES_CENTER, $ES_NUMBER))
			GUICtrlSetOnEvent(-1, "ApplyElixirGTFO")
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "LblMinSaveGTFO_02", "Exit SKD when Dark Elixir") & " <", $x + 25, $y + 50, -1, -1)
		$g_hTxtMinSaveGTFO_DE = GUICtrlCreateInput("2000", $x + 160, $y + 47, 56, 21, BitOR($ES_CENTER, $ES_NUMBER))
			GUICtrlSetOnEvent(-1, "ApplyDarkElixirGTFO")

	$x += 210
	$y += 2
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "Label_01", "Goal of SKD is lightning fast donation"), $x + 2, $y, 250, -1, $SS_CENTER)
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "Label_02", "SKD is perfect for GTFO and to win a lot of XP !"), $x + 2, $y + 18, 250, -1, $SS_CENTER)
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "Label_03", "Time usage: 95% on Donations, 5% on Training"), $x + 2, $y + 36, 250, -1, $SS_CENTER)

		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "Label_04", "Initial") & ": ", $x + 17, $y + 54, -1, -1)
		$g_hLblInitialDonated = GUICtrlCreateLabel("0", $x + 52, $y + 54, 40, -1, $SS_LEFT)

		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "Label_05", "Current") & ": ", $x + 112, $y + 54, -1, -1)
		$g_hLblCurrentDonated = GUICtrlCreateLabel("0", $x + 157, $y + 54, 40, -1, $SS_LEFT)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 25, $y = 180
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - Misc", "Group_02", "Special Kickass New Members"), $x - 20, $y - 20, $g_iSizeWGrpTab2, 150)

	$x -= 17
		$g_hLblKickout = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "LblKickout", "Kickout Spammers / New Members"), $x, $y, 436, 22, BitOR($SS_CENTER, $SS_CENTERIMAGE))
			GUICtrlSetBkColor($g_hLblKickout, 0x3498db) ; Blue
			GUICtrlSetFont($g_hLblKickout, 12)

	$y += 30
		$g_hChkUseKickOut = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Misc", "ChkUseKickOut", "Enable it (at your own risks...)"), $x + 20, $y, -1, 17)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Misc", "ChkUseKickOut_Info_01", "Is necessary to be a Co-Leader or Leader"))
			GUICtrlSetOnEvent(-1, "ApplyKickOut")

	$y += 25
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "LblDonatedCap", "Donated Cap"), $x + 20, $y, -1, -1)
		$g_hTxtDonatedCap = GUICtrlCreateInput("8", $x + 120, $y - 2, 56, 21, BitOR($ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Misc", "LblDonatedCap_Info_01", "New member + Donated Troops Limits, when reach will be kick [0-8]"))
			GUICtrlSetOnEvent(-1, "ApplyDonatedCap")

	$y += 25
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "LblReceivedCap", "Received Cap"), $x + 20, $y, -1, -1)
		$g_hTxtReceivedCap = GUICtrlCreateInput("35", $x + 120, $y - 2, 56, 21, BitOR($ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Misc", "LblReceivedCap_Info_01", "New member + Received Troops limits, when reach will be kick [0-35]"))
			GUICtrlSetOnEvent(-1, "ApplyReceivedCap")

	$y -= 10
		$g_hChkKickOutSpammers = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Misc", "ChkKickOutSpammers", "KickOut Spammers"), $x + 190, $y, -1, 17)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Misc", "ChkKickOutSpammers_Info_01", "Kick only members with Donations and '0' Requests!"))
			GUICtrlSetOnEvent(-1, "ApplyKickOutSpammers")

		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Misc", "LblKickLimit", "Kickout Limits"), $x + 359, $y - 15, -1, -1)
		$g_hTxtKickLimit = GUICtrlCreateInput("6", $x + 365, $y, 56, 21, BitOR($ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Misc", "LblKickLimit_Info_01", "How many Members will be kick each time.[1-9]") & @CRLF & _
							   GetTranslatedFileIni("MOD GUI Design - Misc", "LblKickLimit_Info_02", "From Bottom Rank to Top"))
			GUICtrlSetOnEvent(-1, "ApplyKickLimits")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc   ;==>MiscMODGUI
