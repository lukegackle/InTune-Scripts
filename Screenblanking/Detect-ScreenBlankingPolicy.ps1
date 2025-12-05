<# 
.SYNOPSIS 
Set Screen blanking policy across devices, so screensaver activates after 2 minutes of IDLE then computer locks after 5 minutes of IDLE
 
.DESCRIPTION 
The script will set the user profile settings required to achieve the following requirements:
 - After 2 minutes of inactivity, active screensaver (the user can wiggle their mouse or press key to wake screen between 2-5 minutes)
 - After 5 minutes of inactivity lock the device (The setting to lock the device is set seperate to these policies) 
 
.NOTES     
        Name       : Screenblanking User Settings
        Author     : Luke Gackle
        Version    : 1.0.0  
        DateCreated: 05-NOV-2025
	DateUpdated: 05-NOV-2025
#>
Start-Transcript -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\Detect-ScreenBlankingPolicy.ps1.log" -Force
$compliant = $true

# Check registry values
$regPath = "HKCU:\Control Panel\Desktop"
$expected = @{
    "ScreenSaveActive"    = "1"
    "ScreenSaverIsSecure" = "1"
    "ScreenSaveTimeOut"   = "120"
    "SCRNSAVE.EXE"        = "C:\WINDOWS\system32\scrnsave.scr"
}

foreach ($name in $expected.Keys) {
    $actual = (Get-ItemProperty -Path $regPath -Name $name -ErrorAction SilentlyContinue).$name
    if ($actual -ne $expected[$name]) {
        $compliant = $false
        Write-Output "Screensaver Settings not compliant"
    }
}

# Check power settings
$acTimeout = (powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE).Split("`n") | Where-Object { $_ -match "Power Setting Index" } | Select-Object -First 1
$dcTimeout = (powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE).Split("`n") | Where-Object { $_ -match "Power Setting Index" } | Select-Object -Last 1

if (($acTimeout -notmatch "0x0") -or ($dcTimeout -notmatch "0x0")) {
    $compliant = $false
    Write-Output "Power Policies not compliant"
}

if ($compliant) {
    Write-Output "Compliant"
    Stop-Transcript
    exit 0
} else {
    Write-Output "Non-compliant"
    Stop-Transcript
    exit 1
}
