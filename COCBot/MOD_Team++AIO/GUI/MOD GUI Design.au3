; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team++ AIO (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_MOD = 0
Global $g_hGUI_MOD_TAB = 0, $g_hGUI_MOD_TAB_ITEM1 = 0 , $g_hGUI_MOD_TAB_ITEM2 = 0 ,$g_hGUI_MOD_TAB_ITEM3 = 0, $g_hGUI_MOD_TAB_ITEM4 = 0, $g_hGUI_MOD_TAB_ITEM5 = 0, $g_hGUI_MOD_TAB_ITEM6 = 0, $g_hGUI_MOD_TAB_ITEM7 = 0

; CoC Stats
Global $g_hChkCoCStats = 0, $g_hTxtAPIKey = 0

; Bot Humanization
#include "MOD GUI Design - Humanization.au3"

; Switch Account & Profiles
#include "MOD GUI Design - Profiles.au3"
#include "MOD GUI Design - ProfileStats.au3"

Func CreateMODTab()

	$g_hGUI_MOD = GUICreate("", $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, $_GUI_CHILD_LEFT, $_GUI_CHILD_TOP, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hFrmBotEx)

	GUISwitch($g_hGUI_MOD)
	$g_hGUI_MOD_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
		$g_hGUI_MOD_TAB_ITEM1 = GUICtrlCreateTabItem("Misc")
			OptionsGUI()
		$g_hGUI_MOD_TAB_ITEM2 = GUICtrlCreateTabItem("Humanize")
			HumanizationGUI()
		$g_hGUI_MOD_TAB_ITEM3 = GUICtrlCreateTabItem("Goblin XP")
			GoblinXPGUI()
		$g_hGUI_MOD_TAB_ITEM4 = GUICtrlCreateTabItem("Switch Account")
			CreateSwitchAccount()
		$g_hGUI_MOD_TAB_ITEM5 = GUICtrlCreateTabItem("Switch Profile")
			CreateModSwitchProfile()

		$g_hGUI_MOD_TAB_ITEM6 = GUICtrlCreateTabItem("Stat's") ; Has to be outside of the Last Control to hide
			$g_hLastControlToHide = GUICtrlCreateDummy()
			ReDim $g_aiControlPrevState[$g_hLastControlToHide + 1]
			CreateProfileStats()
		$g_hGUI_MOD_TAB_ITEM7 = GUICtrlCreateTabItem("Loot")


	GUICtrlCreateTabItem("")
EndFunc   ;==>CreateMODTab

Func OptionsGUI()

	Local $sTxtTip = ""
	Local $x = 25, $y = 30
	Local $Group1 = GUICtrlCreateGroup("", $x - 20, $y, 440, 35)

	   $y += 10
	   $x += -12
		   $g_hChkCoCStats = GUICtrlCreateCheckbox(GetTranslated(657,1, "CoCStats Activate"), $x, $y, -1, -1)
		   $sTxtTip = GetTranslated(657,2, "Activate sending raid results to CoCStats.com")
		   GUICtrlSetTip(-1, $sTxtTip)
		   GUICtrlSetOnEvent(-1, "chkCoCStats")

	   $x += 135
		   GUICtrlCreateLabel(GetTranslated(657,3, "API Key:"), $x - 18, $y + 4, -1, 21, $SS_LEFT)
		   $g_hTxtAPIKey = GUICtrlCreateInput("", $x + 30, $y, 250, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
		   $sTxtTip = GetTranslated(657,4, "Join in CoCStats.com and input API Key here")
		   GUICtrlSetTip(-1, $sTxtTip)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 70
	$x = 5
	Local $Group2 = GUICtrlCreateGroup("Not thought out of additional functions....!!", $x, $y, 440, 200)
	Local $txtHelp = "Wait For The Next Version......!!!!!" & _
		 @CRLF & "Coming Soon.................!! :P "
		GUICtrlCreateLabel($txtHelp, $x + 30, $y + 30, 430, 125)

EndFunc   ;==>OptionsGUI

Func GoblinXPGUI()

	Local $x = 25, $y = 50, $xStart = 25, $yStart = 50
#cs
	$grpSuperXP = GUICtrlCreateGroup(GetTranslated(700, 1, "Goblin XP"), $x - 20, $y - 20, 440, 305)
		$chkEnableSuperXP = GUICtrlCreateCheckbox(GetTranslated(700, 2, "Enable Goblin XP"), $x, $y, 102, 17)
		GUICtrlSetOnEvent(-1, "chkEnableSuperXP")
			$rbSXTraining = GUICtrlCreateRadio(GetTranslated(700, 3, "Farm XP during troops Training"), $x, $y + 23, 165, 17)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkEnableSuperXP2")
			$lblLOCKEDSX = GUICtrlCreateLabel(GetTranslated(700, 13, "LOCKED"), $x + 210, $y + 23, 173, 50)
			GUICtrlSetFont(-1, 30, 800, 0, "Arial")
			GUICtrlSetColor(-1, 0xFF0000)
			GUICtrlSetState(-1, $GUI_HIDE)
			$rbSXIAttacking = GUICtrlCreateRadio(GetTranslated(700, 4, "Farm XP instead of Attacking"), $x, $y + 46, 158, 17)
			GUICtrlCreateLabel (GetTranslated(700, 14, "Max XP to Gain") & ":", $x, $y + 69, -1, 17)
			GUICtrlSetOnEvent(-1, "chkEnableSuperXP2")
			$txtMaxXPtoGain = GUICtrlCreateInput("500", $x + 85, $y + 67, 70, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 8)
			GUICtrlSetOnEvent(-1, "chkEnableSuperXP2")
	$x += 129
	$y += 100
		GUICtrlCreateLabel(GetTranslated(700, 5, "Use"), $x - 35, $y + 13, 23, 17)
			GUICtrlCreateIcon($g_sLibIconPath, $eIcnKing, $x, $y, 32, 32)
			GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueen, $x + 40, $y, 32, 32)
			GUICtrlCreateIcon($g_sLibIconPath, $eIcnWarden, $x + 80, $y, 32, 32)
		GUICtrlCreateLabel(GetTranslated(700, 6, "to gain XP"), $x + 123, $y + 13, 53, 17)
	$x += 10
		$chkSXBK = GUICtrlCreateCheckbox("", $x, $y + 35, 17, 17)
		GUICtrlSetOnEvent(-1, "chkEnableSuperXP2")
		$chkSXAQ = GUICtrlCreateCheckbox("", $x + 40, $y + 35, 17, 17)
		GUICtrlSetOnEvent(-1, "chkEnableSuperXP2")
		$chkSXGW = GUICtrlCreateCheckbox("", $x + 80, $y + 35, 17, 17)
		GUICtrlSetOnEvent(-1, "chkEnableSuperXP2")

	$x = $xStart + 25
	$y += 73
		GUICtrlCreateLabel("", $x - 25, $y, 5, 19)
		GUICtrlSetBkColor (-1, 0xD8D8D8)
		$DocXP1 = GUICtrlCreateLabel(GetTranslated(700, 7, "XP at Start"), $x - 20, $y, 98, 19)
		GUICtrlSetBkColor (-1, 0xD8D8D8)
		$DocXP2 = GUICtrlCreateLabel(GetTranslated(700, 8, "Current XP"), $x + 63 + 15, $y, 104, 19)
		GUICtrlSetBkColor (-1, 0xD8D8D8)
		$DocXP3 = GUICtrlCreateLabel(GetTranslated(700, 9, "XP Won"), $x + 71 + 76 + 35, $y, 103, 19)
		GUICtrlSetBkColor (-1, 0xD8D8D8)
		$DocXP4 = GUICtrlCreateLabel(GetTranslated(700, 10, "XP Won/Hour"), $x + 69 + 55 + 110 + 45, $y, 87, 19)
		GUICtrlSetBkColor (-1, 0xD8D8D8)
		;GUICtrlCreateGroup("", $x - 28, $y - 7, 395, 29)
	$y += 15
			GUICtrlCreateLabel("", $x - 25, $y + 7, 5, 36)
			GUICtrlSetBkColor (-1, 0xbfdfff)
		$lblXPatStart = GUICtrlCreateLabel("0", $x - 20, $y + 7, 99, 36)
			GUICtrlSetFont(-1, 20, 800, 0, "Arial")
			GUICtrlSetBkColor (-1, 0xbfdfff)
		$lblXPCurrent = GUICtrlCreateLabel("0", $x + 78, $y + 7, 105, 36)
			GUICtrlSetFont(-1, 20, 800, 0, "Arial")
			GUICtrlSetBkColor (-1, 0xbfdfff)
		$lblXPSXWon = GUICtrlCreateLabel("0", $x + 182, $y + 7, 97, 36)
			GUICtrlSetFont(-1, 20, 800, 0, "Arial")
			GUICtrlSetBkColor (-1, 0xbfdfff)
		$lblXPSXWonHour = GUICtrlCreateLabel("0", $x + 279, $y + 7, 87, 36)
			GUICtrlSetFont(-1, 20, 800, 0, "Arial")
			GUICtrlSetBkColor (-1, 0xbfdfff)

	$x = $xStart
	$y += 57
		GUICtrlCreateLabel(GetTranslated(700, 11, "Goblin XP attack continuously the TH of Goblin Picnic to farm XP."), $x, $y, 312, 17)
		GUICtrlCreateLabel(GetTranslated(700, 12, "At each attack, you win 5 XP"), $x, $y + 20, 306, 17)

	chkEnableSuperXP()
#ce
	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc   ;==>GoblinXPGUI
