#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Kychera
 Date:           18.01.2017
 Date mod.       03/03/2017
 Script Function: Transparent Gui
 
#ce ----------------------------------------------------------------------------
Func Slider()        
     $iSldTransLevel = GUICtrlRead($SldTransLevel)
     GUICtrlSetData($SldTransLevel, $iSldTransLevel) 
	  Switch $iSldTransLevel                
                Case 0
                    WinSetTrans($g_hFrmBot , "", 255)
				Case 1
                    WinSetTrans($g_hFrmBot , "", 235)	
                Case 2
                    WinSetTrans($g_hFrmBot , "", 220)
                Case 3
                    WinSetTrans($g_hFrmBot , "", 205)
                Case 4
                    WinSetTrans($g_hFrmBot , "", 190)
			    Case 5
                    WinSetTrans($g_hFrmBot , "", 175)
				Case 6
                    WinSetTrans($g_hFrmBot , "", 160)
				Case 7
                    WinSetTrans($g_hFrmBot , "", 100)	
                Case 8
                    WinSetTrans($g_hFrmBot , "", 50)            
      EndSwitch    
EndFunc	

 