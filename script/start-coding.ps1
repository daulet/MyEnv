# for Windows Store apps check out registry:
# HKEY_CLASSES_ROOT\Extensions\ContractId\Windows.Protocol\PackageId
$config =@(
    "wunderlist://",
    "$($ENV:LOCALAPPDATA)\gitkraken\app-3.0.0\gitkraken.exe",
    "$($ENV:LOCALAPPDATA)\hyper\Hyper.exe",
    "$($ENV:ProgramFiles)\Notepad++\notepad++.exe",
    "$($ENV:LOCALAPPDATA)\TogglDesktop\TogglDesktop.exe"
)

foreach($application in $config) {
     Start-Process $application
}
