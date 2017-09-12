; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Profiles" tab under the "Bot" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: NguyenAnhHD (2017)
; Modified ......: Team AiO MOD++ (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_MOD_SWITCH = 0, $g_hGUI_MOD_SWITCH_TAB = 0, $g_hGUI_MOD_SWITCH_TAB_ITEM1 = 0, $g_hGUI_MOD_SWITCH_TAB_ITEM2 = 0

; Profiles & SwitchAccount
Global $g_hCmbProfile = 0, $g_hTxtVillageName = 0, $g_hBtnAddProfile = 0, $g_hBtnConfirmAddProfile = 0, $g_hBtnConfirmRenameProfile = 0, _
	   $g_hBtnDeleteProfile = 0, $g_hBtnCancelProfileChange = 0, $g_hBtnRenameProfile = 0, $g_hBtnRecycle = 0

; Switch Profiles
Global $g_hChkGoldSwitchMax = 0, $g_hCmbGoldMaxProfile = 0, $g_hTxtMaxGoldAmount = 0, $g_hChkGoldSwitchMin = 0, $g_hCmbGoldMinProfile = 0, $g_hTxtMinGoldAmount = 0, _
	   $g_hChkElixirSwitchMax = 0, $g_hCmbElixirMaxProfile = 0, $g_hTxtMaxElixirAmount = 0, $g_hChkElixirSwitchMin = 0, $g_hCmbElixirMinProfile = 0, $g_hTxtMinElixirAmount = 0, _
	   $g_hChkDESwitchMax = 0, $g_hCmbDEMaxProfile = 0, $g_hTxtMaxDEAmount = 0, $g_hChkDESwitchMin = 0, $g_hCmbDEMinProfile = 0, $g_hTxtMinDEAmount = 0, _
	   $g_hChkTrophySwitchMax = 0, $g_hCmbTrophyMaxProfile = 0, $g_hTxtMaxTrophyAmount = 0, $g_hChkTrophySwitchMin = 0, $g_hCmbTrophyMinProfile = 0, $g_hTxtMinTrophyAmount = 0

#include "MOD GUI Design - SwitchAcc.au3"

Func CreateModProfiles()

	$g_hGUI_MOD_SWITCH = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_MOD)

	GUISwitch($g_hGUI_MOD_SWITCH)
    $g_hGUI_MOD_SWITCH_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 30, $_GUI_MAIN_HEIGHT - 255 - 30, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
    $g_hGUI_MOD_SWITCH_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_06_STab_01_STab_01", "Switch Accounts"))
		CreateSwitchAccount()
	$g_hGUI_MOD_SWITCH_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_06_STab_01_STab_02", "Switch Profiles"))
		CreateModSwitchProfile()
	GUICtrlCreateTabItem("")

EndFunc

