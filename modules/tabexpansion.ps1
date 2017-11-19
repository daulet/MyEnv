param (
    [string[]]$expansionPrefixes)

if (Test-Path Function:\TabExpansion) {
    if (Test-Path Function:\initTabExpansionBackup) {
        Remove-Item Function:\initTabExpansionBackup
    }
    Rename-Item Function:\TabExpansion initTabExpansionBackup
}

# FF is a Fast File Finder. Source: https://github.com/daulet/FastFileFinder

function TabExpansion($line, $lastWord) {
    $matchInCurrentDir = $False

    $words = $line.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)

    # Test current directory before kicking off potentially expensive recursive search
    # TODO expansion should match path, not name, in case of cd-ing with multiple dirs typed out already
    $currentDir = Get-ChildItem
    $prefix = $words[-1].ToLower()
    foreach ($file in $currentDir) {
        if ($file.Name.ToLower().StartsWith($prefix)) {
            $matchInCurrentDir = $True
            break
        }
    }

    if (-Not $matchInCurrentDir -And ($expansionPrefixes -contains $words[0])) {
        $ff = . $PsScriptRoot\find-fastfilefinder.ps1
        $paths = & $ff -includedir -nostats $words[-1]
        return $paths
    }
    else {
        if (Test-Path Function:\initTabExpansionBackup) {
            initTabExpansionBackup $line $lastWord
        }
    }
}
