; #FUNCTION# ====================================================================================================================
; Name ..........: Bot Humanization
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Roro-Titi
; Modified ......: Team AiO & RK MOD++ (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $Icon1 = 0 , $chkUseBotHumanization = 0 , $chkUseAltRClick = 0 , $Label1 = 0 , $g_acmbPriority , $Label20 = 0 , $challengeMessage = 0 , $g_ahumanMessage, $Label2 = 0 , $Label4 = 0 , $Label3= 0
Global $Icon2 = 0 , $Label5 = 0 , $Label6 = 0 , $Label7 = 0 , $Label8 = 0
Global $Icon3 = 0 , $Label9 = 0 , $Label10 = 0 , $Label11 = 0 , $Label12 = 0
Global $Icon4 = 0 , $Label14 = 0 , $Label15 = 0 , $Label16 = 0 , $Label13 = 0
Global $Icon5 = 0 , $Label17 = 0 , $Label18 = 0 , $chkCollectAchievements = 0 , $chkLookAtRedNotifications = 0 , $cmbMaxActionsNumber = 0

Func HumanizationGUI()
$3 = GUICtrlCreatePic($g_sImagePath & $g_sImageBg, 2, 23, 442, 410, $WS_CLIPCHILDREN)
	Local $x , $y

	$chkUseBotHumanization = _GUICtrlCreateCheckbox(GetTranslated(42, 0, "Enable Bot Humanization"), 10, 20, 137, 17, -1, -1)
 		GUICtrlSetOnEvent(-1, "chkUseBotHumanization")
 		GUICtrlSetState(-1, $GUI_UNCHECKED)

	$chkUseAltRClick = _GUICtrlCreateCheckbox(GetTranslated(42, 1, "Make ALL BOT clicks random"), 280, 20, 162, 17, -1, -1)
 		GUICtrlSetOnEvent(-1, "chkUseAltRClick")
 		GUICtrlSetState(-1, $GUI_UNCHECKED)

 	GUICtrlCreateGroup(GetTranslated(42, 2, "Settings"), 4, 55, 440, 335)

 	Local $x = 0, $y = 20

 	$x += 10
 	$y += 50

 		$Icon1 = GUICtrlCreateIcon($g_sLibIconPath, $eIcnChat, $x, $y + 5, 32, 32)
 		$Label1 = GUICtrlCreateLabel(GetTranslated(42, 3, "Read the Clan Chat"), $x + 40, $y + 5, 110, 17)
 		$g_acmbPriority[0] = GUICtrlCreateCombo("", $x + 155, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label2 = GUICtrlCreateLabel(GetTranslated(42, 4, "Read the Global Chat"), $x + 240, $y + 5, 110, 17)
 		$g_acmbPriority[1] = GUICtrlCreateCombo("", $x + 355, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label4 = GUICtrlCreateLabel(GetTranslated(42, 6, "Say..."), $x + 40, $y + 30, 47, 17)
 		$g_ahumanMessage[0] = GUICtrlCreateInput(GetTranslated(42, 7, "Hello !"), $x + 90, $y + 25, 100, 21)
 		$Label3 = GUICtrlCreateLabel(GetTranslated(42, 8, "Or"), $x + 195, $y + 30, 20, 17)
 		$g_ahumanMessage[1] = GUICtrlCreateInput(GetTranslated(42, 5, "Re !"), $x + 225, $y + 25, 121, 21)
 		$g_acmbPriority[2] = GUICtrlCreateCombo("", $x + 355, $y + 25, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label20 = GUICtrlCreateLabel(GetTranslated(42, 9, "Launch Challenges with message"), $x + 40, $y + 55, 170, 17)
		$challengeMessage = GUICtrlCreateInput(GetTranslated(42, 10, "Can you beat my village ?"), $x + 205, $y + 50, 141, 21)
 		$g_acmbPriority[12] = GUICtrlCreateCombo("", $x + 355, $y + 50, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))

 	$y += 81

 		$Icon2 = GUICtrlCreateIcon($g_sLibIconPath, $eIcnRepeat, $x, $y + 5, 32, 32)
 		$Label5 = GUICtrlCreateLabel(GetTranslated(42, 11, "Watch Defenses"), $x + 40, $y + 5, 110, 17)
 		$g_acmbPriority[3] = GUICtrlCreateCombo("", $x + 155, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 			GUICtrlSetOnEvent(-1, "cmbStandardReplay")
 		$Label6 = GUICtrlCreateLabel(GetTranslated(42, 12, "Watch Attacks"), $x + 40, $y + 30, 110, 17)
 		$g_acmbPriority[4] = GUICtrlCreateCombo("", $x + 155, $y + 25, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 			GUICtrlSetOnEvent(-1, "cmbStandardReplay")
 		$Label7 = GUICtrlCreateLabel(GetTranslated(42, 13, "Max Replay Speed") & " ", $x + 240, $y + 5, 110, 17)
 		$g_acmbMaxSpeed[0] = GUICtrlCreateCombo("", $x + 355, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, $g_sReplayChain, "2")
 		$Label8 = GUICtrlCreateLabel(GetTranslated(42, 14, "Pause Replay"), $x + 240, $y + 30, 110, 17)
 		$g_acmbPause[0] = GUICtrlCreateCombo("", $x + 355, $y + 25, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))

 	$y += 56

 		$Icon3 = GUICtrlCreateIcon($g_sLibIconPath, $eIcnClan, $x, $y + 5, 32, 32)
 		$Label9 = GUICtrlCreateLabel(GetTranslated(42, 15, "Watch War log"), $x + 40, $y + 5, 110, 17)
 		$g_acmbPriority[5] = GUICtrlCreateCombo("", $x + 155, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label10 = GUICtrlCreateLabel(GetTranslated(42, 16, "Visit Clanmates"), $x + 40, $y + 30, 110, 17)
 		$g_acmbPriority[6] = GUICtrlCreateCombo("", $x + 155, $y + 25, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label11 = GUICtrlCreateLabel(GetTranslated(42, 17, "Look at Best Players"), $x + 240, $y + 5, 110, 17)
 		$g_acmbPriority[7] = GUICtrlCreateCombo("", $x + 355, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label12 = GUICtrlCreateLabel(GetTranslated(42, 18, "Look at Best Clans"), $x + 240, $y + 30, 110, 17)
 		$g_acmbPriority[8] = GUICtrlCreateCombo("", $x + 355, $y + 25, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))

 	$y += 56

 		$Icon4 = GUICtrlCreateIcon($g_sLibIconPath, $eIcnSwords, $x, $y + 5, 32, 32)
 		$Label14 = GUICtrlCreateLabel(GetTranslated(42, 19, "Look at Current War"), $x + 40, $y + 5, 110, 17)
 		$g_acmbPriority[9] = GUICtrlCreateCombo("", $x + 155, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label16 = GUICtrlCreateLabel(GetTranslated(42, 20, "Watch Replays"), $x + 40, $y + 30, 110, 17)
 		$g_acmbPriority[10] = GUICtrlCreateCombo("", $x + 155, $y + 25, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 			GUICtrlSetOnEvent(-1, "cmbWarReplay")
 		$Label13 = GUICtrlCreateLabel(GetTranslated(42, 13, "Max Replay Speed") & " ", $x + 240, $y + 5, 110, 17)
 		$g_acmbMaxSpeed[1] = GUICtrlCreateCombo("", $x + 355, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, $g_sReplayChain, "2")
 		$Label15 = GUICtrlCreateLabel(GetTranslated(42, 14, "Pause Replay"), $x + 240, $y + 30, 110, 17)
 		$g_acmbPause[1] = GUICtrlCreateCombo("", $x + 355, $y + 25, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))

 	$y += 56

 		$Icon5 = GUICtrlCreateIcon($g_sLibIconPath, $eIcnLoop, $x, $y + 5, 32, 32)
 		$Label17 = GUICtrlCreateLabel(GetTranslated(42, 21, "Do nothing"), $x + 40, $y + 5, 110, 17)
 		$g_acmbPriority[11] = GUICtrlCreateCombo("", $x + 155, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, GetTranslated(42, 31, "Never") & "|" &  GetTranslated(42, 32, "Sometimes") & "|" &  GetTranslated(42, 33, "Frequently") & "|" &  GetTranslated(42, 34, "Often") & "|" &  GetTranslated(42, 35, "Very Often"), GetTranslated(42, 31, "Never"))
 		$Label18 = GUICtrlCreateLabel(GetTranslated(42, 22, "Max Actions by Loop"), $x + 240, $y + 5, 103, 17)
 		$cmbMaxActionsNumber = GUICtrlCreateCombo("", $x + 355, $y, 75, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
 			GUICtrlSetData(-1, "1|2|3|4|5", "2")

 	$y += 25

 		$chkCollectAchievements = _GUICtrlCreateCheckbox(GetTranslated(42, 23, "Collect achievements automatically"), $x + 40, $y, 182, 17, -1, -1)
 			GUICtrlSetOnEvent(-1, "chkCollectAchievements")
 			GUICtrlSetState(-1, $GUI_UNCHECKED)

 		$chkLookAtRedNotifications = _GUICtrlCreateCheckbox(GetTranslated(42, 24, "Look at red/purple flags on buttons"), $x + 240, $y, 187, 17, -1, -1)
 			GUICtrlSetOnEvent(-1, "chkLookAtRedNotifications")
 			GUICtrlSetState(-1, $GUI_UNCHECKED)

 	GUICtrlCreateGroup("", -99, -99, 1, 1)

 	For $i = $Icon1 To $chkLookAtRedNotifications
 		GUICtrlSetState($i, $GUI_DISABLE)
 	Next

	chkUseBotHumanization()

EndFunc   ;==>HumanizationGUI