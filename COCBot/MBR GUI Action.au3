; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Action
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: cosote (2016)
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func BotStart($bAutostartDelay = 0)
	FuncEnter(BotStart)

	If Not $g_bSearchMode Then
		If $g_hLogFile = 0 Then CreateLogFile() ; only create new log file when doesn't exist yet
		CreateAttackLogFile()
		If $g_iFirstRun = -1 Then $g_iFirstRun = 1
	EndIf
	SetLogCentered(" BOT LOG ", Default, Default, True)

	If Not ForumAuthentication() Then
		; not authenticated exit now, but restore controls first
		EnableControls($g_hFrmBotBottom, Default, $g_aFrmBotBottomCtrlState)
		SetRedrawBotWindow(True, Default, Default, Default, "BotStart")
		Return FuncReturn()
	EndIf

	ResumeAndroid()
	CleanSecureFiles()
	CalCostCamp()
	CalCostSpell()
	CalCostSiege()

	$g_bRunState = True
	$g_bTogglePauseAllowed = True
	$g_bSkipFirstZoomout = False
	$g_bIsSearchLimit = False
	$g_bIsClientSyncError = False

	EnableControls($g_hFrmBotBottom, False, $g_aFrmBotBottomCtrlState)
	;$g_iFirstAttack = 0

	$g_bTrainEnabled = True
	$g_bDonationEnabled = True
	$g_bMeetCondStop = False
	$g_bIsClientSyncError = False
	$g_bDisableBreakCheck = False ; reset flag to check for early warning message when bot start/restart in case user stopped in middle

	SaveConfig()
	readConfig()
	applyConfig(False) ; bot window redraw stays disabled!
	CreaTableDB()

	; Initial ObjEvents for the Autoit objects errors
	__ObjEventIni()

	If BitAND($g_iAndroidSupportFeature, 1 + 2) = 0 And $g_bChkBackgroundMode = True Then
		GUICtrlSetState($g_hChkBackgroundMode, $GUI_UNCHECKED)
		UpdateChkBackground() ; Invoke Event manually
		SetLog("Background Mode not supported for " & $g_sAndroidEmulator & " and has been disabled", $COLOR_ERROR)
	EndIf

	; update bottom buttons
	GUICtrlSetState($g_hBtnStart, $GUI_HIDE)
	GUICtrlSetState($g_hBtnStop, $GUI_SHOW)
	GUICtrlSetState($g_hBtnPause, $GUI_SHOW)
	GUICtrlSetState($g_hBtnResume, $GUI_HIDE)
	GUICtrlSetState($g_hBtnSearchMode, $GUI_HIDE)
	GUICtrlSetState($g_hChkBackgroundMode, $GUI_DISABLE)

	; update try items
	TrayItemSetText($g_hTiStartStop, GetTranslatedFileIni("MBR GUI Design - Loading", "StatusBar_Item_Stop", "Stop bot"))
	TrayItemSetState($g_hTiPause, $TRAY_ENABLE)
	TrayItemSetText($g_hTiPause, GetTranslatedFileIni("MBR GUI Design - Loading", "StatusBar_Item_Pause", "Pause bot"))

	EnableControls($g_hFrmBotBottom, Default, $g_aFrmBotBottomCtrlState)

	DisableGuiControls()

	SetRedrawBotWindow(True, Default, Default, Default, "BotStart")

	If $bAutostartDelay Then
		SetLog("Bot Auto Starting in " & Round($bAutostartDelay / 1000, 0) & " seconds", $COLOR_ERROR)
		_SleepStatus($bAutostartDelay)
	EndIf

	; wait for slot
	LockBotSlot(True)
	If $g_bRunState = False Then Return FuncReturn()

	Local $Result = False
	If WinGetAndroidHandle() = 0 Then
		$Result = OpenAndroid(False)
	EndIf
	SetDebugLog("Android Window Handle: " & WinGetAndroidHandle())
	If $g_hAndroidWindow <> 0 Then ;Is Android open?
		If Not $g_bRunState Then Return FuncReturn()
		If $g_bAndroidBackgroundLaunched = True Or AndroidControlAvailable() Then ; Really?
			If Not $Result Then
				$Result = InitiateLayout()
			EndIf
		Else
			; Not really
			SetLog("Current " & $g_sAndroidEmulator & " Window not supported by MyBot", $COLOR_ERROR)
			$Result = RebootAndroid(False)
		EndIf
		If Not $g_bRunState Then Return FuncReturn()
		Local $hWndActive = $g_hAndroidWindow
		; check if window can be activated
		If $g_bNoFocusTampering = False And $g_bAndroidBackgroundLaunched = False And $g_bAndroidEmbedded = False Then
			Local $hTimer = __TimerInit()
			$hWndActive = -1
			Local $activeHWnD = WinGetHandle("")
			While __TimerDiff($hTimer) < 1000 And $hWndActive <> $g_hAndroidWindow And Not _Sleep(100)
				$hWndActive = WinActivate($g_hAndroidWindow) ; ensure bot has window focus
			WEnd
			WinActivate($activeHWnD) ; restore current active window
		EndIf
		If Not $g_bRunState Then Return FuncReturn()
		If $hWndActive = $g_hAndroidWindow And ($g_bAndroidBackgroundLaunched = True Or AndroidControlAvailable())  Then ; Really?

			; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
			If $g_bChkAutoDock Then
				If Not $g_bAndroidEmbedded Then
					SetLog("Auto use Dock Android Window", $COLOR_INFO)
					btnEmbed()
				EndIf
				If _Sleep($DELAYRUNBOT5) Then Return
			ElseIf $g_bChkAutoHideEmulator Then
				If Not $g_bIsHidden Then
					SetLog("Auto hidden the Emulator", $COLOR_INFO)
					btnHide()
					$g_bIsHidden = True
				EndIf
				If _Sleep($DELAYRUNBOT5) Then Return
			EndIf

			If $g_bChkAutoMinimizeBot Then
				SetLog("Auto Minimize the Bot", $COLOR_INFO)
				If $g_bUpdatingWhenMinimized Then
					If $g_bHideWhenMinimized Then
						WinMove2($g_hFrmBot, "", -32000, -32000, -1, -1, 0, $SWP_HIDEWINDOW, False)
						_WinAPI_SetWindowLong($g_hFrmBot, $GWL_EXSTYLE, BitOR(_WinAPI_GetWindowLong($g_hFrmBot, $GWL_EXSTYLE), $WS_EX_TOOLWINDOW))
					EndIf
					If _WinAPI_IsIconic($g_hFrmBot) Then WinSetState($g_hFrmBot, "", @SW_RESTORE)
					If _WinAPI_IsIconic($g_hAndroidWindow) Then WinSetState($g_hAndroidWindow, "", @SW_RESTORE)
					WinMove2($g_hFrmBot, "", -32000, -32000, -1, -1, 0, BitOR($SWP_SHOWWINDOW, $SWP_NOACTIVATE), False)
				Else
					If $g_bHideWhenMinimized Then
						WinMove2($g_hFrmBot, "", -1, -1, -1, -1, 0, $SWP_HIDEWINDOW, False)
						_WinAPI_SetWindowLong($g_hFrmBot, $GWL_EXSTYLE, BitOR(_WinAPI_GetWindowLong($g_hFrmBot, $GWL_EXSTYLE), $WS_EX_TOOLWINDOW))
					EndIf
					WinSetState($g_hFrmBot, "", @SW_MINIMIZE)
				EndIf
				If _Sleep($DELAYRUNBOT5) Then Return
			EndIf

			Initiate() ; Initiate and run bot
		Else
			SetLog("Cannot use " & $g_sAndroidEmulator & ", please check log", $COLOR_ERROR)
			btnStop()
		EndIf
	Else
		SetLog("Cannot start " & $g_sAndroidEmulator & ", please check log", $COLOR_ERROR)
		btnStop()
	EndIf
	FuncReturn()
