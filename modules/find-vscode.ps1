. $PsScriptRoot\test-platform.ps1

if (Get-CurrentPlatform -eq [Platform]::Windows)
{
    return . $PsScriptRoot\find-vscode.windows.ps1
}
else    
{
    return . $PsScriptRoot\find-vscode.macos.ps1
}