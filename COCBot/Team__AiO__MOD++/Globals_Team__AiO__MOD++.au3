; #FUNCTION# ====================================================================================================================
; Name ..........: Globals_Team__AiO__MOD++
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Check Version
Global $g_sLastModversion = "" ;latest version from GIT
Global $g_sLastModmessage = "" ;message for last version
Global $g_sOldModversmessage = "" ;warning message for old bot

; Attack Settings [Dec 2016] used on Classic Attack
Global Const $g_aaiTopLeftDropPoints[5][2] = [[62, 306], [156, 238], [221, 188], [288, 142], [383, 76]]
Global Const $g_aaiTopRightDropPoints[5][2] = [[486, 59], [586, 134], [652, 184], [720, 231], [817, 308]]
Global Const $g_aaiBottomLeftDropPoints[5][2] = [[20, 373], [101, 430], [171, 481], [244, 535], [346, 615]]
Global Const $g_aaiBottomRightDropPoints[5][2] = [[530, 615], [632, 535], [704, 481], [781, 430], [848, 373]]
Global Const $g_aaiEdgeDropPoints[4] = [$g_aaiBottomRightDropPoints, $g_aaiTopLeftDropPoints, $g_aaiBottomLeftDropPoints, $g_aaiTopRightDropPoints]

; Unit/Wave Factor
Global $iChkGiantSlot = 0, $iCmbGiantSlot = 0
Global $g_iSlotsGiants = 1, $iSlotsGiants = 1
Global $iChkUnitFactor = 0, $iTxtUnitFactor = 10
Global $iChkWaveFactor = 0, $iTxtWaveFactor = 100

; Drop Order Troops
Global Enum $eTroopBarbarianS, $eTroopArcherS, $eTroopGiantS, $eTroopGoblinS, $eTroopWallBreakerS, $eTroopBalloonS, _
		$eTroopWizardS, $eTroopHealerS, $eTroopDragonS, $eTroopPekkaS, $eTroopBabyDragonS, $eTroopMinerS, _
		$eTroopMinionS, $eTroopHogRiderS, $eTroopValkyrieS, $eTroopGolemS, $eTroopWitchS, _
		$eTroopLavaHoundS, $eTroopBowlerS, $eHeroeS, $eCCS, $eTroopCountDrop
Global $icmbDropTroops[$eTroopCountDrop] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
Global Const $g_asTroopNamesPluralDrop[$eTroopCountDrop] = ["Barbarians", "Archers", "Giants", "Goblins", "Wall Breakers", "Balloons", "Wizards", "Healers", "Dragons", "Pekkas", "Baby Dragons", "Miners", "Minions", "Hog Riders", "Valkyries", "Golems", "Witches", "Lava Hounds", "Bowlers", "Clan Castle", "Heroes"]

Global Const $g_aiTroopOrderDropIcon[23] = [ _
		$eIcnOptions, $eIcnBarbarian, $eIcnArcher, $eIcnGiant, $eIcnGoblin, $eIcnWallBreaker, $eIcnBalloon, _
		$eIcnWizard, $eIcnHealer, $eIcnDragon, $eIcnPekka, $eIcnBabyDragon, $eIcnMiner, $eIcnMinion, _
		$eIcnHogRider, $eIcnValkyrie, $eIcnGolem, $eIcnWitch, $eIcnLavaHound, $eIcnBowler, $eIcnCC, $eIcnHeroes]

Global $g_hChkCustomTrainDropOrderEnable = 0
Global $g_bCustomTrainDropOrderEnable = False
Global $g_hBtnRemoveTroops2, $g_hBtnTroopOrderSet2
Global $g_ahImgTroopDropOrderSet = 0
Global $g_ahImgTroopDropOrder[$eTroopCountDrop] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $cmbDropTroops = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global Const $g_asTroopDropList[] = ["", _
		"Barbarians", "Archers", "Giants", "Goblins", _
		"Wall Breakers", "Balloons", "Wizards", "Healers", _
		"Dragons", "Pekkas", "Baby Dragons", "Miners", _
		"Minions", "Hog Riders", "Valkyries", "Golems", _
		"Witches", "Lava Hounds", "Bowlers", "Clan Castle", "Heroes"]

; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
Global $ichkAutoHide, $ichkAutoHideDelay = 10

