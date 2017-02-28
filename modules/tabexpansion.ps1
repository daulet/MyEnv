if (Test-Path Function:\TabExpansion) {
    if (Test-Path Function:\MyEnvTabExpansionBackup) {
        Remove-Item Function:\MyEnvTabExpansionBackup
    }
    Rename-Item Function:\TabExpansion MyEnvTabExpansionBackup
}

$expandable_commands = "c", "cd", "sn", "vs"

# FF is a Fast File Finder. Source: https://github.com/Wintellect/FastFileFinder

function TabExpansion($line, $lastWord) {
    $words = $line.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)

    if ($expandable_commands -contains $words[0]) {
        $ff = Join-Path $PsScriptRoot "ff.exe"
        $paths = & $ff $words[-1] -nostats
        return $paths
    }
    else {
        if (Test-Path Function:\MyEnvTabExpansionBackup) {
            MyEnvTabExpansionBackup $line $lastWord
        }
    }
}