; #Variables# ====================================================================================================================
; Name ..........: Image Search Directories
; Description ...: Gobal Strings holding Path to Images used for Image Search
; Syntax ........: $g_sImgxxx = @ScriptDir & "\imgxml\xxx\"
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $g_sImgImgLocButtons = @ScriptDir & "\imgxml\imglocbuttons"

#Region Obstacles
Global Const $g_sImgAnyoneThere = @ScriptDir & "\imgxml\other\AnyoneThere[[Android]]*"
Global Const $g_sImgPersonalBreak = @ScriptDir & "\imgxml\other\break*"
Global Const $g_sImgAnotherDevice = @ScriptDir & "\imgxml\other\Device[[Android]]*"
Global Const $g_sImgCocStopped = @ScriptDir & "\imgxml\other\CocStopped*"
Global Const $g_sImgCocReconnecting = @ScriptDir & "\imgxml\other\CocReconnecting*"
Global Const $g_sImgAppRateNever = @ScriptDir & "\imgxml\other\RateNever[[Android]]*"
Global Const $g_sImgGfxError = @ScriptDir & "\imgxml\other\GfxError*"
Global Const $g_sImgError = @ScriptDir & "\imgxml\other\Error[[Android]]*"
Global Const $g_sImgOutOfSync = @ScriptDir & "\imgxml\other\Oos[[Android]]*"
#EndRegion

#Region Main Village
Global $g_sImgCollectRessources = @ScriptDir & "\imgxml\Resources\Collect"
Global $g_sImgCollectLootCart = @ScriptDir & "\imgxml\Resources\LootCart\LootCart_0_85.xml"
Global $g_sImgBoat = @ScriptDir & "\imgxml\Boat\BoatNormalVillage_0_89.xml"
Global $g_sImgZoomOutDir = @ScriptDir & "\imgxml\village\NormalVillage\"
Global $g_sImgCheckWallDir = @ScriptDir & "\imgxml\Walls"
Global $g_sImgClearTombs = @ScriptDir & "\imgxml\Resources\Tombs"
Global $g_sImgCleanYard = @ScriptDir & "\imgxml\Resources\Obstacles"
Global $g_sImgCleanYardSnow = @ScriptDir & "\imgxml\Obstacles_Snow"
Global $g_sImgGemBox = @ScriptDir & "\imgxml\Resources\GemBox"
Global $g_sImgCollectReward = @ScriptDir & "\imgxml\Resources\ClaimReward"
Global $g_sImgTrader = @ScriptDir & "\imgxml\FreeMagicItems\TraderIcon"
Global $g_sImgDailyDiscountWindow = @ScriptDir & "\imgxml\FreeMagicItems\DailyDiscount"
Global $g_sImgBuyDealWindow = @ScriptDir & "\imgxml\FreeMagicItems\BuyDeal"
#EndRegion

#Region Builder Base
Global $g_sImgCollectRessourcesBB = @ScriptDir & "\imgxml\Resources\BuildersBase\Collect"
Global $g_sImgBoatBB = @ScriptDir & "\imgxml\Boat\BoatBuilderBase_0_89.xml"
Global $g_sImgZoomOutDirBB = @ScriptDir & "\imgxml\village\BuilderBase\"
Global $g_sImgStartCTBoost = @ScriptDir & "\imgxml\Resources\BuildersBase\ClockTower\ClockTowerAvailable*.xml"
Global $g_sImgCleanBBYard = @ScriptDir & "\imgxml\Resources\ObstaclesBB"
Global $g_sImgIsOnBB = @ScriptDir & "\imgxml\village\Page\BuilderBase*"
Global $g_sImgStarLaboratory = @ScriptDir & "\imgxml\Resources\BuildersBase\StarLaboratory"
Global $g_sImgStarLabElex = @ScriptDir & "\imgxml\Resources\BuildersBase\StarLabElex\StarLabElex*"
#EndRegion

#Region DonateCC
Global $g_sImgDonateTroops = @ScriptDir & "\imgxml\DonateCC\Troops\"
Global $g_sImgDonateSpells = @ScriptDir & "\imgxml\DonateCC\Spells\"
Global $g_sImgDonateSiege = @ScriptDir & "\imgxml\DonateCC\SiegeMachines\"
Global $g_sImgChatDivider = @ScriptDir & "\imgxml\DonateCC\donateccwbl\chatdivider_0_98.xml"
Global $g_sImgChatDividerHidden = @ScriptDir & "\imgxml\DonateCC\donateccwbl\chatdividerhidden_0_98.xml"
Global $g_sImgChatIUnterstand = @ScriptDir & "\imgxml\DonateCC\donateccwbl\iunderstand_0_95.xml"
#EndRegion

#Region Auto Upgrade Normal Village
 Global $g_sImgAUpgradeObst = @ScriptDir & "\imgxml\Resources\Auto Upgrade\Obstacles"
 Global $g_sImgAUpgradeZero = @ScriptDir & "\imgxml\Resources\Auto Upgrade\Zero"
 Global $g_sImgAUpgradeUpgradeBtn = @ScriptDir & "\imgxml\Resources\Auto Upgrade\UpgradeButton"
 Global $g_sImgAUpgradeRes = @ScriptDir & "\imgxml\Resources\Auto Upgrade\Resources"
