; #FUNCTION# ====================================================================================================================
; Name ..........: GUI Design DropOrderTpoops
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: Kychera 05/2017
; Modified ......: 
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Global $g_hChkCustomTrainDropOrderEnable = 0
Global $g_bCustomTrainDropOrderEnable = False
Global $g_hBtnRemoveTroops2, $g_hBtnTroopOrderSet2
Global $g_ahImgTroopDropOrderSet = 0
Global $g_ahImgTroopDropOrder[$eTroopCountDrop] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]  
Global $cmbDropTroops = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Global Const $g_asTroopDropList[] = [ "", _
   GetTranslated(604,1, "Barbarians"), GetTranslated(604,2, "Archers"), GetTranslated(604,3, "Giants"), GetTranslated(604,4, "Goblins"), _
   GetTranslated(604,5, "Wall Breakers"), GetTranslated(604,7, "Balloons"), GetTranslated(604,8, "Wizards"), GetTranslated(604,9, "Healers"), _
   GetTranslated(604,10, "Dragons"), GetTranslated(604,11, "Pekkas"), GetTranslated(604,20, "Baby Dragons"), GetTranslated(604,21, "Miners"), _
   GetTranslated(604,13, "Minions"), GetTranslated(604,14, "Hog Riders"), GetTranslated(604,15, "Valkyries"), GetTranslated(604,16, "Golems"), _
   GetTranslated(604,17, "Witches"), GetTranslated(604,18, "Lava Hounds"), GetTranslated(604, 19, "Bowlers"), GetTranslated(604, 25,"Clan Castle"), GetTranslated(604, 26,"Heroes")] 


Func TroopsDrop()
$10 = GUICtrlCreatePic(@ScriptDir & '\COCBot\MOD_Team++AIO\Images\1.jpg', 2, 23, 442, 410, $WS_CLIPCHILDREN)
Local $x = 25, $y = 45
GUICtrlCreateGroup(GetTranslated(641, 58, "Custom dropping order"), $x - 20, $y - 20, 350, 405)
$x += 10
$y += 20
        GUICtrlCreateLabel("BETA", $x + 200, $y - 35, 50, 30)
		GUICtrlSetFont(-1, 14, 700, 0, "Comic Sans MS")
		 GUICtrlSetBkColor(-1, 0xCCFFCC)
$g_hChkCustomTrainDropOrderEnable = GUICtrlCreateCheckbox(GetTranslated(641, 59, "Enable troops order drop"), $x, $y - 25, -1, -1)
	   GUICtrlSetState(-1, $GUI_UNCHECKED)
	   _GUICtrlSetTip(-1, GetTranslated(641, 60, "Enable to select a custom troop dropping order") & @CRLF & _
						  GetTranslated(641, 61, "Changing drop order can NOT be used with CSV scripted attack! For a standard attack. Live and dead bases. Consistency - all troops"))
	   GUICtrlSetOnEvent(-1, "chkTroopDropOrder")
	 ; If UBound($g_asTroopOrderList) - 1 <> $eTroopCount Then ; safety check in case troops are added
	;	If $g_iDebugSetlogTrain = 1 Then Setlog("UBound($g_asTroopOrderList) - 1: " & UBound($g_asTroopOrderList) - 1 & " = " & "$eTroopCount: " & $eTroopCount, $COLOR_DEBUG) ;Debug
	;	Setlog("Monkey ate bad banana, fix $g_asTroopOrderList & $eTroopCount arrays!", $COLOR_RED)
	 ; EndIf

	  ; Create translated list of Troops for combo box
Local $sComboData = ""
	    For $j = 0 To UBound($g_asTroopDropList) - 1
		  $sComboData &= $g_asTroopDropList[$j] & "|"
	    Next

	  For $p = 0 To $eTroopCountDrop - 1
		  If $p < 10 Then
			  GUICtrlCreateLabel($p + 1 & ":", $x - 16, $y + 2, -1, 25)
			  $cmbDropTroops[$p] = GUICtrlCreateCombo("", $x, $y, 94, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				  GUICtrlSetOnEvent(-1, "GUITrainOrder2")
				 GUICtrlSetData(-1, $sComboData, "")
				
				 ;_GUICtrlSetTip(-1, $txtTroopOrder & $p + 1)
				 GUICtrlSetState(-1, $GUI_DISABLE)
			  $g_ahImgTroopDropOrder[$p] = GUICtrlCreateIcon($g_sLibIconPath, $eIcnOptions, $x + 100, $y, 25, 25)
			  $y += 30 ; move down to next combobox location
		  Else
			  If $p = 10 Then
				  $x += 135
				  $y = 65
			  EndIf
			  GUICtrlCreateLabel($p + 1 & ":", $x - 5, $y + 2, -1, 25)
			  $cmbDropTroops[$p] = GUICtrlCreateCombo("", $x + 20, $y, 94, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				  GUICtrlSetOnEvent(-1, "GUITrainOrder2")
				 GUICtrlSetData(-1, $sComboData, "")
				
				 ;_GUICtrlSetTip(-1, $txtTroopOrder & $p + 1)
				 GUICtrlSetState(-1, $GUI_DISABLE)
			$g_ahImgTroopDropOrder[$p] =  GUICtrlCreateIcon($g_sLibIconPath, $eIcnOptions, $x + 120, $y, 25, 25)
			  $y += 30 ; move down to next combobox location
		  EndIf
	  Next
	  
	  $x = 25
	  $y = 400
		  ; Create push button to set training order once completed
		  $g_hBtnTroopOrderSet2 = GUICtrlCreateButton(GetTranslated(641, 62, "Apply New Order"), $x, $y, 100, 25)
			 GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_ENABLE))
			 _GUICtrlSetTip(-1, GetTranslated(641, 63, "Push button when finished selecting custom troops dropping order") & @CRLF & _								
								GetTranslated(641, 65, "When not all troop slots are filled, will use random troop order in empty slots!"))
			 GUICtrlSetOnEvent(-1, "btnTroopOrderSet2")
		  ;$g_ahImgTroopOrderSet = GUICtrlCreateIcon($g_sLibIconPath, $eIcnSilverStar, $x + 226, $y + 2, 18, 18)
      $x += 150
	     $g_hBtnRemoveTroops2 = GUICtrlCreateButton(GetTranslated(641, 66, "Empty drop list"), $x, $y, 110, 25)
			GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_DISABLE))
			_GUICtrlSetTip(-1, GetTranslated(641, 67, "Push button to remove all troops from list and start over"))
			GUICtrlSetOnEvent(-1, "btnRemoveTroops2")

EndFunc