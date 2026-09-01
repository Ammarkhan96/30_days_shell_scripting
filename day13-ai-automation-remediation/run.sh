#!/bin/bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo "    AI AUTO-REMEDIATION SYSTEM"
echo "======================================"
echo

"$PROJECT_DIR/scripts/monitor.sh"
