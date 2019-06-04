; #FUNCTION# ====================================================================================================================
; Name ..........: MOD GUI Design - BuilderBase-Attack
; Description ...: Design sub gui for BuilderBase tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Chilly-Chill (2019)
; Modified ......: Team AiO MOD++ (2019)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_BBDropOrder = 0
Global $g_hChkEnableBBAttack = 0
Global $g_hBtnBBDropOrder = 0, $g_hChkBBTrophyRange = 0, $g_hTxtBBTrophyLowerLimit = 0, $g_hTxtBBTrophyUpperLimit = 0, $g_hChkBBAttIfLootAvail = 0, $g_hChkBBWaitForMachine = 0
Global $g_hCmbBBNextTroopDelay = 0, $g_hCmbBBSameTroopDelay = 0, $g_hLblBBNextTroopDelay = 0, $g_hLblBBSameTroopDelay = 0

Global $g_hChkBBCustomDropOrderEnable = 0
Global $g_ahCmbBBDropOrder[$g_iBBTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_hBtnBBDropOrderSet = 0, $g_hBtnBBRemoveDropOrder = 0, $g_hBtnBBClose = 0

Func CreateBBAttackGUI()
	Local $x = 15, $y = 115
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "Group_01", "Builders Base Attacking"), $x - 10, $y - 20, $g_iSizeWGrpTab3, 100)
		$g_hChkEnableBBAttack = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkEnableBBAttack", "Attack"), $x + 20, $y, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkEnableBBAttack_Info_01", "Uses the currently queued army to attack."))
			GUICtrlSetOnEvent(-1, "chkEnableBBAttack")
		$g_hBtnBBDropOrder = GUICtrlCreateButton(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBDropOrder", "Drop Order"), $x + 10, $y + 30, 65, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBDropOrder_Info", "Set a custom dropping order for your troops."))
			GUICtrlSetBkColor(-1, $COLOR_RED)
			GUICtrlSetOnEvent(-1, "btnBBDropOrder")

	$x += 90
		$g_hLblBBNextTroopDelay = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "LblBBNextTroopDelay", "Next Troop Delay"), $x, $y + 20, -1, -1)
		$g_hCmbBBNextTroopDelay = GUICtrlCreateCombo("", $x + 100, $y + 17, 30, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "CmbBBNextTroopDelay_Info_01", "Set the delay between different troops. 1 fastest to 9 slowest."))
			GUICtrlSetOnEvent(-1, "cmbBBNextTroopDelay")
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9")
			_GUICtrlComboBox_SetCurSel($g_hCmbBBNextTroopDelay, 4) ; start in middle
		$g_hLblBBSameTroopDelay = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "LblBBSameTroopDelay", "Same Troop Delay"), $x, $y + 50, -1, -1)
		$g_hCmbBBSameTroopDelay = GUICtrlCreateCombo("", $x + 100, $y + 47, 30, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "CmbBBSameTroopDelay_Info_01", "Set the delay between same troops. 1 fastest to 9 slowest."))
			GUICtrlSetOnEvent(-1, "cmbBBSameTroopDelay")
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9")
			_GUICtrlComboBox_SetCurSel($g_hCmbBBSameTroopDelay, 4) ; start in middle

	$x += 160
		$g_hChkBBTrophyRange = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkBBTrophyRange", "Trophies:"), $x, $y, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkBBTrophyRange_Info_01", "Enable ability to set a trophy range."))
			GUICtrlSetOnEvent(-1, "chkBBTrophyRange")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hTxtBBTrophyLowerLimit = GUICtrlCreateInput($g_iTxtBBTrophyLowerLimit, $x + 70, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "TxtBBTrophyLimit_Info_01", "If your trophies go below this number then attacking is stopped."))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hTxtBBTrophyUpperLimit = GUICtrlCreateInput($g_iTxtBBTrophyUpperLimit, $x + 120, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "TxtBBTrophyLimit_Info_02", "If your trophies go above this number then the bot drops trophies"))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hChkBBAttIfLootAvail = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkBBAttIfLootAvail", "Only if loot is available"), $x, $y + 25, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkBBAttIfLootAvail_Info_01", "Only attack if there is loot available."))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hChkBBWaitForMachine = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkBBWaitForMachine", "Wait For Battle Machine"), $x, $y + 50, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "ChkBBWaitForMachine_Info_01", "Makes the bot not attack while Machine is down."))

	GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc

