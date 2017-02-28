# Setup aliases
$config = @{
    'sn' = .\modules\find-notepad++.ps1;
    'vs' = .\modules\find-vscode.ps1;
}

function Add-Alias($alias, [string]$path)
{
    if (($path) -and (Test-Path $path))
    {
        Set-Alias -Scope Global $alias $path;
    }
}

$config.GetEnumerator() | ForEach-Object { Add-Alias $_.Key $_.Value }
