# Setup common aliases

. .\modules\set-directory.ps1

$config = @{
    'c'     = (Get-Command Set-Directory).Name;
    'ff'    = .\modules\find-fastfilefinder.ps1;
    'sn'    = .\modules\find-notepad++.ps1;
    'vs'    = .\modules\find-vscode.ps1;
}
$config.GetEnumerator() | ForEach-Object {
    if ($_.Value) {
        Set-Alias -Scope Global $_.Key $_.Value;
    }
}
