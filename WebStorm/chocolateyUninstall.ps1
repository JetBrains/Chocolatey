try
{
	# Common Functions and Config
	. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Common.ps1')

	$extractionPath = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]

	$installDir = Join-Path $extractionPath 'JetBrains'

	$uninstallExe = (gci "${installDir}/${packageName} ${packageVersion}/bin/uninstall.exe").FullName | sort -Descending | Select -first 1
	
    $params = @{
        PackageName = $packageName;
		FileType = "exe";
		SilentArgs = "/S";
		File = $uninstallExe;
    }   

	Uninstall-ChocolateyPackage @params
	
	Write-ChocolateySuccess $packageName
}
catch
{
    Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw $_.Exception
}