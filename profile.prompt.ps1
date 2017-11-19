if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Write-Debug "posh-git module is not installed, not modifying the prompt"
    return
}

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from default location
Import-Module posh-git

$GitPromptSettings.BeforeText = '['
$GitPromptSettings.AfterText = '] '

function global:prompt {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $origLastExitCode = $LASTEXITCODE

    Write-VcsStatus

    $maxPathLength = 40
    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.Length -gt $maxPathLength) {
        $curPath = '...' + $curPath.SubString($curPath.Length - $maxPathLength + 3)
    }
    Write-Host $curPath -ForegroundColor Cyan

    "[$([Math]::Round($stopwatch.Elapsed.TotalMilliseconds)) ms] $(Get-Date -Format HH:mm:ss)$('>' * ($nestedPromptLevel + 1)) "

    $LASTEXITCODE = $origLastExitCode
    $stopwatch.Stop()
}

Pop-Location

Start-SshAgent -Quiet