; Check Collector Outside (McSlither) - Added by NguyenAnhHD
#region Check Collectors Outside
; Collectors outside filter
Global $ichkDBMeetCollOutside, $iDBMinCollOutsidePercent, $iCollOutsidePercent ; check later if $iCollOutsidePercent obsolete

; constants
Global Const $THEllipseWidth = 200, $THEllipseHeigth = 150, $CollectorsEllipseWidth = 130, $CollectorsEllipseHeigth = 97.5
Global Const $centerX = 430, $centerY = 335 ; check later if $THEllipseWidth, $THEllipseHeigth obsolete
Global $hBitmapFirst
#endregion

; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
Global $cmbCSVSpeed[2] = [$LB, $DB]
Global $icmbCSVSpeed[2] = [2, 2]
Global $g_CSVSpeedDivider[2] = [1, 1] ; default CSVSpeed for DB & LB

; Switch Profile (IceCube) - Added by NguyenAnhHD
Global $profileString = ""
Global $ichkGoldSwitchMax, $itxtMaxGoldAmount, $icmbGoldMaxProfile, $ichkGoldSwitchMin, $itxtMinGoldAmount, $icmbGoldMinProfile
Global $ichkElixirSwitchMax, $itxtMaxElixirAmount, $icmbElixirMaxProfile, $ichkElixirSwitchMin, $itxtMinElixirAmount, $icmbElixirMinProfile
Global $ichkDESwitchMax, $itxtMaxDEAmount, $icmbDEMaxProfile, $ichkDESwitchMin, $itxtMinDEAmount, $icmbDEMinProfile
Global $ichkTrophySwitchMax, $itxtMaxTrophyAmount, $icmbTrophyMaxProfile, $ichkTrophySwitchMin, $itxtMinTrophyAmount, $icmbTrophyMinProfile

; SwitchAcc (Demen) - Added By Demen
Global $profile = $g_sProfilePath & "\Profile.ini"
Global $ichkSwitchAcc = 0, $ichkTrain = 0, $icmbTotalCoCAcc, $nTotalCoCAcc = 8, $ichkSmartSwitch, $ichkCloseTraining
Global Enum $eNull, $eActive, $eDonate, $eIdle, $eStay, $eContinuous ; Enum for Profile Type & Switch Case & ForceSwitch
Global $ichkForceSwitch, $iForceSwitch, $eForceSwitch = 0, $iProfileBeforeForceSwitch
Global $ichkForceStayDonate
Global $nTotalProfile = 1, $nCurProfile = 1, $nNextProfile
Global $ProfileList
Global $aProfileType[8] ; Type of the all Profiles, 1 = active, 2 = donate, 3 = idle
Global $aMatchProfileAcc[8] ; Accounts match with All Profiles
Global $aDonateProfile, $aActiveProfile
Global $aAttackedCountSwitch[8], $ActiveSwitchCounter = 0, $DonateSwitchCounter = 0
Global $bReMatchAcc = False
Global $aTimerStart[8], $aTimerEnd[8]
Global $aRemainTrainTime[8], $aUpdateRemainTrainTime[8], $nMinRemainTrain
Global $aLocateAccConfig[8], $aAccPosY[8]
Global $g_iTrainTimeToSkip = 0

