$Files= Get-ChildItem %system.teamcity.build.tempDir% -Recurse -Filter *.dcvr | where-object {$_.length -gt 50} | Select-Object -ExpandProperty FullName 

$snapshot =[string]::Join(";",$Files) 

Write-Output "Discovered snapshots: $snapshot"
Write-Output "HTML Report path: %sonarqube.dotCoverHtmlReport%"

$dotCoverPath = "%teamcity.tool.JetBrains.dotCover.CommandLineTools.DEFAULT%\dotCover.exe"

Write-Output "dotCover Path: $dotCoverPath"

& $dotCoverPath merge /Source=$snapshot /Output=%env.TEMP%\dotCoverReport.dcvr
& $dotCoverPath report /Source=%env.TEMP%\dotCoverReport.dcvr /Output=%sonarqube.dotCoverHtmlReport% /ReportType=HTML