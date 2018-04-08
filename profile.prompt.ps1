function prompt {
    "$pwd`r`n$(Get-Date -Format HH:mm:ss) > "
}

Start-SshAgent -Quiet
