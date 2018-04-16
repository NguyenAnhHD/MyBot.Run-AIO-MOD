; #FUNCTION# ====================================================================================================================
; Name ..........: Kickout
; Description ...: This File contents for 'Kickout' algorithm , fast Donate'n'Train and Kickout New members
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: ProMac
; Modified ......: 06/2017
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================


Func MainKickout()

	If Not $g_bChkUseKickOut Then Return

	Local $Screencap = True
	Local $Debug = False

	SetLog("Start The Kickout Feature![" & $g_iTxtKickLimit & "]....", $COLOR_INFO)
	Local $Number2Kick = 0

	For $T = 0 To $g_iTxtKickLimit - 1

		If OpenClanPage() Then
			If Go2Bottom() Then
				; Bottom to Top [0 is Bottom , 9 Top ]
				; TODO : check how many slots exist 9/8/7/6

				SetLog("Donated CAP: " & $g_iTxtDonatedCap & " /Received CAP: " & $g_iTxtReceivedCap & " /Kick Spammers: " & $g_bChkKickOutSpammers, $COLOR_INFO)
				For $Rank = 0 To 9

					Local $MemberPosition = GetMemberRank($Rank)
					If $MemberPosition = -1 Then
						ContinueLoop ; Get Upper Rank
					EndIf
					; Setlog("Player [" & $MemberPosition[2] & "] * [" & $MemberPosition[0] & "," & $MemberPosition[1] & "]", $COLOR_INFO)
					; Get the Red from 'New' Word
					Local $p_NewWord = _PixelSearch(199, $MemberPosition[1], 201, $MemberPosition[1] + 52, Hex(0xE73838, 6), 10)

					; Return 0 let's proceed with a new loop
					If $p_NewWord = 0 Then ContinueLoop

					Local $iDonated = ""
					Local $iReceived = ""

					; Confirming the array and the Dimension
					If IsArray($p_NewWord) And UBound($p_NewWord) = 2 Then
						$iDonated = Int(Number(getOcrAndCapture("coc-army", 500, $p_NewWord[1] - 10, 70, 14, True)))
						$iReceived = Int(Number(getOcrAndCapture("coc-army", 627, $p_NewWord[1] - 10, 70, 14, True)))
						; If $g_iDebugSetlog = 1 Then
						SetLog("[#" & $MemberPosition[2] & "][NEW CLAN MEMBER] Donated: " & $iDonated & " / Received: " & $iReceived, $COLOR_BLACK)
					Else

					EndIf

					; Verify Donate Cap , Receive Cap , Ratio etc [True/False]
					Local $2Kick = False
					Select
						; Zero Donated and Received , sure didn't had time to request
						Case $iDonated = 0 And $iReceived = 0
							$2Kick = False

						Case $g_bChkKickOutSpammers = True And $iDonated > 0 And $iReceived = 0
							$2Kick = True

						Case $iDonated < $g_iTxtDonatedCap And $iReceived < $g_iTxtReceivedCap
							$2Kick = False

						Case $g_bChkKickOutSpammers = False And $iDonated >= $g_iTxtDonatedCap
							$2Kick = True

						Case $g_bChkKickOutSpammers = False And $iReceived >= $g_iTxtReceivedCap
							$2Kick = True

						Case Else
							$2Kick = False
					EndSelect

					If $g_bDebugSetlog Then SetDebugLog("Is This member 2 Kick? " & $2Kick, $COLOR_DEBUG)
					If Not $2Kick Then ContinueLoop

					; Click $p_NewWord[0] , $p_NewWord[1] To Open Dialog
					Click($p_NewWord[0] + 150, $p_NewWord[1])
					If _Sleep(1000) Then ExitLoop

					; Search for 'Kick Out' Button with imgloc  x=447 , x1 = 582, y = 110 , y1 = 732
					Local $sKickOutDirectory = @ScriptDir & "\imgxml\Resources\GTFO\KickOut"
					If QuickMIS("BC1", $sKickOutDirectory, 460, 45, 575, 730, $Screencap, $Debug) Then
						; Click KickOut
						Click($g_iQuickMISX + 460, $g_iQuickMISY + 45, 1)
						If _Sleep(500) Then ExitLoop
					Else
						ContinueLoop
					EndIf

					; Text Dialog KickOut sent text 'Unicode'
					;
					; If $g_bChkBackgroundMode = False And $g_bNoFocusTampering = False Then ControlFocus($g_hAndroidWindow, "", "")
					; 	Click(430, 150, 1) ; Select the input text
					; 		If SendText($g_sKickoutMSG) = 0 Then
					; 		Setlog(" $g_sKickoutMSG text entry failed, try again", $COLOR_ERROR)
					; 		Return
					; 		EndIf
					;

					; Click 'Send' Button [GREEN]
					Click(520, 240, 1)

					SetLog("[#" & $MemberPosition[2] & "] has been kicked out!", $COLOR_ERROR)

					; Verify KickOut Members number [Stay/Return]
					$Number2Kick += 1
				Next
				Click(825, 5, 1) ; Exit From Clan page
				ContinueLoop
			Else
				Click(825, 5, 1) ; Exit From Clan page
				Return
			EndIf
		Else
			Return
		EndIf
		If $g_iTxtKickLimit = $Number2Kick Then Return
	Next

