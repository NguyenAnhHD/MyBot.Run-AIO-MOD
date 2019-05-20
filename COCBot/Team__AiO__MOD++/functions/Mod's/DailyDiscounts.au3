; #FUNCTION# ============================================================================================================================
; Name ..........: DailyDiscounts
; Version........:
; Description ...: This function purchases selected gem deals on the users behalf
; Syntax ........: DailyDiscounts()
; Parameters ....: None
; Return values .: None
; Author ........: Chilly-Chill (04/2019)
; Modified ......:
; Remarks .......: This file is a part of MyBotRun. Copyright 2018
; ................ MyBotRun is distributed under the terms of the GNU GPL
; Related .......: No
; =======================================================================================================================================

Func DailyDiscounts()
	If Not $g_bDD_DealsSet Then Return
	If Not $g_bRunState Then Return

	Local Static $iLastTimeChecked[8] = [0, 0, 0, 0, 0, 0, 0, 0]
	If $iLastTimeChecked[$g_iCurAccount] = @MDAY Then Return

	ClickP($aAway, 1, 0, "#0332") ;Click Away
	SetLog("Checking gem deals.", $COLOR_INFO)

	; Check Trader Icon on Main Village
	If QuickMIS("BC1", $g_sImgTrader, 120, 160, 210, 215, True, False) Then
		SetLog("Trader available, listing all deals.", $COLOR_SUCCESS)
		Click($g_iQuickMISX + 120, $g_iQuickMISY + 160)
		If _Sleep(500) Then Return
	Else
		SetLog("Trader unavailable", $COLOR_INFO)
		Return
	EndIf

	; Check Daily Discounts Window
	If Not QuickMIS("BC1", $g_sImgDailyDiscountWindow, 280, 175, 345, 210, True, False) Then
		ClickP($aAway, 1, 0, "#0332") ;Click Away
		Return
	EndIf

	$iLastTimeChecked[$g_iCurAccount] = @MDAY

	; Find out which deals we have
	If Not $g_bRunState Then Return
	Local $aOcrPositions[3][2] = [[200, 439], [390, 439], [580, 439]]
	Local $sSearchDiamond = GetDiamondFromRect("140,240,720,485")
	Local $iSlotOffset = 192 ; 192 pixels apart
	Local $iWindowOffset = 158 ; 158 pixels to the trader window

	Local $aDeals[0][6]
	#cs
		$aDeals[][0] = Name
		$aDeals[][1] = x coordinate
		$aDeals[][2] = y coordinate
		$aDeals[][3] = slot
		$aDeals[][4] = cost
		$aDeals[][5] = index
	#ce

	Local $aDealsResult = findMultiple($g_sImgDirDailyDiscounts, $sSearchDiamond, $sSearchDiamond, 0, 1000, 0, "objectname,objectpoints", True)

	If UBound($aDealsResult) = 0 Then
		SetLog("All deals collected or clan castle has no room for the current deals.")
		Return
	EndIf

	For $i = 0 To UBound($aDealsResult, 1) - 1
		Local $aCurrDeal = $aDealsResult[$i]
		Local $aCoords = decodeSingleCoord($aCurrDeal[1])
		Local $iSlot = Int(($aCoords[0] - $iWindowOffset) / $iSlotOffset)
		Local $iCost = 0, $iIndex = 0

		If $aCurrDeal[0] = "WallRing" Then
			If UBound(decodeSingleCoord(findImage("WallRingAmountx5", $g_sImgDDWallRingx5, $sSearchDiamond, 1, True))) > 1 Then
				$iIndex = $g_eDDWallRing5
				$aCurrDeal[0] = $aCurrDeal[0] & " x5"
			ElseIf UBound(decodeSingleCoord(findImage("WallRingAmountx10", $g_sImgDDWallRingx10, $sSearchDiamond, 1, False))) > 1 Then
				$iIndex = $g_eDDWallRing10
				$aCurrDeal[0] = $aCurrDeal[0] & " x10"
			Else
				SetLog("ERROR: Could not find the amount of wall rings.", $COLOR_ERROR)
				ContinueLoop
			EndIf
		Else
			$iIndex = GetDealIndex($aCurrDeal[0])
			If $iIndex = -1 Then
				SetLog("ERROR: Invalid deal name.", $COLOR_ERROR)
				ContinueLoop
			EndIf
		EndIf
		$iCost = $g_aiDD_DealsCosts[$iIndex]
		Local $aTempElement[1][6] = [[$aCurrDeal[0], $aCoords[0], $aCoords[1], $iSlot, $iCost, $iIndex]]
		_ArrayAdd($aDeals, $aTempElement)
		_Sleep($DELAYRESPOND)
	Next

	For $i = 0 To UBound($aDeals, 1) - 1
		SetLog($aDeals[$i][0] & " - " & String($aDeals[$i][4]) & " Gems", $COLOR_SUCCESS)
		If $g_bDebugSetlog Then SetDebugLog($aDeals[$i][0] & " x: " & String($aDeals[$i][1]) & " y: " & String($aDeals[$i][2]) & " Slot: " & String($aDeals[$i][3]) & " Cost: " & String($aDeals[$i][4]) & " Index: " & String($aDeals[$i][5]))
	Next
	_Sleep(1500)

	; check if the deals we have found are wanted and if we have enough gems
	Local $iSelections = 0
	For $i = 0 To UBound($aDeals, 1) - 1
		If $g_abChkDD_Deals[$aDeals[$i][5]] = True Then
			SetLog("Buying " & $aDeals[$i][0], $COLOR_INFO)
			If $g_iGemAmount < $aDeals[$i][4] Then
				SetLog("Not enough gems.")
				ContinueLoop
			EndIf
			If Not _ColorCheck(_GetPixelColor($aOcrPositions[$aDeals[$i][3]][0], $aOcrPositions[$aDeals[$i][3]][1] + 5, True), Hex(0x5D79C5, 6), 5) Then ; if price background isnt blue
				SetLog("No Space In Castle")
				ContinueLoop
			EndIf
			Click($aDeals[$i][1], $aDeals[$i][2])
			_Sleep(750)
			If Not ConfirmPurchase() Then
				ClickP($aAway, 2, 50, "#0332") ;Click Away twice in case window is open
				Return ; leave if gem click fails to avoid playing with people's gems
			EndIf
			_Sleep(1200)
		EndIf
	Next

	ClickP($aAway, 1, 0, "#0332") ;Click Away
