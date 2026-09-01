#!/bin/bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CONTEXT_FILE="$PROJECT_DIR/logs/context.txt"
DECISION_FILE="$PROJECT_DIR/logs/ai_decision.json"

echo "======================================"
echo "          AI DECISION ENGINE"
echo "======================================"

if [ ! -f "$CONTEXT_FILE" ]; then
    echo "❌ Context file not found."
    exit 1
fi

echo "Analyzing incident context..."
echo

# Temporary mock AI decision.
# Real AI API integration will be added later.

cat > "$DECISION_FILE" <<EOF
{
  "severity": "HIGH",
  "cause": "Disk usage exceeded configured threshold",
  "action": "docker_cleanup",
  "reason": "Docker resources may be consuming unnecessary disk space"
}
EOF

echo "AI decision generated:"
echo

cat "$DECISION_FILE"

echo

"$PROJECT_DIR/scripts/remediate.sh"