Func CreateBBDropOrderGUI()
	$g_hGUI_BBDropOrder = _GUICreate(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "GUI_BBDropOrder", "BB Custom Drop Order"), 322, 288, -1, -1, $WS_BORDER, $WS_EX_CONTROLPARENT)

	Local $x = 25, $y = 25
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "Group_02", "BB Custom Dropping Order"), $x - 20, $y - 20, 308, 225)
	$x += 10
	$y += 20
		$g_hChkBBCustomDropOrderEnable = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BBChkCustomDropOrderEnable", "Enable Custom Dropping Order"), $x - 13, $y - 22, -1, -1)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BBChkCustomDropOrderEnable_Info_01", "Enable to select a custom troops dropping order"))
			GUICtrlSetOnEvent(-1, "chkBBDropOrder")

	$y += 5
		For $i = 0 To $g_iBBTroopCount-1
			If $i < 5 Then
				GUICtrlCreateLabel($i + 1 & ":", $x - 19, $y + 3 + 25*$i, -1, 18)
				$g_ahCmbBBDropOrder[$i] = GUICtrlCreateCombo("", $x, $y + 25*$i, 94, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					GUICtrlSetOnEvent(-1, "GUIBBDropOrder")
					GUICtrlSetData(-1,  $g_sBBDropOrderDefault)
					_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "TxtBBDropOrder", "Enter sequence order for drop of troop #" & $i + 1))
					GUICtrlSetState(-1, $GUI_DISABLE)
			Else
				GUICtrlCreateLabel($i + 1 & ":", $x + 150 - 19, $y + 3 + 25*($i-5), -1, 18)
				$g_ahCmbBBDropOrder[$i] = GUICtrlCreateCombo("", $x+150, $y + 25*($i-5), 94, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					GUICtrlSetOnEvent(-1, "GUIBBDropOrder")
					GUICtrlSetData(-1,  $g_sBBDropOrderDefault)
					_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "TxtBBDropOrder", "Enter sequence order for drop of troop #" & $i + 1))
					GUICtrlSetState(-1, $GUI_DISABLE)
			EndIf
		Next

	$x = 25
	$y = 200
		; Create push button to set training order once completed
		$g_hBtnBBDropOrderSet = GUICtrlCreateButton(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBDropOrderSet", "Apply New Order"), $x, $y, 100, 25)
			GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_DISABLE))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBDropOrderSet_Info_01", "Push button when finished selecting custom troops dropping order") & @CRLF & _
							   GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBDropOrderSet_Info_02", "When not all troop slots are filled, will use default order."))
			GUICtrlSetOnEvent(-1, "btnBBDropOrderSet")

	$x += 150
		$g_hBtnBBRemoveDropOrder = GUICtrlCreateButton(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBRemoveDropOrder", "Empty Drop List"), $x, $y, 118, 25)
			GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_DISABLE))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBRemoveDropOrder_Info_01", "Push button to remove all troops from list and start over"))
			GUICtrlSetOnEvent(-1, "btnBBRemoveDropOrder")

		$g_hBtnBBClose = GUICtrlCreateButton(GetTranslatedFileIni("MOD GUI Design Child Village - Misc", "BtnBBDropOrderClose", "Close"), 229, 233, 85, 25)
			GUICtrlSetOnEvent(-1, "CloseCustomBBDropOrder")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc
