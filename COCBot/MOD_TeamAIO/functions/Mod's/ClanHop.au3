; #FUNCTION# ============================================================================================================================
; Name ..........: clanHop.au3
; Version........: #13
; Description ...: This function joins/quit random clans and fills requests indefinitly
; Syntax ........: clanHop()
; Parameters ....: None
; Return values .: None
; Author ........: zengzeng
; Modified ......: Rhinoceros
; Remarks .......: This file is a part of MyBotRun. Copyright 2015
; ................ MyBotRun is distributed under the terms of the GNU GPL
; Related .......: No
; Link ..........: https://mybot.run/forums/index.php?/topic/12051-mod-mybot-621-clan-hop-mod-12/
; =======================================================================================================================================

Func clanHop()
    If GUICtrlRead($g_hChkClanHop) = $GUI_CHECKED Then
		$ichkClanHop = 1
		SetLog("Start Clan Hopping", $COLOR_BLUE)
	Else
		$ichkClanHop = 0
        Return
    EndIf

	Local $boostInterval = 2400           ; How often the bot boosts barracks		Unit in seconds (  2400 =  40mn )
	Local $boostTimer = TimerInit()       ;
	Local $trainInterval = 300            ; How often the bot trains troops			Unit in seconds (   300 =   5mn )
	Local $trainTimer = TimerInit()       ;
	Local $collectInterval = 600          ; How often the bot collects resources	Unit in seconds (   600 =  10mn )
	Local $collectTimer = TimerInit()     ;
	Local $checkTombInterval = 3600       ; How often the bot checks tombs			Unit in seconds (  3600 =  60mn )
	Local $checkTombTimer = TimerInit()   ;
	Local $checkReArmInterval = 18000     ; How often the bot rearms defense		Unit in seconds ( 18000 = 240mn )
	Local $checkReArmTimer = TimerInit()  ;
	Local $checkCampTimer = TimerInit()

    While 1
        If (TimerDiff($boostTimer)/1000)>= $boostInterval Then                                   ; CHECK BOOST TIMER
;			SetLog("Time for boosting!", $COLOR_GREEN)                                           ;
			BoostBarracks()                                                                      ;
;			SetLog("Done boosting. Returning to hopping", $COLOR_BLUE)                           ;
			$boostTimer = TimerInit() ; Reset                                                    ;
        EndIf                                                                                    ;

        If (TimerDiff($trainTimer)/1000)>=$trainInterval Then                                    ; CHECK TRAIN INTERVAL
			SetLog("Check troops")                                                               ;
			checkMainScreen(False)                                                               ;
			Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#0293")                      ;     Click Army Overview
			If _Sleep(500) Then Return                                                           ;
			checkArmyCamp()                                                                      ;
            If $CurCamp > 50 Then                                                                ;     If total troops is more than 50
;				SetLog("Time to train some troops")                                              ;
;				Train()                                                                          ;
				TrainRevamp()                                                                    ;
				$trainTimer = TimerInit() ; Reset                                                ;
			Else                                                                                 ;     If total troops is less than 50
				SetLog("NEED TROOPS NOW !!!", $COLOR_RED)                                        ;
				checkMainScreen(False)                                                           ;
;				Train()                                                                          ;
				TrainRevamp()                                                                    ;
				checkMainScreen(False)                                                           ;
				SetLog("Waiting 2 x 4 minutes to have more troops in camps...", $COLOR_RED)      ;     Wait 8 minutes while training troops
				SetLog("Waiting state 1/2 ...")                                                  ;     in 2 times to prevent disconnection
				AndroidShieldForceDown(True)                                                     ;
				If _SleepStatus(240000) Then Return                                              ;     240 000 = 4 minutes
				Click(Random(87,260,1), Random(51,149,1))                                        ;     Random click
				If _Sleep(300) Then Return                                                       ;
				Click(Random(87,260,1), Random(51,149,1))                                        ;     Random click
				SetLog("Waiting state 2/2 ...")                                                  ;
				If _SleepStatus(240000) Then Return                                              ;     240 000 = 4 minutes
				AndroidShieldForceDown(False)                                                    ;
				SetLog("Done !", $COLOR_GREEN)                                                   ;
				SetLog("Resume hopping")                                                         ;
				$checkCampTimer = TimerInit() ; Reset                                            ;
			EndIf                                                                                ;
        EndIf                                                                                    ;

        If (TimerDiff($collectTimer)/1000)>= $collectInterval Then                               ; CHECK COLLECT INTERVAL
            Collect()                                                                            ;
			SetLog("Time to collect ressources")                                                 ;
            $collectTimer = TimerInit() ; Reset                                                  ;
		EndIf                                                                                    ;

        If (TimerDiff($checkTombTimer)/1000)>= $checkTombInterval Then                           ; CHECK TOMBSTONE ON THE GROUND
            SetLog("Check tombstone on the ground !", $COLOR_PURPLE)                             ;
            CheckTombs()                                                                         ;
            SetLog("Done. Returning to hopping", $COLOR_BLUE)                                    ;
            $checkTombTimer = TimerInit() ; Reset                                                ;
        EndIf                                                                                    ;

        If (TimerDiff($checkReArmTimer)/1000)>= $checkReArmInterval Then                         ; CHECK IF DEFENSE NEED TO BE REARMED
            SetLog("Check if your defense need to be rearmed !", $COLOR_PURPLE)                  ;
            ReArm()                                                                              ;
            SetLog("Done. Returning to hopping", $COLOR_BLUE)                                    ;
            $checkReArmTimer = TimerInit() ; Reset                                               ;
        EndIf                                                                                    ;


        checkMainScreen(False)                                                                   ; START OF SEQUENCE
        Local $icount                                                                            ;
		Click(Random(87,260,1), Random(51,149,1))                                                ;     Random click
		If _Sleep(300) Then Return                                                               ;
		Click(Random(87,260,1), Random(51,149,1))                                                ;     Random click
        If _Sleep(500) Then Return                                                               ;
;		Click(Random(180,199,1), Random(21,40,1))                                                ; NEW Click Info Profile Button
		Click(Random(19,59,1), Random(12,53,1))                                                  ; NEW Click Info Profile Button
        If _Sleep(600) Then Return                                                               ;
        _CaptureRegion()                                                                         ;
        While _ColorCheck(_GetPixelColor(242, 80, True), Hex(0x000000, 6), 20) = False           ; Wait for Info Profile to open
            $iCount += 1                                                                         ;
            ;If _Sleep(600) Then Return                                                          ;
            If $iCount >= 3 Then ExitLoop                                                        ;
        WEnd                                                                                     ;
		Click(Random(277,435,1), Random(58,106,1))                                               ; NEW Click clan tab
        If _Sleep(600) Then Return                                                               ;
           _CaptureRegion()                                                                      ;
			If _ColorCheck(_GetPixelColor(800,200), Hex(0xe8e8e0,6)) Then                        ; If in Create Clan tab
			SetLog("Click Join Clan Tab", $COLOR_BLUE)                                           ;
			Click(Random(451,607,1), Random(63,106,1))                                           ;
			ElseIf _ColorCheck(_GetPixelColor(720,340), Hex(0xE55050,6)) Then                    ; If red leave clan button is there
            SetLog("Leaving clan", $COLOR_BLUE)                                                  ;
			Click(Random(700,832,1), Random(324,354,1))                                          ; NEW Click leave button
            If _Sleep(600) Then Return                                                           ;
            _CaptureRegion()                                                                     ;
            If _Colorcheck(_GetPIxelColor(393,412), Hex(0xF0B964,6)) Then                        ; If orange do you really want to leave cancel button
				Click(Random(445,581,1), Random(401,455,1))                                      ; NEW Click Okay
            Else                                                                                 ;
               SetLog("Error, cancel button not available, restarting...", $COLOR_RED)           ;
			   ContinueLoop                                                                      ;
            EndIf                                                                                ;
            If _Sleep(1000) Then Return                                                          ;
;			Click(Random(180,199,1), Random(21,40,1))                                            ; NEW Click Info Profile Button
			Click(Random(19,59,1), Random(12,53,1))                                              ; NEW Click Info Profile Button
            $icount = 0                                                                          ;
            While _ColorCheck(_GetPixelColor(222, 60, True), Hex(0x000000, 6), 20) = False       ; Wait for Info Profile to open
                $iCount += 1                                                                     ;
                If _Sleep(600) Then Return                                                       ;
                If $iCount >= 3 Then ExitLoop                                                    ;
            WEnd                                                                                 ;
            SetLog("Searching for a new clan", $COLOR_BLUE)                                      ;
			Click(Random(451,607,1), Random(63,106,1))                                           ; NEW Click clan tab
        EndIf                                                                                    ;
        If _Sleep(500) Then Return                                                               ;
        For $i = 0 To Random(0,7,1)                                                              ; Scroll down clan list (random 0 to 5 times, max 8)
            Local $sCount = 0                                                                    ;
            While $sCount < 1                                                                    ;
                If _Sleep(300) Then Return                                                       ;
				ClickDrag(550, 635, 550, 308, 600)                                               ; NEW Replace 300 with 600 for slow computers
                $sCount += 1                                                                     ;
            WEnd                                                                                 ;
        Next                                                                                     ;
		If _Sleep(600) Then Return                                                               ;
		Click(Random(22,839,1), Random(286,655,1))                                               ; NEW Click random clan
		If _Sleep(1000) Then Return                                                              ; Wait 1 sec for Join button appearing  (increase if not enough)
        If _ColorCheck(_GetPixelColor(720,335,True), Hex(0xC0E158,6), 20) Then                   ; Is join button there
			SetLog("... Clan found !", $COLOR_BLUE)                                              ;
		If _Sleep(500) Then Return                                                               ;
			Click(Random(700,832,1), Random(324,354,1))                                          ; NEW Click join clan
			SetLog("Entering clan", $COLOR_BLUE)                                                 ;
        Else                                                                                     ;
            SetLog("Oh oh ! I did something wrong, restarting...", $COLOR_RED)                   ;
            ContinueLoop                                                                         ;
        EndIf                                                                                    ;
        If _Sleep(6000) Then Return                                                              ; Wait for "you are now member of clan xxx" disappears
		SetLog("Time to donate troops")                                                          ;
		PrepareDonateCC()                                                                        ;
		DonateCC(False)                                                                          ;
		If _Sleep(500) Then Return                                                               ;
		SetLog("Check if I missed some requests")                                                ;
		PrepareDonateCC()                                                                        ;
		DonateCC(False)                                                                          ;
		If _Sleep(300) Then Return                                                               ;
		VillageReport(False, True)                                                               ;
		If _Sleep(500) Then Return                                                               ;
		ProfileSwitch()                                                                          ;
		If $g_bRestart = True Then ContinueLoop                                                     ;
		chkShieldStatus()                                                                        ;
		If $g_bRestart = True Then ContinueLoop                                                     ;
	    checkAndroidTimeLag()                                                                    ;
		If $g_bRestart = True Then ContinueLoop                                                     ;
		;$cycleCount =$cycleCount+1                                                              ;
    WEnd                                                                                         ;

EndFunc ; clanHop