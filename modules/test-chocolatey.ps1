if (Get-Command choco -errorAction SilentlyContinue)
{
    return $true;
}
else
{
    # More info: https://chocolatey.org/install

    # installation requires admin rights to install
    If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {
        # installation requires at least RemoteSigned execution policy
        Set-ExecutionPolicy RemoteSigned

        iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

        return $true;
    }
    else
    {
        Write-Error "Can't install chocolatey. Retry in administrator mode";
    }
}

return $false;
