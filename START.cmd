@echo off
color 0A
title AP_READER

powershell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0main.ps1' -TargetFolder '%TARGET%'"

echo AP_READER Done, BYE!
timeout /t 20