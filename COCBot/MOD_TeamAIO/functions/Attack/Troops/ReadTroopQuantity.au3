;
; #FUNCTION# ====================================================================================================================
; Name ..........: ReadTroopQuantity
; Description ...: Read the quantity for a given troop
; Syntax ........: ReadTroopQuantity($Troop)
; Parameters ....: $Troop               - an unknown value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ReadTroopQuantity($Troop, $CheckSelectedSlot = False, $bNeedNewCapture = True)
	Local $iAmount
	Switch $CheckSelectedSlot
		Case False
			$iAmount = getTroopCountSmall(GetXPosOfArmySlot($Troop, 40), 641)
			If $iAmount = "" Then
				$iAmount = getTroopCountBig(GetXPosOfArmySlot($Troop, 40), 636)
			EndIf
		Case Else
			Local $rGetXPosOfArmySlot = GetXPosOfArmySlot($Troop, 40, $bNeedNewCapture)
			Local $isTheSlotSelected = IsSlotSelected($Troop, $bNeedNewCapture)
			If $isTheSlotSelected = False Then
				$iAmount = Number(getTroopCountSmall($rGetXPosOfArmySlot, 641, $bNeedNewCapture))
			Else
				$iAmount = Number(getTroopCountBig($rGetXPosOfArmySlot, 636, $bNeedNewCapture))
			EndIf
	EndSwitch
	Return Number($iAmount)
EndFunc   ;==>ReadTroopQuantity