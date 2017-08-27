# navigate to the parent directory of the file

function Set-Directory($path) {
    if (Test-Path $path -PathType Container) {
        Set-Location $path
    }
    else {
        Set-Location (Split-Path $path -Parent)
    }
}
