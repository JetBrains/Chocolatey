$platformPackageName = 'resharper-platform'
$platformPackageVersion = '1.0.1'
$packageName = 'dotMemory'

try {
  $scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $commonPath = $(Split-Path -parent $(Split-Path -parent $scriptPath))

  $installPath = Join-Path  (Join-Path $commonPath $platformPackageName'.'$platformPackageVersion) 'ReSharperAndToolsPacked01Update1.exe'

  Uninstall-ChocolateyPackage packageName 'exe' '/SpecificProductNames=dotMemory /HostsToRemove=dotMemory01;ReSharperPlatformVs10;ReSharperPlatformVs11;ReSharperPlatformVs12;ReSharperPlatformVs14 /Hive=* /ReSharper9PlusMsi=True' $installPath

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}
