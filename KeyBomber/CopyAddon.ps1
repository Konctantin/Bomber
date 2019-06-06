$WOW_BOMBER="C:\Games\World of Warcraft\_retail_\Interface\AddOns\Bomber"
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Remove-Item -LiteralPath $WOW_BOMBER -Force -Recurse

Copy-Item -Path $scriptPath\Bomber -Filter "*.*" -Recurse -Destination $WOW_BOMBER -Container