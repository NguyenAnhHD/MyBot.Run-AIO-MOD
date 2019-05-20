; #FUNCTION# ====================================================================================================================
; Name ..........: FriendlyChallenge
; Description ...:
; Syntax ........: FriendlyChallenge()
; Parameters ....:
; Return values .:
; Author ........: Samkie (11 July, 2017)
; Modified ......: Boludoz (IA Mod)
; Remarks .......:
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func FriendlyChallenge()
	If Not $g_bEnableFriendlyChallenge Then Return

	Local $aBaseForShare[1]
	Local $iCount4Share = 0
	For $i = 0 To 5
		If $g_bFriendlyChallengeBase[$i] = True Then
			ReDim $aBaseForShare[$iCount4Share + 1]
			$aBaseForShare[$iCount4Share] = $i
			$iCount4Share += 1
		EndIf
	Next
	If $iCount4Share = 0 Then
		SetLog("No base to share for friend challenge, please check your setting.", $COLOR_ERROR)
		Return
	EndIf

	ClickP($aAway, 1, 0, "#0167") ;Click Away
	Setlog("Checking Friendly Challenge at Clan Chat", $COLOR_INFO)
	ForceCaptureRegion()

	If Not _CheckPixel($aChatTab, $g_bCapturePixel) Or Not _CheckPixel($aChatTab2, $g_bCapturePixel) Or Not _CheckPixel($aChatTab3, $g_bCapturePixel) Then ClickP($aOpenChat, 1, 0, "#0168") ; Clicks chat tab
	If _Sleep($DELAYCHATACTIONS3) Then Return

	Local $iLoopCount = 0
	While 1
		;If Clan tab is selected.
		If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x706C50, 6), 20) Then ; color med gray
			ExitLoop
		EndIf
		;If Global tab is selected.
		If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x383828, 6), 20) Then ; Darker gray
			If _Sleep($DELAYDONATECC1) Then Return ;small delay to allow tab to completely open
			ClickP($aClanTab, 1, 0, "#0169") ; clicking clan tab
			ExitLoop
		EndIf
		;counter for time approx 3 sec max allowed for tab to open
		$iLoopCount += 1
		If $iLoopCount >= 15 Then ; allows for up to a sleep of 3000
			SetLog("Cannot switch to Clan Chat Tab - Abandon Friendly Challenge")
			AndroidPageError("FriendlyChallenge")
			ClostChatTab()
			Return False
		EndIf
		If _Sleep($DELAYDONATECC1) Then Return ; delay Allow 15x
	WEnd

	; check for "I Understand" button
	Local $aCoord = decodeSingleCoord(findImage("I Understand", $g_sImgChatIUnterstand, GetDiamondFromRect("50,400,280,550")))
	If UBound($aCoord) > 1 Then
		SetLog("Clicking 'I Understand' button", $COLOR_ACTION)
		ClickP($aCoord)
		If _Sleep($DELAYDONATECC2) Then Return
	EndIf

	Local $bDoFriendlyChallenge = False
	Local $iBaseForShare = $aBaseForShare[Random(0,UBound($aBaseForShare)-1,1)]

		Local $ClanString
		If $g_bOnlyOnRequest Then
				If ReadChatIA($ClanString, $g_iTxtKeywordForRequest, False) = True Then
					Local $ret = StringRegExp($ClanString, '\d+', 1)
					$bDoFriendlyChallenge = True

						If IsArray($ret) Then
							For $k = 0 To UBound($aBaseForShare) - 1
								If $aBaseForShare[$k] = Int($ret[0] - 1) Then
									$iBaseForShare = Int($ret[0] - 1)
									SetLog("User request challenge base: " & $iBaseForShare + 1, $COLOR_INFO)
								EndIf
							Next
						EndIf
				EndIf
		Else
			$bDoFriendlyChallenge = True
		EndIf

	Local $bIsBtnStartOk = False

	If $bDoFriendlyChallenge Then
		SetLog("Prepare for select base: " & $iBaseForShare + 1, $COLOR_INFO)
		If _WaitForCheckPixel($aButtonFriendlyChallenge, $g_bCapturePixel, Default, "Wait for FC Btn:") Then
			Click($aButtonFriendlyChallenge[0], $aButtonFriendlyChallenge[1], 1, 0, "#BtnFC")
			If _WaitForCheckPixel($aButtonFCChangeLayout, $g_bCapturePixel, Default, "Wait for FCCL Btn:") Then
				Click($aButtonFCChangeLayout[0], $aButtonFCChangeLayout[1], 1, 0, "#BtnFCCL")
				If _WaitForCheckPixel($aButtonFCBack, $g_bCapturePixel, Default, "Wait for FC Back:") Then
					If CheckNeedSwipeFriendlyChallengeBase($iBaseForShare) Then
						If _WaitForCheckPixel($aButtonFCStart, $g_bCapturePixel, Default, "Wait for FC Start:") Then
							If $g_iTxtChallengeText <> "" Then
								Click(Random(440, 620, 1), Random(165, 185, 1))
								If _Sleep($DELAYCHATACTIONS1) Then Return False
								Local $asText = StringSplit($g_iTxtChallengeText, @CRLF, BitOR($STR_ENTIRESPLIT, $STR_NOCOUNT))
								If IsArray($asText) Then
									Local $sText4Send = $asText[Random(0, UBound($asText) - 1, 1)]
									SetLog("Send text: " & $sText4Send, $COLOR_DEBUG)
									If Not $g_bChkBackgroundMode And Not $g_bNoFocusTampering Then ControlFocus($g_hAndroidWindow, "", "")
									If SendText($sText4Send) = 0 Then
										Setlog("Challenge text entry failed!", $COLOR_ERROR)
									EndIf
								EndIf
								If _Sleep($DELAYCHATACTIONS2) Then Return
							EndIf
							If _WaitForCheckPixel($aButtonFCStart, $g_bCapturePixel, Default, "Wait for FC Start:") Then $bIsBtnStartOk = True
							If _Sleep($DELAYCHATACTIONS2) Then Return

							If $bIsBtnStartOk = True Then
								Click($aButtonFCStart[0], $aButtonFCStart[1], 1, 0, "#BtnFCStart")
								SetLog("Friendly Challenge Shared.", $COLOR_INFO)
								ClostChatTab()
								Return True
							EndIf
						Else
							SetLog("Cannot find friendly challenge start button. Maybe the base cannot be select.", $COLOR_ERROR)
							$g_bFriendlyChallengeBase[$iBaseForShare] = False
							GUICtrlSetState($g_hChkFriendlyChallengeBase[$iBaseForShare], $GUI_UNCHECKED)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	ClostChatTab()
	Return False
