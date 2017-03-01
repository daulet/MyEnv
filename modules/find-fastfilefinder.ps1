
$path = Join-Path (Get-Item $PsScriptRoot).Parent.FullName -ChildPath "bin/ff.exe"
return (Get-Item $path).FullName