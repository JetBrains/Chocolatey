$platformPackageName = 'ReSharperPlatform'
$platformPackageVersion = '1.0'
$packageName = 'dotTrace'

try {

  $scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $commonPath = $(Split-Path -parent $(Split-Path -parent $scriptPath))

  $installPath = Join-Path  (Join-Path $commonPath $platformPackageName'.'$platformPackageVersion) 'ReSharperAndToolsPacked01.exe'

  Start-ChocolateyProcessAsAdmin '/SpecificProductNames=dotTrace /Silent=True' $installPath

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}