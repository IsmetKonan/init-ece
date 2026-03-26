#
# Made by Ismet Konan for ece24
# Last Edited 17.03.2026
#


$VERSION     = "1.0.1"
$DEKO        = "-----------------------------------------------------------------"
$EMPTY_LINE  = "                                                                 "

$Host.UI.RawUI.ForegroundColor = 'Blue'
Write-Host $EMPTY_LINE
Write-Host $DEKO
Write-Host "    ____                    __     __ __"
Write-Host "   /  _/________ ___  ___  / /_   / //_/___  ____  ____ _____"
Write-Host "   / // ___/ __ `__ \/ _ \/ __/  / ,< / __ \/ __ \/ __ `/ __ \"
Write-Host " _/ /(__  ) / / / / /  __/ /_   / /| / /_/ / / / / /_/ / / / /"
Write-Host "/___/____/_/ /_/ /_/\___/\__/  /_/ |_\____/_/ /_/\__,_/_/ /_/"
Write-Host $DEKO
Write-Host "CC Ismet Konan"
Write-Host "$VERSION starting up ..."
Write-Host $DEKO

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# --- 7ZIP ---
$baseUrl = "https://www.7-zip.org/"
$page = Invoke-WebRequest -Uri $baseUrl -UseBasicParsing
$downloadLink = ($page.Links | Where-Object { $_.href -match "a/7z.*-x64\.exe" } | Select-Object -First 1).href
$sevenZipUrl = if ($downloadLink -match "^http") { $downloadLink } else { $baseUrl + $downloadLink }
$sevenZipPath = Join-Path $scriptDir "7zip.exe"

Invoke-WebRequest -Uri $sevenZipUrl -OutFile $sevenZipPath

# --- TEAMVIEWER ---
$tvPath = Join-Path $scriptDir "TeamViewer_ECE.exe"
Invoke-WebRequest -Uri "https://help.ece24.net/TeamViewer_ECE.exe" -OutFile $tvPath

# --- PDF XCHANGE ---
$pdfPath = Join-Path $scriptDir "pdfxchange.msi"
Invoke-WebRequest -Uri "https://www.pdf-xchange.com/downloads/EditorV10.x64.msi?..." -OutFile $pdfPath

# --- CHROME ---
$chromePath = Join-Path $scriptDir "chrome.msi"
Invoke-WebRequest -Uri "https://dl.google.com/.../GoogleChromeStandaloneEnterprise64.msi" -OutFile $chromePath

# --- INSTALL ---
Write-Host "Installing..." -ForegroundColor Yellow

Start-Process -FilePath $sevenZipPath -ArgumentList "/S" -Wait
Start-Process -FilePath $tvPath -ArgumentList "/S" -Wait
Start-Process "msiexec.exe" -ArgumentList "/i `"$pdfPath`" /qn /norestart" -Wait
Start-Process "msiexec.exe" -ArgumentList "/i `"$chromePath`" /qn /norestart" -Wait

Write-Host "Done!" -ForegroundColor Green

Write-Host $DEKO
Write-Host "All Done!" -ForegroundColor Green
Write-Host $DEKO
Write-Host $DEKO
pause > $null
