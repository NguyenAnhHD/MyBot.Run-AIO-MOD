; #FUNCTION# ====================================================================================================================
; Name ..........: applyConfig.au3
; Description ...: Applies all of the  variable to the GUI
; Syntax ........: applyConfig()
; Parameters ....: $bRedrawAtExit = True, redraws bot window after config was applied
; Return values .: NA
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ApplyConfig_MOD($TypeReadSave)
	; <><><> Team AiO MOD++ (2018) <><><>
	Switch $TypeReadSave
		Case "Read"
			; Classic Four Finger - Team AiO MOD++
			cmbStandardDropSidesAB()
			cmbStandardDropSidesDB()

			; CSV Deploy Speed - Team AiO MOD++
			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$LB], $icmbCSVSpeed[$LB])
			_GUICtrlComboBox_SetCurSel($cmbCSVSpeed[$DB], $icmbCSVSpeed[$DB])

			; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
			GUICtrlSetState($g_hChkEnableAuto, $g_bEnableAuto = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableAuto()
			If $g_bChkAutoDock Then
				GUICtrlSetState($g_hChkAutoDock, $GUI_CHECKED)
				GUICtrlSetState($g_hChkAutoHideEmulator, $GUI_UNCHECKED)
			ElseIf $g_bChkAutoHideEmulator Then
				GUICtrlSetState($g_hChkAutoHideEmulator, $GUI_CHECKED)
				GUICtrlSetState($g_hChkAutoDock, $GUI_UNCHECKED)
			EndIf
			btnEnableAuto()
			GUICtrlSetState($g_hChkAutoMinimizeBot, $g_bChkAutoMinimizeBot = True ? $GUI_CHECKED : $GUI_UNCHECKED)

			; Max logout time - Team AiO MOD++
			GUICtrlSetState($g_hChkTrainLogoutMaxTime, $g_bTrainLogoutMaxTime = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkTrainLogoutMaxTime()
			GUICtrlSetData($g_hTxtTrainLogoutMaxTime, $g_iTrainLogoutMaxTime)

			; Restart Search Legend league - Team AiO MOD++
			GUICtrlSetState($g_hChkSearchTimeout, $g_bIsSearchTimeout = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtSearchTimeout, $g_iSearchTimeout)
			chkSearchTimeout()

			; ClanHop - Team AiO MOD++
			GUICtrlSetState($g_hChkClanHop, $g_bChkClanHop = True ? $GUI_CHECKED : $GUI_UNCHECKED)

		Case "Save"
			; CSV Deploy Speed - Team AiO MOD++
			$icmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$LB])
			$icmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$DB])

			; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
			$g_bEnableAuto = (GUICtrlRead($g_hChkEnableAuto) = $GUI_CHECKED)
			$g_bChkAutoDock = (GUICtrlRead($g_hChkAutoDock) = $GUI_CHECKED)
			$g_bChkAutoHideEmulator = (GUICtrlRead($g_hChkAutoHideEmulator) = $GUI_CHECKED)
			$g_bChkAutoMinimizeBot = (GUICtrlRead($g_hChkAutoMinimizeBot) = $GUI_CHECKED)

			; Max logout time - Team AiO MOD++
			$g_bTrainLogoutMaxTime = (GUICtrlRead($g_hChkTrainLogoutMaxTime) = $GUI_CHECKED)
			$g_iTrainLogoutMaxTime = GUICtrlRead($g_hTxtTrainLogoutMaxTime)

			; Restart Search Legend league - Team AiO MOD++
			$g_bIsSearchTimeout = (GUICtrlRead($g_hChkSearchTimeout) = $GUI_CHECKED)
			$g_iSearchTimeout = GUICtrlRead($g_hTxtSearchTimeout)

			; ClanHop - Team AiO MOD++
			$g_bChkClanHop = (GUICtrlRead($g_hChkClanHop) = $GUI_CHECKED)

	EndSwitch
EndFunc   ;==>ApplyConfig_MOD