EndFunc   ;==>MainKickout

Func OpenClanPage()

	$g_bDebugOcr = True

	Local Static $FirstRun = True
	Local $_aClanColor[4] = [360, 63, 0xf0f4f0, 5]
	Local $_aClanMainVillage = [360, 125, 0xc8c8b8, 5]

	ClickP($aAway, 1, 0, "#0221") ;Click Away
	If _Sleep($DELAYPROFILEREPORT1) Then Return

	; ********* OPEN TAB AND CHECK IT PROFILE ***********
	Local $sPageDirectory = @ScriptDir & "\imgxml\Resources\Pages\Profile"

	SetLog(" ## OpenClanPage ## ", $COLOR_DEBUG)
	; Click Info Profile Button
	Click(30, 40, 1, 0, "#0222")
	If _Sleep(2500) Then Return

	; Check the 'My Profile' tab region
;~ 	Local $iCount = 0
;~ 	While Not QuickMIS("BC1", $sPageDirectory, 110, 67, 250, 100, True, False)
;~ 		; 1000ms between checks
;~ 		If _Sleep($DELAYPROFILEREPORT2) Then Return
;~ 		$iCount += 1
;~ 		If $iCount > 4 Then
;~ 			Setlog("Excess wait time for profile to open: " & $iCount, $COLOR_DEBUG)
;~ 			Return False
;~ 		EndIf
;~ 	WEnd

	Local Static $TempQuant = 0 ; Initial Value

	$g_iTroopsDonated = getProfile(159, 346) ; MAY UPDATE
	If $g_iTroopsDonated = "" Or $g_iTroopsDonated = Null Then SetLog(" ## OpenClanPage ## Problem on Troops Donated", $COLOR_DEBUG)

	If $FirstRun Then
		GUICtrlSetState($g_hLblInitialDonated, $GUI_ENABLE + $GUI_SHOW)
		GUICtrlSetState($g_hLblCurrentDonated, $GUI_ENABLE + $GUI_SHOW)
		GUICtrlSetData($g_hLblInitialDonated, _NumberFormat($g_iTroopsDonated, True))
		GUICtrlSetData($g_hLblCurrentDonated, _NumberFormat($g_iTroopsDonated, True))
		$TempQuant = $g_iTroopsDonated
		SetLog("Donated this season: " & $TempQuant, $COLOR_INFO)
		$FirstRun = False
	Else
		If $g_iTroopsDonated = "" Or $g_iTroopsDonated = 0 Or $g_iTroopsDonated < $TempQuant Then
			$g_iTroopsDonated = getProfile(159, 346) ; MAY UPDATE
		EndIf
		GUICtrlSetData($g_hLblCurrentDonated, _NumberFormat($g_iTroopsDonated, True))
		SetLog("Donated now: " & $g_iTroopsDonated - $TempQuant, $COLOR_INFO)
	EndIf

	; Click on Clan Tab
	Click(360, 63, 1)
	If _Sleep(500) Then Return
	; Click on Home Village
	Click(360, 125, 1)
	If _Sleep(500) Then Return

	$g_bDebugOcr = False

	; Check if Opened
	If _ColorCheck(_GetPixelColor($_aClanMainVillage[0], $_aClanMainVillage[1], True), Hex($_aClanMainVillage[2], 6), $_aClanMainVillage[3]) = True Then
		Return True
	EndIf

	SetLog(" ## OpenClanPage ## didn't Openned", $COLOR_DEBUG)
	Return False

