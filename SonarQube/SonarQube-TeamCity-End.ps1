$sonarQubeRunnerFolder = '%sonarqube.runnerpath%'
$sonarQubeToken = '%sonarqube.token%'

Write-Output "Saving analysis results to SonarQube..."
$sonarQubeScannerPath = "$sonarQubeRunnerFolder\SonarQube.Scanner.MSBuild.exe"
Write-Output "SonarQube Scanner Path: $sonarQubeScannerPath"
$argumentList= "end /d:sonar.login=`"$sonarQubeToken`""
Write-Output "SonarQube Arguments: $argumentList"
Invoke-Expression -Command "$sonarQubeScannerPath $argumentList"
Write-Output "Done..."