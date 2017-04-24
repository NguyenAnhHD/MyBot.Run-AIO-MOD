; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "MOD" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: NguyenAnhHD, Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_MOD = 0
Global $g_hGUI_MOD_TAB = 0, $g_hGUI_MOD_TAB_ITEM1 = 0 , $g_hGUI_MOD_TAB_ITEM2 = 0 ,$g_hGUI_MOD_TAB_ITEM3 = 0, $g_hGUI_MOD_TAB_ITEM4 = 0, $g_hGUI_MOD_TAB_ITEM5 = 0

; CoC Stats
Global $g_hChkCoCStats = 0, $g_hTxtAPIKey = 0

#include "MOD GUI Design - Profiles.au3"
#include "MOD GUI Design - ProfileStats.au3"

Func CreateMODTab()

	$g_hGUI_MOD = GUICreate("", $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, $_GUI_CHILD_LEFT, $_GUI_CHILD_TOP, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hFrmBotEx)

	GUISwitch($g_hGUI_MOD)
	$g_hGUI_MOD_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
		$g_hGUI_MOD_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslated(600, 58, "Misc MOD"))
			OptionsGUI()
		$g_hGUI_MOD_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslated(600, 59, "Switch Account"))
			CreateSwitchAccount()
		$g_hGUI_MOD_TAB_ITEM3 = GUICtrlCreateTabItem(GetTranslated(600, 60, "Switch Profile"))
			CreateModSwitchProfile()
		$g_hGUI_MOD_TAB_ITEM4 = GUICtrlCreateTabItem(GetTranslated(600, 61, "Profile Stat's")) ; Has to be outside of the Last Control to hide
			$g_hLastControlToHide = GUICtrlCreateDummy()
			ReDim $g_aiControlPrevState[$g_hLastControlToHide + 1]
			CreateProfileStats()
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

EndFunc   ;==>TreasuryGUI
