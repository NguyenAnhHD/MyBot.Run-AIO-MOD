#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         kychera

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
Func chkRusLang2()
If GUICtrlRead($chkRusLang2) = $GUI_CHECKED Then
		$ichkRusLang2 = 1
	Else
		$ichkRusLang2 = 0
	EndIf
EndFunc 


Func ChkNotifyAlertBOTSleep()
   If $g_bNotifyPBEnable = True Or $g_bNotifyTGEnable = True Then
      GUICtrlSetState($ChkNotifyAlertBOTSleep, $GUI_ENABLE)
   Else
      GUICtrlSetState($ChkNotifyAlertBOTSleep, $GUI_DISABLE)
   EndIf
EndFunc 

Func ChkNotifyConnect()
   If $g_bNotifyPBEnable = True Or $g_bNotifyTGEnable = True Then
      GUICtrlSetState($ChkNotifyAlertConnect, $GUI_ENABLE)
   Else
      GUICtrlSetState($ChkNotifyAlertConnect, $GUI_DISABLE)
   EndIf
EndFunc 