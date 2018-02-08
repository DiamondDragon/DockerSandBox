$sonarQubeRunnerFolder = 'd:\sonar-qube-runner-test'

$sonarQubeToken = 'eb71436c5a7bef8a4237c827ac1f9d2a159f42e2'
$sonarQubeBuildNumber = '1.0'
$sonarQubeProjectKey = 'Intelliflo.PFP'
$sonarQubeServerUrl ='http://192.168.8.119:9000'
$sonarQubeFilesToExclude = '**/*.js,**/*.css,**/*.html,**/*.htm'

if (!(Test-Path -Path $sonarQubeRunnerFolder)) {
    Write-Output "Folder $sonarQubeRunnerFolder doesn't exists. Creating folder..."
    New-Item -ItemType Directory -Path $sonarQubeRunnerFolder | Out-Null
    
    Write-Output "Resolving latest version of runner..."
    $webRequestTempFile = "$sonarQubeRunnerFolder\sonar-qube-releases.json"
    $webRequestResult = Invoke-WebRequest -Uri https://api.github.com/repos/SonarSource/sonar-scanner-msbuild/releases -OutFile $webRequestTempFile -PassThru
    $releasedVersion = ConvertFrom-Json -InputObject $webRequestResult.Content
    $downloadUrl = $releasedVersion[0].assets[0].browser_download_url
    $downloadedFilePath = ($sonarQubeRunnerFolder + '\sonarQubeRunner.zip')
    Write-Output "Downloading runner from $downloadUrl to $downloadedFilePath ..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadedFilePath
    
    Write-Output "Unpacking runner..."
    Expand-Archive $downloadedFilePath -DestinationPath $sonarQubeRunnerFolder
    
    Write-Output "Cleaning up..."
    Remove-Item $downloadedFilePath -Force
    Remove-Item $webRequestTempFile -Force
}

Write-Output "Loading SonarQube rules..."
$sonarQubeScannerPath = "$sonarQubeRunnerFolder\SonarQube.Scanner.MSBuild.exe"
Write-Output "SonarQube Scanner Path: $sonarQubeScannerPath"
Start-Process -FilePath $sonarQubeScannerPath -ArgumentList "begin /k:`"$sonarQubeProjectKey`" /v:`"$sonarQubeBuildNumber`" /d:sonar.host.url=`"$sonarQubeServerUrl`" /d:sonar.login=`"$sonarQubeToken`" /d:sonar.exclusions=`"$sonarQubeFilesToExclude`""
Write-Output "Done..."