; #FUNCTION# ====================================================================================================================
; Name ..........: Chatbot
; Description ...:
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........:
; Modified ......: Boludoz (12-3-2018) (based on ClashGameBot mod)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================
#include <WinAPIEx.au3>

Global Const $DELAYCHATACTIONS1 = 100
Global Const $DELAYCHATACTIONS2 = 300
Global Const $DELAYCHATACTIONS3 = 500
Global Const $DELAYCHATACTIONS4 = 750
Global Const $DELAYCHATACTIONS5 = 1000
Global Const $DELAYCHATACTIONS6 = 1250
Global Const $DELAYCHATACTIONS7 = 1500

Func ChatActions() ; run the chatbot
	ApplyConfig_MOD_ChatActions("Save")

	If $g_bChatGlobal Then
		If $g_sDelayTimeGlobal > 0 Then
			If DelayTime("GLOBAL") Then
				ChatGlobal()
				$g_sGlobalChatLastMsgSentTime = _NowCalc() ;Store msg sent time
			EndIf
		Else
			ChatGlobal()
		EndIf
	EndIf

	If $g_bChatClan Then
		If $g_sDelayTimeClan > 0 Then
			If DelayTime("CLAN") Then
				ChatClan()
				$g_sClanChatLastMsgSentTime = _NowCalc() ;Store msg sent time
			EndIf
		Else
			ChatClan()
		EndIf
	EndIf

	If $g_bEnableFriendlyChallenge And Not $g_bStayOnBuilderBase Then
		If $g_sDelayTimeFC > 0 Then
			If DelayTime("FC") Then
				FriendlyChallenge()
				$g_sFCLastMsgSentTime = _NowCalc() ;Store msg sent time
			EndIf
		Else
			FriendlyChallenge()
		EndIf
	EndIf

EndFunc   ;==>ChatActions

