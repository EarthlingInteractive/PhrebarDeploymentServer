#!/bin/bash
# Run all the servers!

set -euo pipefail

/etc/start-da-servers

exec sleep infinity
