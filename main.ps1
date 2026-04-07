#
# Made by Ismet Konan for ece24
# Last Edited 07.04.2026
#

$VERSION     = "1.0.1"
$DEKO        = "-----------------------------------------------------------------"
$EMPTY_LINE  = "                                                                 "

$Host.UI.RawUI.ForegroundColor = 'Blue'
Write-Host $EMPTY_LINE
Write-Host $DEKO
Write-Host '    ____                    __     __ __'
Write-Host '   /  _/________ ___  ___  / /_   / //_/___  ____  ____ _____'
Write-Host '   / // ___/ __ `__ \/ _ \/ __/  / ,< / __ \/ __ \/ __ `/ __ \ '
Write-Host ' _/ /(__  ) / / / / /  __/ /_   / /| / /_/ / / / / /_/ / / / /'
Write-Host '/___/____/_/ /_/ /_/\___/\__/  /_/ |_\____/_/ /_/\__,_/_/ /_/'
Write-Host $DEKO
Write-Host 'CC Ismet Konan'
Write-Host "$VERSION starting up ..."
Write-Host $DEKO

$scriptDir = "$HOME\Downloads"
Write-Host 'Installiere 7-Zip (MSI)...' -ForegroundColor Yellow

$installerPath = Join-Path $HOME 'Downloads\7zip.msi'
$sevenZipUrl   = 'https://www.7-zip.org/a/7z2600-x64.msi'

Invoke-WebRequest -Uri $sevenZipUrl -OutFile $installerPath -ErrorAction SilentlyContinue

if (Test-Path $installerPath) {
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait -WindowStyle Hidden
    Write-Host '7-Zip installiert.' -ForegroundColor Green
}
else {
    Write-Host 'Download fehlgeschlagen – versuche Fallback...' -ForegroundColor DarkYellow

    $baseUrl = 'https://www.7-zip.org/'
    $page = Invoke-WebRequest -Uri $baseUrl -UseBasicParsing -ErrorAction SilentlyContinue

    if ($page) {
        $downloadLink = ($page.Links | Where-Object { $_.href -match 'a/7z.*-x64\.msi' } | Select-Object -First 1).href
        $downloadUrl = if ($downloadLink -match '^http') { $downloadLink } else { $baseUrl + $downloadLink }

        Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath -ErrorAction SilentlyContinue

        if (Test-Path $installerPath) {
            Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait -WindowStyle Hidden
            Write-Host '7-Zip ueber Fallback installiert.' -ForegroundColor Green
        }
        else {
            Write-Host 'Kritischer Fehler: 7-Zip konnte nicht installiert werden ACS' -ForegroundColor Red
        }
    }
    else {
        Write-Host '7-Zip Webseite nicht erreichbar – Uebersprungen.' -ForegroundColor Red
    }
}

$PublicDesktop = 'C:\Users\Public\Desktop'
$FileName = 'TeamViewer_ECE.exe'
$FilePath = Join-Path $PublicDesktop $FileName
write-Host 'Starte Download von TeamViewer...' -ForegroundColor Cyan
Invoke-WebRequest -Uri 'https://help.ece24.net/TeamViewer_ECE.exe' -OutFile $FilePath
Start-Process -FilePath $FilePath -ArgumentList '/S' -Wait
Write-Host 'TeamViewer installiert!' -ForegroundColor Green

$DownloadUrl = 'https://www.pdf-xchange.com/downloads/EditorV10.x64.msi?key=S5m2l6ycL2Imcpo00xVGGpohQ1ODS/40pyL2WXW%2Bms%2BsTE9R4X3uKziSH9gyntNU&version=10.8.4.409'
$FileName = 'PDFXChange_Editor_Plus_10.8.4.409.msi'
$FilePath = Join-Path $scriptDir $FileName
Write-Host 'Starte Download von PDF-XChange Editor Plus...' -ForegroundColor Cyan
Invoke-WebRequest -Uri $DownloadUrl -OutFile $FilePath
Start-Process 'msiexec.exe' -ArgumentList "/i `"$FilePath`" /qn /norestart" -Wait
write-Host 'PDF-XChange Editor Plus installiert!' -ForegroundColor Green

write-Host 'Starte Download von Google Chrome Enterprise...' -ForegroundColor Cyan
$chromeUrl = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BDD8A69D1-8F3B-4F0A-9B3C-1234567890AB%7D/chrome/install/GoogleChromeStandaloneEnterprise64.msi'
$chromePath = Join-Path $scriptDir 'chrome-enterprise-x64.msi'
Invoke-WebRequest -Uri $chromeUrl -OutFile $chromePath
Start-Process 'msiexec.exe' -ArgumentList "/i `"$chromePath`" /qn /norestart" -Wait
write-Host 'Google Chrome Enterprise installiert!' -ForegroundColor Green


Write-Host $DEKO
Write-Host 'All Done!' -ForegroundColor Green
Write-Host $DEKO
Write-Host $DEKO
pause > $null
