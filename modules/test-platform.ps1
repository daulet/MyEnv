enum Platform
{
    macOS = 0
    Windows = 1
}

function Get-CurrentPlatform
{
    if ((Get-WmiObject -Class Win32_OperatingSystem | Select-Object -First 1).Caption -like '*Windows*')
    {
        return [Platform]::Windows;
    }
    else
    {
        return [Platform]::macOS;
    }
}
