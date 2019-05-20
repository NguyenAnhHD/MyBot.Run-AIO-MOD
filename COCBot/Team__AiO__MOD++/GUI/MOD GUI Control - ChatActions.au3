; #FUNCTION# ====================================================================================================================
; Name ..........: MOD GUI Control - ChatActions
; Description ...: This file controls the "ChatActions" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Boduloz
; Modified ......: Team AiO MOD++ (2019)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func ChatbotReadSettings()

	$g_iTxtGlobalMessages1 = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "GlobalMsg1", "War Clan Recruiting|Active War Clan accepting applications"), "|", 2)
	$g_iTxtGlobalMessages2 = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "GlobalMsg2", "Join now|Apply now"), "|", 2)
	GUICtrlSetData($g_hTxtEditGlobalMessages1, _ArrayToString($g_iTxtGlobalMessages1, @CRLF))
	GUICtrlSetData($g_hTxtEditGlobalMessages2, _ArrayToString($g_iTxtGlobalMessages2, @CRLF))

	Local $iTxtClanResponses = ""
	$iTxtClanResponses = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "ResponseMsgClan", "keyword:Response|hello:Hi, Welcome to the clan|hey:Hey, how's it going?"), "|", 2)
	$g_iTxtClanMessages = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "GenericMsgClan", "Testing on Chat|Hey all"), "|", 2)
	Local $rTxtClanResponses[UBound($iTxtClanResponses)][2]
	For $a = 0 To UBound($iTxtClanResponses) - 1
		Local $TmpResp = StringSplit($iTxtClanResponses[$a], ":", 2)
		If UBound($TmpResp) > 0 Then
			$rTxtClanResponses[$a][0] = $TmpResp[0]
		Else
			$rTxtClanResponses[$a][0] = "<invalid>"
		EndIf
		If UBound($TmpResp) > 1 Then
			$rTxtClanResponses[$a][1] = $TmpResp[1]
		Else
			$rTxtClanResponses[$a][1] = "<undefined>"
		EndIf
	Next
	$g_iTxtClanResponses = $rTxtClanResponses
	GUICtrlSetData($g_hTxtEditResponses, _ArrayToString($g_iTxtClanResponses, ":", -1, -1, @CRLF))
	GUICtrlSetData($g_hTxtEditGeneric, _ArrayToString($g_iTxtClanMessages, @CRLF))

EndFunc   ;==>ChatbotReadSettings

Func ChatGuiEditUpdate()

	; how 2 be lazy 101
	$TxtGlobal1 = StringReplace(GUICtrlRead($g_hTxtEditGlobalMessages1), @CRLF, "|")
	$TxtGlobal2 = StringReplace(GUICtrlRead($g_hTxtEditGlobalMessages2), @CRLF, "|")

	$TxtResponse = StringReplace(GUICtrlRead($g_hTxtEditResponses), @CRLF, "|")
	$TxtGeneric = StringReplace(GUICtrlRead($g_hTxtEditGeneric), @CRLF, "|")

	; Clean empty messages to avoid chat bot to slect empty msg
	_StringRemoveBlanksFromSplit($TxtGlobal1)
	_StringRemoveBlanksFromSplit($TxtGlobal2)
	_StringRemoveBlanksFromSplit($TxtResponse)
	_StringRemoveBlanksFromSplit($TxtGeneric)

	;Need to save live changes into config.
	IniWrite($g_sProfileConfigPath, "ChatActions", "GlobalMsg1", $TxtGlobal1)
	IniWrite($g_sProfileConfigPath, "ChatActions", "GlobalMsg2", $TxtGlobal2)
	IniWrite($g_sProfileConfigPath, "ChatActions", "ResponseMsgClan", $TxtResponse)
	IniWrite($g_sProfileConfigPath, "ChatActions", "GenericMsgClan", $TxtGeneric)

	ChatbotReadSettings()
EndFunc   ;==>ChatGuiEditUpdate

; Global Chat
Func chkGlobalChat()
	If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		$g_bChatGlobal = True
		_GUI_Value_STATE("ENABLE", $g_hTxtDelayTimeGlobal & "#" & $g_hChkGlobalScramble & "#" & $g_hChkSwitchLang & "#" & $g_hChkRusLang & "#" & $g_hTxtEditGlobalMessages1 & "#" & $g_hTxtEditGlobalMessages2)
		GUIToggle_OnlyDuringHours(True)
		chkSwitchLang()
	Else
		$g_bChatGlobal = False
		For $i = $g_hTxtDelayTimeGlobal To $g_hTxtEditGlobalMessages2
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		If GUICtrlRead($g_hChkClanChat) = $GUI_UNCHECKED And GUICtrlRead($g_hChkEnableFriendlyChallenge) = $GUI_UNCHECKED Then GUIToggle_OnlyDuringHours(False)
	EndIf
EndFunc   ;==>chkGlobalChat

