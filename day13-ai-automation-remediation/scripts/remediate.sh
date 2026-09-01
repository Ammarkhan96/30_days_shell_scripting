#!/bin/bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DECISION_FILE="$PROJECT_DIR/logs/ai_decision.json"

echo "======================================"
echo "           REMEDIATION ENGINE"
echo "======================================"

if [ ! -f "$DECISION_FILE" ]; then
    echo "❌ AI decision file not found."
    exit 1
fi

ACTION=$(jq -r '.action' "$DECISION_FILE")
SEVERITY=$(jq -r '.severity' "$DECISION_FILE")

echo "Severity : $SEVERITY"
echo "Action   : $ACTION"
echo

case "$ACTION" in

    docker_cleanup)

        echo "✅ Approved action detected."

        if command -v docker >/dev/null 2>&1; then

            echo "Running safe Docker image cleanup..."
            echo

            docker image prune -f

            echo
            echo "✅ Docker cleanup completed."

        else

            echo "⚠️ Docker is not installed."
            echo "Skipping Docker remediation."

        fi

        ;;

    *)

        echo "❌ BLOCKED!"
        echo "Unauthorized remediation action:"
        echo "$ACTION"

        exit 1

        ;;

esac

echo
echo "Starting verification..."

"$PROJECT_DIR/scripts/verify.sh"
