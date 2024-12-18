#!/usr/bin/env bash

if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install -y curl
elif command -v yum >/dev/null 2>&1; then
    # Red Hat/CentOS
    sudo yum install -y curl
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    sudo dnf install -y curl
elif command -v zypper >/dev/null 2>&1; then
    # openSUSE
    sudo zypper install -y curl
elif command -v pacman >/dev/null 2>&1; then
    # Arch Linux
    sudo pacman -Sy --noconfirm curl
elif command -v apk >/dev/null 2>&1; then
    # Alpine Linux
    sudo apk add --no-cache curl
elif command -v pkg >/dev/null 2>&1; then
    # FreeBSD
    sudo pkg install -y curl
elif command -v brew >/dev/null 2>&1; then
    # macOS with Homebrew
    brew install curl
else
    echo "Unsupported package manager. Please install curl manually."
    exit 1
fi

echo "curl has been successfully installed."#!/usr/bin/env bash
