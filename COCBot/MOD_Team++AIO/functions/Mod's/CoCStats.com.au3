; #FUNCTION# ====================================================================================================================
; Name ..........: CoCStats
; Description ...: This file contains all functions of CoCStats feature
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: JK
; Modified ......: 03/09/2016
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......:  =====================================================================================================================

Func CoCStats($starsearned)

	If $ichkCoCStats = 0 Then Return

	; ==================== Begin CoCStats Mod ====================
	SetLog("Sending data to CoCStats.com...", $COLOR_BLUE)
	Local $sPD = 'apikey=' & $MyApiKey & '&ctrophy=' & $g_aiCurrentLoot[$eLootTrophy] & '&cgold=' & $g_aiCurrentLoot[$eLootGold] & '&celix=' & $g_aiCurrentLoot[$eLootElixir] & '&cdelix=' & $g_aiCurrentLoot[$eLootDarkElixir] & '&search=' & $g_iSearchCount & _
	'&gold=' & $g_iStatsLastAttack[$eLootGold] & '&elix=' & $g_iStatsLastAttack[$eLootElixir] & '&delix=' & $g_iStatsLastAttack[$eLootDarkElixir] & '&trophy=' & $g_iStatsLastAttack[$eLootTrophy] & _
	'&bgold=' & $g_iStatsBonusLast[$eLootGold] & '&belix=' & $g_iStatsBonusLast[$eLootElixir] & '&bdelix=' & $g_iStatsBonusLast[$eLootDarkElixir] & '&stars=' & $starsearned & '&thlevel=' & $g_iTownHallLevel & '&log='

	Local  $tempLogText = _GUICtrlRichEdit_GetText($g_hTxtLog, True)
	For $i = 1 To StringLen($tempLogText)
		Local $acode = Asc(StringMid($tempLogText, $i, 1))
		Select
			Case ($acode >= 48 And $acode <= 57) Or _
					($acode >= 65 And $acode <= 90) Or _
					($acode >= 97 And $acode <= 122)
				$sPD = $sPD & StringMid($tempLogText, $i, 1)
			Case $acode = 32
				$sPD = $sPD & "+"
			Case Else
				$sPD = $sPD & "%" & Hex($acode, 2)
		EndSelect
	Next

	Local $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$oHTTP.Open("POST", "https://cocstats.com/api/log.php", False)
	$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

	$oHTTP.Send($sPD)

	Local $oReceived = $oHTTP.ResponseText
	Local $oStatusCode = $oHTTP.Status
	SetLog("Report sent. " & $oStatusCode & " " & $oReceived, $COLOR_BLUE)
	; ===================== End CoCStats Mod =====================

EndFunc   ;==>CoCStats
