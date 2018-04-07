function prompt {
    "$(Get-Date -Format HH:mm:ss) $pwd> "
}

Start-SshAgent -Quiet