Func DelayTime($chatType)
	Local $aHour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)
	If Not $g_abFriendlyChallengeHours[$aHour[0]] Then
		SetLog("ChatActions not planned, Skipped..", $COLOR_INFO)
		Return False
	EndIf

	Switch $chatType
		Case "GLOBAL"
			If $g_sGlobalChatLastMsgSentTime = "" Then Return True ;If GlobalLastMsgSentTime sent time is empty means it's first time sms allow it

				Local $sDateTimeDiffOfLastMsgInMin = _DateDiff("s", $g_sGlobalChatLastMsgSentTime, _NowCalc()) / 60 ;For getting float value of minutes(s) we divided the diffsec by 60
				SetDebugLog("$g_sDelayTimeGlobal = " & $g_sDelayTimeGlobal)
				SetDebugLog("$g_sGlobalChatLastMsgSentTime = " & $g_sGlobalChatLastMsgSentTime & ", $sDateTimeDiffOfLastMsgInMin = " & $sDateTimeDiffOfLastMsgInMin)
				If $sDateTimeDiffOfLastMsgInMin > $g_sDelayTimeGlobal Then ;If GlobalLastMsgSentTime sent time is empty means it's first time sms
					Return True
				Else
					Local $hour = 0, $min = 0, $sec = 0
					Local $sDateTimeDiffOfLastMsgInSec = _DateDiff("s", _NowCalc(), _DateAdd('n', $g_sDelayTimeGlobal, $g_sGlobalChatLastMsgSentTime))
					SetDebugLog("$sDateTimeDiffOfLastMsgInSec = " & $sDateTimeDiffOfLastMsgInSec)
					_TicksToTime($sDateTimeDiffOfLastMsgInSec * 1000, $hour, $min, $sec)

					SetLog("Chatbot: Skip Sending Chats to Global chat", $COLOR_INFO)
					SetLog("Delay Time " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec) & " left before sending new msg.", $COLOR_INFO)
					Return False
				EndIf
		Case "CLAN"
			If $g_sClanChatLastMsgSentTime = "" Then Return True ;If ClanLastMsgSentTime sent time is empty means it's first time sms allow it

				Local $sDateTimeDiffOfLastMsgInMin = _DateDiff("s", $g_sClanChatLastMsgSentTime, _NowCalc()) / 60 ;For getting float value of minutes(s) we divided the diffsec by 60
				SetDebugLog("$g_iTxtDelayTimeClan = " & $g_sDelayTimeClan)
				SetDebugLog("$g_sClanChatLastMsgSentTime = " & $g_sClanChatLastMsgSentTime & ", $sDateTimeDiffOfLastMsgInMin = " & $sDateTimeDiffOfLastMsgInMin)
				If $sDateTimeDiffOfLastMsgInMin > $g_sDelayTimeClan Then ;If ClanLastMsgSentTime sent time is empty means it's first time sms
					Return True
				Else
					Local $hour = 0, $min = 0, $sec = 0
					Local $sDateTimeDiffOfLastMsgInSec = _DateDiff("s", _NowCalc(), _DateAdd('n', $g_sDelayTimeClan, $g_sClanChatLastMsgSentTime))
					SetDebugLog("$sDateTimeDiffOfLastMsgInSec = " & $sDateTimeDiffOfLastMsgInSec)
					_TicksToTime($sDateTimeDiffOfLastMsgInSec * 1000, $hour, $min, $sec)

					SetLog("Chatbot: Skip Sending Chats To clan chat", $COLOR_INFO)
					SetLog("Delay Time " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec) & " left before sending new msg.", $COLOR_INFO)
					Return False
				EndIf
		Case "FC"
			If $g_sFCLastMsgSentTime = "" Then Return True ;If ClanLastMsgSentTime sent time is empty means it's first time sms allow it

				Local $sDateTimeDiffOfLastMsgInMin = _DateDiff("s", $g_sFCLastMsgSentTime, _NowCalc()) / 60 ;For getting float value of minutes(s) we divided the diffsec by 60
				SetDebugLog("$g_iTxtDelayTimeFC = " & $g_sDelayTimeFC)
				SetDebugLog("$g_sFCLastMsgSentTime = " & $g_sFCLastMsgSentTime & ", $sDateTimeDiffOfLastMsgInMin = " & $sDateTimeDiffOfLastMsgInMin)
				If $sDateTimeDiffOfLastMsgInMin > $g_sDelayTimeFC Then ;If ClanLastMsgSentTime sent time is empty means it's first time sms
					Return True
				Else
					Local $hour = 0, $min = 0, $sec = 0
					Local $sDateTimeDiffOfLastMsgInSec = _DateDiff("s", _NowCalc(), _DateAdd('n', $g_sDelayTimeFC, $g_sFCLastMsgSentTime))
					SetDebugLog("$sDateTimeDiffOfLastMsgInSec = " & $sDateTimeDiffOfLastMsgInSec)
					_TicksToTime($sDateTimeDiffOfLastMsgInSec * 1000, $hour, $min, $sec)

					SetLog("Chatbot: Skip Sending Chats To friendly challenge", $COLOR_INFO)
					SetLog("Delay Time " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec) & " left before sending new challenge.", $COLOR_INFO)
					Return False
				EndIf
	EndSwitch
EndFunc   ;==>DelayTime

