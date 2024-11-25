#!/usr/bin/env bash

set -e

HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
HOMEBREW_SHELLENV_COMMAND='eval "$('${HOMEBREW_PREFIX}'/bin/brew shellenv)"'

update_package_lists() {
    if command -v apk &>/dev/null; then
        apk update
    fi
}

install_packages() {
    update_package_lists
    if command -v apt-get &>/dev/null || command -v apt &>/dev/null; then
        apt-get update
        sudo apt-get install --assume-yes build-essential procps curl file git
    elif [ -f /etc/fedora-release ] || [ -f /etc/centos-release ] || [ -f /etc/redhat-release ]; then
        sudo yum -y groupinstall 'Development Tools'
        sudo yum -y install procps-ng curl file git
    elif [ -f /etc/arch-release ]; then
        sudo pacman -S base-devel procps-ng curl file git
    elif command -v apk &>/dev/null; then
        apk add --no-cache build-base linux-headers procps curl file git sudo bash ruby ruby-dev gcompat
    else
        echo "Unsupported distribution"
        exit 1
    fi
}

setup_linuxbrew_user() {
    cat >/etc/sudoers.d/alpine <<'EOF'
root ALL=(ALL) ALL
EOF
    chmod 0440 /etc/sudoers.d/alpine

    if ! id -u linuxbrew &>/dev/null; then
        sudo useradd --create-home linuxbrew --shell /bin/bash
    fi

    if ! test -f /etc/sudoers.d/linuxbrew; then
        echo "linuxbrew ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/linuxbrew
    fi
}


















install_packages
setup_linuxbrew_user
install_homebrew
