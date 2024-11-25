{{ define "header" }}
install_homebrew() {
    local script=$(mktemp -p /tmp homebrew-XXXXXX)
    chmod a+rx $script

    cat >$script <<EOF
timeout 30s curl --retry 9999 --connect-timeout 1 -sSf https://www.google.com >/dev/null
export PATH=${HOMEBREW_PREFIX}/bin:\$PATH
LD_PRELOAD=/lib/libgcompat.so.0 NONINTERACTIVE=1 /bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
{{ end }}