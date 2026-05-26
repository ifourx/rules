#!/bin/bash

# Log session end event

set -euo pipefail

# Skip if logging disabled
if [[ "${SKIP_LOGGING:-}" == "true" ]]; then
  exit 0
fi

# Read input from Copilot
INPUT=$(cat)

# Create logs directory if it doesn't exist
SESSION_LOG_DIR="${SESSION_LOG_DIR:-logs/copilot/session-logger}"
mkdir -p "$SESSION_LOG_DIR"

# Extract timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Log session end
echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"sessionEnd\"}" >> "$SESSION_LOG_DIR/session.log"

echo "📝 Session end logged"
exit 0
