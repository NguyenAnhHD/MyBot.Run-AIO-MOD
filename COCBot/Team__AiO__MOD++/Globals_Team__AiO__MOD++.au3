; #FUNCTION# ====================================================================================================================
; Name ..........: Globals Team AiO MOD++
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2018)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global Const $g_sLibModIconPath = $g_sLibPath & "\AIOMod.dll" ; Mod icon library - Team AiO MOD++
; enumerated Icons 1-based index to IconLibMod
Global Enum $eIcnModKingGray = 1, $eIcnModKingBlue, $eIcnModKingGreen, $eIcnModKingRed, $eIcnModQueenGray, $eIcnModQueenBlue, $eIcnModQueenGreen, $eIcnModQueenRed, _
		$eIcnModWardenGray, $eIcnModWardenBlue, $eIcnModWardenGreen, $eIcnModWardenRed, $eIcnModLabGray, $eIcnModLabGreen, $eIcnModLabRed, _
		$eIcnModArrowLeft, $eIcnModArrowRight, $eIcnModTrainingP, $eIcnModResourceP, $eIcnModHeroP, $eIcnModClockTowerP, $eIcnModBuilderP, $eIcnModPowerP, _
		$eIcnModChat, $eIcnModRepeat, $eIcnModClan, $eIcnModTarget, $eIcnModSettings, $eIcnModBKingSX, $eIcnModAQueenSX, $eIcnModGWardenSX, $eIcnModDebug, $eIcnModClanHop, $eIcnModPrecise, _
		$eIcnModAccountsS, $eIcnModProfilesS, $eIcnModFarmingS, $eIcnMiscMod, $eIcnSuperXP, $eIcnChatActions, $eIcnHumanization, $eIcnAIOMod

; SuperXP / GoblinXP - Team AiO MOD++
Global $g_bEnableSuperXP = False, $g_bSkipZoomOutSX = False, $g_bFastSuperXP = False, $g_bSkipDragToEndSX = False, _
	$g_iActivateOptionSX = 1, $g_iGoblinMapOptSX = 2, $g_sGoblinMapOptSX = "The Arena", $g_iMaxXPtoGain = 500, _
	$g_bBKingSX = False, $g_bAQueenSX = False, $g_bGWardenSX = False
Global $g_iStartXP = 0, $g_iCurrentXP = 0, $g_iGainedXP = 0, $g_iGainedHourXP = 0, $g_sRunTimeXP = 0
Global $g_bDebugSX = False
; [0] = Queen, [1] = Warden, [2] = Barbarian King
; [0][0] = X, [0][1] = Y, [0][2] = XRandomOffset, [0][3] = YRandomOffset
Global $g_aiDpGoblinPicnic[3][4] = [[310, 200, 5, 5], [340, 140, 5, 5], [290, 220, 5, 5]]
Global $g_aiDpTheArena[2][4] = [[429, 36, 0, 0], [430, 10, 5, 5]] ; Can't Farm With Barbarian King
Global $g_aiBdGoblinPicnic[3] = [0, "5000-7000", "6000-8000"] ; [0] = Archer Queen, [1] = Grand Warden, [2] = Barbarian King
Global $g_aiBdTheArena[2] = [0, "5000-7000"] ; [0] = Queen, [1] = Warden, Can't Farm With Barbarian King
Global $g_bActivatedHeroes[3] = [False, False, False] ; [0] = Archer Queen, [1] = Grand Warden, [2] = Barbarian King , Prevent to click on them to Activate Again And Again
Global Const $g_iMinStarsToEnd = 1
Global $bCanGainXP = False

; ChatActions - Team AiO MOD++
Global $g_bChatGlobal = False, $g_sDelayTimeGlobal = 10, $g_bScrambleGlobal = False, $g_bSwitchLang = False, $g_iCmbLang = 0, $g_bRusLang = False, _
	$g_sGlobalMessages1 = "", $g_sGlobalMessages2 = ""
Global $g_bChatClan = False, $g_sDelayTimeClan = 2, $g_bClanUseResponses = False, $g_bClanUseGeneric = False, $g_bCleverbot = False, _
	$g_sClanResponses = "", $g_sClanGeneric = ""
