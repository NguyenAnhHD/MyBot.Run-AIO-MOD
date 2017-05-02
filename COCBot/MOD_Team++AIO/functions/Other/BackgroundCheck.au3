#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Kychera
 Date:    2016
 Script Function: Check background color or image
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

;========= Addied Kychera ==============
Func chkPic()
   Dim $i
	If GUICtrlRead($chkPic) = $GUI_CHECKED Then
	       $ichkPic = 1
	        GUICtrlSetState($BackGr, $GUI_SHOW)
	      For $i = 1 To 50
		    GUICtrlSetState(Eval("" & $i), $GUI_SHOW)
         Next
	ElseIf GUICtrlRead($chkPic) = $GUI_UNCHECKED Then
	        $ichkPic = 0
	        GUICtrlSetState($BackGr, $GUI_HIDE)
		 For $i = 1 To 50	
			GUICtrlSetState(Eval("" & $i), $GUI_HIDE)
   	     Next				
	EndIf
EndFunc   ;==>chkPic


 Func BackGr()
     Local $iKey
        For $i = 1 To 42
            $iKey = StringRight(GUICtrlRead($BackGr), 1)
            GUICtrlSetImage(Eval("" & $i), @ScriptDir & '\Images\' & $iKey & '.jpg')			
        Next
		 For $i = 43 To 47
            $iKey = StringRight(GUICtrlRead($BackGr), 1)
            GUICtrlSetImage(Eval("" & $i), @ScriptDir & '\Images2\' & $iKey & '.jpg')			
        Next		
		 For $i = 49 To 50
            $iKey = StringRight(GUICtrlRead($BackGr), 1)
            GUICtrlSetImage(Eval("" & $i), @ScriptDir & '\Images3\' & $iKey & '.jpg')			
        Next		
EndFunc   ;==>BackGr
;================================