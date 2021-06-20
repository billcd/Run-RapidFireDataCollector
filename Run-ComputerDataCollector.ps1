
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$config = Get-Content -Path "$scriptPath\AppConfig.json" | ConvertFrom-Json

$appHome = $config.appHome
$dataCollectorHome = $config.dataCollectorHome


$dataCollectorCmd = "$dataCollectorHome\hipaacmdline.exe"
$scanConfigFile = "$appHome\NetworkDetectiveSettings-Computer.ndp"


# copy scan config file
Copy-Item "$scriptPath\NetworkDetectiveSettings-Computer.ndp" $scanConfigFile


# run the data collector
Invoke-Expression -Command "$dataCollectorCmd -file $scanConfigFile"
