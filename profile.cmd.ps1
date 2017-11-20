# Copy command line environment variables to powershell environment

$EnvFilePath = $Env:CmdEnvFilePath
if ($EnvFilePath -eq $null) {
  # quit if no environment file is provided 
  return
}

# merge two paths
function Merge-Path($OldPath, $IncPath)
{
  $MergedPath = ($IncPath -split ";") + ($OldPath -split ';') `
  | Where-Object {$_.Trim().Length -gt 0} `
  | Select-Object -Unique

  $NewPath = $MergedPath -join ";"

  Write-Verbose "New Path:"
  Write-Verbose $NewPath

  return $NewPath
}

$TempFilePath = [System.IO.Path]::GetTempFileName()

Write-Host "Init environment with $($EnvFilePath)" -Foreground Blue
cmd /c "$EnvFilePath && set > $TempFilePath"

if (-not (Test-Path $TempFilePath)) {
  Write-Error "Cannot find expected temp file $TempFilePath" -Category InvalidData
  return
}

$lines = Get-Content $TempFilePath
Remove-Item -Force $TempFilePath

Write-Host "Importing $($lines.Count) environment variables" -Foreground Blue
foreach ($line in $lines) {
  $name, $value = $line -split '=', 2

  #Write-Host "Overwrite [$name] with $value"
  if ($name -eq "Path") {
    $OldPath = $env:Path
    $IncPath = $value
    $mergedPath = Merge-Path $OldPath $IncPath

    Set-Item -Path "Env:Path" -Value $mergedPath
  } else {
    
    Set-Item -Path "Env:$name" -Value $value
  }
}