EndFunc   ;==>BotStart

Func BotStop()
	FuncEnter(BotStop)
	; release bot slot
	LockBotSlot(False)

	; release other switch accounts
	releaseProfilesMutex()

	ResumeAndroid()

	$g_bRunState = False
	$g_bBotPaused = False
	$g_bTogglePauseAllowed = True

	;WinSetState($g_hFrmBotBottom, "", @SW_DISABLE)
	Local $aCtrlState
	EnableControls($g_hFrmBotBottom, False, $g_aFrmBotBottomCtrlState)
	;$g_bFirstStart = true

	EnableGuiControls()

	;DistributorsUpdateGUI()
	AndroidBotStopEvent() ; signal android that bot is now stopping
	If $g_bTerminateAdbShellOnStop Then
		AndroidAdbTerminateShellInstance() ; terminate shell instance
	EndIf
	AndroidShield("btnStop", Default)

	EnableControls($g_hFrmBotBottom, Default, $g_aFrmBotBottomCtrlState)

	; update bottom buttons
	GUICtrlSetState($g_hChkBackgroundMode, $GUI_ENABLE)
	GUICtrlSetState($g_hBtnStart, $GUI_SHOW)
	GUICtrlSetState($g_hBtnStop, $GUI_HIDE)
	GUICtrlSetState($g_hBtnPause, $GUI_HIDE)
	GUICtrlSetState($g_hBtnResume, $GUI_HIDE)
	If $g_iTownHallLevel > 2 Then GUICtrlSetState($g_hBtnSearchMode, $GUI_ENABLE)
	GUICtrlSetState($g_hBtnSearchMode, $GUI_SHOW)
	;GUICtrlSetState($g_hBtnMakeScreenshot, $GUI_ENABLE)

	; Enable/Disable GUI while botting - Team AiO MOD++
	GUICtrlSetState($g_hBtnEnableGUI, $GUI_HIDE)
	GUICtrlSetState($g_hBtnDisableGUI, $GUI_HIDE)

	; hide attack buttons if show
	GUICtrlSetState($g_hBtnAttackNowDB, $GUI_HIDE)
	GUICtrlSetState($g_hBtnAttackNowLB, $GUI_HIDE)
	GUICtrlSetState($g_hBtnAttackNowTS, $GUI_HIDE)
	GUICtrlSetState($g_hPicTwoArrowShield, $GUI_SHOW)
	GUICtrlSetState($g_hLblVersion, $GUI_SHOW)
	GUICtrlSetState($g_hLblMod, $GUI_SHOW)

	; update try items
	TrayItemSetText($g_hTiStartStop, GetTranslatedFileIni("MBR GUI Design - Loading", "StatusBar_Item_Start", "Start bot"))
	TrayItemSetState($g_hTiPause, $TRAY_DISABLE)

	SetLogCentered(" Bot Stop ", Default, $COLOR_ACTION)
	If Not $g_bSearchMode Then
		If Not $g_bBotPaused Then $g_iTimePassed += Int(__TimerDiff($g_hTimerSinceStarted))
		If ProfileSwitchAccountEnabled() And Not $g_bBotPaused Then $g_aiRunTime[$g_iCurAccount] += Int(__TimerDiff($g_ahTimerSinceSwitched[$g_iCurAccount]))
		;AdlibUnRegister("SetTime")
		$g_bRestart = True

	   If $g_hLogFile <> 0 Then
		  FileClose($g_hLogFile)
		  $g_hLogFile = 0
	   EndIf

	   If $g_hAttackLogFile <> 0 Then
		  FileClose($g_hAttackLogFile)
		  $g_hAttackLogFile = 0
	   EndIf
	Else
		$g_bSearchMode = False
	EndIf

	; Ends ObjEvents for the Autoit objects errors
	__ObjEventEnds()

	ReduceBotMemory()
	FuncReturn()
