$packageName = 'dotPeek'
$url = 'http://download-ln.jetbrains.com/dotpeek/dotPeekSetup-1.1.1.33.msi'


Install-ChocolateyPackage $packageName "msi" "/q" $url
