if (-Not (Get-Command choco -errorAction SilentlyContinue))
{
    # More info: https://chocolatey.org/install

    # installation requires admin rights to install
    if ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
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