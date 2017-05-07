; #FUNCTION# ====================================================================================================================
; Name ..........: GUI Control DropOrderTpoops
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: Kychera 05/2017
; Modified ......: Team AiO & RK MOD++ (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func chkTroopDropOrder()
	If GUICtrlRead($g_hChkCustomTrainDropOrderEnable) = $GUI_CHECKED Then
		$g_bCustomTrainDropOrderEnable = True
		GUICtrlSetState($g_hBtnTroopOrderSet2, $GUI_ENABLE)
		GUICtrlSetState($g_hBtnRemoveTroops2, $GUI_ENABLE)
		For $i = 0 To UBound($cmbDropTroops) - 1
			GUICtrlSetState($cmbDropTroops[$i], $GUI_ENABLE)
		Next
		If IsUseCustomTroopOrder2() = True Then GUICtrlSetImage($g_ahImgTroopOrderSet, $g_sLibIconPath, $eIcnRedLight)
	Else
		$g_bCustomTrainDropOrderEnable = False
		GUICtrlSetState($g_hBtnTroopOrderSet2, $GUI_DISABLE) ; disable button
		GUICtrlSetState($g_hBtnRemoveTroops2, $GUI_DISABLE)
		For $i = 0 To UBound($cmbDropTroops) - 1
			GUICtrlSetState($cmbDropTroops[$i], $GUI_DISABLE) ; disable combo boxes
		Next
		;SetDefaultTroopGroup($bNoiseMode) ; Reset troopgroup values to default
		If $g_iDebugSetlogTrain = 1 Then
			Local $sNewDropList = ""
			For $i = 0 To $eTroopCountDrop - 1
				$sNewDropList &= $g_asTroopNamesPluralDrop[$icmbDropTroops[$i]] & ", "
			Next
			$sNewDropList = StringTrimRight($sNewDropList, 2)
			Setlog("Current drop order= " & $sNewDropList, $COLOR_BLUE)
		EndIf
	EndIf
EndFunc   ;==>chkTroopDropOrder


Func GUITrainOrder2()
	Local $bDuplicate = False
	Local $iGUI_CtrlId = @GUI_CtrlId
	Local $iCtrlIdImage = $iGUI_CtrlId + 1 ; record control ID for $g_ahImgTroopOrder[$z] based on control of combobox that called this function
	Local $iTroopIndex = _GUICtrlComboBox_GetCurSel($iGUI_CtrlId) + 1 ; find zero based index number of troop selected in combo box, add one for enum of proper icon

	GUICtrlSetImage($iCtrlIdImage, $g_sLibIconPath, $g_aiTroopOrderDropIcon[$iTroopIndex]) ; set proper troop icon

	For $i = 0 To UBound($cmbDropTroops) - 1 ; check for duplicate combobox index and flag problem
		If $iGUI_CtrlId = $cmbDropTroops[$i] Then ContinueLoop
		If _GUICtrlComboBox_GetCurSel($iGUI_CtrlId) = _GUICtrlComboBox_GetCurSel($cmbDropTroops[$i]) Then
			GUICtrlSetImage($g_ahImgTroopDropOrder[$i], $g_sLibIconPath, $eIcnOptions)
			_GUICtrlComboBox_SetCurSel($cmbDropTroops[$i], -1)
			GUISetState()
			$bDuplicate = True
		EndIf
	Next
	If $bDuplicate Then
		GUICtrlSetState($g_hBtnTroopOrderSet2, $GUI_ENABLE) ; enable button to apply new order
		Return
	Else
		GUICtrlSetState($g_hBtnTroopOrderSet2, $GUI_ENABLE) ; enable button to apply new order
		GUICtrlSetImage($g_ahImgTroopOrderSet, $g_sLibIconPath, $eIcnRedLight) ; set status indicator to show need to apply new order
	EndIf
EndFunc   ;==>GUITrainOrder2

Func BtnRemoveTroops2()
	Local $bWasRedraw = SetRedrawBotWindow(False, Default, Default, Default, "BtnRemoveTroops2")
	Local $sComboData = ""
	  For $j = 0 To UBound($g_asTroopDropList) - 1
		  $sComboData &= $g_asTroopDropList[$j] & "|"
	  Next
	For $i = $eTroopBarbarian To $eTroopCountDrop - 1
		$icmbDropTroops[$i] = -1
		_GUICtrlComboBox_ResetContent ($icmbDropTroops[$i])
		GUICtrlSetData($cmbDropTroops[$i], $sComboData, "")
		GUICtrlSetImage($g_ahImgTroopDropOrder[$i], $g_sLibIconPath, $eIcnOptions)
	Next
	GUICtrlSetImage($g_ahImgTroopDropOrderSet, $g_sLibIconPath, $eIcnSilverStar)
	SetDefaultTroopGroup(False)
	SetRedrawBotWindow($bWasRedraw, Default, Default, Default, "BtnRemoveTroops2")
EndFunc   ;==>BtnRemoveTroops2

Func BtnTroopOrderSet2()
	Local $bWasRedraw = SetRedrawBotWindow(False, Default, Default, Default, "BtnTroopOrderSet2")
	Local $bReady = True ; Initialize ready to record troop order flag
	Local $sNewDropList = ""

	Local $bMissingTroop = False ; flag for when troops are not assigned by user
	Local $aiUsedTroop[$eTroopCountDrop] = [ _
		$eTroopBarbarian, $eTroopArcher, $eTroopGiant, $eTroopGoblin, $eTroopWallBreaker, $eTroopBalloon, $eTroopWizard, _
		$eTroopHealer, $eTroopDragon, $eTroopPekka, $eTroopBabyDragon, $eTroopMiner, $eTroopMinion, $eTroopHogRider, _
		$eTroopValkyrie, $eTroopGolem, $eTroopWitch, $eTroopLavaHound, $eTroopBowler, -1, -1]

	; check for duplicate combobox index and take action
	For $i = 0 To UBound($cmbDropTroops) - 1
		For $j = 0 To UBound($cmbDropTroops) - 1
			If $i = $j Then ContinueLoop ; skip if index are same
			If _GUICtrlComboBox_GetCurSel($cmbDropTroops[$i]) <> -1 And _
					_GUICtrlComboBox_GetCurSel($cmbDropTroops[$i]) = _GUICtrlComboBox_GetCurSel($cmbDropTroops[$j]) Then
				_GUICtrlComboBox_SetCurSel($cmbDropTroops[$j], -1)
				GUICtrlSetImage($g_ahImgTroopDropOrder[$j], $g_sLibIconPath, $eIcnOptions)
				$bReady = False
			Else
				GUICtrlSetColor($cmbDropTroops[$j], $COLOR_BLACK)
			EndIf
		Next
		; update combo array variable with new value
		$icmbDropTroops[$i] = _GUICtrlComboBox_GetCurSel($cmbDropTroops[$i])
		If $icmbDropTroops[$i] = -1 Then $bMissingTroop = True ; check if combo box slot that is not assigned a troop
	Next

	; Automatic random fill missing troops
	If $bReady And $bMissingTroop Then
		; 1st update $aiUsedTroop array with troops not used in $g_aiCmbCustomTrainOrder
		For $i = 0 To UBound($icmbDropTroops) - 1
			For $j = 0 To UBound($aiUsedTroop) - 1
				If $icmbDropTroops[$i] = $j Then
					$aiUsedTroop[$j] = -1 ; if troop is used, replace enum value with -1
					ExitLoop
				EndIf
			Next
		Next
		_ArrayShuffle($aiUsedTroop) ; make missing training order assignment random
		For $i = 0 To UBound($icmbDropTroops) - 1
			If $icmbDropTroops[$i] = -1 Then ; check if custom order index is not set
				For $j = 0 To UBound($aiUsedTroop) - 1
					If $aiUsedTroop[$j] <> -1 Then ; loop till find a valid troop enum
						$icmbDropTroops[$i] = $aiUsedTroop[$j] ; assign unused troop
						_GUICtrlComboBox_SetCurSel($cmbDropTroops[$i], $aiUsedTroop[$j])
						GUICtrlSetImage($g_ahImgTroopDropOrder[$i], $g_sLibIconPath, $g_aiTroopOrderDropIcon[$icmbDropTroops[$i] + 1])
						$aiUsedTroop[$j] = -1 ; remove unused troop from array
						ExitLoop
					EndIf
				Next
			EndIf
		Next
	EndIf

	If $bReady Then
		ChangeTroopTrainOrder2() ; code function to record new training order

		If @error Then
			Switch @error
				Case 1
					Setlog("Code problem, can not continue till fixed!", $COLOR_ERROR)
				Case 2
					Setlog("Bad Combobox selections, please fix!", $COLOR_ERROR)
				Case 3
					Setlog("Unable to Change Troop Drop Order due bad change count!", $COLOR_ERROR)
				Case Else
					Setlog("Monkey ate bad banana, something wrong with ChangeTroopTrainOrder() code!", $COLOR_ERROR)
			EndSwitch
			GUICtrlSetImage($g_ahImgTroopDropOrderSet, $g_sLibIconPath, $eIcnRedLight)
		Else
		Setlog("Troop droping order changed successfully!", $COLOR_SUCCESS)
			For $i = 0 To $eTroopCountDrop - 1
				$sNewDropList &= $g_asTroopNamesPluralDrop[$icmbDropTroops[$i]] & ", "
			Next
			$sNewDropList = StringTrimRight($sNewDropList, 2)
			Setlog("Troop drop order= " & $sNewDropList, $COLOR_INFO)

		EndIf
	Else
		Setlog("Must use all troops and No duplicate troop names!", $COLOR_ERROR)
		GUICtrlSetImage($g_ahImgTroopDropOrderSet, $g_sLibIconPath, $eIcnRedLight)
	EndIf
	GUICtrlSetState($g_hBtnTroopOrderSet2, $GUI_DISABLE)
	SetRedrawBotWindow($bWasRedraw, Default, Default, Default, "BtnTroopOrderSet2")
EndFunc   ;==>BtnTroopOrderSet2

Func IsUseCustomTroopOrder2()
	For $i = 0 To UBound($icmbDropTroops) - 1 ; Check if custom train order has been used, to select log message
		If $icmbDropTroops[$i] = -1 Then
			If $g_iDebugSetlogTrain = 1 Then Setlog("Custom drop order not used...", $COLOR_DEBUG) ;Debug
			Return False
		EndIf
	Next
	If $g_iDebugSetlogTrain = 1 Then Setlog("Custom drop order used...", $COLOR_DEBUG) ;Debug
	Return True
EndFunc   ;==>IsUseCustomTroopOrder2

Func ChangeTroopTrainOrder2()

	If $g_iDebugSetlog = 1 Or $g_iDebugSetlogTrain = 1 Then Setlog("Begin Func ChangeTroopTrainOrder2()", $COLOR_DEBUG) ;Debug

	Local $NewTroopDrop[$eTroopCountDrop]
	Local $iUpdateCount = 0

	If Not IsUseCustomTroopOrder2() Then ; check if no custom troop values saved yet.
		SetError(2, 0, False)
		Return
	EndIf

	; Look for match of combobox text to troopgroup and create new train order
	For $i = 0 To UBound($cmbDropTroops) - 1
		Local $sComboText = GUICtrlRead($cmbDropTroops[$i])
		For $j = 0 To UBound($g_asTroopDropList) - 1
			If $sComboText = $g_asTroopDropList[$j] Then
				$NewTroopDrop[$i] = $j - 1
				$iUpdateCount += 1
				ExitLoop
			EndIf
		Next
	Next

	If $iUpdateCount = $eTroopCountDrop Then ; safety check that all troops properly assigned to new array.
		For $i = 0 To $eTroopCountDrop - 1
			$icmbDropTroops[$i] = $NewTroopDrop[$i]
		Next
		GUICtrlSetImage($g_ahImgTroopDropOrderSet, $g_sLibIconPath, $eIcnGreenLight)
	Else
		Setlog($iUpdateCount & "|" & $eTroopCountDrop & " - Error - Bad troop assignment in ChangeTroopTrainOrder2()", $COLOR_ERROR)
		;SetError(3, 0, False)
		Return
	EndIf

	Return True
EndFunc   ;==>ChangeTroopTrainOrder2