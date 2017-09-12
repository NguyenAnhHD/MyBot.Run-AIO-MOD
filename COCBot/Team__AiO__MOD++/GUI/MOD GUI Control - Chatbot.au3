; #FUNCTION# ====================================================================================================================
; Name ..........: Chatbot
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: NguyenAnhHD (2017)
; Modified ......: Team AiO MOD++ (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func cmbChatBot()
	If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		For $i = $g_hChkGlobalScramble To $g_hChkSwitchLang
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		For $i = $g_hEditGlobalMessages1 To $g_hEditGlobalMessages4
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
		cmbSwitchLang()
	Else
		For $i = $g_hChkGlobalScramble To $g_hChkSwitchLang
			GUICtrlSetState($i, $GUI_UNCHECKED)
		Next
		For $i = $g_hChkGlobalScramble To $g_hEditGlobalMessages4
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	EndIf

	If GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED Then
		For $i = $g_hChkRusLang To $g_hEditClanMessages2
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
	Else
		For $i = $g_hChkRusLang To $g_hChkPbSendNewChats
			GUICtrlSetState($i, $GUI_UNCHECKED)
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
		For $i = $g_hEditClanMessages1 To $g_hEditClanMessages2
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	EndIf
EndFunc   ;==>cmbChatBot

Func cmbSwitchLang()
	If GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
		GUICtrlSetState($g_hCmbLang, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hCmbLang, $GUI_DISABLE)
	EndIf
EndFunc   ;==>cmbSwitchLang

Func ChatBotReadMessages()

	$ClanMessages2 = StringSplit(IniRead($chatIni, "Clan", "ClanMessages2", "Testing on Chat|Hey all"), "|", 2)
	Local $ClanResponses0 = StringSplit(IniRead($chatIni, "Clan", "ClanMessages1", "keyword:Response|hello:Hi, Welcome to the clan|hey:Hey, how's it going?"), "|", 2)
	Local $ClanResponses1[UBound($ClanResponses0)][2]
	For $a = 0 To UBound($ClanResponses0) - 1
		Local $TmpResp = StringSplit($ClanResponses0[$a], ":", 2)
		If UBound($TmpResp) > 0 Then
			$ClanResponses1[$a][0] = $TmpResp[0]
		Else
			$ClanResponses1[$a][0] = "<invalid>"
		EndIf
		If UBound($TmpResp) > 1 Then
			$ClanResponses1[$a][1] = $TmpResp[1]
		Else
			$ClanResponses1[$a][1] = "<undefined>"
		EndIf
	Next
	$ClanMessages1 = $ClanResponses1

	$GlobalMessages1 = StringSplit(IniRead($chatIni, "Global", "GlobalMessages1", "War Clan Recruiting|Active War Clan accepting applications"), "|", 2)
	$GlobalMessages2 = StringSplit(IniRead($chatIni, "Global", "GlobalMessages2", "Join now|Apply now"), "|", 2)
	$GlobalMessages3 = StringSplit(IniRead($chatIni, "Global", "GlobalMessages3", "250 war stars min|Must have 250 war stars"), "|", 2)
	$GlobalMessages4 = StringSplit(IniRead($chatIni, "Global", "GlobalMessages4", "Adults Only| 18+"), "|", 2)

EndFunc   ;==>ChatBotReadMessages

Func ChatMessagesEdit()
Global $GlobalMessages1 = GUICtrlRead($g_hEditGlobalMessages1)
Global $GlobalMessages2 = GUICtrlRead($g_hEditGlobalMessages2)
Global $GlobalMessages3 = GUICtrlRead($g_hEditGlobalMessages3)
Global $GlobalMessages4 = GUICtrlRead($g_hEditGlobalMessages4)

Global $ClanMessages1 = GUICtrlRead($g_hEditClanMessages1)
Global $ClanMessages2 = GUICtrlRead($g_hEditCLanMessages2)

	$GlobalMessages1 = StringReplace($GlobalMessages1, @CRLF, "|")
	$GlobalMessages2 = StringReplace($GlobalMessages2, @CRLF, "|")
	$GlobalMessages3 = StringReplace($GlobalMessages3, @CRLF, "|")
	$GlobalMessages4 = StringReplace($GlobalMessages4, @CRLF, "|")

	$ClanMessages1 = StringReplace($ClanMessages1, @CRLF, "|")
	$ClanMessages2 = StringReplace($ClanMessages2, @CRLF, "|")

	IniWriteS($chatIni, "Global", "GlobalMessages1", $GlobalMessages1)
	IniWriteS($chatIni, "Global", "GlobalMessages2", $GlobalMessages2)
	IniWriteS($chatIni, "Global", "GlobalMessages3", $GlobalMessages3)
	IniWriteS($chatIni, "Global", "GlobalMessages4", $GlobalMessages4)

	IniWriteS($chatIni, "Clan", "ClanMessages1", $ClanMessages1)
	IniWriteS($chatIni, "Clan", "ClanMessages2", $ClanMessages2)

	ChatBotReadMessages()
EndFunc   ;==>ChatGuiEditUpdate
