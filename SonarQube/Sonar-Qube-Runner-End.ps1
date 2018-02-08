$sonarQubeRunnerFolder = 'd:\sonar-qube-runner-test'

$sonarQubeToken = 'eb71436c5a7bef8a4237c827ac1f9d2a159f42e2'

Write-Output "Saving analysis results to SonarQube..."
$sonarQubeScannerPath = "$sonarQubeRunnerFolder\SonarQube.Scanner.MSBuild.exe"
Start-Process -FilePath $sonarQubeScannerPath -ArgumentList "end /d:sonar.login=`"$sonarQubeToken`""
Write-Output "Done..."