# install if necessary
if (-Not (Get-Command nuget.exe -errorAction SilentlyContinue))
{
    if (-Not (. $PsScriptRoot\test-chocolatey.ps1))
    {
        return $null
    }

    choco install nuget.commandline --confirm;
}
return "nuget.exe"
