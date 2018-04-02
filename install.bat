@echo off
reg add "HKCU\Software\Kitware\CMake\Packages\XP-CMake" /v Path /t REG_SZ /d %~dp0
pause
