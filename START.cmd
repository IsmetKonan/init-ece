@echo off
color 0A
title init_ece

powershell -NoProfile -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0main.ps1\" -TargetFolder \"%TARGET%\"' -Verb RunAs"

echo int_ece Done, BYE!
exit /b
