$sonarQubeRunnerFolder = "d:\sonar-qube-runner-test"

if (Test-Path -Path $sonarQubeRunnerFolder) {
    Write-Output "Folder exists. No need to download SonarQube MSBuild runner."
    exit;
}

Write-Output "Folder $sonarQubeRunnerFolder doesn't exists. Creating folder..."

New-Item -ItemType Directory -Path $sonarQubeRunnerFolder | Out-Null

Write-Output "Resolving latest version of runner..."
$webRequestResult = Invoke-WebRequest -Uri https://api.github.com/repos/SonarSource/sonar-scanner-msbuild/releases -OutFile "sonar-qube-releases.json" -PassThru
$releasedVersion = ConvertFrom-Json -InputObject $webRequestResult.Content

$downloadUrl = $releasedVersion[0].zipball_url
$downloadedFilePath = ($sonarQubeRunnerFolder + '\sonarQubeRunner.zip')

Write-Output "Downloading runner from $downloadUrl to $downloadedFilePath ..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadedFilePath

Write-Output "Unpacking runner..."