Func ChatClan() ; Handle Clan Chat Logic
	If Not $g_bChatClan Then Return
	While 1
		SetLog("Chatbot: Will Send Clan Chat", $COLOR_INFO)
		If Not ChatbotChatOpen() Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		If Not ChatbotSelectClanChat() Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		If Not ChatbotCheckIfUserIsInClan() Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		Local $SentClanChat = False
		_Sleep(2000)
		If $ChatbotReadQueued Then
			ChatbotNotifySendChat()
			$ChatbotReadQueued = False
			$SentClanChat = True
		ElseIf $ChatbotIsOnInterval Then
			If ChatbotIsInterval() Then
				ChatbotStartTimer()
				ChatbotNotifySendChat()
				$SentClanChat = True
			EndIf
		EndIf

		If UBound($ChatbotQueuedChats) > 0 Then
			SetLog("Chatbot: Sending Notify Chats", $COLOR_GREEN)

			For $a = 0 To UBound($ChatbotQueuedChats) - 1
				Local $ChatToSend = $ChatbotQueuedChats[$a]
				If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
				If Not ChatbotChatInput(_Encoding_JavaUnicodeDecode($ChatToSend)) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
				If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
			Next

			Dim $Tmp[0] ; clear queue
			$ChatbotQueuedChats = $Tmp
			_Sleep(2000)
			ChatbotNotifySendChat()

			ExitLoop ;Chatbot: Clan Chatting Done Exit Loop So bot can close chat dailog
		EndIf

		If Not ChatbotIsLastChatNew() Then
			; get text of the latest message
			Local $sLastChat
			ReadChatIA($sLastChat, -1, True)
			Local $ChatMsg = StringStripWS($sLastChat, 7)
			SetLog("Found Chat Message : " & $ChatMsg, $COLOR_GREEN)
			Local $SentMessage = False

			If StringStripWS($ChatMsg, $STR_STRIPALL) = "" Then
				If $g_bClanAlwaysMsg Then
					If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotChatInput($g_iTxtClanMessages[Random(0, UBound($g_iTxtClanMessages) - 1, 1)]) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					$SentMessage = True
				EndIf
			EndIf

			If $g_bClanUseResponses And Not $SentMessage Then
				For $a = 0 To UBound($g_iTxtClanResponses) - 1
					If StringInStr($ChatMsg, $g_iTxtClanResponses[$a][0]) Then
						Local $Response = $g_iTxtClanResponses[$a][1]
						SetLog("Sending Response : " & $Response, $COLOR_GREEN)
						If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
						If Not ChatbotChatInput($Response) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
						If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
						$SentMessage = True
						ExitLoop
					EndIf
				Next
			EndIf

			If $g_bCleverbot And Not $SentMessage Then
				Local $Response = runHelper($ChatMsg, $g_bCleverbot)
				If $Response = False Or StringStripWS($ChatMsg, $STR_STRIPALL) <> "" Then
					;If Not _Encoding_JavaUnicodeDecode($sString) Then Return
					SetLog("Got Cleverbot Response : " & $Response, $COLOR_GREEN)
					If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotChatInput($Response) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					$SentMessage = True
				EndIf
			EndIf
			If Not $SentMessage Then
				If $g_bClanAlwaysMsg Then
					If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotChatInput($g_iTxtClanMessages[Random(0, UBound($g_iTxtClanMessages) - 1, 1)]) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
				EndIf
			EndIf

			; send it via Notify if it's new
			; putting the code here makes sure the (cleverbot, specifically) response is sent as well :P
			If $g_bUseNotify And $g_bPbSendNew Then
				If Not $SentClanChat Then ChatbotNotifySendChat()
			EndIf
		ElseIf $g_bClanAlwaysMsg Then
			If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
			If Not ChatbotChatInput($g_iTxtClanMessages[Random(0, UBound($g_iTxtClanMessages) - 1, 1)]) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
			If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		EndIf
		ExitLoop
	WEnd
	ChatbotChatClose() ;Close Chat Dialog At the End Of Chat
	SetLog("Chatbot: Clan Chatting Done", $COLOR_GREEN)

EndFunc   ;==>ChatClan

