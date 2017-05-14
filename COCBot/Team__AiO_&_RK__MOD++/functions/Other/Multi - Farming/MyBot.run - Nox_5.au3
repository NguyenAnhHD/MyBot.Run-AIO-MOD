; AutoIt pragmas
#RequireAdmin
#AutoIt3Wrapper_UseX64=7n
;#AutoIt3Wrapper_Res_HiDpi=Y ; HiDpi will be set during run-time!
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/rsln /MI=3
;/SV=0

;#AutoIt3Wrapper_Change2CUI=y
;#pragma compile(Console, true)
#pragma compile(Icon, "MyBot.ico")
#pragma compile(FileDescription, Clash of Clans Bot - A Free Clash of Clans bot - https://mybot.run)
#pragma compile(ProductName, My Bot)
#pragma compile(ProductVersion, 7.1.4)
#pragma compile(FileVersion, 7.1.4)
#pragma compile(LegalCopyright, © https://mybot.run)
#pragma compile(Out, MyBot.run - Nox_5.exe) ; Required
Run("MyBot.run.exe Nox_5 Nox Nox_5")