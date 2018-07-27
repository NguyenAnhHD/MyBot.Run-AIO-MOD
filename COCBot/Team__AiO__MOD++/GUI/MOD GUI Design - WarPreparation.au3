; #FUNCTION# ====================================================================================================================
; Name ..........: War Preparation
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $g_hChkStopForWar = 0, $g_hCmbStopTime = 0, $g_hCmbStopBeforeBattle = 0, $g_hCmbReturnTime = 0
Global $g_hChkTrainWarTroop = 0, $g_hChkUseQuickTrainWar, $g_ahChkArmyWar[3], $g_hLblRemoveArmyWar, $g_ahTxtTrainWarTroopCount[$eTroopCount], $g_ahTxtTrainWarSpellCount[$eSpellCount]
Global $g_hCalTotalWarTroops, $g_hLblTotalWarTroopsProgress, $g_hLblCountWarTroopsTotal
Global $g_hCalTotalWarSpells, $g_hLblTotalWarSpellsProgress, $g_hLblCountWarSpellsTotal
Global $g_hChkRequestCCForWar = 0, $g_hTxtRequestCCForWar = 0

Func WarPreparationGUI()

	Local $aTroopsIcons[$eTroopCount] = [$eIcnBarbarian, $eIcnArcher, $eIcnGiant, $eIcnGoblin, $eIcnWallBreaker, $eIcnBalloon, _
			$eIcnWizard, $eIcnHealer, $eIcnDragon, $eIcnPekka, $eIcnBabyDragon, $eIcnMiner, $eIcnElectroDragon, $eIcnMinion, _
			$eIcnHogRider, $eIcnValkyrie, $eIcnGolem, $eIcnWitch, $eIcnLavaHound, $eIcnBowler]
	Local $aSpellsIcons[$eSpellCount] =[$eIcnLightSpell, $eIcnHealSpell, $eIcnRageSpell, $eIcnJumpSpell, $eIcnFreezeSpell, _
			$eIcnCloneSpell, $eIcnPoisonSpell, $eIcnEarthQuakeSpell, $eIcnHasteSpell, $eIcnSkeletonSpell]

	Local $x = 15, $y = 40
	GUICtrlCreateGroup(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "Group_01", "War preration"), $x - 10, $y - 15, $g_iSizeWGrpTab3, $g_iSizeHGrpTab3)

		$g_hChkStopForWar = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "ChkStopForWar", "Pause farming for war"), $x, $y, -1, -1)
			_GUICtrlSetTip(-1, GetTranslatedFileIni("MOD GUI Design - WarPreparation", "ChkStopForWar_Info_01", "Pause or set current account 'idle' to prepare for war"))
			GUICtrlSetOnEvent(-1, "ChkStopForWar")

		$g_hCmbStopTime = GUICtrlCreateCombo("", $x + 140, $y, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0 hr|1 hr|2 hrs|3 hrs|4 hrs|5 hrs|6 hrs|7 hrs|8 hrs|9 hrs|10 hrs|11 hrs|12 hrs |13 hrs|14 hrs|15 hrs|16 hrs|17 hrs|18 hrs|19 hrs|20 hrs|21 hrs|22 hrs|23 hrs", "0 hr")
			GUICtrlSetOnEvent(-1,"CmbStopTime")
		$g_hCmbStopBeforeBattle = GUICtrlCreateCombo("", $x + 220, $y, 160, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, GetTranslatedFileIni("MOD GUI Design - WarPreparation", "CmbStopBeforeBattle", "before battle start|after battle start"), "before battle start")
			GUICtrlSetOnEvent(-1,"CmbStopTime")

	$y += 25
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "LblReturnTime_01", "Return to farm"), $x + 15, $y + 1, -1, -1)
		$g_hCmbReturnTime = GUICtrlCreateCombo("", $x + 140, $y, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, 	"0 hr|1 hr|2 hrs|3 hrs|4 hrs|5 hrs|6 hrs|7 hrs|8 hrs|9 hrs|10 hrs|11 hrs|12 hrs |13 hrs|14 hrs|15 hrs|16 hrs|17 hrs|18 hrs|19 hrs|20 hrs|21 hrs|22 hrs|23 hrs", "0 hr")
			GUICtrlSetOnEvent(-1,"CmbReturnTime")
		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "LblReturnTime_02", "before battle finish"), $x + 220, $y + 1, -1, -1)

	$y += 25
		$g_hChkTrainWarTroop = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "ChkTrainWarTroop", "Delete all farming troops and train war troops before pausing"), $x, $y, -1, -1)
			GUICtrlSetOnEvent(-1, "ChkTrainWarTroop")

	$y += 25
		$g_hChkUseQuickTrainWar = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "ChkUseQuickTrain", -1), $x + 15, $y, -1, 15)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "chkUseQTrainWar")
		For $i = 0 To 2
			$g_ahChkArmyWar[$i] = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "ChkArmy", -1) & " " & $i + 1, $x + 120 + $i * 60, $y, 50, 15)
				GUICtrlSetState(-1, $GUI_DISABLE)
				If $i = 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetOnEvent(-1, "chkQuickTrainComboWar")
		Next
		$g_hLblRemoveArmyWar = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "Btn_Remove_Army", -1), $x + 305, $y + 1, -1, 15, $SS_LEFT)
		_GUICtrlCreateIcon($g_sLibIconPath, $eIcnResetButton, $x + 375, $y - 4, 24, 24)
			GUICtrlSetOnEvent(-1, "RemovecampWar")

	$x = 30
	$y += 25
		For $i = 0 To $eTroopCount - 1 ; Troops
			If $i >= 12 Then $x = 37
			_GUICtrlCreateIcon($g_sLibIconPath, $aTroopsIcons[$i], $x + Int($i / 2) * 38, $y + Mod($i, 2) * 60, 32, 32)

			$g_ahTxtTrainWarTroopCount[$i] = GUICtrlCreateInput("0", $x + Int($i / 2) * 38 + 1, $y + Mod($i, 2) * 60 + 34, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
				GUICtrlSetLimit(-1, 3)
				GUICtrlSetOnEvent(-1, "TrainWarTroopCountEdit")
		Next

	$x = 30
	$y += 120
		$g_hCalTotalWarTroops = GUICtrlCreateProgress($x, $y + 3, 285, 10)
		$g_hLblTotalWarTroopsProgress = GUICtrlCreateLabel("", $x, $y + 3, 285, 10)
			GUICtrlSetBkColor(-1, $COLOR_RED)
			GUICtrlSetState(-1, BitOR($GUI_DISABLE, $GUI_HIDE))

		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "LblCountWarTroopsTotal", "Total troops"), $x + 290, $y, -1, -1)
		$g_hLblCountWarTroopsTotal = GUICtrlCreateLabel("" & 0, $x + 350, $y, 30, 15, $SS_CENTER)
			GUICtrlSetBkColor(-1, $COLOR_MONEYGREEN) ;lime, moneygreen

	$y += 25
		For $i = 0 To $eSpellCount - 1 ; Spells
			If $i >= 6 Then $x = 37
			_GUICtrlCreateIcon($g_sLibIconPath, $aSpellsIcons[$i], $x + $i * 38, $y, 32, 32)
			$g_ahTxtTrainWarSpellCount[$i] = GUICtrlCreateInput("0", $x +  $i * 38, $y + 34, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
				GUICtrlSetLimit(-1, 3)
				GUICtrlSetOnEvent(-1, "TrainWarSpellCountEdit")
		Next

	$x = 30
	$y += 60
		$g_hCalTotalWarSpells = GUICtrlCreateProgress($x, $y + 3, 285, 10)
		$g_hLblTotalWarSpellsProgress = GUICtrlCreateLabel("", $x, $y + 3, 285, 10)
			GUICtrlSetBkColor(-1, $COLOR_RED)
			GUICtrlSetState(-1, BitOR($GUI_DISABLE, $GUI_HIDE))

		GUICtrlCreateLabel(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "LblCountWarSpellsTotal", "Total spells"), $x + 290, $y, -1, -1)
		$g_hLblCountWarSpellsTotal = GUICtrlCreateLabel("" & 0, $x + 350, $y, 30, 15, $SS_CENTER)
			GUICtrlSetBkColor(-1, $COLOR_MONEYGREEN) ;lime, moneygreen

	$x = 15
	$y += 25
		$g_hChkRequestCCForWar = GUICtrlCreateCheckbox(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "ChkRequestCCForWar", "Request CC before pausing"), $x, $y, -1, -1)
			GUICtrlSetOnEvent(-1, "ChkRequestCCForWar")
		$g_hTxtRequestCCForWar = GUICtrlCreateInput(GetTranslatedFileIni("MOD GUI Design - WarPreparation", "TxtRequestCCForWar", "War troop please"), $x + 180, $y, 120, -1, $SS_CENTER)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc   ;==>WarPreparationGUI
