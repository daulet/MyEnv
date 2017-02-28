# set alias to the path if it exists

function Set-PathAlias($alias, [string]$path)
{
    if (($path) -and (Test-Path $path))
    {
        Set-Alias -Scope Global $alias $path;
    }
}