EndFunc   ;==>FriendlyChallenge

Func CheckNeedSwipeFriendlyChallengeBase($iBaseSlot)
	If _Sleep($DELAYCHATACTIONS1) Then Return False
	; check need swipe
	Local $iSwipeNum = 2
	Local $iCount = 0
	If $iBaseSlot > $iSwipeNum Then
		$iCount = 0
		While Not _ColorCheck(_GetPixelColor(712, 295, True), Hex(0XD3D3CB, 6), 10)
			ClickDrag(700, 250, 150, 250, 250)
			If _Sleep($DELAYCHATACTIONS1) Then Return False
			$iCount += 1
			If $iCount > 3 Then Return False
		WEnd
		$iBaseSlot -= 3
		Click(Random(200 + ($iBaseSlot * 184), 230 + ($iBaseSlot * 184), 1), Random(220, 270, 1))
	Else
		$iCount = 0
		While Not _ColorCheck(_GetPixelColor(146, 295, True), Hex(0XD3D3CB, 6), 10)
			ClickDrag(155, 250, 705, 250, 250)
			If _Sleep($DELAYCHATACTIONS1) Then Return False
			$iCount += 1
			If $iCount > 3 Then Return False
		WEnd
		Click(Random(200 + ($iBaseSlot * 184), 230 + ($iBaseSlot * 184), 1), Random(220, 270, 1))
	EndIf
	Return True
EndFunc   ;==>CheckNeedSwipeFriendlyChallengeBase

Func ClostChatTab()
	Local $i = 0
	While 1
		If _Sleep($DELAYCHATACTIONS1) Then Return
		ForceCaptureRegion()
		_CaptureRegion()
		Select
			Case _CheckPixel($aCloseChat, $g_bCapturePixel, Default, "BtnCloseChat:")
				Click($aCloseChat[0], $aCloseChat[1], 1, 0, "#0173") ;Clicks chat thing
			Case _CheckPixel($aOpenChatTab, $g_bCapturePixel, Default, "BtnOpenChatTab:")
				ExitLoop
			Case _CheckPixel($aButtonFCClose, $g_bCapturePixel, Default, "BtnFCClose:")
				Click($aButtonFCClose[0], $aButtonFCClose[1], 1, 0, "#BtnFCClose") ;Clicks chat thing
			Case _CheckPixel($aButtonFCBack, $g_bCapturePixel, Default, "BtnFCBack:")
				AndroidBackButton()
			Case Else
				ClickP($aAway, 1, 0, "#0167") ;Click Away
				$i += 1
				If $i > 30 Then
					SetLog("Error finding Clan Tab to close...", $COLOR_ERROR)
					AndroidPageError("FriendlyChallenge")
					ExitLoop
				EndIf
		EndSelect
	WEnd
	If _Sleep($DELAYCHATACTIONS1) Then Return
EndFunc   ;==>ClostChatTab
