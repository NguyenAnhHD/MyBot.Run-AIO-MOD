; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control Attack Standard
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: MyBot.run team
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func chkRandomSpeedAtkAB()
	If GUICtrlRead($g_hChkRandomSpeedAtkAB) = $GUI_CHECKED Then
		;$iChkABRandomSpeedAtk = 1
		GUICtrlSetState($g_hCmbStandardUnitDelayAB, $GUI_DISABLE)
		GUICtrlSetState($g_hCmbStandardWaveDelayAB, $GUI_DISABLE)
	Else
		;$iChkABRandomSpeedAtk = 0
		GUICtrlSetState($g_hCmbStandardUnitDelayAB, $GUI_ENABLE)
		GUICtrlSetState($g_hCmbStandardWaveDelayAB, $GUI_ENABLE)
	EndIf
EndFunc   ;==>chkRandomSpeedAtkAB

Func chkSmartAttackRedAreaAB()
	If GUICtrlRead($g_hChkSmartAttackRedAreaAB) = $GUI_CHECKED Then
		$g_abAttackStdSmartAttack[$LB] = 1
		For $i = $g_hLblSmartDeployAB To $g_hPicAttackNearDarkElixirDrillAB
			GUICtrlSetState($i, $GUI_SHOW)
		Next
	Else
		$g_abAttackStdSmartAttack[$LB] = 0
		For $i = $g_hLblSmartDeployAB To $g_hPicAttackNearDarkElixirDrillAB
			GUICtrlSetState($i, $GUI_HIDE)
		Next
	EndIf
EndFunc   ;==>chkSmartAttackRedAreaAB

Func chkRandomSpeedAtkDB()
	If GUICtrlRead($g_hChkRandomSpeedAtkDB) = $GUI_CHECKED Then
		;$iChkDBRandomSpeedAtk = 1
		GUICtrlSetState($g_hCmbStandardUnitDelayDB, $GUI_DISABLE)
		GUICtrlSetState($g_hCmbStandardWaveDelayDB, $GUI_DISABLE)
	Else
		;$iChkDBRandomSpeedAtk = 0
		GUICtrlSetState($g_hCmbStandardUnitDelayDB, $GUI_ENABLE)
		GUICtrlSetState($g_hCmbStandardWaveDelayDB, $GUI_ENABLE)
	EndIf
EndFunc   ;==>chkRandomSpeedAtkDB

Func chkSmartAttackRedAreaDB()
	If GUICtrlRead($g_hChkSmartAttackRedAreaDB) = $GUI_CHECKED Then
		$g_abAttackStdSmartAttack[$DB] = 1
		For $i = $g_hLblSmartDeployDB To $g_hPicAttackNearDarkElixirDrillDB
			GUICtrlSetState($i, $GUI_SHOW)
		Next
	Else
		$g_abAttackStdSmartAttack[$DB] = 0
		For $i = $g_hLblSmartDeployDB To $g_hPicAttackNearDarkElixirDrillDB
			GUICtrlSetState($i, $GUI_HIDE)
		Next
	EndIf
EndFunc   ;==>chkSmartAttackRedAreaDB

; =================== UNIT/WAVE FACTOR =====================
Func chkUnitFactor()
	If GUICtrlRead($ChkUnitFactor) = $GUI_CHECKED Then
		$iChkUnitFactor = 1
		GUICtrlSetState($TxtUnitFactor, $GUI_ENABLE)
	Else
		$iChkUnitFactor = 0
		GUICtrlSetState($TxtUnitFactor, $GUI_DISABLE)
	EndIf
	$iTxtUnitFactor = GUICtrlRead($TxtUnitFactor)
EndFunc

Func chkWaveFactor()
	If GUICtrlRead($ChkWaveFactor) = $GUI_CHECKED Then
		$iChkWaveFactor = 1
		GUICtrlSetState($TxtWaveFactor, $GUI_ENABLE)
	Else
		$iChkWaveFactor = 0
		GUICtrlSetState($TxtWaveFactor, $GUI_DISABLE)
	EndIf
	$iTxtWaveFactor = GUICtrlRead($TxtWaveFactor)
EndFunc

Func ChkGiantSlot()
	If GUICtrlRead($ChkGiantSlot) = $GUI_CHECKED Then
		$iChkGiantSlot = 1
		GUICtrlSetState($CmbGiantSlot, $GUI_ENABLE)
	Else
		$iChkGiantSlot = 0
		GUICtrlSetState($CmbGiantSlot, $GUI_DISABLE)
	EndIf
	;$iCmbGiantSlot = _GUICtrlComboBox_GetCurSel($CmbGiantSlot)
EndFunc
Func CmbGiantSlot()
 If $iChkGiantSlot = 1 Then 
     Switch _GUICtrlComboBox_GetCurSel($CmbGiantSlot)
		 Case 0
			 $SlotsGiantsVN = 0			 
		 Case 1
			 $SlotsGiantsVN = 2		     
     EndSwitch
 Else
 LocaL $GiantComp = $g_ahTxtTrainArmyTroopCount[$eTroopGiant]
    If Number($GiantComp) >= 1 And Number($GiantComp) <= 7 Then $SlotsGiantsVN = 1
	If Number($GiantComp) >= 8 Then $SlotsGiantsVN = 2 ; will be split in 2 slots, when >16 or >=8 with FF	
	If Number($GiantComp) >= 12 Then $SlotsGiantsVN = 0 ; spread on vector, when >20 or >=12 with FF 
	
 EndIf
EndFunc