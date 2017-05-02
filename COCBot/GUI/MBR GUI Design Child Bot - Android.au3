; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Bot Android
; Description ...: This file creates the "Android" tab under the "Bot" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hCmbCOCDistributors

Func CreateBotAndroid()
   $4 = GUICtrlCreatePic(@ScriptDir & '\COCBot\MOD_Team++AIO\Images\1.jpg', 2, 23, 442, 410, $WS_CLIPCHILDREN)
   Local $x = 25, $y = 45
   GUICtrlCreateGroup(GetTranslated(642, 1, "Distributors"), $x - 20, $y - 20, 438, 50)
	   $y -=2
	   $g_hCmbCOCDistributors = GUICtrlCreateCombo("", $x - 8 , $y, 185, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	   _GUICtrlSetTip(-1, GetTranslated(642, 2, "Allow bot to launch COC based on the distribution chosen"))
	   LoadCOCDistributorsComboBox()
	   SetCurSelCmbCOCDistributors()
	   GUICtrlSetOnEvent(-1, "cmbCOCDistributors")
   GUICtrlCreateGroup("", -99, -99, 1, 1)
   ; Android Settings (LunaEclipse)- modification (rulesss,kychera)
    Local $x = 25, $y = 95
	GUICtrlCreateGroup(GetTranslated(91,2,"Android Options"), $x - 20, $y - 20, 438, 50)
		$CmbAndroid = GUICtrlCreateCombo("", $x - 10, $y - 5, 130, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip($CmbAndroid, GetTranslated(91,3,"Use this to select the Android Emulator to use with this profile."))
			setupAndroidComboBox()
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetOnEvent(-1, "CmbAndroid")
		$LblAndroidInstance = GUICtrlCreateLabel(GetTranslated(91,4,"Instance:"), $x + 130, $y - 2 , 60, 21, $SS_RIGHT)
		$TxtAndroidInstance = GUICtrlCreateInput("", $x + 200, $y - 5, 210, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip($TxtAndroidInstance, GetTranslated(91,5,"Enter the Instance to use with this profile."))
			GUICtrlSetOnEvent(-1, "TxtAndroidInstance")
			
EndFunc

