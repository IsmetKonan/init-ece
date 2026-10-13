#
# Made by Ismet Konan for ece24
# Last Edited 13.10.2026
#

$VERSION     = "5.0.0"
$DEKO        = "-----------------------------------------------------------------"
$EMPTY_LINE  = "                                                                 "
$scriptDir = "$HOME\Downloads"
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

#
# // check fuer Admin wegen MSI-Installationen
# 

$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Fehler: Bitte starten sie das Programm als Administrator!" -ForegroundColor Red
    pause
    exit 1
}

# services liste:
$firefox = $true
$chrome = $true
$sevenzip = $true
$teamViewer = $true
$pdfXchange = $true
$adobeReader = $true
$TeamViewerHost = $true
$pdf24     = $true
$wireguard = $true
$nextcloud = $true
$keepass = $true
$keepassxc = $true
$datev = $true

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Services Auswaehlen"
$Form.Size = New-Object System.Drawing.Size(380, 500) # x y
$Form.StartPosition = "CenterScreen"

$Checkbox = New-Object System.Windows.Forms.CheckBox
$Checkbox.Location = New-Object System.Drawing.Size(20, 20)
$Checkbox.Size = New-Object System.Drawing.Size(200, 30)
$Checkbox.Text = "Firefox installieren"
$Form.Controls.Add($Checkbox)

$CheckboxC = New-Object System.Windows.Forms.CheckBox
$CheckboxC.Location = New-Object System.Drawing.Size(20, 50)
$CheckboxC.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxC.Text = "Chrome installieren"
$Form.Controls.Add($CheckboxC)

$Checkbox7 = New-Object System.Windows.Forms.CheckBox
$Checkbox7.Location = New-Object System.Drawing.Size(20, 80)
$Checkbox7.Size = New-Object System.Drawing.Size(200, 30)
$Checkbox7.Text = "7-Zip installieren"
$Form.Controls.Add($Checkbox7)

$CheckboxT = New-Object System.Windows.Forms.CheckBox
$CheckboxT.Location = New-Object System.Drawing.Size(20, 110)
$CheckboxT.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxT.Text = "TeamViewer installieren"
$Form.Controls.Add($CheckboxT)

$CheckboxP = New-Object System.Windows.Forms.CheckBox
$CheckboxP.Location = New-Object System.Drawing.Size(20, 140)
$CheckboxP.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxP.Text = "PDF-XChange Editor installieren"
$Form.Controls.Add($CheckboxP)

$CheckboxAD = New-Object System.Windows.Forms.CheckBox
$CheckboxAD.Location = New-Object System.Drawing.Size(20, 170)
$CheckboxAD.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxAD.Text = "Adobe Reader installieren"
$Form.Controls.Add($CheckboxAD)

$CheckboxTVH = New-Object System.Windows.Forms.CheckBox
$CheckboxTVH.Location = New-Object System.Drawing.Size(20, 200)
$CheckboxTVH.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxTVH.Text = "TeamViewer Host installieren"
$Form.Controls.Add($CheckboxTVH)

$CheckboxP24 = New-Object System.Windows.Forms.CheckBox
$CheckboxP24.Location = New-Object System.Drawing.Size(20, 230)
$CheckboxP24.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxP24.Text = "PDF24 installieren"
$Form.Controls.Add($CheckboxP24)

$CheckboxWG = New-Object System.Windows.Forms.CheckBox
$CheckboxWG.Location = New-Object System.Drawing.Size(20, 260)
$CheckboxWG.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxWG.Text = "WireGuard installieren"
$Form.Controls.Add($CheckboxWG)

$CheckboxNC = New-Object System.Windows.Forms.CheckBox
$CheckboxNC.Location = New-Object System.Drawing.Size(20, 290)
$CheckboxNC.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxNC.Text = "Nextcloud installieren"
$Form.Controls.Add($CheckboxNC)

#keepass checkbox
$CheckboxKP = New-Object System.Windows.Forms.CheckBox
$CheckboxKP.Location = New-Object System.Drawing.Size(20, 320)
$CheckboxKP.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxKP.Text = "KeePass installieren"
$Form.Controls.Add($CheckboxKP)

