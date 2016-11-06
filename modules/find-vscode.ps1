$installationPath = "${env:ProgramFiles(x86)}\Microsoft VS Code\Code.exe";

# install if necessary
if (-Not (Test-Path $installationPath))
{
    choco upgrade visualstudiocode;
}

return $installationPath;