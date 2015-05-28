try
{
	# Common Functions and Config
	. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Common.ps1')

	$installerType = 'EXE' 
	$url = "http://download.jetbrains.com/webstorm/WebStorm-10.0.3.exe" 
	$url64 = $url 
	$silentArgs = '/S' 
	$validExitCodes = @(0) 

	Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes

	Write-ChocolateySuccess $packageName

	}
catch
{
    Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw $_.Exception
}