EndFunc   ;==>BotStop

Func BotSearchMode()
	FuncEnter(BotSearchMode)
	$g_bSearchMode = True
	$g_bRestart = False
	$g_bIsClientSyncError = False
	If $g_iFirstRun = 1 Then $g_iFirstRun = -1
	btnStart()
	checkMainScreen(False)
	If _Sleep(100) Then Return FuncReturn()
	$g_aiCurrentLoot[$eLootTrophy] = getTrophyMainScreen($aTrophies[0], $aTrophies[1]) ; get OCR to read current Village Trophies
	If _Sleep(100) Then Return FuncReturn()
	CheckIfArmyIsReady()
	ClickP($aAway, 2, 0, "") ;Click Away
	If _Sleep(100) Then Return FuncReturn()
	If (IsSearchModeActive($DB) And checkCollectors(True, False)) Or IsSearchModeActive($LB) Or IsSearchModeActive($TS) Then
		If _Sleep(100) Then Return FuncReturn()
		PrepareSearch()
		If _Sleep(1000) Then Return FuncReturn()
		VillageSearch()
		If _Sleep(100) Then Return FuncReturn()
	Else
		SetLog("Your Army is not prepared, check the Attack/train options")
	EndIf
	btnStop()
	FuncReturn()
EndFunc   ;==>BotSearchMode
