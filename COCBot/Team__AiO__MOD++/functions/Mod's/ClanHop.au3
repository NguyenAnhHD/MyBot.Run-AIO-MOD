; #FUNCTION# ============================================================================================================================
; Name ..........: ClanHop
; Version........:
; Description ...: This function joins/quit random clans and fills requests indefinitly
; Syntax ........: clanHop()
; Parameters ....: None
; Return values .: None
; Author ........: zengzeng, MantasM (complete overhaul)
; Modified ......: Rhinoceros, Team AiO MOD++ (2018)
; Remarks .......: This file is a part of MyBotRun. Copyright 2018
; ................ MyBotRun is distributed under the terms of the GNU GPL
; Related .......: No
; =======================================================================================================================================

Func ClanHop()

	If Not $g_bChkClanHop Then Return

	SetLog("Start Clan Hopping", $COLOR_INFO)
	Local $sTimeStartedHopping = _NowCalc()

	Local $iPosJoinedClans = 0, $iScrolls = 0, $iHopLoops = 0, $iErrors = 0

	$g_iCommandStop = 0 ; Halt Attacking

	If Not IsMainPage() Then
		SetLog("Couldn't locate Mainscreen!", $COLOR_ERROR)
		Return
	EndIf

	While 1

		ClickP($aAway, 1, 0) ; Click away any open Windows
		If _Sleep($DELAYRESPOND) Then Return

		If $iErrors >= 10 Then
			Local $y = 0
			SetLog("Too Many Errors occured in current ClanHop Loop. Leaving ClanHopping!", $COLOR_ERROR)
			While 1
				If _Sleep(50) Then Return
				If _ColorCheck(_GetPixelColor($aCloseChat[0], $aCloseChat[1], True), Hex($aCloseChat[2], 6), $aCloseChat[3]) Then
					; Clicks chat Button
					Click($aCloseChat[0], $aCloseChat[1], 1, 0, "#0173") ;Clicks chat close button
					ExitLoop
				Else
					If _Sleep(100) Then Return
					$y += 1
					If $y > 30 Then
						SetLog("Error finding Clan Tab to close.", $COLOR_ERROR)
						AndroidPageError("ClanHop")
						ExitLoop
					EndIf
				EndIf
			WEnd
			Return
		EndIf

		If $iScrolls >= 8 Then
			CloseCoc(True) ; Restarting to get some new Clans
			$iScrolls = 0
			$iPosJoinedClans = 0
		EndIf

		ForceCaptureRegion()
		If Not _CheckPixel($aChatTab, $g_bCapturePixel) Or Not _CheckPixel($aChatTab2, $g_bCapturePixel) Or Not _CheckPixel($aChatTab3, $g_bCapturePixel) Then ClickP($aOpenChat, 1, 0, "#0168") ; Clicks chat tab
		If _Sleep($DELAYDONATECC4) Then Return

		Local $iCount = 0
		While 1
			;If Clan tab is selected.
			If _CheckPixel($aClanChatTab, $g_bCapturePixel) Then ; color med gray
				ExitLoop
			EndIf
			;If Global tab is selected.
			If _CheckPixel($aGlobalChatTab, $g_bCapturePixel) Then ; Darker gray
				If _Sleep($DELAYDONATECC1) Then Return ;small delay to allow tab to completely open
				ClickP($aClanTab, 1, 0, "#0169") ; clicking clan tab
				If _Sleep(500) Then Return ; Delay to wait till Clan Page is fully up and visible so the next Color Check won't fail ;)
				ExitLoop
			EndIf
			;counter for time approx 3 sec max allowed for tab to open
			$iCount += 1
			If $iCount >= 15 Then ; allows for up to a sleep of 3000
				SetLog("Clan Chat Did Not Open - Abandon ClanHop")
				AndroidPageError("ClanHop")
				Return
			EndIf
			If _Sleep($DELAYDONATECC1) Then Return ; delay Allow 15x
		WEnd

		If Not _CheckPixel($aClanBadgeNoClan, $g_bCapturePixel) Then ; If Still in Clan
			SetLog("Still in a Clan! Leaving the Clan now")
			ClickP($aClanNameBtn)
			If _WaitForCheckPixel($aClanPage, $g_bCapturePixel, Default, "Wait for Clan Page:") Then
				ClickP($aClanPage)
				If Not ClickOkay("ClanHop") Then
					SetLog("Okay Button not found! Starting over again", $COLOR_ERROR)
					$iErrors += 1
					ContinueLoop
				Else
					SetLog("Successfully left Clan", $COLOR_SUCCESS)
					If _Sleep(400) Then Return
				EndIf
			Else
				SetLog("Clan Page did not open! Starting over again", $COLOR_ERROR)
				$iErrors += 1
				ContinueLoop
			EndIf
		EndIf

		If _CheckPixel($aJoinClanBtn, $g_bCapturePixel) Then ; Click on Green Join Button on Donate Window
			SetLog("Opening Join Clan Page", $COLOR_INFO)
			ClickP($aJoinClanBtn)
		Else
			SetLog("Join Clan Button not visible! Starting over again", $COLOR_ERROR)
			$iErrors += 1
			ContinueLoop
		EndIf

		If Not _WaitForCheckPixel($aJoinClanPage, $g_bCapturePixel, Default, "Wait For Join Clan Page:") Then ; Wait For The golden Trophy Background of the First Clan in list
			SetLog("Joinable Clans did not show.. Starting over again", $COLOR_ERROR)
			$iErrors += 1
			ContinueLoop
		EndIf

		;Go through all Clans of the list 1 by 1
		If $iPosJoinedClans >= 7 Then
			ClickDrag(333, 668, 333, 286, 300)
			$iScrolls += 1
			$iPosJoinedClans = 0
		EndIf

		Click(161, 286 + ($iPosJoinedClans * 55)) ; Open specific Clans Page
		$iPosJoinedClans += 1
		If _Sleep(300) Then Return
		If Not _WaitForCheckPixel($aClanPageJoin, $g_bCapturePixel, Default, "Wait For Clan Page:") Then ; Check if Clan Page itself opened up
			SetLog("Clan Page did not open. Starting over again", $COLOR_ERROR)
			$iErrors += 1
			ContinueLoop
		EndIf

		ClickP($aClanPageJoin) ; Join Clan

		If Not _WaitForCheckPixel($aClanChatRules, $g_bCapturePixel, Default, "Wait For Chat Rules in Clan Page:") Then ; Check Chat Rules in Clan Page
			SetLog("Chat Rules did not show.. Starting over again", $COLOR_ERROR)
			$iErrors += 1
			ContinueLoop
		EndIf

		ClickP($aClanChatRules)

		If Not _WaitForCheckPixel($aClanChat, $g_bCapturePixel, Default, "Wait For Clan Chat:") Then ; Check for your "joined the Clan" Message to verify that Chat loaded successfully
			SetLog("Could not verify loaded Clan Chat. Starting over again", $COLOR_ERROR)
			$iErrors += 1
			ContinueLoop
		EndIf

		DonateCC() ; Start Donate Sequence

		If _Sleep(300) Then Return ; Little Sleep if requests got filled and chat moves

		DonateCC()

		ForceCaptureRegion()
		If Not _CheckPixel($aChatTab, $g_bCapturePixel) Or Not _CheckPixel($aChatTab2, $g_bCapturePixel) Or Not _CheckPixel($aChatTab3, $g_bCapturePixel) Then ClickP($aOpenChat, 1, 0, "#0168") ; Clicks chat tab
		If _Sleep($DELAYDONATECC4) Then Return

		ClickP($aClanNameBtn) ;  Click the Clan Banner in Top left corner of donate window

		If _WaitForCheckPixel($aClanPage, $g_bCapturePixel, Default, "Wait for Clan Page:") Then ; Leave the Clan
			ClickP($aClanPage)
			If Not ClickOkay("ClanHop") Then
				SetLog("Okay Button not found! Starting over again", $COLOR_ERROR)
				$iErrors += 1
				ContinueLoop
			Else
				SetLog("Successfully left Clan", $COLOR_SUCCESS)
				If _Sleep(400) Then Return
			EndIf
		Else
			SetLog("Clan Page did not open! Starting over again", $COLOR_ERROR)
			$iErrors += 1
			ContinueLoop
		EndIf

		If $iHopLoops >= 5 Then
			; Update Troops and Spells Capacity
			Local $i = 0
			While 1
				If _Sleep(100) Then Return
				If _CheckPixel($aCloseChat, $g_bCapturePixel) Then
					; Clicks chat Button
					Click($aCloseChat[0], $aCloseChat[1], 1, 0, "#0173") ;Clicks chat close button
					ExitLoop
				Else
					If _Sleep(100) Then Return
					$i += 1
					If $i > 30 Then
						SetLog("Error finding Clan Tab to close.", $COLOR_ERROR)
						AndroidPageError("ClanHop")
						ExitLoop
					EndIf
				EndIf
			WEnd
			VillageReport()
			ProfileSwitch()
			TrainSystem()
			$iHopLoops = 0

		EndIf

		If _DateDiff("h", $sTimeStartedHopping, _NowCalc) > 1 Then ExitLoop
		$iHopLoops += 1
	WEnd

EndFunc   ;==>ClanHop
