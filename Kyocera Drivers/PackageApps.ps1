$cd = Get-Location
Write-Host $cd
$filenameToPackage = "InstallPrinters.ps1"
$packagingArgs = "-c `"$cd\source`" -s `"$filenameToPackage`" -o `"$cd\output`""
if(Test-Path "$cd\source\$filenameToPackage"){
    Start-Process -NoNewWindow -FilePath "$cd\IntuneWinAppUtil.exe" -ArgumentList $packagingArgs -Wait
    Read-Host -Prompt "Press Enter to Exit"
}
else{
Write-Host "Error: Path not found"
Read-Host -Prompt "Press Enter to Exit"
}