#!/bin/bash

# Check if Air is installed
if ! command -v air &> /dev/null; then
    echo "Air is not installed. Installing via go install..."
    go install github.com/air-verse/air@latest
fi

# Copy config file to the extension directory
cp .air.toml /private/tmp/testuVP/

echo "Extension reloader installed successfully!"
echo "Run 'air' in your extension directory to start watching for changes"
