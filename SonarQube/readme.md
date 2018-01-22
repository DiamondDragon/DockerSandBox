# Usage instructions

1. Start services using the following command `docker-compose -f docker-compose.yml -f docker-compose.override.yml up`
1. Connect to MS SQL Server `localhost:1477`
1. Create database named `SonarQubeDb` with collation `SQL_Latin1_General_CP1_CS_AS`
1. New database is detected by SonarQube

**NOTE:** **SonarQube** uses the following default credentials: `admin / admin`

The following command is used to start whole setup:
```
docker-compose -f docker-compose.yml -f docker-compose.override.yml config
```

# Creation of Roslyn-based plugins for Sonar

1. Update `docker-compose.yml` as follows: 
```
  sonarqube:
    volumes:
      - d:\_Tests\SonarExtensions:/opt/sonarqube/extensions
```
these changes required to discover pluging which are going to be created later.

**NOTE:** Sonar C# plugin must be installed too in order to make other Roslyn-based plugings work.

2. Download latest version of **SonarQube Roslyn SDK** [here](https://github.com/SonarSource/sonarqube-roslyn-sdk/releases)
1. Detailed instructions can be found [here](https://github.com/SonarSource/sonarqube-roslyn-sdk) 
1. Once pluin is created it must be copied to `d:\_Tests\SonarExtensions\plugins` folder. Please note that this folder must not be available. 
1. Once SonarQube is restarted new pluging is going to be available among installed plugins.

**NOTE:** The following [ticket](https://jira.sonarsource.com/browse/SFSRAP-45) contains workaround for plugins which require Roslyn 1.2 (at the moment Roslyn 1.0 and 1.1 are supported by SDK).

# Sonar Scaner for MSBuild

1. Get latest version of scanner [here](https://github.com/SonarSource/sonar-scanner-msbuild/releases)
1. Installation instructions can be found [here](https://docs.sonarqube.org/display/SCAN/Scanning+on+Windows)


Example of analysis execution commands:

```
SonarQube.Scanner.MSBuild.exe begin /k:"Intelliflo.PFP" /v:"1.0" /d:sonar.host.url="http://192.168.8.119:9000" /d:sonar.login="eb71436c5a7bef8a4237c827ac1f9d2a159f42e2" /d:sonar.exclusions="**/*.js,**/*.css,**/*.html,**/*.htm"

"c:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\MSBuild.exe" Intelliflo.PersonalFinancePortal.sln /t:Rebuild

SonarQube.Scanner.MSBuild.exe end /d:sonar.login="eb71436c5a7bef8a4237c827ac1f9d2a159f42e2"
```

# Team City configuration
The following steps must be performed to configure TeamCity
1. Create MS SQL Database using `Latin1_General_100_CI_AS` collation
2. Add JDBC driver for MS Server. It can be downloaded [here](https://www.microsoft.com/en-us/download/details.aspx?id=55539).
3. Copy content of driver to container. Use command similar to this:
```
docker container cp d:\_Downloads\sqljdbc_6.2\enu\. 90471ebcddd4:/data/teamcity_server/datadir/lib/jdbc
```
You can verify correctness of operation using the following command
```
docker container exec 90471ebcddd4 ls /data/teamcity_server/datadir/lib/jdbc
```
4. Refresh Team City page, follow instructions
5. Define password `admin:admin`