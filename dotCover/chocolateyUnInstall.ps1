$packageName = 'dotCover'

$url = 'http://download.jetbrains.com/resharper/ReSharperAndToolsPacked01.exe'

try {

  $scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $packagePath = $(Split-Path -parent $scriptPath)
  $installPath = Join-Path $packagePath 'ReSharperAndToolsPacked01.exe'

  Uninstall-ChocolateyPackage packageName 'exe' '/SpecificProductNames=dotCover /HostsToRemove=dotCover01;ReSharperPlatformVs10;ReSharperPlatformVs11;ReSharperPlatformVs12;ReSharperPlatformVs14 /Hive=* /ReSharper9PlusMsi=True' $installPath

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}
