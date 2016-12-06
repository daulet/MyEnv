# VS Code only has x86 flavor
$installationPath = "${env:ProgramFiles(x86)}\Microsoft VS Code\Code.exe";

# install if necessary
if (-Not (Test-Path $installationPath))
{
    if (. $PsScriptRoot\test-chocolatey.ps1)
    {
        choco install visualstudiocode;
    }
}

if (Test-Path $installationPath)
{
    return $installationPath;
}
else
{
    return $null;
}