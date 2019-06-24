$WOW_INSTALL_KEY = "HKLM:\SOFTWARE\WOW6432Node\Blizzard Entertainment\World of Warcraft"
$WOW_DIR = (Get-ItemProperty -Path $WOW_INSTALL_KEY -Name "InstallPath").InstallPath
$WOW_DIR = (Get-Item $WOW_DIR).Parent.FullName
$WOW_BOMBER=Join-Path -Path $WOW_DIR -ChildPath "_retail_\Interface\AddOns\Bomber"

Write-Output $WOW_BOMBER

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Write-Output "Cleanup addon path: $WOW_BOMBER"
Remove-Item -LiteralPath $WOW_BOMBER -Force -Recurse

Write-Output "Copy addon from $scriptPath\Bomper to $WOW_BOMBER"
Copy-Item -Path $scriptPath\Bomber -Filter "*.*" -Recurse -Destination $WOW_BOMBER -Container