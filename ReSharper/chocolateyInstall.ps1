$platformPackageName = 'resharper-platform'
$platformPackageVersion = '1.0.1'
$packageName = 'ReSharper'

try {

  $scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $commonPath = $(Split-Path -parent $(Split-Path -parent $scriptPath))

  $installPath = Join-Path  (Join-Path $commonPath $platformPackageName'.'$platformPackageVersion) 'ReSharperAndToolsPacked01Update1.exe'

  Start-ChocolateyProcessAsAdmin '/SpecificProductNames=ReSharper /Silent=True' $installPath

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}