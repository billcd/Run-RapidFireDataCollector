$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$config = Get-Content -Path "$scriptPath\AppConfig.json" | ConvertFrom-Json


$appHome = $config.appHome

$dataCollectorURL = "https://s3.amazonaws.com/networkdetective/download/HIPAADataCollector.exe"
$dataCollectorZip = "$appHome\HIPAADataCollector.exe"
$dataCollectorFolder = $config.dataCollectorHome

$7zDll = "https://mflitautomate.blob.core.windows.net/tools/7z.dll"
$7zExe = "https://mflitautomate.blob.core.windows.net/tools/7z.exe"


if(!(Test-Path -Path "$appHome")){
    New-Item -ItemType directory -Path "$appHome"
}


# Download the parts
Invoke-WebRequest -Uri $7zDll -OutFile "$appHome\7z.dll"
Invoke-WebRequest -Uri $7zExe -OutFile "$appHome\7z.exe"
Invoke-WebRequest -Uri "$dataCollectorURL" -OutFile "$dataCollectorZip"

# Unzip the collector
Invoke-Expression "$appHome\7z.exe e `"$dataCollectorZip`" -o`"$dataCollectorFolder`" -aos"
