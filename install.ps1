Write-Output 'Ensuring MyEnv commands are on the path'
$myEnvInstallVariableName = "MyEnvInstall"
$myEnvPath = [Environment]::GetEnvironmentVariable($myEnvInstallVariableName)
if ($myEnvPath -eq $null -or $myEnvPath -eq '') {
  Write-Output "Setting $myEnvInstallVariableName to $PSScriptRoot"
  [Environment]::SetEnvironmentVariable($myEnvInstallVariableName, $PSScriptRoot, "Machine")
}