#!/bin/bash
# Run all the servers!

set -euo pipefail

/etc/init.d/apache2 start
/etc/init.d/postgresql start
exec /root/PhrebarDeploymentManager/deployment-server "$@"
