enum Platform
{
    macOS = 0
    Windows = 1   
}

function Get-CurrentPlatform
{
    # based on "ver" command of cmd.exe
    if (Get-Command ver -errorAction SilentlyContinue)
    {
        return [Platform]::Windows;
    }
    else
    {
        return [Platform]::macOS;
    }
}