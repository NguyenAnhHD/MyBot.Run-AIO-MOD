; #FUNCTION# ====================================================================================================================
; Name ..........: GUI Design _ CheckTroopsCC
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: NguyenAnhHD, DEMEN
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $g_hLblCastleCapacity = 0, $g_hCmbCCTroopCapacity = 0, $g_hCmbCCSpellCapacity = 0, $g_hLblCCSpellCap = 0, $g_hChkTroopsCC = 0, $g_hLblWarningTextCheckCC = 0
Global $g_ahPicCheckTroops[3] = [0, 0, 0], $g_ahCmbCheckTroops[3] = [0, 0, 0], $g_ahTxtCheckTroops[3] = [0, 0, 0]
Global $g_ahPicCheckSpells[2] = [0, 0], $g_ahCmbCheckSpells[2] = [0, 0], $g_ahTxtCheckSpells[2] = [0, 0]
Global $g_hGrpSpellsToHide = 0 ; Standby for CheckCC Spells

Local $sTroopText = _ArrayToString($g_asTroopNames)
$sTroopText &= "|Any"

Local $asDonSpell = $g_asSpellNames
_ArrayDelete($asDonSpell, 5) ; removing "Clone" as it does not fit for CC slots.
Local $sSpellText = _ArrayToString($asDonSpell)
$sSpellText &= "|Any"

Global $g_aiTroopsIcons[20] = [$eIcnDonBarbarian, $eIcnDonArcher, $eIcnDonGiant, $eIcnDonGoblin, $eIcnDonWallBreaker, $eIcnDonBalloon, $eIcnDonWizard, $eIcnDonHealer, _
		$eIcnDonDragon, $eIcnDonPekka, $eIcnDonBabyDragon, $eIcnDonMiner, $eIcnDonMinion, $eIcnDonHogRider, $eIcnDonValkyrie, $eIcnDonGolem, _
		$eIcnDonWitch, $eIcnDonLavaHound, $eIcnDonBowler, $eIcnDonBlank]

Global $g_aiSpellsIcons[10] = [$eIcnLightSpell, $eIcnHealSpell, $eIcnRageSpell, $eIcnJumpSpell, $eIcnFreezeSpell, _
		$eIcnDonPoisonSpell, $eIcnDonEarthQuakeSpell, $eIcnDonHasteSpell, $eIcnDonSkeletonSpell, $eIcnDonBlank]

Func cmbCheckTroopsCC()
	Local $Combo1 = _GUICtrlComboBox_GetCurSel($g_ahCmbCheckTroops[0])
	Local $Combo2 = _GUICtrlComboBox_GetCurSel($g_ahCmbCheckTroops[1])
	Local $Combo3 = _GUICtrlComboBox_GetCurSel($g_ahCmbCheckTroops[2])
	_GUICtrlSetImage($g_ahPicCheckTroops[0], $g_sLibIconPath, $g_aiTroopsIcons[$Combo1])
	_GUICtrlSetImage($g_ahPicCheckTroops[1], $g_sLibIconPath, $g_aiTroopsIcons[$Combo2])
	_GUICtrlSetImage($g_ahPicCheckTroops[2], $g_sLibIconPath, $g_aiTroopsIcons[$Combo3])
	cmbCheckCC()
EndFunc   ;==>cmbCheckTroopsCC

Func cmbCheckSpellsCC()
	Local $Combo4 = _GUICtrlComboBox_GetCurSel($g_ahCmbCheckSpells[0])
	Local $Combo5 = _GUICtrlComboBox_GetCurSel($g_ahCmbCheckSpells[1])
	_GUICtrlSetImage($g_ahPicCheckSpells[0], $g_sLibIconPath, $g_aiSpellsIcons[$Combo4])
	_GUICtrlSetImage($g_ahPicCheckSpells[1], $g_sLibIconPath, $g_aiSpellsIcons[$Combo5])
EndFunc   ;==>cmbCheckSpellsCC

Func cmbCheckCC()
	Local $sWarningTxt, $color
	If GUICtrlRead($g_hChkTroopsCC) = $GUI_CHECKED Then
		Local $iTotalSlotTroop = 0, $iTotalSlotSpell = 0
		Local $iCastleCap = 10 + _GUICtrlComboBox_GetCurSel($g_hCmbCCTroopCapacity) * 5
		Local $bAny = True
		For $i = 0 To 2
			Local $TroopIdx = _GUICtrlComboBox_GetCurSel($g_ahCmbCheckTroops[$i])
			Local $TroopQty = GUICtrlRead($g_ahTxtCheckTroops[$i])
			If $TroopIdx <= $eTroopBowler Then
				$iTotalSlotTroop += $TroopQty * $g_aiTroopSpace[$TroopIdx]
				$bAny = False
			EndIf
