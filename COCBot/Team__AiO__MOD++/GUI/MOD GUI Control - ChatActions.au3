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

	$g_sGlobalMessages1 = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "GlobalMsg1", "War Clan Recruiting|Active War Clan accepting applications"), "|", 2)
	GUICtrlSetData($g_hTxtEditGlobalMessages1, _ArrayToString($g_sGlobalMessages1, @CRLF))

	$g_sGlobalMessages2 = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "GlobalMsg2", "Join now|Apply now"), "|", 2)
	GUICtrlSetData($g_hTxtEditGlobalMessages2, _ArrayToString($g_sGlobalMessages2, @CRLF))

	Local $aTmpClanResponses = ""
    $aTmpClanResponses = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "ResponseMsgClan", "keyword:Response|hello:Hi, Welcome to the clan|hey:Hey, how's it going?"), "|", 2)
    Local $aClanResponses[UBound($aTmpClanResponses)][2]
    For $a = 0 To UBound($aTmpClanResponses) - 1
        Local $aTmpResp = StringSplit($aTmpClanResponses[$a], ":", 2)
        If UBound($aTmpResp) > 0 Then
            $aClanResponses[$a][0] = $aTmpResp[0]
        Else
            $aClanResponses[$a][0] = "<invalid>"
        EndIf
        If UBound($aTmpResp) > 1 Then
            $aClanResponses[$a][1] = $aTmpResp[1]
        Else
            $aClanResponses[$a][1] = "<undefined>"
        EndIf
    Next
	$g_sClanResponses = $aClanResponses
	GUICtrlSetData($g_hTxtEditResponses, _ArrayToString($g_sClanResponses, ":", -1, -1, @CRLF))

	$g_sClanGeneric = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "GenericMsgClan", "Testing on Chat|Hey all"), "|", 2)
	GUICtrlSetData($g_hTxtEditGeneric, _ArrayToString($g_sClanGeneric, @CRLF))

	$g_sChallengeText = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "FriendlyChallengeText", "Kill me"), "|", 2)
	GUICtrlSetData($g_hTxtChallengeText, _ArrayToString($g_sChallengeText, @CRLF))

	$g_sKeywordForRequest = StringSplit(IniRead($g_sProfileConfigPath, "ChatActions", "FriendlyChallengeKeyword", "friendly|challenge"), "|", 2)
	GUICtrlSetData($g_hTxtKeywordForRequest, _ArrayToString($g_sKeywordForRequest, @CRLF))

EndFunc   ;==>ChatbotReadSettings


Func ChatGuiEditUpdate()

	$g_sGlobal1 = _StringRemoveBlanksFromSplit(StringReplace(GUICtrlRead($g_hTxtEditGlobalMessages1), @CRLF, "|"))
	IniWrite($g_sProfileConfigPath, "ChatActions", "GlobalMsg1", $g_sGlobal1)

	$g_sGlobal2 = _StringRemoveBlanksFromSplit(StringReplace(GUICtrlRead($g_hTxtEditGlobalMessages2), @CRLF, "|"))
	IniWrite($g_sProfileConfigPath, "ChatActions", "GlobalMsg2", $g_sGlobal2)

	$g_sResponse = _StringRemoveBlanksFromSplit(StringReplace(GUICtrlRead($g_hTxtEditResponses), @CRLF, "|"))
	IniWrite($g_sProfileConfigPath, "ChatActions", "ResponseMsgClan", $g_sResponse)

	$g_sGeneric = _StringRemoveBlanksFromSplit(StringReplace(GUICtrlRead($g_hTxtEditGeneric), @CRLF, "|"))
	IniWrite($g_sProfileConfigPath, "ChatActions", "GenericMsgClan", $g_sGeneric)

	$g_sWriteFriendlyChallengeText = _StringRemoveBlanksFromSplit(StringReplace(GUICtrlRead($g_hTxtChallengeText), @CRLF, "|"))
	IniWrite($g_sProfileConfigPath, "ChatActions", "FriendlyChallengeText", $g_sWriteFriendlyChallengeText)

	$g_sWriteFriendlyChallengeKeyword = _StringRemoveBlanksFromSplit(StringReplace(GUICtrlRead($g_hTxtKeywordForRequest), @CRLF, "|"))
	IniWrite($g_sProfileConfigPath, "ChatActions", "FriendlyChallengeKeyword", $g_sWriteFriendlyChallengeKeyword)

	ChatbotReadSettings()
EndFunc   ;==>ChatGuiEditUpdate

; Global Chat
Func chkGlobalChat()
	If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		$g_bChatGlobal = True
		_GUI_Value_STATE("ENABLE", $g_hTxtDelayTimeGlobal & "#" & $g_hChkGlobalScramble & "#" & $g_hChkSwitchLang & "#" & $g_hChkRusLang & "#" & $g_hLblEditGlobalMessages1 & "#" & $g_hTxtEditGlobalMessages1 & "#" & $g_hLblEditGlobalMessages2 & "#" & $g_hTxtEditGlobalMessages2)
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
			$g_bClanUseGeneric = True
			GUICtrlSetState($g_hLblEditGeneric, $GUI_ENABLE)
			GUICtrlSetState($g_hTxtEditGeneric, $GUI_ENABLE)
		Else
			$g_bClanUseGeneric = False
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