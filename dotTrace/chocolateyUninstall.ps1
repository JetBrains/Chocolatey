$package = 'dotTrace'

try {
  # HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\
  $msiid = '{DBC020DC-C118-4E18-A5A7-40234850CCBA}'
  Uninstall-ChocolateyPackage $package 'MSI' -SilentArgs "$msIid /qb" -validExitCodes @(0,1603)

  # the following is all part of error handling
  Write-ChocolateySuccess $package¦
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}