#
# Made by Ismet Konan for ece24
# Last Edited 03.06.2026
#

$VERSION     = "3.1.1"
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
$pdf24 = $true

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Services Auswaehlen"
$Form.Size = New-Object System.Drawing.Size(380, 340)
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

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(20, 260) 
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
    # variablen setzen
    $script:firefox = $firefoxChecked
    $script:chrome = $chromeChecked
    $script:sevenzip = $sevenzipChecked
    $script:teamViewer = $teamViewerChecked
    $script:pdfXchange = $pdfXchangeChecked
    $script:adobeReader = $adobeReaderChecked
    $script:TeamViewerHost = $teamViewerHostChecked
    $script:pdf24 = $pdf24Checked
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

Write-Host $DEKO
Write-Host 'All Done!' -ForegroundColor Green
Write-Host $DEKO
Write-Host $DEKO
pause > $null
