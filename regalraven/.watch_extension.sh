#!/bin/bash
# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "fswatch is not installed. Installing via Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Please install it first."
        exit 1
    fi
    brew install fswatch
fi

# Directory to watch
WATCH_DIR="/tmp/testSOF"
# Set latency/cooldown to 10 seconds
LATENCY=10

echo "Watching directory: $WATCH_DIR"
echo "Latency period: ${LATENCY}s"
echo "Press Ctrl+C to stop watching"

# Start watching the directory with built-in latency
fswatch -o -l $LATENCY "$WATCH_DIR" | while read -r file; do
    just --working-directory $WATCH_DIR --justfile $WATCH_DIR/justfile build
    echo "Changes detected, reloading extension..."
    open http://reload.extensions
done