$CheckboxK = New-Object System.Windows.Forms.CheckBox
$CheckboxK.Location = New-Object System.Drawing.Size(20, 350)
$CheckboxK.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxK.Text = "KeePassXC installieren"
$Form.Controls.Add($CheckboxK)

#datev checkbox
$CheckboxD = New-Object System.Windows.Forms.CheckBox
$CheckboxD.Location = New-Object System.Drawing.Size(20, 380)
$CheckboxD.Size = New-Object System.Drawing.Size(200, 30)
$CheckboxD.Text = "DATEV installieren"
$Form.Controls.Add($CheckboxD)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(20, 420) 
$Button.Size = New-Object System.Drawing.Size(100, 30)
$Button.Text = "Uebernehmen"

$Button.Add_Click({
    $firefoxChecked = $Checkbox.Checked
    $chromeChecked = $CheckboxC.Checked
    $sevenzipChecked = $Checkbox7.Checked
    $teamViewerChecked = $CheckboxT.Checked
    $pdfXchangeChecked = $CheckboxP.Checked
    $adobeReaderChecked = $CheckboxAD.Checked
    $teamViewerHostChecked = $CheckboxTVH.Checked
    $pdf24Checked = $CheckboxP24.Checked
    $wireguardChecked = $CheckboxWG.Checked
    $nextcloudChecked = $CheckboxNC.Checked
    $keepassxcChecked = $CheckboxK.Checked
    $keepassChecked = $CheckboxKP.Checked
    $datevChecked = $CheckboxD.Checked
    # variablen setzen
    $script:firefox = $firefoxChecked
    $script:chrome = $chromeChecked
    $script:sevenzip = $sevenzipChecked
    $script:teamViewer = $teamViewerChecked
    $script:pdfXchange = $pdfXchangeChecked
    $script:adobeReader = $adobeReaderChecked
    $script:TeamViewerHost = $teamViewerHostChecked
    $script:pdf24 = $pdf24Checked
    $script:wireguard = $wireguardChecked
    $script:nextcloud = $nextcloudChecked
    $script:keepassxc = $keepassxcChecked
    $script:keepass = $keepassChecked
    $script:datev = $datevChecked
    # schliessen
    $Form.Close()
})

$Form.Controls.Add($Button)
[void]$Form.ShowDialog()

# // Installation

if ($firefox) {
    Write-Host 'Starte Download von Firefox...' -ForegroundColor Cyan
    $firefoxUrl = 'https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64&lang=de'
    $firefoxPath = Join-Path $scriptDir 'Firefox Installer.msi'
    
    # Download mit -UseBasicParsing (verhindert die Sicherheitswarnung)
    Invoke-WebRequest -Uri $firefoxUrl -OutFile $firefoxPath -UseBasicParsing
    
    # Stille MSI-Installation im Hintergrund
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$firefoxPath`" /qn /norestart" -Wait
    
    Write-Host 'Firefox installiert!' -ForegroundColor Green
}

if ($pdf24) {
    Write-Host 'Starte Download von PDF24...' -ForegroundColor Cyan
    Write-Host 'Diese Installation kann einige Minuten dauern. Bitte habe geduld!' -ForegroundColor Yellow

    $pdf24Url = 'https://download.pdf24.org/pdf24-creator-latest-x64.exe'
    $pdf24Path = Join-Path $scriptDir 'PDF24_Installer.exe'

    Invoke-WebRequest -Uri $pdf24Url -OutFile $pdf24Path -UseBasicParsing

    Start-Process `
        -FilePath $pdf24Path `
        -ArgumentList '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' `
        -Wait

    Write-Host 'PDF24 installiert!' -ForegroundColor Green
}

if ($adobeReader) {
    Write-Host 'Installiere Adobe Reader...' -ForegroundColor Yellow
    $installerPath = Join-Path $HOME 'Downloads\AdobeReader.exe'
    $adobeReaderUrl = 'https://init.ece24.net/Assets/Reader.exe'

    Invoke-WebRequest -Uri $adobeReaderUrl -OutFile $installerPath -ErrorAction SilentlyContinue

    if (Test-Path $installerPath) {
        Start-Process -FilePath $installerPath -ArgumentList '/sAll /msi /norestart' -Wait -WindowStyle Hidden
        Write-Host 'Adobe Reader installiert.' -ForegroundColor Green
    }
    else {
        Write-Host 'Download fehlgeschlagen – Adobe Reader konnte nicht installiert werden.' -ForegroundColor Red
    }

}

