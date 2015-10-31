#!/bin/bash
# Run all the servers!

set -euo pipefail

/etc/init.d/postgresql start
/etc/init.d/apache2 start
