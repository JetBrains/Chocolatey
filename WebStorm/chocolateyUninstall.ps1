$extractionPath = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]

$installDir = Join-Path $extractionPath 'JetBrains'

$uninstallExe = (gci "${installDir}/WebStorm 11.0/bin/uninstall.exe").FullName | sort -Descending | Select -first 1

$params = @{
	PackageName = $packageName;
	FileType = "exe";
	SilentArgs = "/S";
	File = $uninstallExe;
}   

Uninstall-ChocolateyPackage @params