EndFunc   ;==>DailyDiscounts

Func GetDealIndex($sName)
	Switch($sName)
		Case "TrainPotion"
			Return $g_eDDPotionTrain
		Case "ClockPotion"
			Return $g_eDDPotionClock
		Case "ResourcePotion"
			Return $g_eDDPotionResource
		Case "BuilderPotion"
			Return $g_eDDPotionBuilder
		Case "PowerPotion"
			Return $g_eDDPotionPower
		Case "HeroPotion"
			Return $g_eDDPotionHero
		Case "Shovel"
			Return $g_eDDShovel
		Case "BookHeros"
			Return $g_eDDBookHeros
		Case "BookFighting"
			Return $g_eDDBookFighting
		Case "BookSpells"
			Return $g_eDDBookSpells
		Case "BookBuilding"
			Return $g_eDDBookBuilding
		Case "RuneGold"
			Return $g_eDDRuneGold
		Case "RuneElixir"
			Return $g_eDDRuneElixir
		Case "RuneDarkElixir"
			Return $g_eDDRuneDarkElixir
		Case "RuneBBGold"
			Return $g_eDDRuneBBGold
		Case "RuneBBElixir"
			Return $g_eDDRuneBBElixir
		Case Else
			Return -1 ; error
	EndSwitch
EndFunc   ;==>GetDealIndex

Func ConfirmPurchase()
	Local $offColors[3][3] = [[0x0D0D0D, 144, 0], [0xDEF885, 13, 3], [0x6DBC1f, 131, 38]] ; 2nd Black opposite button, 3rd green in lighter area top left, 4th green in darker area bottom right
	Local $ButtonPixel = _MultiPixelSearch(340, 385, 506, 461, 1, 1, Hex(0x0D0D0D, 6), $offColors, 20) ; first vertical black pixel of gem button

	If IsArray($ButtonPixel) Then
		PureClick($ButtonPixel[0] + 50, $ButtonPixel[1] + 25)
		Return True
	Else
		SetLog("ERROR: Could not confirm purchase", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ConfirmPurchase