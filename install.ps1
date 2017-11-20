#Requires -RunAsAdministrator

param(
    [string]$configPath
)

# Install choco

if (-Not (Get-Command choco -errorAction SilentlyContinue)) {
    # More info: https://chocolatey.org/install

    # installation requires at least RemoteSigned execution policy
    Set-ExecutionPolicy RemoteSigned

    iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
}

# Install choco packages

if (-Not [string]::IsNullOrEmpty($configPath)) {
    $config = Get-Content $configPath | ConvertFrom-Json
    foreach($package in $config.packages) {
        choco install $package.name --params="$($package.params)" --limit-output --confirm
    }
}

# Add environment variable for this repo's location

Write-Output 'Ensuring init commands are on the path'
$initInstallVariableName = "initInstall"
$initPath = [Environment]::GetEnvironmentVariable($initInstallVariableName)
if ($initPath -eq $null -or $initPath -eq '') {
    Write-Debug "Setting $initInstallVariableName to $PSScriptRoot"
    [Environment]::SetEnvironmentVariable($initInstallVariableName, $PSScriptRoot, "Machine")
}

# Create Powershell profile if needed

$profileFile = "$PROFILE"
if (-Not (Test-Path $profileFile)) {
    New-item -type file -force $profileFile
}

# Ensure latest version of the profile is installed

$version = "v1"

$profileInstall =
"# Load profiles from init: https://github.com/daulet/init $version`n" + @'
$initProfile = "$env:initInstall\profile.ps1"
if (Test-Path($initProfile)) {
    Import-Module "$initProfile"
}
'@

$versions = Select-String -Path $profileFile -Pattern "https://github.com/daulet/init (\w+)"
if ($versions.Matches.Count -gt 0 -and $versions.Matches[-1].Groups[1].Value -eq $version) {
    Write-Debug "init profile is already installed."
}
else {
    Write-Output 'Adding init to the profile.'
    . .\modules\get-fileencoding.ps1
    $profileInstall | Out-File $profileFile -Append -Encoding (Get-FileEncoding $profileFile)
    Write-Warning 'init profile installed. Reload your profile - type . $profile'
}

# Install posh-git

Install-Module posh-git -Scope CurrentUser

# Add script shortcuts to start menu

$startMenuTarget = "$($ENV:APPDATA)\Microsoft\Windows\Start Menu\Programs\initScripts"
if (-Not (Test-Path($startMenuTarget)))
{
    New-Item -type directory $startMenuTarget
}

$shell = New-Object -ComObject ("WScript.Shell")
$scripts = Get-ChildItem "$PsScriptRoot\startup"
foreach ($script in $scripts) {
    $shortCut = $shell.CreateShortcut("$startMenuTarget\$($script.Name).lnk")
    $shortCut.TargetPath = $script.FullName
    $shortCut.Save()
}