; SmartTrain (Demen) - Added By Demen
Global $ichkSmartTrain, $ichkPreciseTroops, $ichkFillArcher, $iFillArcher, $ichkFillEQ
Global $g_bWaitForCCTroopSpell = False	; ForceSwitch while waiting for CC troops - Demen
Global Enum $g_eFull, $g_eRemained, $g_eNoTrain
Global $g_abRCheckWrongTroops[2] = [False, False] ; Result of checking wrong troops & spells
Global $g_bChkMultiClick, $g_iMultiClick = 1
Global $g_aiQueueTroops[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiQueueSpells[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

; Hero and Lab status - Demen
Global $g_bNeedLocateLab = True, $g_bLabReady[9]
Global $g_aLabTimeAcc[8], $g_aLabTime[4] = [0, 0, 0, 0] ; day | hour | minute | time in minutes
Global $g_aLabTimerStart[8], $g_aLabTimerEnd[8]

; Bot Humanization
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

Global $g_iQuickMISX = 0, $g_iQuickMISY = 0
Global $g_iLastLayout = 0

; Auto Upgrade
Global $g_ichkAutoUpgrade = 0
Global $g_iSmartMinGold = 150000, $g_iSmartMinElixir = 150000, $g_iSmartMinDark = 1500
Global $g_ichkUpgradesToIgnore[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_ichkResourcesToIgnore[3] = [0, 0, 0]
Global $g_iCurrentLineOffset = 0, $g_iNextLineOffset = 0
Global $g_aUpgradeNameLevel ; [Nb of elements in Array, Name, Level]
Global $g_aUpgradeResourceCostDuration[3] = ["", "", ""] ; Resource, Cost, Duration

; Forecast - Added By Eloy (modification rulesss,kychera)
Global Const $COLOR_DEEPPINK = 0xFF1493
Global Const $COLOR_DARKGREEN = 0x006400
Global $oIE = ObjCreate("Shell.Explorer.2")
Global $grpForecast, $ieForecast
Global $dtStamps[0], $lootMinutes[0]
Global $timeOffset = 0, $TimerForecast = 0
Global $lootIndexScaleMarkers, $currentForecast
Global $iChkForecastBoost = 0, $iTxtForecastBoost = 6
Global $iChkForecastPause = 0, $iTxtForecastPause = 2
Global $ichkForecastHopingSwitchMax = 0, $icmbForecastHopingSwitchMax = 0, $itxtForecastHopingSwitchMax = 2
Global $ichkForecastHopingSwitchMin = 0, $icmbForecastHopingSwitchMin = 0, $itxtForecastHopingSwitchMin = 2
Global $icmbSwLang = 0

; Request CC Troops at first
Global $g_bReqCCFirst = False
Global $chkReqCCFirst = 0

; Goblin XP
Global $ichkEnableSuperXP = 0, $irbSXTraining = 1, $ichkSXBK = 0, $ichkSXAQ = 0, $ichkSXGW = 0, $iStartXP = 0, $iCurrentXP = 0, $iGainedXP = 0, $iGainedXPHour = 0, $itxtMaxXPtoGain = 500
Global $DebugSX = 0

Global $g_DpGoblinPicnic[3][4] = [[300, 205, 5, 5], [340, 140, 5, 5], [290, 220, 5, 5]]
Global $g_BdGoblinPicnic[3] = [0, "5000-7000", "6000-8000"] ; [0] = Queen, [1] = Warden, [2] = Barbarian King
Global $g_ActivatedHeroes[3] = [False, False, False] ; [0] = Queen, [1] = Warden, [2] = Barbarian King , Prevent to click on them to Activate Again And Again
Global Const $g_minStarsToEnd = 1
Global $g_canGainXP = False

; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
Global $g_bChkClanHop = False

; Max logout time (mandryd)
Global $TrainLogoutMaxTime, $TrainLogoutMaxTimeTXT

; ExtendedAttackBar
Global $g_hChkExtendedAttackBarLB, $g_hChkExtendedAttackBarDB, $g_abChkExtendedAttackBar[2]
Global $g_iTotalAttackSlot = 10, $g_bDraggedAttackBar = False ; flag if AttackBar is dragged or not

; Chatbot - Added by NguyenAnhHD
Global $chatIni = ""
Global $GlobalMessages1 = "", $GlobalMessages2 = "", $GlobalMessages3 = "", $GlobalMessages4 = ""
Global $ClanMessages1 = "", $ClanMessages2 = ""
Global $g_iGlobalChat = False, $g_iGlobalScramble = False, $g_iSwitchLang = False, $g_iCmbLang = 1
Global $g_iClanChat = False, $g_iRusLang = 0, $g_iUseResponses = False, $g_iUseGeneric = False, $g_iChatPushbullet = False, $g_iPbSendNewChats = False
Global $ChatbotStartTime
Global $ChatbotQueuedChats[0], $ChatbotReadQueued = False, $ChatbotReadInterval = 0, $ChatbotIsOnInterval = False

; CheckCC Troops
Global $g_aiCCTroops[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiCCTroopsExpected[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_bChkCC, $g_bChkCCTroops, $g_aiCmbCCTroopsExpect[3], $g_aiQtyCCTroopsExpect[3]
Global $g_iCmbCastleCap