Func ChatGlobal() ; Handle Global Chat Logic
	If Not $g_bChatGlobal Then Return
	While 1
		SetLog("Chatbot: Sending Chats To Global", $COLOR_INFO)
		If $g_bSwitchLang Then
			Local $aButtonLanguage = $aButtonLanguageEN ;By default English Language.
			Local $cmbLangMsg = GUICtrlRead($g_hCmbLang)
			Switch GUICtrlRead($g_hCmbLang) ; Just Slect Button Coridnates for language which you want to switch
				Case "FR"
					$aButtonLanguage = $aButtonLanguageFRA
				Case "DE"
					$aButtonLanguage = $aButtonLanguageDE
				Case "ES"
					$aButtonLanguage = $aButtonLanguageES
				Case "IT"
					$aButtonLanguage = $aButtonLanguageITA
				Case "NL"
					$aButtonLanguage = $aButtonLanguageNL
				Case "NO"
					$aButtonLanguage = $aButtonLanguageNO
				Case "PR"
					$aButtonLanguage = $aButtonLanguagePR
				Case "TR"
					$aButtonLanguage = $aButtonLanguageTR
				Case "RU"
					$aButtonLanguage = $aButtonLanguageRU
			EndSwitch
			If Not ChangeLanguageLifeCycle($aButtonLanguage, $cmbLangMsg) Then ;Switch Language
				ChatbotSettingClose() ; If something bad happen close settings And return don't send chats
				SetLog("Chatbot: Global Chatting Done", $COLOR_GREEN)
				Return
			EndIf
		EndIf
		If Not ChatbotChatOpen() Then ExitLoop ; Error Exit Loop So bot can close chat dailog & switch back to english

		; assemble a message
		Global $g_sMessage[2]
		$g_sMessage[0] = $g_iTxtGlobalMessages1[Random(0, UBound($g_iTxtGlobalMessages1) - 1, 1)]
		$g_sMessage[1] = $g_iTxtGlobalMessages2[Random(0, UBound($g_iTxtGlobalMessages2) - 1, 1)]

		If $g_bScrambleGlobal Then
			_ArrayShuffle($g_sMessage)
		EndIf

		; Send the message
		If Not ChatbotSelectGlobalChat() Then ExitLoop
		If Not ChatbotSelectChatInput("Global") Then ExitLoop ; Error Exit Loop So bot can close chat dailog & switch back to english
		If Not ChatbotChatInput(_ArrayToString($g_sMessage, " ")) Then ExitLoop ; Error Exit Loop So bot can close chat dailog & switch back to english
		If Not ChatbotSendChat("Global") Then ExitLoop ; Error Exit Loop So bot can close chat dailog & switch back to english

		ExitLoop
	WEnd

	ChatbotChatClose() ;Close Chat Dialog At the End Of Chat

	; Change Language Back To English
	If $g_bSwitchLang Then
		Local $iReHere = 0
		While $iReHere < 3 ; If Emulator is slow or something bad happen bot will try to switch language Back to english it will retry 3 times
			If Not $g_bRunState Then Return
			$iReHere += 1
			If Not ChangeLanguageLifeCycle($aButtonLanguageEN, "EN") Then ; Change Language Back To English
				ChatbotSettingClose() ; If something bad happen close settings.
				SetLog("Chatbot: Sorry, Unable To Switch Back To English Try Again : (" & $iReHere & "/3)", $COLOR_ERROR)
				If _Sleep(500) Then Return
				ContinueLoop
			EndIf
			ExitLoop ; Means switched back to english successfully quit loop
		WEnd
	EndIf

	SetLog("Chatbot: Global Chatting Done", $COLOR_GREEN)
EndFunc   ;==>ChatGlobal

