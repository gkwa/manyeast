#!/usr/bin/env bash

set -e

# Clean up existing containers
incus info {{ .Container2Name }} &>/dev/null && incus rm --force {{ .Container2Name }}
incus info {{ .Container1Name }} &>/dev/null && incus rm --force {{ .Container1Name }}

# Clean up existing images
incus image info {{ .OutputImage1 }} &>/dev/null && incus image rm {{ .OutputImage1 }}
incus image info {{ .OutputImage2 }} &>/dev/null && incus image rm {{ .OutputImage2 }}
