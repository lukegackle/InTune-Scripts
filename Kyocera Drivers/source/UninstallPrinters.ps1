<# 
.SYNOPSIS 
Install Kyocera Printers on devices
 
.DESCRIPTION 
The script will copy the KX Drivers to C:\Temp and then install the drivers and add the defined printers 
 
.NOTES     
        Name       : Kyocera Printer Installation Script
        Author     : Luke Gackle
        Version    : 1.0.0  
        DateCreated: 15-DEC-2023
	DateUpdated: 08-APR-2025
#>
Start-Transcript -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\UninstallPrinters.log"


    Remove-Printer -Name "Site Office"
    
    Remove-PrinterPort -Name "Site Office Port"
    
    Remove-PrinterDriver -Name "Kyocera TASKalfa 4052ci KX"
    
    Start-Process "$ENV:SystemRoot\Sysnative\pnputil.exe" -ArgumentList '/delete-driver "C:\Windows\System32\DriverStore\FileRepository\oemsetup.inf_amd64_96185b818e1ee30c\OEMSETUP.INF" /uninstall /force' -Wait -NoNewWindow
        
    Remove-Item -Path C:\Temp\64bit -Recurse

Stop-Transcript