<# 
.SYNOPSIS 
Install Kyocera Printers on devices
 
.DESCRIPTION 
The script will copy the KX Drivers to C:\Temp and then install the drivers and add the defined printers 
 
.NOTES     
        Name       : Kyocera Printer Installation Script
        Author     : Luke Gackle
        Version    : 1.0.2  
        DateCreated: 18-DEC-2023
	DateUpdated: 08-APR-2025
		Install Command:	powershell.exe -Executionpolicy Bypass -File .\InstallPrinters.ps1
		Uninstall Command:	powershell.exe -Executionpolicy Bypass -File .\UninstallPrinters.ps1
		Detection File Rule:	C:\Windows\System32\DriverStore\FileRepository\oemsetup.inf_amd64_96185b818e1ee30c\OEMSETUP.INF
#>

Start-Transcript -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\InstallPrinters.log"
$testpath = Test-Path "C:\Temp\"
If ($testpath -eq $false) { New-Item "C:\Temp" -Type Directory }
Copy-Item -Path .\64bit -Destination C:\Temp\ -Recurse -Force
if (Test-path C:\Temp\64bit\OEMSETUP.INF)
{
    Start-Process "$ENV:SystemRoot\Sysnative\pnputil.exe" -ArgumentList '/add-driver "C:\Temp\64bit\OEMSETUP.INF"' -Wait -NoNewWindow
    Add-PrinterDriver -Name "Kyocera TASKalfa 4052ci KX" -InfPath "C:\Windows\System32\DriverStore\FileRepository\oemsetup.inf_amd64_96185b818e1ee30c\OEMSETUP.INF"


    Add-PrinterPort -Name "Site Office Port" -PrinterHostAddress 192.168.85.11

    Add-Printer -DriverName "Kyocera TASKalfa 4052ci KX" -Name "Site Office" -PortName "Site Office Port"
}

Stop-Transcript