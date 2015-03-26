$options = @{
  version = '9.0.3';
  unzipLocation = 'C:\';
  runAsSystem = $true;
  userName = '';
  domain = '';
  password = '';
}

$packageParameters = @{
  packageName = 'teamcity-server';
  url = "http://download.jetbrains.com/teamcity/TeamCity-$($options['version']).tar.gz";
  url64bit = '';
  checksum = '';
  checksumType = '';
  checksum64 = '';
  checksumType64 = '';
}

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\ChocolateyHelpers.ps1"

Set-ChocolateyPackageOptions $options
if ($options['userName'] -ne '' -and $options['password'] -ne '') {
  $options['runAsSystem'] = $false;
}

$service = Get-Service | ? Name -eq $options['serviceName']
if ($service -ne $null) {
  Stop-Service $service
}

$binPath = Join-Path $options['unzipLocation'] 'TeamCity\bin'
if ((Test-Path $binPath) -and ($service -ne $null)) {

  Push-Location $binPath
  Start-ChocolateyProcessAsAdmin '.\teamcity-server.bat service delete'
  Pop-Location
}

$tempFolder = Get-ChocolateyPackageTempFolder $packageParameters['packageName']
$downloadFile = Join-Path $tempFolder "TeamCity-$($options['version']).tar.gz"
$tarFile = Join-Path $tempFolder "TeamCity-$($options['version']).tar"
Get-ChocolateyWebFile @packageParameters -FileFullPath $downloadFile
Get-ChocolateyUnzip -FileFullPath $downloadFile -Destination $tempFolder
Get-ChocolateyUnzip -FileFullPath $tarFile -Destination $options['unzipLocation']

Push-Location $binPath
$args = New-Object System.Collections.ArrayList

$args.Add('service') | Out-Null
$args.Add('install') | Out-Null

if ($options['runAsSystem']) {
  $args.Add('/runAsSystem') | Out-Null
}
else {
  $args.Add("/user=`"($options['userName'])`"") | Out-Null
  $args.Add("/password=`"($options['password'])`"") | Out-Null
  if ($options['domain'] -ne '')
  {
    $args.Add("/domain=`"($options['domain'])`"") | Out-Null
  }
}
$joined = $args -join ' '
Write-Host ".\teamcity-server.bat $joined"
Start-ChocolateyProcessAsAdmin ".\teamcity-server.bat $joined"
Pop-Location

$options['password'] = '';
Export-CliXml -Path (Join-Path $PSScriptRoot 'options.xml') -InputObject $options

Remove-Item $tarFile