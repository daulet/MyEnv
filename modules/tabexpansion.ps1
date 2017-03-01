param ([string[]]$expansionPrefixes)

if (Test-Path Function:\TabExpansion) {
    if (Test-Path Function:\MyEnvTabExpansionBackup) {
        Remove-Item Function:\MyEnvTabExpansionBackup
    }
    Rename-Item Function:\TabExpansion MyEnvTabExpansionBackup
}

# FF is a Fast File Finder. Source: https://github.com/Wintellect/FastFileFinder

function TabExpansion($line, $lastWord) {
    $words = $line.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)

    if ($expansionPrefixes -contains $words[0]) {
        $ff = . $PsScriptRoot\find-fastfilefinder.ps1
        $paths = & $ff $words[-1] -nostats
        return $paths
    }
    else {
        if (Test-Path Function:\MyEnvTabExpansionBackup) {
            MyEnvTabExpansionBackup $line $lastWord
        }
    }
}