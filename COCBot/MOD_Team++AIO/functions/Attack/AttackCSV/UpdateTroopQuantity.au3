; #FUNCTION# ====================================================================================================================
; Name ..........: Update Troop Quantity
; Description ...:
; Syntax ........: UpdateTroopQuantity, IsSlotSelected, GetSelectedSlotIndex
; Parameters ....:
; Return values .: None
; Author ........: MR.ViPER (25-12-2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func UpdateTroopQuantity($sTroop, $bNeedNewCapture = Default)
	If $bNeedNewCapture = Default Then $bNeedNewCapture = True
	If $bNeedNewCapture = True Then
		_CaptureRegion2()
	EndIf

	; Get the integer index of the troop name specified
	Local $troopName = $sTroop
	Local $iTroopIndex = TroopIndexLookup($troopName)
	If $iTroopIndex = -1 Then
		Setlog("'UpdateTroopQuantity' troop name '" & $troopName & "' is unrecognized.")
		Return
	EndIf

	Local $troopPosition = -1
	For $i = 0 To UBound($g_avAttackTroops) - 1
		If $g_avAttackTroops[$i][0] = $iTroopIndex Then
			$troopPosition = $i
			ExitLoop
		EndIf
	Next

	If $g_bRunState = False Then Return
	If $troopPosition <> -1 Then
		Local $iQuantity = ReadTroopQuantity($troopPosition, True, Not $bNeedNewCapture)
		$g_avAttackTroops[$troopPosition][1] = $iQuantity
	EndIf
	Return $troopPosition ; Return Troop Position in the Array, will be the slot of Troop in Attack bar
EndFunc   ;==>UpdateTroopQuantity

Func IsSlotSelected($iSlotIndex, $bNeedNewCapture = Default)
	; $iSlotIndex Starts from 0
	If $bNeedNewCapture = Default Then $bNeedNewCapture = True
	If $bNeedNewCapture = True Then
		ForceCaptureRegion()
		_CaptureRegion()
	EndIf
	Local $iOffset = 73
	Local $iStartX = 75
	Local $iY = 724
	If $bNeedNewCapture = True Then
		Return _ColorCheck( _
				_GetPixelColor($iStartX + ($iOffset * $iSlotIndex), $iY, False), _ ; capture color #1
				Hex(0xFFFFFF, 6), _ ; compare to Color #2 from screencode
				20)
	Else
		Return _ColorCheck( _
				Hex(_GDIPlus_BitmapGetPixel(_GDIPlus_BitmapCreateFromHBITMAP($g_hHBitmap2), ($iStartX + ($iOffset * $iSlotIndex)), $iY), 6), _ ; Get pixel color
				Hex(0xFFFFFF, 6), _ ; compare to Color #2 from screencode
				20)
	EndIf
EndFunc   ;==>IsSlotSelected

Func GetSelectedSlotIndex($bNeedNewCapture = Default)
	If $bNeedNewCapture = Default Then $bNeedNewCapture = True
	If $bNeedNewCapture = True Then
		ForceCaptureRegion()
		_CaptureRegion()
	EndIf
	Local $iOffset = 73
	Local $iStartX = 75
	Local $iEndX = 805 ; 11th Slot Check Point
	Local $iY = 724
	Local $iCounter = 0
	Local $iResult = -1
	For $iX = $iStartX To $iEndX Step +$iOffset
		Local $rColCheck = _ColorCheck( _
				_GetPixelColor($iX, $iY, False), _ ; capture color #1
				Hex(0xFFFFFF, 6), _ ; compare to Color #2 from screencode
				20)
		If $rColCheck = True Then
			$iResult = $iCounter
			ExitLoop
		EndIf
		$iCounter += 1
	Next
	SetLog("Selected Slot: #" & Number($iResult + 1), $COLOR_DEBUG)
	Return $iResult
EndFunc   ;==>GetSelectedSlotIndex
