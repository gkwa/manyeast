#!/usr/bin/env bash

set -e

HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
HOMEBREW_SHELLENV_COMMAND='eval "$('${HOMEBREW_PREFIX}'/bin/brew shellenv)"'

install_packages() {
    if command -v apt-get &>/dev/null || command -v apt &>/dev/null; then
        apt-get update
        sudo apt-get install --assume-yes build-essential procps curl file git
    elif [ -f /etc/fedora-release ] || [ -f /etc/centos-release ] || [ -f /etc/redhat-release ]; then
        sudo yum -y groupinstall 'Development Tools'
        sudo yum -y install procps-ng curl file git
    elif [ -f /etc/arch-release ]; then
        sudo pacman -S base-devel procps-ng curl file git
    else
        echo "Unsupported distribution"
        exit 1
    fi
}

setup_linuxbrew_user() {
    if ! id -u linuxbrew &>/dev/null; then
        sudo useradd --create-home linuxbrew --shell /bin/bash
    fi
    if ! test -f /etc/sudoers.d/linuxbrew; then
        echo "linuxbrew ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/linuxbrew
    fi
}

install_homebrew() {
    local script=$(mktemp /tmp/homebrew-XXXXX.sh)
    chmod a+rx $script
    cat >$script <<EOF
timeout 30s curl --retry 9999 --connect-timeout 1 -sSf https://www.google.com >/dev/null
export PATH=${HOMEBREW_PREFIX}/bin:\$PATH
NONINTERACTIVE=1 /bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$HOMEBREW_SHELLENV_COMMAND
if ! grep HOMEBREW_AUTO_UPDATE_SECS ~/.profile; then
echo 'export HOMEBREW_AUTO_UPDATE_SECS=\$((24*60*60))' >> ~/.profile
fi
brew --version
EOF
    cd /home/linuxbrew
    if [ ! -f "${HOMEBREW_PREFIX}/bin/brew" ]; then
        sudo --login --user linuxbrew bash -e $script
    else
        echo "Homebrew is already installed. Skipping installation."
    fi
    rm -f $script
}

install_packages
setup_linuxbrew_user
install_homebrew
