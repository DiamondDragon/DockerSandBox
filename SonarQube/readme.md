# Usage instructions

1. Start services using the following command `docker-compose -f docker-compose.yml -f docker-compose.override.yml up`
1. Connect to MS SQL Server `localhost:1477`
1. Create database named `SonarQubeDb` with collation `SQL_Latin1_General_CP1_CS_AS`
1. Shutdown services `docker-compose -f docker-compose.yml -f docker-compose.override.yml down`
1. Start them again `docker-compose -f docker-compose.yml -f docker-compose.override.yml up`

**NOTE:** **SonarQube** uses the following default credentials: `admin / admin`

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
