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
Global Const $DELAYCHATACTIONS2 = 250
Global Const $DELAYCHATACTIONS3 = 500
Global Const $DELAYCHATACTIONS4 = 750
Global Const $DELAYCHATACTIONS5 = 1000
Global Const $DELAYCHATACTIONS6 = 1250
Global Const $DELAYCHATACTIONS7 = 1500

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

					SetLog("Chatbot: Skip Sending Chats to Global Chat", $COLOR_INFO)
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

					SetLog("Chatbot: Skip Sending Chats to Clan Chat", $COLOR_INFO)
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

					SetLog("Chatbot: Skip Sending Chats to Friendly Challenge", $COLOR_INFO)
					SetLog("Delay Time " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec) & " left before sending new challenge.", $COLOR_INFO)
					Return False
				EndIf
	EndSwitch
EndFunc   ;==>DelayTime

Func ChatActions() ; run the chatbot
	ApplyConfig_MOD_ChatActions("Save")

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

EndFunc   ;==>ChatActions

Func ChatClan() ; Handle Clan Chat Logic
	If Not $g_bChatClan Then Return
	While 1
		SetLog("Chatbot: Sending Chats To Clan", $COLOR_INFO)
		If Not ChatbotChatOpen() Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		If Not ChatbotSelectClanChat() Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		If Not ChatbotCheckIfUserIsInClan() Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		Local $bSentClanChat = False
		If _Sleep(2000) Then Return
		If $ChatbotReadQueued Then
			ChatbotNotifySendChat()
			$ChatbotReadQueued = False
			$bSentClanChat = True
		ElseIf $ChatbotIsOnInterval Then
			If ChatbotIsInterval() Then
				ChatbotStartTimer()
				ChatbotNotifySendChat()
				$bSentClanChat = True
			EndIf
		EndIf

		If UBound($ChatbotQueuedChats) > 0 Then
			SetLog("Chatbot: Sending Notify Chats", $COLOR_SUCCESS)

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
			Local $sChatMsg = "", $bChatMsg = False, $sCondition = ""

			For $iRespInt = 0 To UBound($g_sClanResponses)-1
				$sCondition &= $g_sClanResponses[$iRespInt][0] & "|"
			Next

			$bChatMsg = ReadChatIA($sChatMsg, $sCondition, True)

			Local $bSentMessage = False
			If Not $bChatMsg Then
				If $g_bClanUseGeneric Then
					If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotChatInput($g_sClanGeneric[Random(0, UBound($g_sClanGeneric) - 1, 1)]) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					$bSentMessage = True
				EndIf
			EndIf

			If $bChatMsg And $g_bClanUseResponses And Not $bSentMessage Then
				For $a = 0 To UBound($g_sClanResponses) - 1
					If StringInStr($sChatMsg, $g_sClanResponses[$a][0]) Then
						Local $sResponse = $g_sClanResponses[$a][1]
						SetLog("Sending Response : " & $sResponse, $COLOR_SUCCESS)
						If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
						If Not ChatbotChatInput($sResponse) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
						If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
						$bSentMessage = True
						ExitLoop
					EndIf
				Next
			EndIf

			If $g_bCleverbot And Not $bSentMessage Then
				Local $sResponse = runHelper($sChatMsg, $g_bCleverbot)
				If $sResponse = False Or StringStripWS($sChatMsg, $STR_STRIPALL) <> "" Then
					SetLog("Got Cleverbot Response : " & $sResponse, $COLOR_SUCCESS)
					If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotChatInput($sResponse) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					$bSentMessage = True
				EndIf
			EndIf
			If Not $bSentMessage Then
				If $g_bClanUseGeneric Then
					If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotChatInput($g_sClanGeneric[Random(0, UBound($g_sClanGeneric) - 1, 1)]) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
					If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
				EndIf
			EndIf

			; send it via Notify if it's new
			; putting the code here makes sure the (cleverbot, specifically) response is sent as well :P
			If $g_bUseNotify And $g_bPbSendNew Then
				If Not $bSentClanChat Then ChatbotNotifySendChat()
			EndIf
		ElseIf $g_bClanUseGeneric Then
			If Not ChatbotSelectChatInput("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
			If Not ChatbotChatInput($g_sClanGeneric[Random(0, UBound($g_sClanGeneric) - 1, 1)]) Then ExitLoop ; Error Exit Loop So bot can close chat dailog
			If Not ChatbotSendChat("Clan") Then ExitLoop ; Error Exit Loop So bot can close chat dailog
		EndIf
		ExitLoop
	WEnd

	ChatbotChatClose() ;Close Chat Dialog At the End Of Chat
	SetLog("Chatbot: Clan Chatting Done", $COLOR_SUCCESS)
EndFunc   ;==>ChatClan

Func ChatGlobal() ; Handle Global Chat Logic
	If Not $g_bChatGlobal Then Return
	While 1
		SetLog("Chatbot: Sending Chats To Global", $COLOR_INFO)
		If $g_bSwitchLang Then
			Local $aButtonLanguage = $aButtonLanguageEN ;By default English Language.
			Local $aLangSelected = $aLangSelectedEN
			Local $cmbLangMsg = GUICtrlRead($g_hCmbLang)
			Switch GUICtrlRead($g_hCmbLang) ; Just Slect Button Coridnates for language which you want to switch
				Case "FR"
					$aButtonLanguage = $aButtonLanguageFRA
					$aLangSelected = $aLangSelectedFRA
				Case "DE"
					$aButtonLanguage = $aButtonLanguageDE
					$aLangSelected = $aLangSelectedDE
				Case "ES"
					$aButtonLanguage = $aButtonLanguageES
					$aLangSelected = $aLangSelectedES
				Case "IT"
					$aButtonLanguage = $aButtonLanguageITA
					$aLangSelected = $aLangSelectedITA
				Case "NL"
					$aButtonLanguage = $aButtonLanguageNL
					$aLangSelected = $aLangSelectedNL
				Case "NO"
					$aButtonLanguage = $aButtonLanguageNO
					$aLangSelected = $aLangSelectedNO
				Case "PR"
					$aButtonLanguage = $aButtonLanguagePR
					$aLangSelected = $aLangSelectedPR
				Case "TR"
					$aButtonLanguage = $aButtonLanguageTR
					$aLangSelected = $aLangSelectedTR
				Case "RU"
					$aButtonLanguage = $aButtonLanguageRU
					$aLangSelected = $aLangSelectedRU
			EndSwitch
			If Not ChangeLanguageLifeCycle($aButtonLanguage, $aLangSelected, $cmbLangMsg) Then ;Switch Language
				ChatbotSettingClose() ; If something bad happen close settings And return don't send chats
				SetLog("Chatbot: Language Switch Done.", $COLOR_SUCCESS)
				Return
			EndIf
		EndIf

		If Not ChatbotChatOpen() Then ExitLoop ; Error Exit Loop So bot can close chat dailog & switch back to english
		If Not ChatbotSelectGlobalChat() Then ExitLoop
		If Not ChatbotSelectChatInput("Global") Then ExitLoop ; Error Exit Loop So bot can close chat dailog & switch back to english

		; assemble a message
		Global $g_sMessage[2]
		$g_sMessage[0] = $g_sGlobalMessages1[Random(0, UBound($g_sGlobalMessages1) - 1, 1)]
		$g_sMessage[1] = $g_sGlobalMessages2[Random(0, UBound($g_sGlobalMessages2) - 1, 1)]
		If $g_bScrambleGlobal Then
			_ArrayShuffle($g_sMessage)
		EndIf
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
			If Not ChangeLanguageLifeCycle($aButtonLanguageEN, $aLangSelectedEN, "EN") Then ; Change Language Back To English
				ChatbotSettingClose() ; If something bad happen close settings.
				SetLog("Chatbot: Sorry, Unable To Switch Back To English Try Again : (" & $iReHere & "/3)", $COLOR_ERROR)
				If _Sleep(500) Then Return
				ContinueLoop
			EndIf
			ExitLoop ; Means switched back to english successfully quit loop
		WEnd
	EndIf

	SetLog("Chatbot: Global Chatting Done", $COLOR_SUCCESS)
EndFunc   ;==>ChatGlobal

Func ChatbotChatOpen() ; open the chat area
	SetDebugLog("ChatBot|Begin ChatbotChatOpen", $COLOR_DEBUG)

	ClickP($aAway, 1, 0, "#0167") ;Click Away
	ForceCaptureRegion()
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If Not _CheckPixel($aChatTab, $g_bCapturePixel) Or Not _CheckPixel($aChatTab2, $g_bCapturePixel) Or Not _CheckPixel($aChatTab3, $g_bCapturePixel) Then
		ClickP($aOpenChat, 1, 0, "#OpenChatBtn") ; Clicks chat tab
		If _Sleep($DELAYCHATACTIONS2) Then Return
		If _WaitForCheckPixel($aChatTab, $g_bCapturePixel, Default, "Wait for Open ClanChat #1:") Or _WaitForCheckPixel($aChatTab2, $g_bCapturePixel, Default, "Wait for Open ClanChat #2:") Or _WaitForCheckPixel($aChatTab3, $g_bCapturePixel, Default, "Wait for Open ClanChat #3:") Then
			SetDebugLog("Chatbot: Chat Window Opened.", $COLOR_SUCCESS)
			Return True
		Else
			SetDebugLog("Chatbot: Not find $aChatTab|Pixel was:" & _GetPixelColor($aChatTab[0], $aChatTab[1], True), $COLOR_ERROR)
			Return False
		EndIf
	EndIf
	SetDebugLog("ChatBot|ChatbotChatOpen Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotChatOpen

Func ChatbotChatClose() ; close chat area
	SetDebugLog("ChatBot|Begin ChatbotChatClose", $COLOR_DEBUG)

	If _WaitForCheckPixel($aCloseChat, $g_bCapturePixel, Default, "Wait for Close Chat Btn:") Then
		Click($aCloseChat[0], $aCloseChat[1], 1, 0, "#CloseChatBtn") ; close chat
		If _Sleep($DELAYCHATACTIONS2) Then Return
		SetDebugLog("Chatbot: Chat Window Closed.", $COLOR_INFO)
		waitMainScreen()
		Return True
	Else
		SetDebugLog("Chatbot: Not find $aCloseChat|Pixel was:" & _GetPixelColor($aCloseChat[0], $aCloseChat[1], True), $COLOR_ERROR)
		Return False
	EndIf
	SetDebugLog("ChatBot|ChatbotChatClose Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotChatClose

Func ChatbotSelectGlobalChat() ; select global tab
	SetDebugLog("ChatBot|Begin ChatbotSelectGlobalChat", $COLOR_DEBUG)

	Click($aGlobalChatTab[0], $aGlobalChatTab[1], 1, 0, "GlobalChatBtn") ; switch to Global Chat tab
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aGlobalChatTab, $g_bCapturePixel, Default, "Wait for Global Chat tab:") Then
		SetDebugLog("Chatbot: Global Tab Selected.", $COLOR_SUCCESS)
		If _Sleep($DELAYCHATACTIONS2) Then Return
		If _CheckPixel($aChatRules, $g_bCapturePixel) Then ClickP($aChatRules, 1, 0, "#ChatRulesBtn")
		Return True
	Else
		SetDebugLog("Chatbot: Not find $aGlobalChatTab|Pixel was:" & _GetPixelColor($aGlobalChatTab[0], $aGlobalChatTab[1], True), $COLOR_ERROR)
		Return False
	EndIf
	SetDebugLog("ChatBot|ChatbotSelectGlobalChat Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotSelectGlobalChat

Func ChatbotSelectClanChat() ; select clan tab
	SetDebugLog("ChatBot|Begin ChatbotSelectClanChat", $COLOR_DEBUG)

	Click($aClanChatTab[0], $aClanChatTab[1], 1, 0, "ClanChatBtn") ; switch to Clan Chat tab
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aClanChatTab, $g_bCapturePixel, Default, "Wait for Clan Chat tab:") Then
		SetDebugLog("Chatbot: Clan Tab Selected.", $COLOR_SUCCESS)
		If _Sleep($DELAYCHATACTIONS2) Then Return
		If _CheckPixel($aChatRules, $g_bCapturePixel) Then ClickP($aChatRules, 1, 0, "#ChatRulesBtn")
		Return True
	Else
		SetDebugLog("Chatbot: Not find $aClanChatTab|Pixel was:" & _GetPixelColor($aClanChatTab[0], $aClanChatTab[1], True), $COLOR_ERROR)
		Return False
	EndIf
	SetDebugLog("ChatBot|ChatbotSelectClanChat Finished", $COLOR_DEBUG)
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
	SetDebugLog("ChatBot|Begin ChatbotSelectChatInput", $COLOR_DEBUG)

	Click($aChatSelectTextBox[0], $aChatSelectTextBox[1], 1, 0, "SelectTextBoxBtn")
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aOpenedChatSelectTextBox, $g_bCapturePixel, Default, "Wait for Chat Select Text Box:") Then
		SetDebugLog("Chatbot: " & $fromTab & " Chat TextBox Appeared.", $COLOR_INFO)
		Return True
	Else
		SetDebugLog("Chatbot: Not find $aOpenedChatSelectTextBox in " & $fromTab & "|Pixel was:" & _GetPixelColor($aOpenedChatSelectTextBox[0], $aOpenedChatSelectTextBox[1], True), $COLOR_ERROR)
		If _WaitForCheckPixel($aChatRules, $g_bCapturePixel, Default, "Wait for Chat Rules:") Then
			ClickP($aChatRules, 1, 0, "#ChatRulesBtn")
			If _Sleep($DELAYCHATACTIONS2) Then Return
			Return ChatbotSelectChatInput($fromTab)
		EndIf
		Return False
	EndIf
	SetDebugLog("ChatBot|ChatbotSelectChatInput Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotSelectChatInput

Func ChatbotChatInput($g_sMessage)
	SetDebugLog("ChatBot|Begin ChatbotChatInput", $COLOR_DEBUG)

	SetLog("Chatbot: Type msg : " & $g_sMessage, $COLOR_SUCCESS)
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
	SetDebugLog("ChatBot|ChatbotChatInput Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotChatInput

Func ChatbotSendChat($fromTab) ; click send for global or clan chat
	SetDebugLog("ChatBot|Begin ChatbotSendChat", $COLOR_DEBUG)

	If _CheckPixel($aChatSendBtn, $g_bCapturePixel, Default, "Chat Send (" & $fromTab & ") Btn:") Then
		Click($aChatSendBtn[0], $aChatSendBtn[1], 1, 0, "ChatSendBtn") ; send
		If _Sleep($DELAYCHATACTIONS5) Then Return
		Return True
	Else
		SetDebugLog("Chatbot: Not find $aChatSendBtn in " & $fromTab & "|Pixel was:" & _GetPixelColor($aChatSendBtn[0], $aChatSendBtn[1], True), $COLOR_ERROR)
		Return False
	EndIf
	SetDebugLog("ChatBot|ChatbotSendChat Finished", $COLOR_DEBUG)
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

Func ChatbotSettingOpen() ; Open the Settings
	SetDebugLog("ChatBot|Begin ChatbotSettingOpen", $COLOR_DEBUG)

	ClickP($aAway, 1, 0, "#0167") ;Click Away to prevent any pages on top
	ForceCaptureRegion()
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If Not _CheckPixel($aIsSettingPage, $g_bCapturePixel) Then
		Click($aButtonSetting[0], $aButtonSetting[1], 1, 0, "OpenSettingBtn")
		If _Sleep($DELAYCHATACTIONS2) Then Return
		If _WaitForCheckPixel($aIsSettingPage, $g_bCapturePixel, Default, "Wait for Setting Page:") Then
			SetDebugLog("Chatbot: Main Settings Opened.", $COLOR_SUCCESS)
			Return True
		Else
			SetDebugLog("Chatbot: Not find $aIsSettingPage|Pixel was:" & _GetPixelColor($aIsSettingPage[0], $aIsSettingPage[1], True), $COLOR_ERROR)
			Return False
		EndIf
	EndIf
	SetDebugLog("ChatBot|ChatbotSettingOpen Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotSettingOpen

Func ChatbotSettingClose() ; close settings
	SetDebugLog("ChatBot|Begin ChatbotSettingClose", $COLOR_DEBUG)

	If _WaitForCheckPixel($aIsSettingPage, $g_bCapturePixel, Default, "Wait for Close Setting Btn:") Then
		Click($aIsSettingPage[0], $aIsSettingPage[1], 1, 0, "#CloseChatBtn") ; close chat
		If _Sleep($DELAYCHATACTIONS2) Then Return
		SetDebugLog("Chatbot: Close Language Settings Window..", $COLOR_INFO)
		Return True
	Else
		SetDebugLog("Chatbot: Error in $aIsSettingPage|Pixel was:" & _GetPixelColor($aIsSettingPage[0], $aIsSettingPage[1], True), $COLOR_ERROR)
		Return False
	EndIf
	SetDebugLog("ChatBot|ChatbotSettingClose Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotSettingClose

Func ChatbotClickLanguageButton() ; Click on language button in settings
	SetDebugLog("ChatBot|Begin ChatbotClickLanguageButton", $COLOR_DEBUG)

	Click($aSelectLangBtn[0], $aSelectLangBtn[1], 1, 0, "SelectLanguageBtn") ; Click on language button in settings
	If _Sleep($DELAYCHATACTIONS2) Then Return
	If _WaitForCheckPixel($aOpenedSelectLang, $g_bCapturePixel, Default, "Wait for Select Language Page:") Then
		SetDebugLog("Chatbot: Language Settings Opened", $COLOR_SUCCESS)
		Return True
	Else
		SetDebugLog("Chatbot: Not find $aOpenedSelectLang|Pixel was:" & _GetPixelColor($aOpenedSelectLang[0], $aOpenedSelectLang[1], True), $COLOR_ERROR)
		Return False
	EndIf
	SetDebugLog("ChatBot|ChatbotClickLanguageButton Finished", $COLOR_DEBUG)
EndFunc   ;==>ChatbotClickLanguageButton

Func ChangeLanguageForChatBot($aButtonLanguage, $cmbLangMsg) ; Select Language Which You Want To Switch and click on that
	SetDebugLog("ChatBot|Begin ChangeLanguageForChatBot", $COLOR_DEBUG)

	Local $bDragDone = False
	If QuickMIS("N1", @ScriptDir & "\COCBot\Team__AiO__MOD++\Images\ChatActions", 130, 170, 195, 195, True, $g_bDebugImageSave) = "EN" Then
		$bDragDone = True
	Else
		ClickDrag(775, 180, 775, 440, 2000)
		If _Sleep($DELAYCHATACTIONS2) Then Return
		Local $iCount = 0
		While 1
			If QuickMIS("N1", @ScriptDir & "\COCBot\Team__AiO__MOD++\Images\ChatActions", 130, 170, 195, 195, True, $g_bDebugImageSave) = "EN" Then
				$bDragDone =  True
				ExitLoop
			EndIf
			$iCount += 1
			If $iCount >= 15 Then
				$bDragDone = False
				Return
			EndIf
		WEnd
	EndIf
	If $bDragDone Then ClickP($aButtonLanguage) ; Click on language button in settings
	SetLog("Chatbot: Switching Language To " & $cmbLangMsg, $COLOR_SUCCESS)
	If _Sleep($DELAYCHATACTIONS2) Then Return
	Return True
	SetDebugLog("ChatBot|ChangeLanguageForChatBot Finished", $COLOR_DEBUG)
EndFunc   ;==>ChangeLanguageForChatBot

Func ChangeLanguagePressOk($aLangSelected, $cmbLangMsg) ;Press OK On Lanugage Select Dialog
	SetDebugLog("ChatBot|Begin ChangeLanguagePressOk", $COLOR_DEBUG)

	If _CheckPixel($aLangSelected, $g_bCapturePixel, Default, "Wait for Selected Language:") Then
		SetLog("Chatbot: Sorry, You Are Already In : " & $cmbLangMsg, $COLOR_SUCCESS)
		Click($aIsSettingPage[0], $aIsSettingPage[1], 1, 0, "CloseSettingBtn") ; close setting
		If _Sleep($DELAYCHATACTIONS2) Then Return
		Return True
	Else
		If _WaitForCheckPixel($aLangSettingOK, $g_bCapturePixel, Default, "Wait for Okay Btn:") Then
			Click(Random(460, 565, 1), Random(412, 447, 1), 1, 0, "OkayBtn")
			If _Sleep($DELAYCHATACTIONS2) Then Return
			SetLog("Chatbot: Language Successfully Changed To : " & $cmbLangMsg, $COLOR_SUCCESS)
			Return True
		Else
			SetDebugLog("Chatbot: Error in $aLangSettingOK|Pixel was:" & _GetPixelColor($aLangSettingOK[0], $aLangSettingOK[1], True), $COLOR_ERROR)
			Return False
		EndIf
	EndIf
	SetDebugLog("ChatBot|ChangeLanguagePressOk Finished", $COLOR_DEBUG)
EndFunc   ;==>ChangeLanguagePressOk

Func ChangeLanguageLifeCycle($aButtonLanguage, $aLangSelected, $cmbLangMsg) ;Call this function when wants to change language
	If Not ChatbotSettingOpen() Then Return False ;First Open Setting
	If Not ChatbotClickLanguageButton() Then Return False ;Second Click Language Button
	If Not ChangeLanguageForChatBot($aButtonLanguage, $cmbLangMsg) Then Return False ;Third Select Language Which You Want To Switch

	If Not ChangeLanguagePressOk($aLangSelected, $cmbLangMsg) Then ; Fourth Press OK On Lanugage Select Dialog
		ClickP($aAway, 1, 0, "#0167") ;If Dialog unable to be clicked on means something bad happened press away
		Return False
	Else
		Sleep(3000)
		checkMainScreen()
		Return True
	EndIf
EndFunc   ;==>ChangeLanguageLifeCycle

; Returns the response from cleverbot or simsimi, if any
Func runHelper($msg, $g_bCleverbot) ; run a script to get a response from cleverbot.com or simsimi.com
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

Func _StringRemoveBlanksFromSplit($strMsg) ;Remove empty string pipes from string e.g |Test||Hey all| becomes Test|Hey all (Using in Chat to avoid empty messages)
	Local $strArray = StringSplit($strMsg, "|", 2)
	$strMsg = ""

	For $i = 0 To (UBound($strArray) - 1)
		If $strArray[$i] <> "" Then
			$strMsg = $strMsg & $strArray[$i] & "|"
		EndIf
	Next
	If ($strMsg <> "") Then $strMsg = StringTrimRight($strMsg, 1) ;Remove last extra pipe from string
	Return $strMsg
EndFunc   ;==>_StringRemoveBlanksFromSplit

Func FriendlyChallenge()
	If Not $g_bEnableFriendlyChallenge Then Return

	Local $aBaseForShare[0][2]
	Local $iCount4Share
	For $i = 0 To 5
		Local $bIAdd[1][2] = [[$i, $g_bFriendlyChallengeBase[$i]]]
		_ArrayAdd($aBaseForShare, $bIAdd)
		If $g_bFriendlyChallengeBase[$i] Then $iCount4Share += 1
	Next
	If $iCount4Share = 0 Then
		SetLog("No base to share for friend challenge, please check your setting.", $COLOR_ERROR)
		Return
	Else
		_ArrayShuffle($aBaseForShare)
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
			AndroidPageError("ChatActions")
			Return False
		EndIf
		If _Sleep($DELAYDONATECC1) Then Return ; delay Allow 15x
	WEnd

	; check for "I Understand" button
	Local $aCoord = decodeSingleCoord(findImage("I Understand", $g_sImgChatIUnterstand, GetDiamondFromRect("50,400,280,550")))
	If UBound($aCoord) > 1 Then
		SetDebugLog("Clicking 'I Understand' button", $COLOR_ACTION)
		ClickP($aCoord)
		If _Sleep($DELAYDONATECC2) Then Return
	EndIf

	Local $bDoFriendlyChallenge = False
	Local $sClanString, $iRequested, $iTempR

	If $g_bOnlyOnRequest Then
		If ReadChatIA($sClanString, $g_sWriteFriendlyChallengeKeyword, False) = True Then
			$bDoFriendlyChallenge = True
			$iTempR = Number(StringReverse($sClanString))
			$iRequested = (BitAnd($iTempR > 0, $iTempR < 7)) ? ($iTempR-1) : (-1)
			If $iRequested <> -1 Then
				For $i = 0 To UBound($aBaseForShare) -1
					If $aBaseForShare[$i][0] = $iRequested And $aBaseForShare[$i][1] = True Then
						_ArrayDelete($aBaseForShare, $i)
						Local $bIAdd[1][2] = [[$iRequested, $g_bFriendlyChallengeBase[$i]]]
						_ArrayInsert($aBaseForShare, 0, $bIAdd)
						SetLog("User request challenge base: " & $iRequested, $COLOR_INFO)
						ExitLoop
					EndIf
				Next
			Else
				SetLog("Prepare for select random base", $COLOR_INFO)
			EndIf
		EndIf
	Else
		$bDoFriendlyChallenge = True
	EndIf

	Local $bIsBtnStartOk = False
	If $bDoFriendlyChallenge Then
		If _WaitForCheckPixel($aButtonFriendlyChallenge, $g_bCapturePixel, Default, "Wait for FC Btn:") Then
			Click($aButtonFriendlyChallenge[0], $aButtonFriendlyChallenge[1], 1, 0, "#BtnFC")
			If _WaitForCheckPixel($aButtonFCChangeLayout, $g_bCapturePixel, Default, "Wait for FCCL Btn:") Then
				Click($aButtonFCChangeLayout[0], $aButtonFCChangeLayout[1], 1, 0, "#BtnFCCL")
				If _WaitForCheckPixel($aButtonFCBack, $g_bCapturePixel, Default, "Wait for FC Back:") Then
					If RandomBaseIfNot($aBaseForShare) Then
						If _WaitForCheckPixel($aButtonFCStart, $g_bCapturePixel, Default, "Wait for FC Start:") Then
							If $g_sWriteFriendlyChallengeText <> "" Then
								Click(Random(440, 620, 1), Random(165, 185, 1))
								If _Sleep($DELAYCHATACTIONS1) Then Return False
								Local $asText = StringSplit($g_sWriteFriendlyChallengeText, "|", BitOR($STR_ENTIRESPLIT, $STR_NOCOUNT))
								If IsArray($asText) Then
									Local $sText4Send = $asText[Random(0, UBound($asText) - 1, 1)]
									SetLog("Send text: " & $sText4Send, $COLOR_DEBUG)
									If $g_bChkBackgroundMode = False And $g_bNoFocusTampering = False Then ControlFocus($g_hAndroidWindow, "", "")
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
								Return True
							EndIf
						Else
							SetLog("Cannot find friendly challenge start button. Maybe the base cannot be select.", $COLOR_ERROR)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	Return False

	ChatbotChatClose() ;Close Chat Dialog At the End Of Chat
EndFunc   ;==>FriendlyChallenge

Func RandomBaseIfNot($aBaseForShare)

	; Profile entity diff.
	Local Static $asLastTimeChecked[8] = ["", "", "", "", "", "", "", ""]

	If _Sleep($DELAYCHATACTIONS3) Then Return
	For $i = 0 To UBound($aBaseForShare) - 1
		If $aBaseForShare[$i][1] <> True Or (StringInStr($asLastTimeChecked[$g_iCurAccount], $aBaseForShare[$i][0]) > 0) Then ContinueLoop ; Check obstacles or if base is unchecked.
		Setlog("Friendly Challenge : Sharing base " & $aBaseForShare[$i][0] + 1 & ".", $COLOR_ACTION)
		If CheckNeedSwipeFriendlyChallengeBase($aBaseForShare[$i][0]) = True Then
			Return True
		Else
			$asLastTimeChecked[$g_iCurAccount] &= " " & $aBaseForShare[$i][0]
			Setlog("Friendly Challenge : The base has obstacles, it will not be taken into account until you correct it and restart the bot or change account.", $COLOR_INFO)
		EndIf
		If _Sleep($DELAYCHATACTIONS3) Then Return
	Next

	Setlog("Friendly Challenge : No base for share.", $COLOR_ERROR)
	Return False
EndFunc   ;==>RandomBaseIfNot

Func CheckNeedSwipeFriendlyChallengeBase($iBaseSlot)
	If _Sleep($DELAYCHATACTIONS1) Then Return False
	Local $aMeasures[3] = ["148, 180, 330, 300", "330, 180, 518, 300", "516, 180, 712, 300"]
	Local $aClick[3][2] = [[250, 245], [435, 235], [595, 226]]

	; check need swipe
	Local $iSwipeNum = 2
	Local $iCount = 0
	If $iBaseSlot > $iSwipeNum Then
		$iCount = 0
		While Not _ColorCheck(_GetPixelColor(712, 295, True), Hex(0XD3D3CB, 6), 10)
			ClickDrag(700, 250, 150, 250, 250)
			If _Sleep($DELAYCHATACTIONS2) Then Return False
			$iCount += 1
			If $iCount > 3 Then Return False
		WEnd
		$iBaseSlot -= 3
		If _Sleep($DELAYCHATACTIONS3) Then Return False
		If _ImageSearchXML($g_sImgChatObstacles, 1, $aMeasures[$iBaseSlot], True, False) = -1 Then
			Click($aClick[$iBaseSlot][0], $aClick[$iBaseSlot][1], 1, Random(500, 570, 1))
			Return True
		EndIf
	Else
		$iCount = 0
		While Not _ColorCheck(_GetPixelColor(146, 295, True), Hex(0XD3D3CB, 6), 10)
			ClickDrag(155, 250, 705, 250, 250)
			If _Sleep($DELAYCHATACTIONS2) Then Return False
			$iCount += 1
			If $iCount > 3 Then Return False
		WEnd
		If _Sleep($DELAYCHATACTIONS3) Then Return False
		If _ImageSearchXML($g_sImgChatObstacles, 1, $aMeasures[$iBaseSlot], True, False) = -1 Then
			Click($aClick[$iBaseSlot][0], $aClick[$iBaseSlot][1], 1, Random(500,570,1))
			Return True
		EndIf
	EndIf
	Return False
EndFunc   ;==>CheckNeedSwipeFriendlyChallengeBase