Global $g_bUseNotify = False, $g_bPbSendNew = False
Global $g_bEnableFriendlyChallenge = False, $g_sDelayTimeFC = 5, $g_bOnlyOnRequest = False, _
	$g_sChallengeText = "", $g_sKeywordForRequest = ""
Global $g_bFriendlyChallengeBase[6] = [False, False, False, False, False, False]
Global $g_abFriendlyChallengeHours[24] = [True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True, True]
Global $g_sGlobal1, $g_sGlobal2, $g_sResponse, $g_sGeneric, $g_sWriteFriendlyChallengeText, $g_sWriteFriendlyChallengeKeyword
Global $ChatbotStartTime, $ChatbotQueuedChats[0], $ChatbotReadQueued = False, $ChatbotReadInterval = 0, $ChatbotIsOnInterval = False, _
	$g_sMessage = "", $g_sGlobalChatLastMsgSentTime = "", $g_sClanChatLastMsgSentTime = "", $g_sFCLastMsgSentTime = ""
Global $g_aIAVar[5] = [0, 0, 0, 0, 0], $g_sIAVar = '0|0|0|0|0'
Global $g_sGetOcrMod = "", $g_aImageSearchXML = -1

; Daily Discounts - Team AiO MOD++
#Region
Global $g_iDDCount = 18
Global $g_abChkDD_Deals[$g_iDDCount] = [False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False]
Global $g_aiDD_DealsCosts[$g_iDDCount] = [25, 75, 115, 285, 300, 300, 500, 1000, 500, 500, 925, 925, 925, 1500, 1500, 3000, 1500, 1500]
Global $g_eDDPotionTrain = 0, $g_eDDPotionClock = 1, $g_eDDPotionResource = 2, $g_eDDPotionBuilder = 3, _
		$g_eDDPotionPower = 4, $g_eDDPotionHero = 5, $g_eDDWallRing5 = 6, $g_eDDWallRing10 = 7, $g_eDDShovel = 8, $g_eDDBookHeros = 9, _
		$g_eDDBookFighting = 10, $g_eDDBookSpells = 11, $g_eDDBookBuilding = 12, $g_eDDRuneGold = 13, $g_eDDRuneElixir = 14, $g_eDDRuneDarkElixir = 15, _
		$g_eDDRuneBBGold = 16, $g_eDDRuneBBElixir = 17
Global $g_bDD_DealsSet = False
#EndRegion

; Builder Base Attack - Team AiO MOD++
Global $g_bChkEnableBBAttack = False, $g_bChkBBTrophyRange = False, $g_bChkBBAttIfLootAvail = False, $g_bChkBBWaitForMachine = False
Global $g_iTxtBBTrophyLowerLimit = 0, $g_iTxtBBTrophyUpperLimit = 5000
Global $g_bBBMachineReady = False
Global $g_aBBMachine = [0,0] ; x,y coordinates of where to click for Battle machine on attack bar
Global $g_iBBMachAbilityTime = 14000 ; in milliseconds, so 14 seconds between abilities
Global Const $g_iBBNextTroopDelayDefault = 2000, $g_iBBSameTroopDelayDefault = 300 ; default delay times
Global $g_iBBNextTroopDelay = $g_iBBNextTroopDelayDefault, $g_iBBSameTroopDelay = $g_iBBSameTroopDelayDefault; delay time between different and same troops
Global $g_iBBNextTroopDelayIncrement = 400, $g_iBBSameTroopDelayIncrement = 60 ; used for math to calculate delays based on selection
Global $g_apTL[10][2] = [ [22, 374], [59, 348], [102, 319], [137, 288], [176, 259], [209, 232], [239, 212], [270, 188], [307, 164], [347, 139] ]
Global $g_apTR[10][2] = [ [831, 368], [791, 334], [747, 306], [714, 277], [684, 252], [647, 227], [615, 203], [577, 177], [539, 149], [506, 123] ]
; BB Drop Order
Global $g_bBBDropOrderSet = False
Global Const $g_iBBTroopCount = 10
Global Const $g_sBBDropOrderDefault = "BoxerGiant|SuperPekka|DropShip|Witch|BabyDrag|WallBreaker|Barbarian|CannonCart|Archer|Minion"
Global $g_sBBDropOrder = $g_sBBDropOrderDefault
; BB Suggested Upgrades
Global $g_bChkBBIgnoreWalls = False

