; #FUNCTION# ====================================================================================================================
; Name ..........: Functions_Team__AiO__MOD++
; Description ...: This file Includes several files in the current script.
; Syntax ........: #include
; Parameters ....: None
; Return values .: None
; Author ........: Team AiO MOD++ (2019)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; <><><><><><><><><><><><><><><> Team AiO MOD++ (2019) <><><><><><><><><><><><><><><>
#include "functions\Mod's\ModFuncs.au3"
#include "functions\Pixels\_Wait4Pixel.au3"

; SuperXP / GoblinXP - Team AiO MOD++
#include "functions\Mod's\SuperXP\ArrayFunctions.au3"
#include "functions\Mod's\SuperXP\multiSearch.au3"
#include "functions\Mod's\SuperXP\SuperXP.au3"

; ChatActions - Team AiO MOD++
#include "functions\Mod's\ChatActions\Chatbot.au3"
#include "functions\Mod's\ChatActions\MultyLang.au3"
#include "functions\Mod's\ChatActions\IAChat.au3"
#include "functions\Mod's\ChatActions\FriendlyChallenge.au3"

; Daily Discounts - Team AiO MOD++
#include "functions\Mod's\DailyDiscounts.au3"

; ClanHop - Team AiO MOD++
#include "functions\Mod's\ClanHop.au3"

; Auto Dock, Hide Emulator & Bot - Team AiO MOD++
#include "functions\Mod's\AutoHideDockMinimize.au3"

; Check Collector Outside - Team AiO MOD++
#include "functions\Mod's\CheckCollectorsOutside\AreCollectorsOutside.au3"
#include "functions\Mod's\CheckCollectorsOutside\AreCollectorsNearRedline.au3"
#include "functions\Mod's\CheckCollectorsOutside\isOutsideEllipse.au3"

; Switch Profiles - Team AiO MOD++
#include "functions\Mod's\ProfilesOptions\SwitchProfiles.au3"
; Farm Schedule - Team AiO MOD++
#include "functions\Mod's\ProfilesOptions\FarmSchedule.au3"

; Builder Base Attack - Team AiO MOD++
#include "functions\Mod's\BuilderBase\PrepareAttackBB.au3"
#include "functions\Mod's\BuilderBase\AttackBB.au3"
#include "functions\Mod's\BuilderBase\GetAttackBarBB.au3"

; moved to the end to avoid any global declare issues
#include "functions\Config\saveConfig.au3"
#include "functions\Config\readConfig.au3"
#include "functions\Config\applyConfig.au3"