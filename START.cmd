@echo off
color 0A
title init_ece

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
 "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0main.ps1""'"

echo init_ece started as Administrator
exit /b
