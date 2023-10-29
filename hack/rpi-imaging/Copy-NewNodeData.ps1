param(
  [Parameter(Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string] $HostName,

  [Parameter(Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string] $IPAddress
)

$ErrorActionPreference = "Stop"

$CloudInitDrive = $(Get-Volume -FileSystemLabel "CIDATA").DriveLetter

$NetworkData = (Get-Content "$PSScriptRoot\network-config.yml").Replace('{{address}}', $IPAddress)
$UserData = (Get-Content "$PSScriptRoot\user-data.yml").Replace('{{hostname}}', $HostName)

$UserData | Out-File -Path "$($Drive):\user-data" -Verbose
$NetworkData | Out-File -Path "$($Drive):\network-config" -Verbose
