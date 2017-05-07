#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
Func _GUICtrlCreateRadio($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle = -1, $iExStyle = -1)
    GUICtrlCreateLabel($sText, $iLeft + 17, $iTop + Round(($iHeight + 5) / 2) - 0, -1, -1)
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	Local $ID = GUICtrlCreateRadio($sText, $iLeft, $iTop + Round(($iHeight + 5) / 2), 13, 13, $iStyle, $iExStyle)
    If $ID = 0 Then
        Return 0
    EndIf
    Return $ID
EndFunc   ;==>_GUICtrlCreateRadio

