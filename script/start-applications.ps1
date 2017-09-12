param(
    [string]$configPath
)

$locations = @{
    "appdata" = $env:APPDATA
    "localappdata" = $env:LOCALAPPDATA
    "programfiles" = $env:ProgramFiles
}

$config = Get-Content $configPath | ConvertFrom-Json
foreach($application in $config.applications) {

    $filePath = $application.filePath
    if ($application.root) {
        $rootPath = $locations[$application.root]
        $filePath = "$rootPath\$filePath"
    }

    Write-Host $filePath

    if ($application.argumentList) {
        Start-Process -FilePath $filePath -ArgumentList $application.argumentList
    }
    else {
        Start-Process -FilePath $filePath
    }
}