EndFunc   ;==>OpenClanPage

Func Go2Bottom()

	; Clan Edit Button
	Local $CheckEditButton[4] = [500, 380, 0xd5f17d, 5]
	If _Sleep(1500) Then Return

	If Not _ColorCheck(_GetPixelColor($CheckEditButton[0], $CheckEditButton[1], True), Hex($CheckEditButton[2], 6), $CheckEditButton[3]) = True Then
		SetLog("You are not a Co-Leader/Leader of your clan! ", $COLOR_DEBUG)
		Return False
	EndIf

	SetLog(" ## Go2Bottom | ClickDrag ## ", $COLOR_DEBUG)
	For $i = 0 To 2
		;ClickDrag(421, 670, 421, 50, 1800)
		Swipe(421, 670, 421, 50, 1100)
		If @error Then
			SetLog("Swipe ISSUE|error: " & @error, $COLOR_DEBUG)
		EndIf
		If _Sleep(150) Then Return ; 500ms
	Next

	If _Sleep(1500) Then Return
	If Not _ColorCheck(_GetPixelColor($CheckEditButton[0], $CheckEditButton[1], True), Hex($CheckEditButton[2], 6), $CheckEditButton[3]) = True Then Return True

	SetLog(" ## Go2Bottom | ClickDrag ## Failed!", $COLOR_DEBUG)
	Return False
EndFunc   ;==>Go2Bottom

Func GetMemberRank($Slot = 0)

	$g_bDebugOcr = True

	Local $iSlot = 52
	Local $x = 25, $y = 615, $x1 = 60, $y1 = $y + 52
	Local $Return[3] = [0, 0, 0]
	Local $iClanPosition = ""

	Local $YSlot = (615 - ($Slot * 52)) + 22
	$iClanPosition = Number(getTrophyVillageSearch($x, $YSlot))
	If $iClanPosition <> "" And IsNumber($iClanPosition) And $iClanPosition < 51 Then
		$Return[0] = $x
		$Return[1] = (615 - ($Slot * 52))
		$Return[2] = $iClanPosition
		Return $Return
	EndIf

	$g_bDebugOcr = False

	Return -1
EndFunc   ;==>GetMemberRank

Func Swipe($x1, $y1, $X2, $Y2, $Delay, $wasRunState = $g_bRunState)

	Local $error = 0

	If $g_bAndroidAdbClickDrag Then
		AndroidAdbLaunchShellInstance($wasRunState)
		If @error = 0 Then
			AndroidAdbSendShellCommand("input swipe " & $x1 & " " & $y1 & " " & $X2 & " " & $Y2, Default, $wasRunState)
			SetError(0, 0)
		Else
			$error = @error
			SetDebugLog("Disabled " & $g_sAndroidEmulator & " ADB input due to error", $COLOR_ERROR)
			$g_bAndroidAdbInput = False
		EndIf
		If _Sleep($Delay / 5) Then Return SetError(-1, "", False)
	EndIf

	If Not $g_bAndroidAdbClickDrag Or $error <> 0 Then
		Return _PostMessage_ClickDrag($x1, $y1, $X2, $Y2, "left", $Delay)
	EndIf

	Return SetError($error, 0)

EndFunc   ;==>Swipe