;~ 			If $i = 2 Then ExitLoop
;~ 			Local $SpellIdx = _GUICtrlComboBox_GetCurSel($g_ahCmbCheckSpells[$i])
;~ 			If $SpellIdx > $eSpellFreeze Then $SpellIdx += 1 ; exclude Clone Spell
;~ 			Local $SpellQty = GUICtrlRead($g_ahTxtCheckSpells[$i])
;~ 			If $SpellIdx <= $eSpellSkeleton Then $iTotalSlotSpell += $SpellQty * $g_aiSpellSpace[$SpellIdx]
		Next

		If $bAny = False Then
			If $iTotalSlotTroop < $iCastleCap Then
				$sWarningTxt = GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "WarningText_Info_01", "Troop expectation is less than Castle capacity (") & $iTotalSlotTroop & "/" & $iCastleCap & ")." & @CRLF & _
							   GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "WarningText_Info_02", "WARNING: Your CC will never be full.")
				$color = $COLOR_RED
			ElseIf $iTotalSlotTroop > $iCastleCap Then
				$sWarningTxt = GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "WarningText_Info_03", "Troop expectation is more than Castle capacity (") & $iTotalSlotTroop & "/" & $iCastleCap & ")."
				$color = $COLOR_ORANGE
			Else
				$sWarningTxt = GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "WarningText_Info_04", "Troop expectation fits your Castle capacity nicely (") & $iTotalSlotTroop & "/" & $iCastleCap & ")."
				$color = $COLOR_GREEN
			EndIf
			GUICtrlSetData($g_hLblWarningTextCheckCC, $sWarningTxt)
			GUICtrlSetColor($g_hLblWarningTextCheckCC, $color)
		EndIf
	Else
		$sWarningTxt = GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "WarningText", -1)
		$color = $COLOR_BLACK
		GUICtrlSetData($g_hLblWarningTextCheckCC, $sWarningTxt)
		GUICtrlSetColor($g_hLblWarningTextCheckCC, $color)
	EndIf

EndFunc   ;==>cmbCheckCC

Func CreateGUICheckCC()
	Local $x = 100, $y = 80
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "Group", "CC Troops expectation"), $x, $y, 320, 200)
		$y += 25
		$x += 5

		$g_hLblCastleCapacity = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "CastleCapacity", "Castle Capacity") & ": ", $x + 5, $y, -1, -1)
		$g_hCmbCCTroopCapacity = GUICtrlCreateCombo("", $x + 85, $y - 2, 35, 25)
			GUICtrlSetData(-1, "10|15|20|25|30|35", "35")
			GUICtrlSetOnEvent(-1, "cmbCheckCC")
			GUICtrlCreateLabel("Troops", $x + 125, $y, -1, -1)
		$g_hCmbCCSpellCapacity = GUICtrlCreateCombo("", $x + 195, $y - 2, 35, 25)
			GUICtrlSetData(-1, "1|2", "2")
			GUICtrlSetState(-1, $GUI_DISABLE)
			$g_hLblCCSpellCap = GUICtrlCreateLabel("Spells", $x + 235, $y, -1, -1)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hGrpSpellsToHide = $g_hCmbCCSpellCapacity & "#" & $g_hLblCCSpellCap

		$y += 30
		For $i = 0 To 2
			$g_ahPicCheckTroops[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDonBlank, $x + 5, $y + $i * 25, 24, 24)
			$g_ahCmbCheckTroops[$i] = GUICtrlCreateCombo("", $x + 35, $y + $i * 25, 85, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, $sTroopText, "Any")
			GUICtrlSetOnEvent(-1, "cmbCheckTroopsCC")
			$g_ahTxtCheckTroops[$i] = GUICtrlCreateInput("0", $x + 125, $y + $i * 25, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 1)
			GUICtrlSetOnEvent(-1, "cmbCheckCC")

			If $i = 2 Then ExitLoop
			$g_ahPicCheckSpells[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDonBlank, $x + 165, $y + $i * 25, 24, 24)
			$g_ahCmbCheckSpells[$i] = GUICtrlCreateCombo("", $x + 195, $y + $i * 25, 80, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, $sSpellText, "Any")
			GUICtrlSetOnEvent(-1, "cmbCheckSpellsCC")
			$g_ahTxtCheckSpells[$i] = GUICtrlCreateInput("0", $x + 280, $y + $i * 25, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 1)
			$g_hGrpSpellsToHide &= "#" & $g_ahPicCheckSpells[$i] & "#" & $g_ahCmbCheckSpells[$i] & "#" & $g_ahTxtCheckSpells[$i]
		Next
		_GUI_Value_STATE("DISABLE", $g_hGrpSpellsToHide); Temporary disable until CheckCC Spells is made

		$y += 80

		$g_hChkTroopsCC = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "TroopsCC", "Remove unwanted troops in CC"), $x + 5, $y, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "TroopsCC_Info_01", "Checking troops/spells in CC. Remove any item other than the above expected."))
			GUICtrlSetOnEvent(-1, "cmbCheckCC")

		$g_hLblWarningTextCheckCC = GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - CheckTroopsCC", "WarningText", "Please set troops/spells to fit your Castle Capacity"), $x + 21, $y + 25, 290, 30)


	GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc   ;==>CheckTroopsCC
