$sonarQubeRunnerFolder = "d:\sonar-qube-runner-test"

if (Test-Path -Path $sonarQubeRunnerFolder) {
    Write-Output "Folder exists. No need to download SonarQube MSBuild runner."
    exit;
}

Write-Output "Folder $sonarQubeRunnerFolder doesn't exists. Creating folder..."
New-Item -ItemType Directory -Path $sonarQubeRunnerFolder | Out-Null

Write-Output "Resolving latest version of runner..."
$webRequestTempFile = "$sonarQubeRunnerFolder\sonar-qube-releases.json"
$webRequestResult = Invoke-WebRequest -Uri https://api.github.com/repos/SonarSource/sonar-scanner-msbuild/releases -OutFile $webRequestTempFile -PassThru
$releasedVersion = ConvertFrom-Json -InputObject $webRequestResult.Content

Write-Output "Downloading runner from $downloadUrl to $downloadedFilePath ..."
$downloadUrl = $releasedVersion[0].assets[0].browser_download_url
$downloadedFilePath = ($sonarQubeRunnerFolder + '\sonarQubeRunner.zip')
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadedFilePath

Write-Output "Unpacking runner..."
Expand-Archive $downloadedFilePath -DestinationPath $sonarQubeRunnerFolder

Write-Output "Cleaning up..."
Remove-Item $downloadedFilePath -Force
Remove-Item $webRequestTempFile -Force

Write-Output "Done."

