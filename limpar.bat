@echo off

del /f /q "C:\Windows\Setup\Scripts\*.cmd"
del /f /q "C:\Windows\Setup\Scripts\*.ps1"
del /f /q "C:\Windows\Setup\Scripts\*.log"

reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /f

powershell -NoProfile -Command "$name = 'WIN-' + (Get-Date -Format 'ddMMyyHHmm'); Rename-Computer -NewName $name -Force"

powershell -Command "Set-ExecutionPolicy Undefined -Force"

powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $list = Get-WinUserLanguageList; foreach ($l in $list) { $null = $l.InputMethodTips.Remove('0416:00000416') }; Set-WinUserLanguageList $list -Force } catch { Write-Error $_ }"

pause