if ($TeamViewerHost) {
    Write-Host 'Installiere TeamViewer Host...' -ForegroundColor Yellow
    $installerPath = Join-Path $HOME 'Downloads\TeamViewer_Host.exe'
    $teamViewerHostUrl = 'https://download.teamviewer.com/download/TeamViewer_Host_Setup_x64.exe?_gl=1*1vnbudr*_gcl_au*MTIwNjc0Nzk2Ni4xNzgwNDkwNDcw'

    Invoke-WebRequest -Uri $teamViewerHostUrl -OutFile $installerPath -ErrorAction SilentlyContinue

    if (Test-Path $installerPath) {
        $proc = Start-Process `
            -FilePath $installerPath `
            -ArgumentList '/S' `
            -PassThru `
            -Wait

        Write-Host "ExitCode: $($proc.ExitCode)"
        
        Write-Host 'TeamViewer Host installiert.' -ForegroundColor Green
    }
    else {
        Write-Host 'Download fehlgeschlagen – TeamViewer Host konnte nicht installiert werden.' -ForegroundColor Red
    }

}


if ($sevenzip) {
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
}

if ($teamViewer) {
    $PublicDesktop = 'C:\Users\Public\Desktop'
    $FileName = 'TeamViewer_ECE.exe'
    $FilePath = Join-Path $PublicDesktop $FileName
    write-Host 'Starte Download von TeamViewer...' -ForegroundColor Cyan
    Invoke-WebRequest -Uri 'https://help.ece24.net/TeamViewer_ECE.exe' -OutFile $FilePath
    Start-Process -FilePath $FilePath -ArgumentList '/S' -Wait
    Write-Host 'TeamViewer installiert!' -ForegroundColor Green
}

if ($pdfXchange) {    
    $DownloadUrl = 'https://www.pdf-xchange.com/downloads/EditorV11.x64.msi?key=QqcIJ/QN%2BMKPQk8fKNTabbAz28su7eWxP/I7YClBdlbWUFAK16S9FfiDz/KFN/7M&version=11.0.1.0'    
    $FileName = 'PDFXChange_Editor_Plus_11.0.1.0.msi'
    $FilePath = Join-Path $scriptDir $FileName
    Write-Host 'Starte Download von PDF-XChange Editor Plus...' -ForegroundColor Cyan
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $FilePath
    Start-Process 'msiexec.exe' -ArgumentList "/i `"$FilePath`" /qn /norestart" -Wait
    write-Host 'PDF-XChange Editor Plus installiert!' -ForegroundColor Green
}

if ($chrome) {
    write-Host 'Starte Download von Google Chrome Enterprise...' -ForegroundColor Cyan
    $chromeUrl = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BDD8A69D1-8F3B-4F0A-9B3C-1234567890AB%7D/chrome/install/GoogleChromeStandaloneEnterprise64.msi'
    $chromePath = Join-Path $scriptDir 'chrome-enterprise-x64.msi'
    Invoke-WebRequest -Uri $chromeUrl -OutFile $chromePath
    Start-Process 'msiexec.exe' -ArgumentList "/i `"$chromePath`" /qn /norestart" -Wait
    write-Host 'Google Chrome Enterprise installiert!' -ForegroundColor Green
}

if ($wireguard) {
    write-Host 'Starte Download von WireGuard...' -ForegroundColor Cyan
    $wireguardUrl = 'https://download.wireguard.com/windows-client/wireguard-amd64-1.1.1.msi'
    $wireguardPath = Join-Path $scriptDir 'wireguard-x64.msi'
    Invoke-WebRequest -Uri $wireguardUrl -OutFile $wireguardPath
    Start-Process 'msiexec.exe' -ArgumentList "/i `"$wireguardPath`" /qn /norestart" -Wait
    write-Host 'WireGuard installiert!' -ForegroundColor Green
}

if ($nextcloud) {
    write-Host 'Starte Download von Nextcloud...' -ForegroundColor Cyan
    $nextcloudUrl = 'https://download.nextcloud.com/desktop/releases/Windows/Nextcloud-35.0.0-x64.msi'
    $nextcloudPath = Join-Path $scriptDir 'nextcloud-x64.msi'
    Invoke-WebRequest -Uri $nextcloudUrl -OutFile $nextcloudPath
    Start-Process 'msiexec.exe' -ArgumentList "/i `"$nextcloudPath`" /qn /norestart" -Wait
    write-Host 'Nextcloud installiert!' -ForegroundColor Green
}

