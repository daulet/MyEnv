if (-Not (Get-Module -ListAvailable -Name ZLocation)) {
    Install-Module ZLocation -Scope CurrentUser
}

# Load ZLocation module from default location
Import-Module ZLocation