Func chkSwitchLang()
	If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		If GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
			$g_bSwitchLang = True
			GUICtrlSetState($g_hCmbLang, $GUI_ENABLE)
		Else
			$g_bSwitchLang = False
			GUICtrlSetState($g_hCmbLang, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc   ;==>chkSwitchLang

; Clan Chat
Func chkClanChat()
	If GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED Then
		$g_bChatClan = True
		For $i = $g_hTxtDelayTimeClan To $g_hChkCleverbot
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		GUICtrlSetState($g_hChkChatNotify, $GUI_ENABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_ENABLE)
		GUIToggle_OnlyDuringHours(True)
		chkUseResponses()
		chkUseGeneric()
	Else
		$g_bChatClan = False
		For $i = $g_hTxtDelayTimeClan To $g_hTxtEditGeneric
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		GUICtrlSetState($g_hChkChatNotify, $GUI_DISABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_DISABLE)
		If GUICtrlRead($g_hChkGlobalChat) = $GUI_UNCHECKED And GUICtrlRead($g_hChkEnableFriendlyChallenge) = $GUI_UNCHECKED Then GUIToggle_OnlyDuringHours(False)
	EndIf
EndFunc   ;==>chkClanChat

Func chkUseResponses()
	If GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED Then
		If GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED Then
			$g_bClanUseResponses = True
			GUICtrlSetState($g_hLblEditResponses, $GUI_ENABLE)
			GUICtrlSetState($g_hTxtEditResponses, $GUI_ENABLE)
		Else
			$g_bClanUseResponses = False
			GUICtrlSetState($g_hLblEditResponses, $GUI_DISABLE)
			GUICtrlSetState($g_hTxtEditResponses, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc   ;==>chkUseResponses

Func chkUseGeneric()
	If GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED Then
		If GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED Then
			$g_bClanAlwaysMsg = True
			GUICtrlSetState($g_hLblEditGeneric, $GUI_ENABLE)
			GUICtrlSetState($g_hTxtEditGeneric, $GUI_ENABLE)
		Else
			$g_bClanAlwaysMsg = False
			GUICtrlSetState($g_hLblEditGeneric, $GUI_DISABLE)
			GUICtrlSetState($g_hTxtEditGeneric, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc   ;==>chkUseGeneric

; Friendly Challenge
Func chkEnableFriendlyChallenge()
	If GUICtrlRead($g_hChkEnableFriendlyChallenge) = $GUI_CHECKED Then
		$g_bEnableFriendlyChallenge = True
		For $i = $g_hTxtDelayTimeFC To $g_hTxtChallengeText
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		GUIToggle_OnlyDuringHours(True)
		chkOnlyOnRequest()
	Else
		$g_bEnableFriendlyChallenge = False
		For $i = $g_hTxtDelayTimeFC To $g_hTxtKeywordForRequest
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		If GUICtrlRead($g_hChkGlobalChat) = $GUI_UNCHECKED And GUICtrlRead($g_hChkClanChat) = $GUI_UNCHECKED Then GUIToggle_OnlyDuringHours(False)
	EndIf
EndFunc   ;==>chkEnableFriendlyChallenge

Func chkOnlyOnRequest()
	If GUICtrlRead($g_hChkEnableFriendlyChallenge) = $GUI_CHECKED Then
		If GUICtrlRead($g_hChkOnlyOnRequest) = $GUI_CHECKED Then
			$g_bOnlyOnRequest = True
			GUICtrlSetState($g_hLblKeywordForRequest, $GUI_ENABLE)
			GUICtrlSetState($g_hTxtKeywordForRequest, $GUI_ENABLE)
		Else
			$g_bOnlyOnRequest = False
			GUICtrlSetState($g_hLblKeywordForRequest, $GUI_DISABLE)
			GUICtrlSetState($g_hTxtKeywordForRequest, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc   ;==>chkOnlyOnRequest

Func txtChallengeText()
	Local $sInputText = StringReplace(GUICtrlRead($g_hTxtChallengeText), @CRLF, "|")
	Local $iCount = 0
	Local $bUpdateDateFlag = False
	While 1
		If StringRight($sInputText,1) = "|" Then
			$sInputText = StringLeft($sInputText, StringLen($sInputText) - 1)
			$bUpdateDateFlag = True
		Else
			If $bUpdateDateFlag Then GUICtrlSetData($g_hTxtChallengeText, StringReplace($sInputText, "|", @CRLF))
			ExitLoop
		EndIf
		$iCount += 1
		If $iCount > 10 Then ExitLoop
	WEnd
	$g_iTxtChallengeText = StringReplace($sInputText, "|", @CRLF)
EndFunc   ;==>txtChallengeText

Func chkFriendlyChallengeHoursE1()
	If GUICtrlRead($g_hChkFriendlyChallengeHoursE1) = $GUI_CHECKED And GUICtrlRead($g_ahChkFriendlyChallengeHours[0]) = $GUI_CHECKED Then
		For $i = 0 To 11
			GUICtrlSetState($g_ahChkFriendlyChallengeHours[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 0 To 11
			GUICtrlSetState($g_ahChkFriendlyChallengeHours[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkFriendlyChallengeHoursE1, $GUI_UNCHECKED)
EndFunc   ;==>chkFriendlyChallengehoursE1

Func chkFriendlyChallengeHoursE2()
	If GUICtrlRead($g_hChkFriendlyChallengeHoursE2) = $GUI_CHECKED And GUICtrlRead($g_ahChkFriendlyChallengeHours[12]) = $GUI_CHECKED Then
		For $i = 12 To 23
			GUICtrlSetState($g_ahChkFriendlyChallengeHours[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 12 To 23
			GUICtrlSetState($g_ahChkFriendlyChallengeHours[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkFriendlyChallengeHoursE2, $GUI_UNCHECKED)
EndFunc   ;==>chkFriendlyChallengehoursE2

Func GUIToggle_OnlyDuringHours($Enable = True)
	If $Enable Then
		For $i = $g_hLblChatActionsOnlyDuringHours To $g_hLblFriendlyChallengeHoursPM
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
	Else
		For $i = $g_hLblChatActionsOnlyDuringHours To $g_hLblFriendlyChallengeHoursPM
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	EndIf
EndFunc   ;==>GUIToggle_OnlyDuringHours