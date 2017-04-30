; #FUNCTION# ====================================================================================================================
; Name ..........: Functions_Team++AIO
; Description ...: This file Includes several files in the current script.
; Syntax ........: #include
; Parameters ....: None
; Return values .: None
; Author ........: Team++ AIO (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; <><><><><><><><><><><><><><><> Team++ AIO MOD <><><><><><><><><><><><><><><>

#include "functions\Config\saveConfig.au3"
#include "functions\Config\readConfig.au3"
#include "functions\Config\applyConfig.au3"

; CSV Command DropS, SideP, Zap, Remain (Mr.Viper) - Added by NguyenAnhHD
#include "functions\Attack\AttackCSV\DropSpellFromINIOnDefense.au3"
#include "functions\Attack\AttackCSV\DropTroopFromINI.au3"
#include "functions\Attack\AttackCSV\ParseAttackCSV.au3"
#include "functions\Attack\AttackCSV\ParseAttackCSV_Read_SIDE_variables.au3"
#include "functions\Attack\AttackCSV\SideP.au3"
#include "functions\Attack\AttackCSV\UpdateTroopQuantity.au3"
#include "functions\Attack\AttackCSV\ZapCmd.au3"

#include "functions\Attack\RedArea\_GetRedArea.au3"

#include "functions\Attack\Troops\GetXPosOfArmySlot.au3"
#include "functions\Attack\Troops\ReadTroopQuantity.au3"

#include "functions\Other\ArrayFunctions.au3"
#include "functions\Search\multiSearch.au3"

; Bot Humanization (Roro-Titi) - Added by NguyenAnhHD
#include "functions\BotHumanization\BotHumanization.au3"
#include "functions\BotHumanization\AttackNDefenseActions.au3"
#include "functions\BotHumanization\BestClansNPlayersActions.au3"
#include "functions\BotHumanization\ChatActions.au3"
#include "functions\BotHumanization\ClanActions.au3"
#include "functions\BotHumanization\ClanWarActions.au3"

; Goblin XP (Mr.Viper) - Added by NguyenAnhHD
#include "functions\Mod's\GoblinXP.au3"

; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
#include "functions\Mod's\AutoHide.au3"

; Check Collector Outside (McSlither) - Added by NguyenAnhHD
#include "functions\Mod's\AreCollectorsOutside.au3"

; Switch Profile (IceCube) - Added by NguyenAnhHD
#include "functions\Mod's\ProfileSwitch.au3"

; Smart Upgarde (Roro-Titi) - Added by NguyenAnhHD
#include "functions\Mod's\SmartUpgrade.au3"

; Upgrade Management (MMHK) - Added by NguyenAnhHD
#include "functions\Mod's\UpgradesMgmt.au3"

; SwitchAcc (Demen) - Added By Demen
#include "functions\Mod's\SwitchAcc.au3"
#include "functions\Mod's\UpdateProfileStats.au3"

; SimpleTrain (Demen) - Added By Demen
#include "functions\Mod's\SimpleTrain.au3"

; CoCStats - Added by NguyenAnhHD
#include "functions\Mod's\CoCStats.com.au3"

; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
#include "functions\Mod's\ClanHop.au3"

; Multi Fingers Vectors - (LunaEclipse) - Added by Eloy
#include "functions\Attack\Multi Fingers\Vectors\4FingerStandard.au3"
#include "functions\Attack\Multi Fingers\Vectors\4FingerSpiralLeft.au3"
#include "functions\Attack\Multi Fingers\Vectors\4FingerSpiralRight.au3"
#include "functions\Attack\Multi Fingers\Vectors\8FingerPinWheelLeft.au3"
#include "functions\Attack\Multi Fingers\Vectors\8FingerPinWheelRight.au3"
#include "functions\Attack\Multi Fingers\Vectors\8FingerBlossom.au3"
#include "functions\Attack\Multi Fingers\Vectors\8FingerImplosion.au3"
; Multi Fingers Profile - (LunaEclipse) - Added by Eloy
#include "functions\Attack\Multi Fingers\4Fingers.au3"
#include "functions\Attack\Multi Fingers\8Fingers.au3"
#include "functions\Attack\Multi Fingers\MultiFinger.au3"
#include "functions\Attack\Multi Fingers\UnitInfo.au3"
;=============================================================================
; Chatbot - Added Kychera
#include "functions\Chatbot\Chatbot.au3"
;Multi lang by Kychera
#include "functions\Other\Multy Lang.au3"