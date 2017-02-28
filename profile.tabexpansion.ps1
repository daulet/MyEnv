Push-Location $PsScriptRoot

$expandable_prefixes = "c", "cd", "devenv", "sn", "vs"

. .\modules\tabexpansion.ps1 $expandable_prefixes

Pop-Location