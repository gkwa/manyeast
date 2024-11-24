#!/usr/bin/env bash


if ! incus image info crustalmice &>/dev/null; then
    packer init .
    packer build ubuntu.pkr.hcl
fi

terraform init
terraform plan -out=tfplan
terraform apply tfplan
incus ls crustalmice
incus exec crustalmice -- curl --version
