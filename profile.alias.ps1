# Setup aliases
$config = @{
    'sn' = .\modules\find-notepad++.ps1;
    'vs' = .\modules\find-vscode.ps1;
}

function Add-Alias($alias, $path)
{
    if (($path -ne $null) -and (Test-Path $path))
    {
        Set-Alias -Scope Global $alias $path;
    }
    else
    {
        Write-Warning "Path for alias $alias doesn't exist: $path";
    }
}

$config.GetEnumerator() | % { Add-Alias $_.Key $_.Value }
