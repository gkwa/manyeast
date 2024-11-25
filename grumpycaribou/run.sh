#!/usr/bin/env bash

packer init .

if ! incus image info {{ .OutputImage1 }} &>/dev/null; then
    echo "Building base image {{ .OutputImage1 }}..."
    packer build {{ .Script1 }}
fi

if ! incus image info {{ .OutputImage2 }} &>/dev/null; then
    echo "Building configured image {{ .OutputImage2 }}..."
    packer build {{ .Script2 }}
fi

# Clean up existing containers
incus info {{ .Container1Name }} &>/dev/null && incus rm --force {{ .Container1Name }}
incus info {{ .Container2Name }} &>/dev/null && incus rm --force {{ .Container2Name }}

terraform init
terraform plan -out=tfplan
terraform apply tfplan

# Test that brew command runs as expected with example app chamber
incus exec {{ .Container2Name }} -- bash -l -c 'brew install chamber'
incus exec {{ .Container2Name }} -- bash -l -c 'chamber version'
