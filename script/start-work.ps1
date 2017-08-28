# for Windows Store apps check out registry:
# HKEY_CLASSES_ROOT\Extensions\ContractId\Windows.Protocol\PackageId
$config =@(
    "lync",
    "ms-todo://",
    "outlook",
    "$($ENV:APPDATA)\Microsoft\Windows\Start Menu\Programs\Microsoft\reSearch.appref-ms",
    "$($ENV:LOCALAPPDATA)\Microsoft\Teams\current\Teams.exe",
    "$($ENV:LOCALAPPDATA)\TogglDesktop\TogglDesktop.exe"
)

foreach($application in $config) {
     Start-Process $application
}
