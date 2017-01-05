Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git
}

# Load posh-git module from default location
Import-Module posh-git

$GitPromptSettings.BeforeText = '['
$GitPromptSettings.AfterText = '] '

function global:prompt {
    $origLastExitCode = $LASTEXITCODE
    Write-VcsStatus

    $maxPathLength = 40
    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.Length -gt $maxPathLength) {
        $curPath = '...' + $curPath.SubString($curPath.Length - $maxPathLength + 3)
    }
    Write-Host $curPath -ForegroundColor Green

    $LASTEXITCODE = $origLastExitCode
    "$(Get-Date -Format HH:MM:ss)$('>' * ($nestedPromptLevel + 1)) "
}

Pop-Location

Start-SshAgent -Quiet