; Request CC for defense - Team AiO MOD++
Global $g_bRequestCCDefense = False, $g_sRequestCCDefenseText = "", $g_bRequestCCDefenseWhenPB, $g_iRequestDefenseTime, $g_bSaveCCTroopForDefense = True
Global $g_aiCCTroopsExpectedForDefense[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiCCTroopDefenseType[3], $g_aiCCTroopDefenseQty[3]

; ClanHop - Team AiO MOD++
Global $g_bChkClanHop = False

; Restart Search Legend league - Team AiO MOD++
Global $g_bIsSearchTimeout = False, $g_iSearchTimeout = 10, $g_iTotalSearchTime = 0

; CSV Deploy Speed - Team AiO MOD++
Global $cmbCSVSpeed[2] = [$LB, $DB]
Global $icmbCSVSpeed[2] = [2, 2]
Global $g_CSVSpeedDivider[2] = [1, 1] ; default CSVSpeed for DB & LB

; Check Collector Outside - Team AiO MOD++
Global $g_bScanMineAndElixir = False
#Region Check Collectors Outside
; Collectors Outside Filter
Global $g_bDBMeetCollectorOutside = False, $g_iDBMinCollectorOutsidePercent = 80
Global $g_bDBCollectorNearRedline = False, $g_iCmbRedlineTiles = 1
Global $g_bSkipCollectorCheck = False, $g_iTxtSkipCollectorGold = 400000, $g_iTxtSkipCollectorElixir = 400000, $g_iTxtSkipCollectorDark = 0
Global $g_bSkipCollectorCheckTH = False, $g_iCmbSkipCollectorCheckTH = 1
; constants
Global Const $THEllipseWidth = 200, $THEllipseHeigth = 150, $CollectorsEllipseWidth = 130, $CollectorsEllipseHeigth = 97.5
#EndRegion Check Collectors Outside

; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
Global $g_bEnableAuto = False, $g_bChkAutoDock = False, $g_bChkAutoHideEmulator = True, $g_bChkAutoMinimizeBot = False

; Switch Profiles - Team AiO MOD++
Global $g_abChkSwitchMax[4] = [False, False, False, False], $g_abChkSwitchMin[4] = [False, False, False, False], _
		$g_aiCmbSwitchMax[4] = [-1, -1, -1, -1], $g_aiCmbSwitchMin[4] = [-1, -1, -1, -1], _
		$g_abChkBotTypeMax[4] = [False, False, False, False], $g_abChkBotTypeMin[4] = [False, False, False, False], _
		$g_aiCmbBotTypeMax[4] = [1, 1, 1, 1], $g_aiCmbBotTypeMin[4] = [2, 2, 2, 2], _
		$g_aiConditionMax[4] = ["12000000", "12000000", "240000", "5000"], $g_aiConditionMin[4] = ["1000000", "1000000", "20000", "3000"]

; Farm Schedule - Team AiO MOD++
Global $g_abChkSetFarm[8], _
		$g_aiCmbAction1[8], $g_aiCmbCriteria1[8], $g_aiTxtResource1[8], $g_aiCmbTime1[8], _
		$g_aiCmbAction2[8], $g_aiCmbCriteria2[8], $g_aiTxtResource2[8], $g_aiCmbTime2[8]

; Builder Status - Team AiO MOD++
Global $g_sNextBuilderReadyTime = ""
Global $g_asNextBuilderReadyTime[8] = ["", "", "", "", "", "", "", ""]

; Max logout time - Team AiO MOD++
Global $g_bTrainLogoutMaxTime = False, $g_iTrainLogoutMaxTime = 4

; Multipixel solution
Global $g_iMultiPixelOffSet[2]
