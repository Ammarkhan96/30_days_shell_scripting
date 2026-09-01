#!/bin/bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CONTEXT_FILE="$PROJECT_DIR/logs/context.txt"

echo "======================================"
echo "       COLLECTING SYSTEM CONTEXT"
echo "======================================"

{
    echo "===== INCIDENT TIMESTAMP ====="
    date

    echo
    echo "===== HOSTNAME ====="
    hostname

    echo
    echo "===== DISK USAGE ====="
    df -h /

    echo
    echo "===== MEMORY USAGE ====="
    free -h

    echo
    echo "===== TOP PROCESSES ====="
    ps aux --sort=-%mem | head -10

    echo
    echo "===== /VAR DISK USAGE ====="
    du -xh /var 2>/dev/null | sort -h | tail -10

    echo
    echo "===== DOCKER DISK USAGE ====="

    if command -v docker >/dev/null 2>&1; then
        docker system df
    else
        echo "Docker is not installed."
    fi

} > "$CONTEXT_FILE"

echo
echo "✅ Context collected."
echo "Saved to:"
echo "$CONTEXT_FILE"

echo

"$PROJECT_DIR/scripts/ai_decision.sh"
