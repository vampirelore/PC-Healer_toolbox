# 🛠️ PC Healer Toolbox by VampireLore

This is a PowerShell-based system repair and optimization tool, developed with love by VampireLore.  
It includes utilities for network, system tweaks, app installs, malware scanning, and more — all accessible through a user-friendly graphical interface.

---




## 💻 How to Use

1. Click **Code → Download ZIP** and extract the folder.
2. Right-click `launch.bat` → **Run as Administrator** (important).
3. Enjoy the toolbox!

---

## ⚙️ Requirements

- Windows 10 or 11
- Administrator permissions for full access

---

## External Tools

This toolbox links to external tools created by:

- [Chris Titus Tech](https://github.com/ChrisTitusTech/winutil)
- [Sycnex - Windows10Debloater](https://github.com/Sycnex/Windows10Debloater)

These tools are not part of this project but are included for convenience.

---

## 🧾 A Legacy Worth Keeping
## From Batch File to PowerShell Toolbox

Before PC Healer evolved into a full-featured PowerShell GUI, it began humbly — a batch file built line by line by someone learning along the way. What started with @echo off became a tool shaped over years of trial, return, and refinement.

This project started when I wasn’t a programmer — just someone trying to make things work. I would return to the script from time to time, learn more, and improve it as I went. It did its job well for a few years, but now it’s grown into something worth sharing with the world.

For those who know batch scripting — especially those who remember the early days of Windows 10 — I hope you can appreciate the simplicity of this original script. It may look basic now, but it’s the foundation of everything that followed.

Below is the original PC Healer batch file — preserved to honor how far it’s come.

" @echo off
echo.
echo.
title PC HEALER
::Mode cols & lines
mode con cols=80 lines=50
color 4
echo
:title
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                ____________________________
echo. 
echo                                 "  !!!  Welcome  ! ! ! "
echo.
echo                                 "  !!!  PC HEALER !!!  "
echo.
echo                               _____________________________
echo.
echo.
pause>nul
:Main
color 7
cls
echo.
echo.
echo.
echo.
echo                                   Pick Something to do
echo.
echo.
echo.
echo.
echo                                     1) WiFi
echo.
echo                                     2) System
echo.
echo                                     3) Install
echo.
echo                                     4) BIOs
echo.
echo.
echo.
echo.
set /p number=number >nul
echo.
if %number% equ 1 goto WiFi
if %number% equ 2 goto Syst
if %number% equ 3 goto Install
if %number% equ 4 goto BIOs
pause >nul
:BIOs
cls
shutdown /r /fw /f /t 0
echo.
echo.
pause >nul
:Install
cls
winget install Google.Chrome
pause >nul
:WiFi
cls 
color 7
echo.
echo.
echo.
echo                                                  WiFi
echo.
echo.
echo                                              1) Wlan
echo.
echo                                              2) macaddress
echo.
echo                                              3) Wifi_info 
echo.
echo                                              4) Main
echo.
set /p number=number >nul
echo.
if %number% equ 1 goto wlan
if %number% equ 2 goto macaddress
if %number% equ 3 goto Wifi_info
if %number% equ 4 goto Main
echo.
:Wifi_info
cls
echo.
ipconfig /all
echo.
pause >nul
goto WiFi
:macaddress
cls
getmac /v
echo.
pause >nul
goto WiFi
:wlan
cls
color 7
echo.
echo.
echo.
netsh wlan show profile
echo.
echo                            Type Name then Hit Enter
set /p name=name >nul 
echo.
echo.
netsh wlan export profile folder=E:\Password %name% key=clear
echo
echo.
pause
goto WiFi
echo.
:Syst
cls
color 7
echo.
echo.
echo.
echo                                         System
echo.
echo.
echo.
echo                                       1) systeminfo
echo.
echo                                       2) Speed Check
echo.
echo                                       3) Dism
echo.
echo                                       4) Energy
echo.
echo                                       5) Battery
echo.                            
echo                                       6) Main
set /p number=number >nul
echo.
if %number% equ 1 goto systeminfo
if %number% equ 2 goto Diskcheck
if %number% equ 3 goto Dism
if %number% equ 4 goto energy
if %number% equ 5 goto Battery
if %number% equ 6 goto Main
echo.
:systeminfo
cls
echo.
systeminfo
echo.
pause >nul
echo.
goto Syst
pause >nul
:energy
cls
@echo on
powercfg /energy
pause
@echo off
goto Syst
:Battery
cls
echo.
@ echo on
powercfg /batteryreport |clip
@echo off
echo.
pause >nul
echo.
goto Syst
:Diskcheck
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo                                        ___________________________
echo.
echo.
echo                                              /f   /r  Main
echo.
echo                                        ___________________________
set /p name=name
chkdsk %name%
echo.
goto Main
:chkdsk/f
cls
chkdsk /f
pause >nul
:chkdsk/r
chkdsk /r
pause >nul
goto Syst
:Dism
cls
echo.
echo.
echo.
echo                                            1)Checkhealth
echo.
echo                                            2)ScanHealth
echo.
echo                                            3)Restorehealth
echo.
echo                                            4)Main
echo.
@echo off
set /p number=number >nul
if %number% equ 1 goto Checkhealth
if %number% equ 2 goto ScanHealth
if %number% equ 3 goto Restorehealth
if %number% equ 4 goto Main
:Checkhealth
cls
echo.
dism /online /Cleanup-Image /Checkhealth
pause >nul
goto Dism
"ScanHealth
cls
:ScanHealth
cls
echo.
dism /online /Cleanup-Image /ScanHealth
pause >nul
goto Dism
:Restorehealth
cls
echo.
dism /online /Cleanup-Image /Restorehealth
pause >nul
goto Dism "

---


## 📝 License

This project is licensed under the **GNU GPL v3.0**.  
You're free to use, share, and improve it — just keep it as .bat and keep it open also give credit where it's due.  
Stay awesome, and don't forget the name: `vampirelore`.

