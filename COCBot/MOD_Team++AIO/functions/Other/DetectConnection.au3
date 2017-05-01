#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Kychera
 Date:           22.04.2017
 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#Include <WinAPI.au3>
Func _IsInternet()
    Local $Ret = DllCall('wininet.dll', 'int', 'InternetGetConnectedState', 'dword*', 0x20, 'dword', 0)
    If @error Then
        Return SetError(1, 0, 0)
    EndIf
    Local $Error = _WinAPI_GetLastError()
    Return SetError((Not ($Error = 0)), $Error, $Ret[0])
EndFunc   ;==>_IsInternet

Func _ConnectTime()         
    If $iNotifyAlertConnect = 1 and _IsInternet() <> 1 Then     
	 $TimerConnect = __TimerInit() 
	 ;setlog("timer")
    EndIf	
EndFunc

Func _ConnectTime2()
Global $Secs = 0, $Mins = 0, $Hour = 0, $Time = 0
If $iNotifyAlertConnect = 1 and _IsInternet() <> 0 Then 	
	;$DiffConnect = TimerDiff($TimerConnect)	
	$DiffConnect = _TicksToTime(Int(__TimerDiff($TimerConnect)), $Hour, $Mins, $Secs)
	$Time = StringFormat("%02i:%02i:%02i", $Hour, $Mins, $Secs)
	;setlog($Time)
	  	  If $Time <> "00:00:00" Then
		  NotifyPendingActions()
	      PushMsg("Connect")		  
	      ;setlog("Connect")		 
	       EndIf	   
	  ;$TimerConnect = __TimerInit()
EndIf	 
EndFunc