# Phrebar Deployment Server

It's a docker container that runs:

- Postgres 9.4 + PostGIS
- Apache2
- PHP 5.something
- [PhrebarDeploymentManager](http://github.com/EarthlingInteractive/PhrebarDeploymentManager)

By default (with no arguments given), ```docker run -ti
togos/phrebar-deployment-server``` will run the deployment manager
```deployment-server``` command.

See [PhrebarDeploymentManager's documentation](http://github.com/EarthlingInteractive/PhrebarDeploymentManager)
for information on available commands.
