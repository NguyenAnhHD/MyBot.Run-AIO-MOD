; #FUNCTION# ====================================================================================================================
; Name ..........: Globals Team AiO MOD++
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; CSV Deploy Speed - Team AiO MOD++
Global $cmbCSVSpeed[2] = [$LB, $DB]
Global $icmbCSVSpeed[2] = [2, 2]
Global $g_CSVSpeedDivider[2] = [1, 1] ; default CSVSpeed for DB & LB

; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
Global $g_bEnableAuto = False, $g_iChkAutoDock = False, $g_iChkAutoHideEmulator = True, $g_iChkAutoMinimizeBot = False

; Check Collector Outside - Team AiO MOD++
Global $g_bScanMineAndElixir = False
#region Check Collectors Outside
; Collectors Outside Filter
Global $g_bDBMeetCollOutside = False, $g_iTxtDBMinCollOutsidePercent = 80
; constants
Global Const $THEllipseWidth = 200, $THEllipseHeigth = 150, $CollectorsEllipseWidth = 130, $CollectorsEllipseHeigth = 97.5
Global $hBitmapFirst
Global $g_bDBCollectorsNearRedline = 1, $g_bSkipCollectorCheck = 1, $g_bSkipCollectorCheckTH = 1
Global $g_iCmbRedlineTiles = 1, $g_iCmbSkipCollectorCheckTH = 1
Global $g_iTxtSkipCollectorGold = 400000, $g_iTxtSkipCollectorElixir = 400000, $g_iTxtSkipCollectorDark = 0
#endregion

; ClanHop - Team AiO MOD++
Global $g_bChkClanHop = False

; Bot Humanization - Team AiO MOD++
Global $g_iacmbPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_iacmbMaxSpeed[2] = [1, 1]
Global $g_iacmbPause[2] = [0, 0]
Global $g_iahumanMessage[2] = ["Hello !", "Hello !"]
Global $g_ichallengeMessage = "Can you beat my village?"

Global $g_iMinimumPriority, $g_iMaxActionsNumber, $g_iActionToDo
Global $g_aSetActionPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

Global $g_sFrequenceChain = "Never|Sometimes|Frequently|Often|Very Often"
Global $g_sReplayChain = "1|2|4"
Global $g_ichkUseBotHumanization = 0, $g_ichkUseAltRClick = 0, $g_icmbMaxActionsNumber = 1, $g_ichkCollectAchievements = 0, $g_ichkLookAtRedNotifications = 0

Global $g_aReplayDuration[2] = [0, 0] ; An array, [0] = Minute | [1] = Seconds
Global $g_bOnReplayWindow, $g_iReplayToPause

Global $g_iLastLayout = 0

; Goblin XP - Team AiO MOD++
Global $ichkEnableSuperXP = 0, $ichkSkipZoomOutXP = 0, $ichkFastGoblinXP = 0, $irbSXTraining = 1, $ichkSXBK = 0, $ichkSXAQ = 0, $ichkSXGW = 0, $iStartXP = 0, $iCurrentXP = 0, $iGainedXP = 0, $iGainedXPHour = 0, $itxtMaxXPtoGain = 500
Global $g_bDebugSX = False

Global $g_DpGoblinPicnic[3][4] = [[300, 205, 5, 5], [340, 140, 5, 5], [290, 220, 5, 5]]
Global $g_BdGoblinPicnic[3] = [0, "5000-7000", "6000-8000"] ; [0] = Queen, [1] = Warden, [2] = Barbarian King
Global $g_ActivatedHeroes[3] = [False, False, False] ; [0] = Queen, [1] = Warden, [2] = Barbarian King , Prevent to click on them to Activate Again And Again
Global Const $g_minStarsToEnd = 1
Global $g_canGainXP = False

; TimerHandle New Used in Donate/Train only Mode - Ezeck 6-14-17
Global $g_hTrainTimeLeft = 0
Global $g_hCurrentDonateButtonBitMap = 0

; GTFO - Team AiO MOD++
Global $g_bChkUseGTFO = False, $g_bChkUseKickOut = False, $g_bChkKickOutSpammers = False
Global $g_iTxtMinSaveGTFO_Elixir = 200000, $g_iTxtMinSaveGTFO_DE = 2000, _
	$g_iTxtDonatedCap = 8, $g_iTxtReceivedCap = 35, _
	$g_iTxtKickLimit = 6

; Max logout time - Team AiO MOD++
Global $g_bTrainLogoutMaxTime = False, $g_iTrainLogoutMaxTime = 4

; Request CC Troops at first - Team AiO MOD++
Global $g_bReqCCFirst = False

; CheckCC Troops - Team AiO MOD++
Global $g_aiCCTroops[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiCCSpells[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiCCTroopsExpected[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiCCSpellsExpected[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_bChkCC = False, $g_bChkCCTroops = False, $g_bChkCCSpells = False
Global $g_aiCmbCCSlot[5], $g_aiTxtCCSlot[5]
Global $g_iCmbCastleCapacityT = 5, $g_iCmbCastleCapacityS = 1

; Attack Log New Style - Team AiO MOD++
Global $eLootPerc = "---"
Global $starsearned = 0
Global $eTHLevel = "-"
Global $g_bColorfulAttackLog = False

; Additional Notifactions - Team AiO MOD++
Global $eWinlose = "-"

; Check Grand Warden Mode - Team AiO MOD++
Global $g_bCheckWardenMode = False, $g_iCheckWardenMode = 0

; Unit/Wave Factor - Team AiO MOD++
Global $g_iChkGiantSlot = 0, $g_iChkUnitFactor = 0, $g_iChkWaveFactor = 0
Global $g_iCmbGiantSlot = 0, $g_iTxtUnitFactor = 10, $g_iTxtWaveFactor = 100
Global $g_iSlotsGiants = 1, $g_aiSlotsGiants = 1

; Restart Search Legend league - Team AiO MOD++
Global $g_bIsSearchTimeout = False, $g_iSearchTimeout = 10, $g_iTotalSearchTime = 0

; Stop on Low battery - Team AiO MOD++
Global $g_bStopOnBatt = False, $g_iStopOnBatt = 10

; Stop For War - Team AiO MOD++
Global $g_bStopForWar = False
Global $g_iStopTime, $g_iReturnTime
Global $g_bTrainWarTroop = False, $g_bUseQuickTrainWar = False, $g_aChkArmyWar[3] = [True, False, False], $g_aiWarCompTroops[$eTroopCount], $g_aiWarCompSpells[$eSpellCount]
Global $g_bRequestCCForWar = False, $g_sTxtRequestCCForWar

; Slot11 - Team AiO MOD++
Global $g_abChkExtendedAttackBar[2] = [False, False]
Global $g_iTotalAttackSlot = 10, $g_bDraggedAttackBar = False ; flag if AttackBar is dragged or not

; Request troops for defense - Team AiO MOD++
Global $g_bRequestTroopsEnableDefense = False, $g_sRequestTroopsTextDefense = "", $g_iRequestDefenseEarly = 0

; Builder Status - Team AiO MOD++
Global $g_sNextBuilderReadyTime = ""
Global $g_asNextBuilderReadyTime[8] = ["", "", "", "", "", "", "", ""]