# Find installation path to Notepad++ based on registry key for uninstalling it
function Find-InstallationPath
{
    $matchingInstalls = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* `
        | Where-Object {$_.DisplayName -ne $null -and $_.DisplayName.StartsWith("Notepad++") } `
        | Select-Object DisplayName, DisplayIcon;
    
    if (@($matchingInstalls).Count -gt 0)
    {
        return ($matchingInstalls | Select-Object -First 1).DisplayIcon;
    }
    return $null;
}

$installationPath = Find-InstallationPath;
if ($installationPath -eq $null)
{
    if (.\test-chocolatey.ps1)
    {
        choco install notepadplusplus;

        $installationPath = Find-InstallationPath;
    }
}
return $installationPath;