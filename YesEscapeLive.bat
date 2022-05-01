@echo off
::Restore access to the unusable keyboard keys
REG DELETE "HKLM\System\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /f>nul 2>&1
REG DELETE "HKLM\System\ControlSet001\Control\Keyboard Layout" /v "Scancode Map" /f>nul 2>&1
::Remove the NoEscape startup program
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v Userinit /t REG_SZ /d %WinDir%\System32\userinit.exe>nul 2>&1
::Allow executable files to run without NoEscape interfering
REG ADD "HKLM\Software\Classes\exefile\shell\open\command" /ve /f /t REG_SZ /d "\"%^1\" %*>nul 2>&1
::Enable UAC, Command Prompt, and Task Manager
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t REG_DWORD /d 1>nul 2>&1
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVerson\Policies\System" /v DisableRegistryTools /f>nul 2>&1
REG DELETE "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /f>nul 2>&1
::Enable the logon background image
REG DELETE "HKLM\Software\Policies\Microsoft\Windows\System" /v DisableLogonBackgroundImage /f>nul 2>&1
::Delete NoEscape executable
del /f %WinDir%\winnt32.exe>nul 2>&1
del /f %SystemRoot%\winnt32.exe>nul 2>&1
del /f %SystemDrive%\Windows\winnt32.exe>nul 2>&1
::Fix the default tile change, weird mouse change, and shutdown change caused by NoEscape
REG DELETE HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v UseDefaultTile /f>nul 2>&1
REG DELETE "HKCU\Control Panel\Mouse" /v SwapMouseButtons /f>nul 2>&1
REG DELETE HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v shutdownwithoutlogon /f>nul 2>&1
