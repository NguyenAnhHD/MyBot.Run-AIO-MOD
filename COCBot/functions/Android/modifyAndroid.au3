; #FUNCTION# ====================================================================================================================
; Name ..........: modifyAndroid
; Description ...: Function to start the correct Android Instance
; Syntax ........: modifyAndroid()
; Parameters ....: None
; Return values .: None
; Author ........: LunaEclipse(March 2016)
; Modified ......: rulesss,kychera
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Func getEmulatorNumber($emulatorName)
	Local $return = -1
	Local $i = 0

	; This loops through the array but allows us to exit as soon as we find our match.
	While $i < UBound($g_avAndroidAppConfig)
		If $g_avAndroidAppConfig[$i][0] = $emulatorName Then
			$return = $i
			ExitLoop
		EndIf

		$i += 1
	WEnd

	; This returns -1 if not found in the array, otherwise the array index.
	Return $return
EndFunc   ;==>getEmulatorNumber

Func getInstalledEmulators() ; Returns an array of all installed Android Emulators
	Local $currentConfig = $g_iAndroidConfig, $currentAndroid = $g_sAndroidEmulator, $currentAndroidInstance = $g_sAndroidInstance
	Local $aReturn[1], $arrayCounter = 0

    $g_bSilentSetLog = True

	For $i = 0 To UBound($g_avAndroidAppConfig) - 1
	    $g_iAndroidConfig = $i
		$g_bInitAndroid = True

		If UpdateAndroidConfig() Then
		    ; Installed Android found
			ReDim $aReturn[$arrayCounter + 1]

			$aReturn[$arrayCounter] = $g_avAndroidAppConfig[$i][0]
			$arrayCounter += 1
		EndIf
	Next

	; Check to make sure an emulator was found.
	If $arrayCounter = 0 Then
		$aReturn[$arrayCounter] = "<No Emulators>"

		; No emulator found so show a message box and exit.
		MsgBox(0, $g_sBotTitle, _
				  "There is no valid Emulators installed.  This BOT will not work without a recognized emulator installed!" & @CRLF & @CRLF & _
				  "Please install a valid emulator before trying to use this BOT!" & @CRLF & @CRLF & _
				  "Valid emulators are BlueStacks, Bluestacks2, Nox, Droid4x and MEmu.")
		Exit
	EndIf

	; Reset to the previous settings
	$g_iAndroidConfig = $CurrentConfig
	$g_sAndroidEmulator = $currentAndroid
	$g_sAndroidInstance = $currentAndroidInstance

	$g_bInitAndroid = True
 	UpdateAndroidConfig($g_sAndroidInstance)

    $g_bSilentSetLog = False

	Return $aReturn
EndFunc   ;==>getInstalledEmulators

Func setupInstances()
	; Update Bot title
	Local $g_sOldTitle = $g_sBotTitle 
    UpdateBotTitle()
 
	Local $g_hMutexTmp = _Singleton($g_sBotTitle, 1)
	If $g_hMutexTmp = 0 And $g_sBotTitle <> $g_sOldTitle Then
		MsgBox(0, $g_sBotTitle, "My Bot for " & $g_sAndroidEmulator & ($g_sAndroidInstance <> "" ? " instance (" & $g_sAndroidInstance & ")" : "") & " is already running." & @CRLF & @CRLF & _
			   "To use this profile you must close the BOT that is currently running on " & $g_sAndroidEmulator & ($g_sAndroidInstance <> "" ? " instance (" & $g_sAndroidInstance & ")" : ""))
		Exit
	EndIf
	_WinAPI_CloseHandle($g_hMutex_BotTitle)

	$g_hMutex_BotTitle = $g_hMutexTmp
	WinSetTitle($g_hFrmBot, "", $g_sBotTitle)

	AndroidAdbTerminateShellInstance()
	UpdateHWnD(0) ; refresh Android Handle

	$g_bInitAndroid = True
	UpdateAndroidConfig($g_sAndroidInstance)
EndFunc   ;==>setupInstances

Func modifyAndroid()
 If $g_iChkAndroid = 1 Then
	Local $currentConfig = $g_iAndroidConfig, $currentAndroid = $g_sAndroidEmulator, $currentAndroidInstance = $g_sAndroidInstance

	; Only use the profile for stored emulator and instance if there was no specific emulator and/or instance specified in the command line.
	Switch $g_asCmdLine[0]
		Case 0, 1 ; Command line does not contain any emulator information so use the profile settings.
			; Set profile name to the text box value if no profiles are found.
			If $g_sProfileCurrentName = "<No Profiles>" Then $g_sProfileCurrentName = StringRegExpReplace(GUICtrlRead($g_hTxtVillageName), '[/:*?"<>|]', '_')

			$g_iAndroidConfig = getEmulatorNumber($sAndroid)

			Switch $sAndroid
				Case "<No Emulators>"
					; Should never happen because the BOT should have exited if no emulator found.
				Case "BlueStacks", "BlueStacks2"
					; Bluestacks or Bluestacks2 so ignore the instance parameter.
					GUICtrlSetState($TxtAndroidInstance, $GUI_DISABLE)

					$g_sAndroidEmulator = $sAndroid
					$g_sAndroidInstance = ""

					If $g_iAndroidConfig <> $currentConfig Or $g_sAndroidEmulator <> $currentAndroid Then setupInstances()
				Case Else
					; Another emulator so use the instance parameter
					GUICtrlSetState($TxtAndroidInstance, $GUI_ENABLE)
                    Local $sAndroidInfo = ""
					$g_sAndroidEmulator = $sAndroid
			        $g_sAndroidInstance = $sAndroidInfo
					
					
					If $g_iAndroidConfig <> $currentConfig Or $g_sAndroidEmulator <> $currentAndroid Or $g_sAndroidInstance <> $currentAndroidInstance Then setupInstances()
			EndSwitch
		Case 2 ; Emulator is specified by the command line so use it instead of the profile setting.
			$g_sAndroidEmulator = $g_asCmdLine[2]
			$g_iAndroidConfig = getEmulatorNumber($g_sAndroidEmulator)
			$g_sAndroidInstance = $g_avAndroidAppConfig[$g_iAndroidConfig][1] ; default instance

			If $g_iAndroidConfig <> $currentConfig Or $g_sAndroidEmulator <> $currentAndroid Then setupInstances()
		Case Else ; Emulator and instance is specified by the command line so use them instead of the profile settings.
			$g_sAndroidEmulator = $g_asCmdLine[2]
			$g_iAndroidConfig = getEmulatorNumber($g_sAndroidEmulator)
			$g_sAndroidInstance = $g_asCmdLine[3]

			If $g_iAndroidConfig <> $currentConfig Or $g_sAndroidEmulator <> $currentAndroid Or $g_sAndroidInstance <> $currentAndroidInstance Then setupInstances()
	EndSwitch
 EndIf	
EndFunc   ;==>modifyAndroid