. $PsScriptRoot\test-platform.ps1

if (Get-CurrentPlatform -eq [Platform]::Windows)
{
    return . $PsScriptRoot\find-notepad++.windows.ps1
}
else    
{
    Write-Host "Notepad++ is not supported on this platform"
    return $null
}