try {

  Install-ChocolateyPackage 'dotTrace' 'msi' '/passive /qn' 'http://download-ln.jetbrains.com/dottrace/dotTraceSetup.5.5.3.554.msi'

} catch {

  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw

}