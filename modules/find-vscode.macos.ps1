$installationPath = "/Applications/Visual Studio Code.app";

# install if necessary
if (-Not (Test-Path $installationPath))
{
    if (.\test-homebrew.ps1)
    {
        brew cask install visual-studio-code
    }
}

if (Test-Path $installationPath)
{
    return "open -a 'visual studio code'";
}
else
{
    return $null;
}