if ($keepass) {
    write-Host 'Starte Download von KeePass...' -ForegroundColor Cyan
    $keepassUrl = 'https://init.ece24.net/Assets/KeePass-2.61.1.msi'
    $keepassPath = Join-Path $scriptDir 'keepass-x64.msi'
    Invoke-WebRequest -Uri $keepassUrl -OutFile $keepassPath -ErrorAction Stop
    $keepassProcess = Start-Process 'msiexec.exe' -ArgumentList "/i `"$keepassPath`" /qn /norestart" -Wait -PassThru
    if ($keepassProcess.ExitCode -notin @(0, 3010)) {
        throw "KeePass installation failed with exit code $($keepassProcess.ExitCode)."
    }
    write-Host 'KeePass installiert!' -ForegroundColor Green
}

if ($keepassxc) {
    write-Host 'Starte Download von KeePassXC...' -ForegroundColor Cyan
    $keepassxcUrl = 'https://github.com/keepassxreboot/keepassxc/releases/download/2.7.12/KeePassXC-2.7.12-Win64.msi'
    $keepassxcPath = Join-Path $scriptDir 'keepassxc-x64.msi'
    Invoke-WebRequest -Uri $keepassxcUrl -OutFile $keepassxcPath
    Start-Process 'msiexec.exe' -ArgumentList "/i `"$keepassxcPath`" /qn /norestart" -Wait
    write-Host 'KeePassXC installiert!' -ForegroundColor Green
}

if ($datev) {
    Write-Host 'Starte Installation des DATEV Sicherheitspakets Compact...' -ForegroundColor Cyan
    $wingetCommand = Get-Command 'winget.exe' -ErrorAction Stop
    $datevPackageId = 'DATEV.SicherheitspaketCompact'

    & $wingetCommand.Source list --id $datevPackageId --exact --source winget --scope machine --accept-source-agreements
    $lookupExitCode = $LASTEXITCODE
    $lookupExitHex = '0x{0:X8}' -f [BitConverter]::ToUInt32([BitConverter]::GetBytes([int]$lookupExitCode), 0)
    if ($lookupExitCode -eq 0) {
        $datevAction = 'upgrade'
    }
    elseif ($lookupExitHex -eq '0x8A150014') {
        $datevAction = 'install'
    }
    else {
        throw "DATEV-Paketstatus konnte nicht ermittelt werden (WinGet $lookupExitHex)."
    }

    & $wingetCommand.Source $datevAction --id $datevPackageId --exact --source winget --scope machine --silent --accept-source-agreements --accept-package-agreements
    $installExitCode = $LASTEXITCODE
    $installExitHex = '0x{0:X8}' -f [BitConverter]::ToUInt32([BitConverter]::GetBytes([int]$installExitCode), 0)
    if ($installExitCode -eq 3010) {
        Write-Host 'DATEV-Installation abgeschlossen; ein Neustart ist erforderlich.' -ForegroundColor Yellow
    }
    elseif ($installExitCode -ne 0 -and -not ($datevAction -eq 'upgrade' -and $installExitHex -eq '0x8A15002B')) {
        throw "DATEV-Installation fehlgeschlagen (WinGet $installExitHex)."
    }

    & $wingetCommand.Source list --id $datevPackageId --exact --source winget --scope machine --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        throw 'DATEV-Sicherheitspaket Compact wurde nach der Installation nicht gefunden.'
    }
    Write-Host 'DATEV Sicherheitspaket Compact installiert bzw. aktuell.' -ForegroundColor Green
}

Write-Host $DEKO
Write-Host 'All Done!' -ForegroundColor Green
Write-Host $DEKO
Write-Host $DEKO
pause > $null
