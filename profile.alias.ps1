# Setup alias for Set-Directory command
. .\modules\set-directory.ps1
Set-Alias -Scope Global 'c' (Get-Command Set-Directory).Name

# Setup aliases for common paths
. .\modules\set-pathalias.ps1
$config = @{
    'ff'    = .\modules\find-fastfilefinder.ps1;
    'nuget' = .\modules\find-nuget.ps1;
    'sn'    = .\modules\find-notepad++.ps1;
    'vs'    = .\modules\find-vscode.ps1;
}
$config.GetEnumerator() | ForEach-Object { Set-PathAlias $_.Key $_.Value }