Func ChatbotChatOpen() ; open the chat area
	ClickP($aAway, 1, 0, "#0167") ;Click Away
	ForceCaptureRegion()
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If Not _CheckPixel($aChatTab, $g_bCapturePixel) Or Not _CheckPixel($aChatTab2, $g_bCapturePixel) Or Not _CheckPixel($aChatTab3, $g_bCapturePixel) Then ClickP($aOpenChat, 1, 0, "#0168") ; Clicks chat tab
	If _Sleep($DELAYCHATACTIONS3) Then Return
	If _WaitForCheckPixel($aChatTab, $g_bCapturePixel, Default, "Wait for ClanChat Page #1:") Or _
		_WaitForCheckPixel($aChatTab2, $g_bCapturePixel, Default, "Wait for ClanChat Page #2:") Or _
		_WaitForCheckPixel($aChatTab3, $g_bCapturePixel, Default, "Wait for ClanChat Page #3:") Then
		SetLog("Chatbot: Chat Window Opened.", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Chat Window Did Not Opened.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotChatOpen

Func ChatbotChatClose() ; close chat area
	Click($aCloseChat[0], $aCloseChat[1], 1, 0, "CloseChatBtn") ; close chat
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _Wait4PixelGone($aChatTab[0], $aChatTab[1], $aChatTab[2], $aChatTab[3], 5000, "Wait for Close ClanChat #1:") Or _
		_Wait4PixelGone($aChatTab2[0], $aChatTab2[1], $aChatTab2[2], $aChatTab2[3], 5000, "Wait for Close ClanChat #2:") Or _
		_Wait4PixelGone($aChatTab3[0], $aChatTab3[1], $aChatTab3[2], $aChatTab3[3], 5000, "Wait for Close ClanChat #3:") Then
		SetLog("Chatbot: Chat Window Closed.", $COLOR_INFO)
		waitMainScreen()
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Close The Chat.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotChatClose

Func ChatbotSelectGlobalChat() ; select global tab
	Click($aGlobalChatTab[0], $aGlobalChatTab[1], 1, 0, "GlobalChatBtn") ; switch to Global Chat tab
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aGlobalChatTab, $g_bCapturePixel, Default, "Wait for Global Chat tab:") Then
		SetLog("Chatbot: Global Tab Selected.", $COLOR_SUCCESS)
		Local $aCoord = decodeSingleCoord(findImage("I Understand", $g_sImgChatIUnterstand, GetDiamondFromRect("50,400,280,550")))
		If UBound($aCoord) > 1 Then
			If $g_bDebugSetlog Then SetDebugLog("Clicking 'I Understand' button", $COLOR_ACTION)
			ClickP($aCoord)
			If _Sleep($DELAYDONATECC2) Then Return
		EndIf
		Return True
	Else
		SetLog("Chatbot: Sorry, Global Tab Not Selected.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSelectGlobalChat

Func ChatbotSelectClanChat() ; select clan tab
	Click($aClanChatTab[0], $aClanChatTab[1], 1, 0, "ClanChatBtn") ; switch to Clan Chat tab
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aClanChatTab, $g_bCapturePixel, Default, "Wait for Clan Chat tab:") Then
		SetLog("Chatbot: Clan Tab Selected.", $COLOR_SUCCESS)
		Local $aCoord = decodeSingleCoord(findImage("I Understand", $g_sImgChatIUnterstand, GetDiamondFromRect("50,400,280,550")))
		If UBound($aCoord) > 1 Then
			If $g_bDebugSetlog Then SetDebugLog("Clicking 'I Understand' button", $COLOR_ACTION)
			ClickP($aCoord)
			If _Sleep($DELAYDONATECC2) Then Return
		EndIf
		Return True
	Else
		SetLog("Chatbot: Sorry, Clan Tab Not Selected.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSelectClanChat

Func ChatbotCheckIfUserIsInClan() ; check if user is in a clan before doing chat
	If Not _CheckPixel($aClanBadgeNoClan, $g_bCapturePixel, Default, "Clan Badge No Clan:") Then
		Return True
	Else
		SetLog("Chatbot: Sorry, You Are Not In A Clan You Can't Chat.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotCheckIfUserIsInClan

Func ChatbotSelectChatInput($fromTab) ; select the textbox for Global chat or Clan Chat
	Click($aChatSelectTextBox[0], $aChatSelectTextBox[1], 1, 0, "SelectTextBoxBtn")
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aOpenedChatSelectTextBox, $g_bCapturePixel, Default, "Wait for Chat Select Text Box:") Then
		SetLog("Chatbot: " & $fromTab & " Chat TextBox Appeared.", $COLOR_INFO)
		Return True
	Else
		SetLog("Chatbot: Sorry, " & $fromTab & " Chat TextBox Is Not Opened.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSelectChatInput

Func ChatbotChatInput($g_sMessage)
	SetLog("Chatbot: Type Msg : " & $g_sMessage, $COLOR_SUCCESS)
	Click($aOpenedChatSelectTextBox[0], $aOpenedChatSelectTextBox[1], 1, 0, "ChatInput")
	If _Sleep($DELAYCHATACTIONS5) Then Return
	If $g_bRusLang Then
		SetLog("Chat Send In Russia", $COLOR_INFO)
		AutoItWinSetTitle('MyAutoItTitle')
		_WinAPI_SetKeyboardLayout(WinGetHandle(AutoItWinGetTitle()), 0x0419)
		_Sleep($DELAYCHATACTIONS3)
		ControlFocus($g_hAndroidWindow, "", "")
		SendKeepActive($g_hAndroidWindow)
		_Sleep($DELAYCHATACTIONS3)
		AutoItSetOption("SendKeyDelay", 50)
		_SendExEx($g_sMessage)
		SendKeepActive("")
	Else
		_Sleep($DELAYCHATACTIONS3)
		SendText($g_sMessage)
	EndIf
	Return True
EndFunc   ;==>ChatbotChatInput

Func ChatbotSendChat($fromTab) ; click send for global or clan chat
	If _CheckPixel($aChatSendBtn, $g_bCapturePixel, Default, "Chat Send (" & $fromTab & ") Btn:") Then
		Click($aChatSendBtn[0], $aChatSendBtn[1], 1, 0, "ChatSendBtn") ; send
		If _Sleep($DELAYCHATACTIONS5) Then Return
		Return True
	Else
		SetLog("Chatbot: Sorry, " & $fromTab & " Chat Send Button is not available.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSendChat

Func ChatbotIsLastChatNew() ; returns true if the last chat was not by you, false otherwise
	_CaptureRegion()
	For $x = 38 To 261
		If _ColorCheck(_GetPixelColor($x, 129), Hex(0x78BC10, 6), 5) Then Return True ; detect the green menu button
	Next
	Return False
EndFunc   ;==>ChatbotIsLastChatNew

Func ChatbotNotifySendChat()
	If Not $g_bUseNotify Then Return

	Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
	Local $Time = @HOUR & "." & @MIN & "." & @SEC
	_CaptureRegion(0, 0, 320, 675)
	Local $ChatFile = $Date & "__" & $Time & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
	_GDIPlus_ImageSaveToFile($g_hBitmap, $g_sProfileLootsPath & $ChatFile)
	_GDIPlus_ImageDispose($g_hBitmap)
	;push the file
	SetLog("Chatbot: Sent chat image", $COLOR_SUCCESS)
	NotifyPushFileToTelegram($ChatFile, "Loots", "image/jpeg", $g_sNotifyOrigin & " | Last Clan Chats" & "\n" & $ChatFile)
	;wait a second and then delete the file
	If _Sleep($DELAYPUSHMSG2) Then Return
	Local $iDelete = FileDelete($g_sProfileLootsPath & $ChatFile)
	If Not ($iDelete) Then SetLog("Chatbot: Failed to delete temp file", $COLOR_ERROR)
EndFunc   ;==>ChatbotNotifySendChat

Func ChatbotStartTimer()
	$ChatbotStartTime = TimerInit()
EndFunc   ;==>ChatbotStartTimer

Func ChatbotIsInterval()
	Local $Time_Difference = TimerDiff($ChatbotStartTime)
	If $Time_Difference > $ChatbotReadInterval * 1000 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>ChatbotIsInterval

Func ChatbotNotifyQueueChat($Chat)
	If Not $g_bUseNotify Then Return
	_ArrayAdd($ChatbotQueuedChats, $Chat)
EndFunc   ;==>ChatbotNotifyQueueChat

Func ChatbotNotifyQueueChatRead()
	If Not $g_bUseNotify Then Return
	$ChatbotReadQueued = True
EndFunc   ;==>ChatbotNotifyQueueChatRead

Func ChatbotNotifyStopChatRead()
	If Not $g_bUseNotify Then Return
	$ChatbotReadInterval = 0
	$ChatbotIsOnInterval = False
EndFunc   ;==>ChatbotNotifyStopChatRead

Func ChatbotNotifyIntervalChatRead($Interval)
	If Not $g_bUseNotify Then Return
	$ChatbotReadInterval = $Interval
	$ChatbotIsOnInterval = True
	ChatbotStartTimer()
EndFunc   ;==>ChatbotNotifyIntervalChatRead

Func ChangeLanguageLifeCycle($aButtonLanguage, $cmbLangMsg) ;Call this function when wants to change language
	If Not ChatbotSettingOpen() Then Return False ;First Open Setting
	If Not ChatbotClickLanguageButton() Then Return False ;Second Click Language Button
	If Not ChangeLanguageForChatBot($aButtonLanguage, $cmbLangMsg) Then Return False ;Third Select Language Which You Want To Switch

	If Not ChangeLanguagePressOk($cmbLangMsg) Then ; Fourth Press OK On Lanugage Select Dialog
		ClickP($aAway, 1, 0, "#0167") ;If Dialog unable to be clicked on means something bad happened press away
		Return False
	Else
		Sleep(3000)
		checkMainScreen()
		Return True
	EndIf
EndFunc   ;==>ChangeLanguageLifeCycle

Func ChatbotSettingOpen() ; Open the Settings
	ClickP($aAway, 1, 0, "#0167") ;Click Away to prevent any pages on top
	ForceCaptureRegion()
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _CheckPixel($aButtonSetting, $g_bCapturePixel, Default, "OpenSettingBtn:") Then Click($aButtonSetting[0], $aButtonSetting[1], 1, 0, "OpenSettingBtn")
	If _WaitForCheckPixel($aIsSettingPage, $g_bCapturePixel, Default, "Wait for Setting Page:") Then
		SetLog("Chatbot: Main Settings Opened.", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Settings Did Not Opened.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSettingOpen

Func ChatbotSettingClose() ; close settings
	Click($aIsSettingPage[0], $aIsSettingPage[1], 1, 0, "CloseSettingBtn") ; close setting
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _Wait4PixelGone($aIsSettingPage[0], $aIsSettingPage[1], $aIsSettingPage[2], $aIsSettingPage[3], 5000, "Wait for Close Setting Page:") Then
		SetLog("Chatbot: Close Language Settings Window.", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Close The Settings.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSettingClose

Func ChatbotClickLanguageButton() ; Click on language button in settings
	Click($aSelectLangBtn[0], $aSelectLangBtn[1], 1, 0, "SelectLanguageBtn") ; Click on language button in settings
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aOpenedSelectLang, $g_bCapturePixel, Default, "Wait for Select Language Page:") Then
		SetLog("Chatbot: Language Settings Opened", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Language Screen Not Opened.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotClickLanguageButton

Func ChangeLanguageForChatBot($aButtonLanguage, $cmbLangMsg) ; Select Language Which You Want To Switch and click on that
	SetLog("Chatbot: Switching Language To " & $cmbLangMsg, $COLOR_SUCCESS)
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If $cmbLangMsg == "EN" Then
		ClickDrag(775, 180, 775, 440)
		If _Sleep($DELAYCHATACTIONS7) Then Return
	EndIf
	Click($aButtonLanguage[0], $aButtonLanguage[1], 1, 0, "LanguageBtn") ; Click on language button in settings
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aLangSelected, $g_bCapturePixel, Default, "Wait for Selected Language:") Then
		Click($aIsSettingPage[0], $aIsSettingPage[1], 1, 0, "CloseSettingBtn") ; close setting
		If _Sleep($DELAYCHATACTIONS2) Then Return
		SetLog("Chatbot: Sorry, Language Change Dialog Does Not Appear. May Be You Are Already In : " & $cmbLangMsg, $COLOR_SUCCESS)
		Return True
	EndIf
	Return True
EndFunc   ;==>ChangeLanguageForChatBot

Func ChangeLanguagePressOk($cmbLangMsg) ;Press OK On Lanugage Select Dialog
	Click(Random(460, 565, 1), Random(412, 447, 1), 1, 0, "OkayBtn")
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _Wait4PixelGone($aLangSettingOK[0], $aLangSettingOK[1], $aLangSettingOK[2], $aLangSettingOK[3], 5000, "Okay Button:") Then
		SetLog("Chatbot: Language Successfully Changed To : " & $cmbLangMsg, $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Change Language : " & $cmbLangMsg, $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChangeLanguagePressOk

; Returns the response from cleverbot or simsimi, if any
Func runHelper($msg, $bCleverbot) ; run a script to get a response from cleverbot.com or simsimi.com
	Local $command, $DOS, $HelperStartTime, $Time_Difference
	Dim $DOS, $g_sMessage = ''

	$command = ' /c "phantomjs.exe phantom-cleverbot-helper.js '

	$DOS = Run(@ComSpec & $command & $msg & '"', "", @SW_HIDE, 8)
	$HelperStartTime = TimerInit()
	SetLog("Waiting for chatbot helper...")
	While ProcessExists($DOS)
		ProcessWaitClose($DOS, 10)
		SetLog("Still waiting for chatbot helper...")
		$Time_Difference = TimerDiff($HelperStartTime)
		If $Time_Difference > 50000 Then
			SetLog("Chatbot helper is taking too long!", $COLOR_RED)
			ProcessClose($DOS)
			_RunDos("taskkill -f -im phantomjs.exe") ; force kill
			Return ""
		EndIf
	WEnd
	$g_sMessage = ''
	While 1
		$g_sMessage &= StdoutRead($DOS)
		If @error Then
			ExitLoop
		EndIf
	WEnd
	Return StringStripWS($g_sMessage, 7)
EndFunc   ;==>runHelper

Func _Encoding_JavaUnicodeDecode($sString)
	Local $iOld_Opt_EVS = Opt('ExpandVarStrings', 0)
	Local $iOld_Opt_EES = Opt('ExpandEnvStrings', 0)

	Local $sOut = "", $aString = StringRegExp($sString, "(\\\\|\\'|\\u[[:xdigit:]]{4}|[[:ascii:]])", 3)

	For $i = 0 To UBound($aString) - 1
		Switch StringLen($aString[$i])
			Case 1
				$sOut &= $aString[$i]
			Case 2
				$sOut &= StringRight($aString[$i], 1)
			Case 6
				$sOut &= ChrW(Dec(StringRight($aString[$i], 4)))
		EndSwitch
	Next

	Opt('ExpandVarStrings', $iOld_Opt_EVS)
	Opt('ExpandEnvStrings', $iOld_Opt_EES)

	Return $sOut
EndFunc   ;==>_Encoding_JavaUnicodeDecode

Func _StringRemoveBlanksFromSplit(ByRef $strMsg) ;Remove empty string pipes from string e.g |Test||Hey all| becomes Test|Hey all (Using in Chat to avoid empty messages)
	Local $strArray = StringSplit($strMsg, "|", 2)
	$strMsg = ""

	For $i = 0 To (UBound($strArray) - 1)
		If $strArray[$i] <> "" Then
			$strMsg = $strMsg & $strArray[$i] & "|"
		EndIf
	Next
	If ($strMsg <> "") Then $strMsg = StringTrimRight($strMsg, 1) ;Remove last extra pipe from string

EndFunc   ;==>_StringRemoveBlanksFromSplit
