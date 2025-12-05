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

Start-Transcript -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\Remediate-ScreenBlankingPolicy.ps1.log" -Force

# Set registry values
$regPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $regPath -Name "ScreenSaveActive" -Value "1"
Set-ItemProperty -Path $regPath -Name "ScreenSaverIsSecure" -Value "1"
Set-ItemProperty -Path $regPath -Name "ScreenSaveTimeOut" -Value "120"
Set-ItemProperty -Path $regPath -Name "SCRNSAVE.EXE" -Value "C:\WINDOWS\system32\scrnsave.scr"

# Set power settings
#Group policy override settings exist for this power scheme or power setting.
#Including these to cover all bases but should already be covered by the configuration policy

powercfg -Change -monitor-timeout-dc 0
powercfg -Change -monitor-timeout-ac 0

Stop-Transcript