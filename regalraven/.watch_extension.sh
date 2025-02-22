#!/bin/bash

# Directory to watch
WATCH_DIR="{{ outputFolder }}"

# Cooldown period in seconds
COOLDOWN=10
LAST_RELOAD=0

# Function to reload extension
reload_extension() {
    CURRENT_TIME=$(date +%s)
    TIME_DIFF=$((CURRENT_TIME - LAST_RELOAD))
    
    if [ $TIME_DIFF -ge $COOLDOWN ]; then
        just --working-directory $WATCH_DIR --justfile $WATCH_DIR/justfile build
        echo "Changes detected, reloading extension..."
        open http://reload.extensions
        LAST_RELOAD=$CURRENT_TIME
    else
        echo "Changes detected, but in cooldown period ($((COOLDOWN - TIME_DIFF))s remaining)..."
    fi
}

echo "Watching directory: $WATCH_DIR"
echo "Cooldown period: ${COOLDOWN}s"
echo "Press Ctrl+C to stop watching"

# Start watching the directory
fswatch -o -e '.git/' "$WATCH_DIR" | while read -r file; do
    reload_extension
done

