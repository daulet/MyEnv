#Requires -RunAsAdministrator

# Adapted from http://www.west-wind.com/Weblog/posts/197245.aspx
function Get-FileEncoding($Path) {
    $bytes = [byte[]](Get-Content $Path -Encoding byte -ReadCount 4 -TotalCount 4)

    if(!$bytes) { return 'utf8' }

    switch -regex ('{0:x2}{1:x2}{2:x2}{3:x2}' -f $bytes[0],$bytes[1],$bytes[2],$bytes[3]) {
        '^efbbbf'   { return 'utf8' }
        '^2b2f76'   { return 'utf7' }
        '^fffe'     { return 'unicode' }
        '^feff'     { return 'bigendianunicode' }
        '^0000feff' { return 'utf32' }
        default     { return 'ascii' }
    }
}

Write-Output 'Ensuring MyEnv commands are on the path'
$myEnvInstallVariableName = "MyEnvInstall"

$myEnvPath = [Environment]::GetEnvironmentVariable($myEnvInstallVariableName)
if ($myEnvPath -eq $null -or $myEnvPath -eq '') {
  Write-Debug "Setting $myEnvInstallVariableName to $PSScriptRoot"
  [Environment]::SetEnvironmentVariable($myEnvInstallVariableName, $PSScriptRoot, "Machine")
}

# value appears in $profileInstall
$myEnvProfileSearch = '$MyEnvProfile'
$profileInstall = @'
# Load profiles from MyEnv
$MyEnvProfile = "$env:MyEnvInstall\profile.ps1"
if (Test-Path($MyEnvProfile)) {
  Import-Module "$MyEnvProfile"
}
'@

$profileFile = "$PROFILE"
if(Select-String -Path $profileFile -Pattern $myEnvProfileSearch -Quiet -SimpleMatch) {
    Write-Debug "MyEnv profile is already installed."
}
else {
    Write-Output 'Adding MyEnv to the profile.'
    $profileInstall | Out-File $profileFile -Append -Encoding (Get-FileEncoding $profileFile)
    Write-Warning 'MyEnv profile installed. Reload your profile - type . $profile'
}
