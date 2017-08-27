# Latest VS Code defaults to x64 flavor
$installationPath = "${env:ProgramFiles}\Microsoft VS Code\Code.exe";

if (Test-Path $installationPath) {
    return $installationPath;
}
return $null;
