; #FUNCTION# ====================================================================================================================
; Name ..........: Chatbot
; Description ...: This file is all related to Gaining XP by Attacking to Goblin Picninc Signle player
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: rulesss, kychera
; Modified ......: NguyenAnhHD (9-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include <Process.au3>
#include <Array.au3>
#include <WinAPIEx.au3>

Func ChatbotChatOpen() ; open the chat area
	Click(20, 379, 1) ; open chat
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotChatOpen

Func ChatbotSelectClanChat() ; select clan tab
	Click(222, 27, 1) ; switch to clan
	If _Sleep(1000) Then Return
	Click(295, 700, 1) ; scroll to top
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotSelectClanChat

Func ChatbotSelectGlobalChat() ; select global tab
	Click(74, 23, 1) ; switch to global
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotSelectGlobalChat

Func ChatbotChatClose() ; close chat area
	Click(330, 384, 1) ; close chat
	waitMainScreen()
	Return True
EndFunc   ;==>ChatbotChatClose

Func ChatbotChatClanInput() ; select the textbox for clan chat
	Click(276, 707, 1) ; select the textbox
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotChatClanInput

Func ChatbotChatGlobalInput() ; select the textbox for global chat
	Click(277, 706, 1) ; select the textbox
	If _Sleep(1000) Then Return
	Return True
EndFunc   ;==>ChatbotChatGlobalInput

Func ChatbotChatInput($Message)
	Click(33, 707, 1)
	If $g_iRusLang = 1 Then
		SetLog("Chat send in russia", $COLOR_BLUE)
		AutoItWinSetTitle('MyAutoItTitle')
			_WinAPI_SetKeyboardLayout(WinGetHandle(AutoItWinGetTitle()), 0x0419)
			Sleep(500)
			ControlFocus($g_hAndroidWindow, "", "")
			SendKeepActive($g_hAndroidWindow)
			Sleep(500)
		AutoItSetOption("SendKeyDelay", 50)
		_SendExEx($Message)
		SendKeepActive("")
	Else
		Sleep(500)
		SendText($Message)
	EndIf
	Return True
EndFunc   ;==>ChatbotChatInput

Func ChatbotChatSendClan() ; click send
	If _Sleep(1000) Then Return
	Click(827, 709, 1) ; send
	If _Sleep(2000) Then Return
	Return True
EndFunc   ;==>ChatbotChatSendClan

Func ChatbotChatSendGlobal() ; click send
	If _Sleep(1000) Then Return
	Click(827, 709, 1) ; send
	If _Sleep(2000) Then Return
	Return True
EndFunc   ;==>ChatbotChatSendGlobal

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

Func ChatbotIsLastChatNew() ; returns true if the last chat was not by you, false otherwise
	_CaptureRegion()
	For $x = 38 To 261
		If _ColorCheck(_GetPixelColor($x, 129), Hex(0x78BC10, 6), 5) Then Return True ; detect the green menu button
	Next
	Return False
EndFunc   ;==>ChatbotIsLastChatNew

Func ChatbotPushbulletSendChat()
   If Not $g_iChatPushbullet Then Return
   _CaptureRegion(0, 0, 320, 675)
   Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
   Local $Time = @HOUR & "." & @MIN & "." & @SEC

   Local $ChatFile = $Date & "__" & $Time & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
   $g_sProfileLootsPath = ""
   _GDIPlus_ImageSaveToFile($g_hBitmap, $g_sProfileLootsPath & $ChatFile)
   _GDIPlus_ImageDispose($g_hBitmap)
   SetLog("Chatbot: Sent chat image", $COLOR_GREEN)
   NotifyPushFileToBoth($ChatFile, "Loots", "image/jpeg", $g_sNotifyOrigin & " | Last Clan Chats" & "\n" & $ChatFile)
   _Sleep(500)
   Local $iDelete = FileDelete($g_sProfileLootsPath & $ChatFile)
   If Not ($iDelete) Then SetLog("Chatbot: Failed to delete temp file", $COLOR_RED)
EndFunc

Func ChatbotPushbulletQueueChat($Chat)
   If Not $g_iChatPushbullet Then Return
   _ArrayAdd($ChatbotQueuedChats, $Chat)
EndFunc

Func ChatbotPushbulletQueueChatRead()
   If Not $g_iChatPushbullet Then Return
   $ChatbotReadQueued = True
EndFunc

Func ChatbotPushbulletStopChatRead()
   If Not $g_iChatPushbullet Then Return
   $ChatbotReadInterval = 0
   $ChatbotIsOnInterval = False
EndFunc

Func ChatbotPushbulletIntervalChatRead($Interval)
   If Not $g_iChatPushbullet Then Return
   $ChatbotReadInterval = $Interval
   $ChatbotIsOnInterval = True
   ChatbotStartTimer()
EndFunc

Func ChangeLanguageToEN()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	ClickDrag(775, 180, 775, 440)
	If _Sleep(1000) Then Return
	Click(165, 180, 1) ;English
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language EN", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToEN

Func ChangeLanguageToFRA()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 230, 1) ;Franch
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language FRA", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToFra

