#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'WebStorm' # arbitrary name for the package, used in messages
$installerType = 'EXE' #only one of these two: exe or msi
$url = 'http://download.jetbrains.com/webstorm/WebStorm-9.0.2.exe' # download url
$url64 = $url # 64bit URL here or just use the same as $url
$silentArgs = '/S' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
