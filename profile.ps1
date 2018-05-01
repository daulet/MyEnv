Push-Location $PsScriptRoot

# Setup aliases
. .\profile.alias.ps1

# Setup prompt
. .\profile.prompt.ps1

# Enable bash style completion
Set-PSReadLineKeyHandler -Key Tab -Function Complete

Pop-Location
				