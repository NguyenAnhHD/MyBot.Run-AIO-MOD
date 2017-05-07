#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
Func _GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle = -1, $iExStyle = -1)
    GUICtrlCreateLabel($sText, $iLeft + 17, $iTop + Round(($iHeight + 5) / 2) - 0, -1, -1)
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	Local $ID = GUICtrlCreateCheckbox($sText, $iLeft, $iTop + Round(($iHeight + 5) / 2), 13, 13, $iStyle, $iExStyle)
    If $ID = 0 Then
        Return 0
    EndIf
    Return $ID
EndFunc   ;==>_GUICtrlCreateCheckbox

Func _GUICtrlCreateCheckboxEx($sText, $iLeft, $iTop, $iWidth, $iHeight, $sBackColor = "" , $sTextColor = $COLOR_ORANGE)
    Local $aCheckBoxID[2]

    $aCheckBoxID[0] = GUICtrlCreateCheckbox("", $iLeft, $iTop, 13, 13)
    $aCheckBoxID[1] = GUICtrlCreateLabel($sText, $iLeft + 17, $iTop + Round(($iHeight + 5) / 2) - 0, -1, -1)
                     GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
    If $sTextColor <> "" And $aCheckBoxID[1] Then
        GUICtrlSetColor($aCheckBoxID[1], $sTextColor)
    EndIf

    If $sBackColor <> "" And $aCheckBoxID[1] Then
        GUICtrlSetBkColor($aCheckBoxID[1], $sBackColor)
    EndIf

    Return $aCheckBoxID
EndFunc
