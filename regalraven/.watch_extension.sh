-- watch_extension.sh --
#!/bin/bash

# Default values
WATCH_DIR="{{ outputFolder }}"
COOLDOWN=10
LAST_RELOAD=0

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
    --directory | --dir)
        WATCH_DIR="$2"
        shift 2
        ;;
    --cooldown)
        COOLDOWN="$2"
        shift 2
        ;;
    --help)
        echo "Usage: $0 [OPTIONS]"
        echo "Options:"
        echo "  --directory, --dir DIR    Directory to watch (default: {{ outputFolder }})"
        echo "  --cooldown SECONDS        Cooldown period in seconds (default: 10)"
        echo "  --help                    Display this help message"
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
    esac
done

# Function to reload extension
reload_extension() {
    local current_time
    local time_diff

    current_time=$(date +%s)
    time_diff=$((current_time - LAST_RELOAD))

    if [ $time_diff -ge "$COOLDOWN" ]; then
        just --working-directory "${WATCH_DIR}" --justfile "${WATCH_DIR}/justfile" build
        echo "Changes detected, reloading extension..."
        open http://reload.extensions
        LAST_RELOAD=$current_time
    else
        echo "Changes detected, but in cooldown period ($((COOLDOWN - time_diff))s remaining)..."
    fi
}

echo "Watching directory: ${WATCH_DIR}"
echo "Cooldown period: ${COOLDOWN}s"
echo "Press Ctrl+C to stop watching"

# First get the list of changes
CHANGES=(
    $(fswatch \
        --insensitive \
        --bubble-events \
        --one-per-batch \
        --exclude=.nearwait.yml --exclude=.nearwait.txtar \
        --exclude=.watch_extension.sh \
        --exclude=dist/ \
        --exclude=.git/ \
        "${WATCH_DIR}")
)

# Then process each change
for change in "${CHANGES[@]}"; do
    reload_extension
done