Func ChangeLanguageToRU()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(173, 607, 1) ;Russian
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language RU", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToRU

Func ChangeLanguageToDE()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 273, 1) ;DEUTCH
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language DE", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToDE

Func ChangeLanguageToES()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 325, 1) ;Ispanol
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language ES", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToES

Func ChangeLanguageToITA()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 375, 1) ;ITALYA
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language ITA", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToITA

Func ChangeLanguageToNL()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 425, 1) ;NL
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language NL", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToNL

Func ChangeLanguageToNO()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 475, 1) ;NORSK
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language NO", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToNO

Func ChangeLanguageToPR()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 525, 1) ;PORTUGAL
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language PR", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToPR

Func ChangeLanguageToTR()
	Click(820, 585, 1) ;settings
	If _Sleep(500) Then Return
	Click(433, 120, 1) ;settings tab
	If _Sleep(500) Then Return
	Click(210, 420, 1) ;language
	If _Sleep(1000) Then Return
	Click(163, 575, 1) ;TURK
	If _Sleep(500) Then Return
	SetLog("Chatbot: Switching language TR", $COLOR_GREEN)
	Click(513, 426, 1) ;language
	If _Sleep(1000) Then Return
EndFunc   ;==>ChangeLanguageToTR

Func ChatbotMessage() ; run the chatbot
	If $g_iGlobalChat Then
		SetLog("Chatbot: Sending some chats", $COLOR_GREEN)
	ElseIf $g_iClanChat Then
		SetLog("Chatbot: Sending some chats", $COLOR_GREEN)
	EndIf
	If $g_iGlobalChat Then
		If $g_iSwitchLang = True Then
			Switch GUICtrlRead($g_hCmbLang)
					Case "EN"
				ChangeLanguageToEN()
					Case "FR"
				ChangeLanguageToFRA()
					Case "DE"
				ChangeLanguageToDE()
					Case "ES"
				ChangeLanguageToES()
					Case "IT"
				ChangeLanguageToITA()
					Case "NL"
				ChangeLanguageToNL()
					Case "NO"
				ChangeLanguageToNO()
					Case "PR"
				ChangeLanguageToPR()
					Case "TR"
				ChangeLanguageToTR()
					Case "RU"
				ChangeLanguageToRU()
			EndSwitch
				waitMainScreen()
		EndIf
		If Not ChatbotChatOpen() Then Return
		SetLog("Chatbot: Sending chats to global", $COLOR_GREEN)
		; assemble a message
		Local $message[4]
		$Message[0] = $GlobalMessages1[Random(0, UBound($GlobalMessages1) - 1, 1)]
		$Message[1] = $GlobalMessages2[Random(0, UBound($GlobalMessages2) - 1, 1)]
		$Message[2] = $GlobalMessages3[Random(0, UBound($GlobalMessages3) - 1, 1)]
		$Message[3] = $GlobalMessages4[Random(0, UBound($GlobalMessages4) - 1, 1)]
		If $g_iGlobalScramble Then
			_ArrayShuffle($Message)
		EndIf
		; Send the message
		If Not ChatbotSelectGlobalChat() Then Return
		If Not ChatbotChatGlobalInput() Then Return
		If Not ChatbotChatInput(_ArrayToString($message, " ")) Then Return
		If Not ChatbotChatSendGlobal() Then Return
		If Not ChatbotChatClose() Then Return
		If $g_iSwitchLang = True Then
			ChangeLanguageToEN()
			waitMainScreen()
		EndIf
	EndIf

	If $g_iClanChat Then
		If Not ChatbotChatOpen() Then Return
			SetLog("Chatbot: Sending chats to clan", $COLOR_GREEN)
		If Not ChatbotSelectClanChat() Then Return

		Local $SentClanChat = False

		If $ChatbotReadQueued Then
			ChatbotPushbulletSendChat()
			$ChatbotReadQueued = False
			$SentClanChat = True
		ElseIf $ChatbotIsOnInterval Then
			If ChatbotIsInterval() Then
				ChatbotStartTimer()
				ChatbotPushbulletSendChat()
				$SentClanChat = True
			EndIf
		EndIf

		If UBound($ChatbotQueuedChats) > 0 Then
			SetLog("Chatbot: Sending pushbullet chats", $COLOR_GREEN)

			For $a = 0 To UBound($ChatbotQueuedChats) - 1
			Local $ChatToSend = $ChatbotQueuedChats[$a]
				If Not ChatbotChatClanInput() Then Return
				If Not ChatbotChatInput(_Encoding_JavaUnicodeDecode($ChatToSend)) Then Return
				If Not ChatbotChatSendClan() Then Return
			Next

			Dim $Tmp[0] ; clear queue
			$ChatbotQueuedChats = $Tmp

			ChatbotPushbulletSendChat()

			If Not ChatbotChatClose() Then Return
			SetLog("Chatbot: Done", $COLOR_GREEN)
			Return
		EndIf

		If ChatbotIsLastChatNew() Then
			; get text of the latest message
			Local $ChatMsg = StringStripWS(getOcrAndCapture("coc-latinA", 30, 148, 270, 13, False), 7)
			SetLog("Found chat message: " & $ChatMsg, $COLOR_GREEN)
			Local $SentMessage = False

			If $ChatMsg = "" Or $ChatMsg = " " Then
				If $g_iUseGeneric Then
					If Not ChatbotChatClanInput() Then Return
					If Not ChatbotChatInput($ClanMessages2[Random(0, UBound($ClanMessages2) - 1, 1)]) Then Return
					If Not ChatbotChatSendClan() Then Return
					$SentMessage = True
				EndIf
			EndIf

			If $g_iUseResponses And Not $SentMessage Then
				For $a = 0 To UBound($ClanMessages1) - 1
					If StringInStr($ChatMsg, $ClanMessages1[$a][0]) Then
						Local $Response = $ClanMessages1[$a][1]
						SetLog("Sending response: " & $Response, $COLOR_GREEN)
						If Not ChatbotChatClanInput() Then Return
						If Not ChatbotChatInput($Response) Then Return
						If Not ChatbotChatSendClan() Then Return
						$SentMessage = True
						ExitLoop
					EndIf
				Next
			EndIf

			If Not $SentMessage Then
				If $g_iUseGeneric Then
					If Not ChatbotChatClanInput() Then Return
					If Not ChatbotChatInput($ClanMessages2[Random(0, UBound($ClanMessages2) - 1, 1)]) Then Return
					If Not ChatbotChatSendClan() Then Return
				EndIf
			EndIf

			; send it via pushbullet if it's new
			; putting the code here makes sure the (cleverbot, specifically) response is sent as well :P
			If $g_iChatPushbullet And $g_iPbSendNewChats Then
				If Not $SentClanChat Then ChatbotPushbulletSendChat()
			EndIf
		ElseIf $g_iUseGeneric Then
			If Not ChatbotChatClanInput() Then Return
			If Not ChatbotChatInput($ClanMessages2[Random(0, UBound($ClanMessages2) - 1, 1)]) Then Return
			If Not ChatbotChatSendClan() Then Return
		EndIf

		If Not ChatbotChatClose() Then Return
	EndIf
	If $g_iGlobalChat Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	ElseIf $g_iClanChat Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	EndIf
EndFunc   ;==>ChatbotMessage

;===========Addied kychera=================
; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_JavaUnicodeDecode
; Description ...: Decode string from Java Unicode format.
; Syntax ........: _Encoding_JavaUnicodeDecode($sString)
; Parameters ....: $sString             - String to decode.
; Return values .: Decoded string.
; Author ........: amel27
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
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
EndFunc ;==>_Encoding_JavaUnicodeDecode
