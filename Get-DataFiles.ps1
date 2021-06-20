
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$config = Get-Content -Path "$scriptPath\AppConfig.json" | ConvertFrom-Json

if(!(Test-Path -Path $config.dataHome)){
    New-Item -ItemType directory -Path $config.dataHome
}


ForEach($df in $config.dataFileTypes){
    ForEach($file in Get-ChildItem -Path $config.dataCollectorHome -Filter "*.$df"){
        $d = $config.dataHome
        Copy-Item $file.FullName "$d\$file"
    }
}
