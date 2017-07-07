; #FUNCTION# ====================================================================================================================
; Name ..........: ProfileSwitch
; Description ...: This file contains all functions of ProfileSwitch feature
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: ---
; Modified ......: 03/09/2016
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......:  =====================================================================================================================

Func ProfileSwitch()
	If $ichkGoldSwitchMax = 1 Or $ichkGoldSwitchMin = 1 Or $ichkElixirSwitchMax = 1 Or $ichkElixirSwitchMin = 1 Or _
			$ichkDESwitchMax = 1 Or $ichkDESwitchMin = 1 Or $ichkTrophySwitchMax = 1 Or $ichkTrophySwitchMin = 1 Then
		Local $SwitchtoProfile = ""
		While True
			If $ichkGoldSwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootGold]) >= Number($itxtMaxGoldAmount) Then
					$SwitchtoProfile = $icmbGoldMaxProfile
					SetLog("Village Gold detected Above Gold Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkGoldSwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootGold]) < Number($itxtMinGoldAmount) And Number($g_aiCurrentLoot[$eLootGold]) > 1 Then
					$SwitchtoProfile = $icmbGoldMinProfile
					Setlog("Village Gold detected Below Gold Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootElixir]) >= Number($itxtMaxElixirAmount) Then
					$SwitchtoProfile = $icmbElixirMaxProfile
					SetLog("Village Gold detected Above Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootElixir]) < Number($itxtMinElixirAmount) And Number($g_aiCurrentLoot[$eLootElixir]) > 1 Then
					$SwitchtoProfile = $icmbElixirMinProfile
					SetLog("Village Gold detected Below Elixir Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootDarkElixir]) >= Number($itxtMaxDEAmount) Then
					$SwitchtoProfile = $icmbDEMaxProfile
					SetLog("Village Dark Elixir detected Above Dark Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootDarkElixir]) < Number($itxtMinDEAmount) And Number($g_aiCurrentLoot[$eLootDarkElixir]) > 1 Then
					$SwitchtoProfile = $icmbDEMinProfile
					SetLog("Village Dark Elixir detected Below Dark Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMax = 1 Then
				If Number($g_aiCurrentLoot[$eLootTrophy]) >= Number($itxtMaxTrophyAmount) Then
					$SwitchtoProfile = $icmbTrophyMaxProfile
					SetLog("Village Trophies detected Above Throphy Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMin = 1 Then
				If Number($g_aiCurrentLoot[$eLootTrophy]) < Number($itxtMinTrophyAmount) And Number($g_aiCurrentLoot[$eLootTrophy]) > 1 Then
					$SwitchtoProfile = $icmbTrophyMinProfile
					SetLog("Village Trophies detected Below Trophy Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			ExitLoop
		WEnd

		If $SwitchtoProfile <> "" Then
			TrayTip(" Profile Switch Village Report!", "Gold: " & _NumberFormat($g_aiCurrentLoot[$eLootGold]) & "; Elixir: " & _NumberFormat($g_aiCurrentLoot[$eLootElixir]) & "; Dark: " & _NumberFormat($g_aiCurrentLoot[$eLootDarkElixir]) & "; Trophy: " & _NumberFormat($g_aiCurrentLoot[$eLootTrophy]), "", 0)
			If FileExists(@ScriptDir & "\Audio\SwitchingProfiles.wav") Then
				SoundPlay(@ScriptDir & "\Audio\SwitchingProfiles.wav", 1)
			ElseIf FileExists(@WindowsDir & "\media\tada.wav") Then
				SoundPlay(@WindowsDir & "\media\tada.wav", 1)
			EndIf

			_GUICtrlComboBox_SetCurSel($g_hCmbProfile, $SwitchtoProfile)
			cmbProfile()
			If _Sleep(2000) Then Return
			runBot()
		EndIf
	EndIf

EndFunc   ;==>ProfileSwitch
