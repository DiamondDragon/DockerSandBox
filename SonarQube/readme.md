# Usage instructions

1. Start services using the following command `docker-compose -f docker-compose.yml -f docker-compose.override.yml up`
2. Connect to MS SQL Server `localhost:1477`
3. Create database named `SonarQubeDb` with collation `SQL_Latin1_General_CP1_CS_AS`
4. Shutdown services `docker-compose -f docker-compose.yml -f docker-compose.override.yml down`
5. Start them again `docker-compose -f docker-compose.yml -f docker-compose.override.yml up`

**NOTE:** **SonarQube** uses the following default credentials: `admin / admin`