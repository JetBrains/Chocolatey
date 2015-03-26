function Get-ChocolateyPackageTempFolder {
param(
  [string] $packageName
)
  $chocTempDir = Join-Path $env:TEMP "chocolatey"
  $tempDir = Join-Path $chocTempDir "$packageName"
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}
   
  return $tempDir;
}

function Set-ChocolateyPackageOptions {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,Position=1)]
        [hashtable] $options
    )
    $packageParameters = $env:chocolateyPackageParameters;

    if ($packageParameters) {
        $parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")
        $parameters.GetEnumerator() | % {
           $options[($_.Key)] = ($_.Value)
        }
    }
}