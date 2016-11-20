Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git
}

# Load posh-git module from default location
Import-Module posh-git

function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    $GitPromptSettings.BeforeText = " ["
    $GitPromptSettings.AfterText = "] `n"
    
    Write-Host "$(Get-Date -Format HH:MM:ss) $pwd" -NoNewline
    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}

Pop-Location

Start-SshAgent -Quiet
