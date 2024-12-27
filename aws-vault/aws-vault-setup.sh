#!/bin/bash

mkdir -p ~/.aws ~/.aws-vault

cat >~/.aws/config <<'EOF'
[default]
region = us-east-1

[profile myprofile]
region = us-east-1
EOF

cat >>~/.bashrc <<'EOF'
export AWS_VAULT_BACKEND=file
export AWS_VAULT_FILE_DIR=~/.aws-vault
EOF

source "${HOME}/.bashrc"
