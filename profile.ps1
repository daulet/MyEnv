Push-Location $PsScriptRoot

# Setup aliases
. .\profile.alias.ps1

# Setup command line environment
.\profile.cmd.ps1

# Setup posh-git profile
.\profile.posh-git.ps1

# Setup tab expansion
. .\profile.tabexpansion.ps1

Pop-Location
