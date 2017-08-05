; #FUNCTION# ====================================================================================================================
; Name ..........: Functions_Team__AiO__MOD++
; Description ...: This file Includes several files in the current script.
; Syntax ........: #include
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; <><><><><><><><><><><><><><><> Team AiO MOD++ (2017) <><><><><><><><><><><><><><><>

#include "functions\Config\saveConfig.au3"
#include "functions\Config\readConfig.au3"
#include "functions\Config\applyConfig.au3"

; Drop Order Troops
#include "functions\Troops Dropping Order\DropOrderTroops GUI.au3"
#include "functions\Troops Dropping Order\DropOrderTroops.au3"

#include "functions\Mod's\QuickMIS.au3"

; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
#include "functions\Mod's\AutoHide.au3"

; Check Collector Outside (McSlither) - Added by NguyenAnhHD
#include "functions\Mod's\AreCollectorsOutside.au3"

; Attack Now
#include "functions\Mod's\Attack Now.au3"

; Switch Profile (IceCube) - Added by NguyenAnhHD
#include "functions\Mod's\ProfileSwitch.au3"

; SwitchAcc (Demen) - Added By Demen
#include "functions\Switch Account\SwitchAcc.au3"
#include "functions\Switch Account\UpdateProfileStats.au3"

; HeroLabStatus - Demen
#include "functions\Switch Account\UpdateLabStatus.au3"

; SmartTrain (Demen) - Added By Demen
#include "functions\Smart Train\SmartTrain.au3"
#include "functions\Smart Train\CheckQueue.au3"
#include "functions\Smart Train\CheckTrainingTab.au3"
#include "functions\Smart Train\CheckPreciseTroop.au3"

; Bot Humanization
#include "functions\Bot Humanization\BotHumanization.au3"
#include "functions\Bot Humanization\AttackNDefenseActions.au3"
#include "functions\Bot Humanization\BestClansNPlayersActions.au3"
#include "functions\Bot Humanization\ChatActions.au3"
#include "functions\Bot Humanization\ClanActions.au3"
#include "functions\Bot Humanization\ClanWarActions.au3"

; Auto Upgrade
#include "functions\Mod's\AutoUpgrade.au3"

; Goblin XP
#include "functions\GoblinXP\GoblinXP.au3"
#include "functions\GoblinXP\multiSearch.au3"
#include "functions\GoblinXP\ArrayFunctions.au3"

; ClanHop (Rhinoceros & MantasM) - Added by NguyenAnhHD
#include "functions\Mod's\ClanHop.au3"
