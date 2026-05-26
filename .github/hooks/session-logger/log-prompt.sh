#!/bin/bash

# Log user prompt submission

set -euo pipefail

# Skip if logging disabled
if [[ "${SKIP_LOGGING:-}" == "true" ]]; then
  exit 0
fi

# Create logs directory if it doesn't exist
SESSION_LOG_DIR="${SESSION_LOG_DIR:-logs/copilot/session-logger}"
mkdir -p "$SESSION_LOG_DIR"

# Extract timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Log prompt with full content (proper JSON encoding via python3)
python3 -c "
import json, sys
data = {'timestamp': sys.argv[1], 'event': 'userPromptSubmitted', 'level': sys.argv[2], 'prompt': sys.stdin.read()}
print(json.dumps(data, ensure_ascii=False))
" "$TIMESTAMP" "${LOG_LEVEL:-INFO}" >> "$SESSION_LOG_DIR/prompts.log"

exit 0
