Push-Location $PsScriptRoot

# Setup tab expansion for file search
. .\modules\tabexpansion.ps1

# Load aliases
.\profile.alias.ps1

# Load command line environment
.\profile.cmd.ps1

# Load posh-git profile
.\profile.posh-git.ps1

Pop-Location