#EndRegion

#Region Auto Upgrade Builder Base
Global $g_sImgAutoUpgradeGold = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\Gold"
Global $g_sImgAutoUpgradeElixir = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\Elixir"
Global $g_sImgAutoUpgradeWindow = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\Window"
Global $g_sImgAutoUpgradeNew = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\New"
Global $g_sImgAutoUpgradeNoRes = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\NoResources"
Global $g_sImgAutoUpgradeBtnElixir = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\ButtonUpg\Elixir"
Global $g_sImgAutoUpgradeBtnGold = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\ButtonUpg\Gold"
Global $g_sImgAutoUpgradeBtnDir = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\Upgrade"
Global $g_sImgAutoUpgradeZero = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\NewBuildings\Shop"
Global $g_sImgAutoUpgradeClock = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\NewBuildings\Clock"
Global $g_sImgAutoUpgradeInfo = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\NewBuildings\Slot"
Global $g_sImgAutoUpgradeNewBldgYes = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\NewBuildings\Yes"
Global $g_sImgAutoUpgradeNewBldgNo = @ScriptDir & "\imgxml\Resources\BuildersBase\AutoUpgrade\NewBuildings\No"
#EndRegion

#Region Train
Global $g_sImgTrainTroops = @ScriptDir & "\imgxml\Train\Train_Train\"
Global $g_sImgTrainSpells = @ScriptDir & "\imgxml\Train\Spell_Train\"
Global $g_sImgArmyOverviewSpells = @ScriptDir & "\imgxml\ArmyOverview\Spells" ; @ScriptDir & "\imgxml\ArmySpells"
Global $g_sImgRequestCCButton = @ScriptDir & "\imgxml\ArmyOverview\RequestCC"
#EndRegion

#Region Attack
Global $g_sImgAttackBarDir = @ScriptDir & "\imgxml\AttackBar"
Global $g_sImgSwitchSiegeMachine = @ScriptDir & "\imgxml\SwitchSiegeMachines\"
Global $g_sImgSwitchWardenMode = @ScriptDir & "\imgxml\SwitchWardenMode"
#EndRegion

#Region Search
Global $g_sImgElixirStorage = @ScriptDir & "\imgxml\deadbase\elix\storage\"
Global $g_sImgElixirCollectorFill = @ScriptDir & "\imgxml\deadbase\elix\fill\"
Global $g_sImgElixirCollectorLvl = @ScriptDir & "\imgxml\deadbase\elix\lvl\"
Global $g_sImgWeakBaseBuildingsDir = @ScriptDir & "\imgxml\Buildings"
Global $g_sImgWeakBaseBuildingsEagleDir = @ScriptDir & "\imgxml\Buildings\Eagle"
Global $g_sImgWeakBaseBuildingsInfernoDir = @ScriptDir & "\imgxml\Buildings\Infernos"
Global $g_sImgWeakBaseBuildingsXbowDir = @ScriptDir & "\imgxml\Buildings\Xbow"
Global $g_sImgWeakBaseBuildingsWizTowerSnowDir = @ScriptDir & "\imgxml\Buildings\WTower_Snow"
Global $g_sImgWeakBaseBuildingsWizTowerDir = @ScriptDir & "\imgxml\Buildings\WTower"
Global $g_sImgWeakBaseBuildingsMortarsDir = @ScriptDir & "\imgxml\Buildings\Mortars"
Global $g_sImgWeakBaseBuildingsAirDefenseDir = @ScriptDir & "\imgxml\Buildings\ADefense"
Global $g_sImgSearchDrill = @ScriptDir & "\imgxml\Storages\Drills"
Global $g_sImgSearchDrillLevel = @ScriptDir & "\imgxml\Storages\Drills\Level"
Global $g_sImgEasyBuildings = @ScriptDir & "\imgxml\easybuildings"
Global $g_sImgRetrySearchButton = @ScriptDir & "\imgxml\Resources\Clouds\RetryButton*"
#EndRegion

#Region SwitchAcc
Global Const $g_sImgLoginWithSupercellID = @ScriptDir & "\imgxml\other\LoginWithSupercellID*"
Global Const $g_sImgGoogleSelectAccount = @ScriptDir & "\imgxml\other\GoogleSelectAccount*"
Global Const $g_sImgGoogleSelectEmail = @ScriptDir & "\imgxml\other\GoogleSelectEmail*"
Global Const $g_sImgGoogleAccounts = @ScriptDir & "\imgxml\SwitchAccounts\GooglePlay\GooglePlay*"
Global Const $g_sImgSupercellID = @ScriptDir & "\imgxml\SwitchAccounts\SuperCellID\SCID*"
#EndRegion

#Region ClanGames
Global Const $g_sImgCaravan =		@ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\Caravan"
Global Const $g_sImgStart = 		@ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\Start"
Global Const $g_sImgPurge = 		@ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\Purge"
Global Const $g_sImgCoolPurge = 	@ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\Gem"
Global Const $g_sImgTrashPurge = 	@ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\Trash"
Global Const $g_sImgOkayPurge = 	@ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\Okay"
Global Const $g_sImgReward = 		@ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\Reward"
Global Const $g_sImageBuilerGames = @ScriptDir & "\imgxml\Resources\ClanGamesImages\MainLoop\BuilderGames"

#EndRegion