#Region Profiles Subtab
Func CreateSwitchAccount()
	Local $x = 22, $y = 45
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "Group_01", "Switch Profiles"), $x - 20, $y - 20, 435, 360)
		$x -= 5
		$g_hCmbProfile = GUICtrlCreateCombo("", $x - 3, $y + 1, 130, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "CmbProfile_Info_01", "Use this to switch to a different profile")& @CRLF & _
							   GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "CmbProfile_Info_02", "Your profiles can be found in") & ": " & @CRLF & $g_sProfilePath)
			setupProfileComboBox()
			PopulatePresetComboBox()
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetOnEvent(-1, "cmbProfile")
		$g_hTxtVillageName = GUICtrlCreateInput(GetTranslatedFileIni("MBR Popups", "MyVillage", "MyVillage"), $x - 3, $y, 130, 22, $ES_AUTOHSCROLL)
			GUICtrlSetLimit (-1, 100, 0)
			GUICtrlSetFont(-1, 9, 400, 1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "TxtVillageName_Info_01", "Your village/profile's name"))
			GUICtrlSetState(-1, $GUI_HIDE)

		Local $bIconAdd = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_4.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
		Local $bIconConfirm = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_4.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
		Local $bIconDelete = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_4.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
		Local $bIconCancel = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_4.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
		Local $bIconEdit = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_4.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")

		; IceCube (Misc v1.0)
		Local $bIconRecycle = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_2.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle_4.bmp")
			_GUIImageList_AddBitmap($bIconRecycle, @ScriptDir & "\images\Button\iconRecycle.bmp")
		; IceCube (Misc v1.0)

		$g_hBtnAddProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnAddProfile, $bIconAdd, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnAddProfile_Info_01", "Add New Profile"))
		$g_hBtnConfirmAddProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmAddProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnConfirmAddProfile_Info_01", "Confirm"))
		$g_hBtnConfirmRenameProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmRenameProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnConfirmAddProfile_Info_01", -1))
		$g_hBtnDeleteProfile = GUICtrlCreateButton("", $x + 164, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnDeleteProfile, $bIconDelete, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnDeleteProfile_Info_01", "Delete Profile"))
		$g_hBtnCancelProfileChange = GUICtrlCreateButton("", $x + 164, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnCancelProfileChange, $bIconCancel, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnCancelProfileChange_Info_01", "Cancel"))
		$g_hBtnRenameProfile = GUICtrlCreateButton("", $x + 194, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnRenameProfile, $bIconEdit, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnRenameProfile_Info_01", "Rename Profile"))

		; IceCube (Misc v1.0)
		$g_hBtnRecycle = GUICtrlCreateButton("", $x + 223, $y + 2, 22, 22)
			_GUICtrlButton_SetImageList($g_hBtnRecycle, $bIconRecycle, 4)
			GUICtrlSetOnEvent(-1, "btnRecycle")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "BtnRecycle_Info_01", "Recycle Profile by removing all settings no longer suported that could lead to bad behaviour"))
			If GUICtrlRead($g_hCmbProfile) = "<No Profiles>" Then
				GUICtrlSetState(-1, $GUI_DISABLE)
			Else
				GUICtrlSetState(-1, $GUI_ENABLE)
			EndIf
		; IceCube (Misc v1.0)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	CreateBotSwitchAcc()

EndFunc   ;==>CreateSwitchAccount
#EndRegion

#Region Profiles Subtab
Func CreateModSwitchProfile()
	Local $x = 25, $y = 45

	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Group_01", "Gold Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ;Gold Switch
		$g_hChkGoldSwitchMax = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkGoldSwitch", "Switch To"), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkGoldSwitch_Info_01", "Enable this to switch profiles when gold is above amount."))
		$g_hCmbGoldMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbGold", "Select which profile to be switched to when conditions met"))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_01", "When Gold is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxGoldAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtGold", "Set the amount of Gold to trigger switching Profile."))
			GUICtrlSetLimit(-1, 7)

	$y += 30
		$g_hChkGoldSwitchMin = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkGoldSwitch", -1), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkGoldSwitch_Info_02", "Enable this to switch profiles when gold is below amount."))
		$g_hCmbGoldMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbGold", -1))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_02", "When Gold is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinGoldAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtGold", -1))
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreatePic(@ScriptDir & "\Images\GoldStorage.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Group_02", "Elixir Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ; Elixir Switch
		$g_hChkElixirSwitchMax = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkElixirSwitch", "Switch To"), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkElixirSwitch_Info_01", "Enable this to switch profiles when Elixir is above amount."))

		$g_hCmbElixirMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbElixir", "Select which profile to be switched to when conditions met"))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_03", "When Elixir is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxElixirAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtElixir", "Set the amount of Elixir to trigger switching Profile."))
			GUICtrlSetLimit(-1, 7)
	$y += 30
		$g_hChkElixirSwitchMin = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkElixirSwitch", -1), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkElixirSwitch_Info_02", "Enable this to switch profiles when Elixir is below amount."))
		$g_hCmbElixirMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbElixir", -1))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_04", "When Elixir is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinElixirAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtElixir", -1))
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreatePic(@ScriptDir & "\Images\ElixirStorage.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Group_03", "Dark Elixir Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ;DE Switch
		$g_hChkDESwitchMax = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkDESwitch", "Switch To"), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkDESwitch_Info_01", "Enable this to switch profiles when Dark Elixir is above amount."))
		$g_hCmbDEMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbDE", "Select which profile to be switched to when conditions met"))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_05", "When Dark Elixir is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxDEAmount = GUICtrlCreateInput("200000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtDE", "Set the amount of Dark Elixir to trigger switching Profile."))
			GUICtrlSetLimit(-1, 6)
	$y += 30
		$g_hChkDESwitchMin = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkDESwitch", -1), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkDESwitch_Info_02", "Enable this to switch profiles when Dark Elixir is below amount."))
		$g_hCmbDEMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbDE", -1))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_06", "When Dark Elixir is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinDEAmount = GUICtrlCreateInput("10000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtDE", -1))
			GUICtrlSetLimit(-1, 6)
		GUICtrlCreatePic(@ScriptDir & "\Images\DEStorage.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Group_04", "Trophy Switch Profile Conditions"), $x - 20, $y - 20, 430, 75) ; Trophy Switch
		$g_hChkTrophySwitchMax = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkTrophySwitch", "Switch To"), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkTrophySwitch_Info_01", "Enable this to switch profiles when Trophies are above amount."))
		$g_hCmbTrophyMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbTrophy", "Select which profile to be switched to when conditions met"))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_07", "When Trophies are Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxTrophyAmount = GUICtrlCreateInput("3000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtTrophy", "Set the amount of Trophies to trigger switching Profile."))
			GUICtrlSetLimit(-1, 4)
	$y += 30
		$g_hChkTrophySwitchMin = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkTrophySwitch", -1), $x - 10, $y - 2, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "ChkTrophySwitch_Info_02", "Enable this to switch profiles when Trophies are below amount."))
		$g_hCmbTrophyMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "CmbTrophy", -1))
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "Label_08", "When Trophies are Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinTrophyAmount = GUICtrlCreateInput("1000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - Switch Profiles", "TxtTrophy", -1))
			GUICtrlSetLimit(-1, 4)
		GUICtrlCreatePic(@ScriptDir & "\Images\TrophyLeague.jpg", $x + 340, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
		setupProfileComboBoxswitch()
EndFunc   ;==>CreateModSwitchProfile
#EndRegion
