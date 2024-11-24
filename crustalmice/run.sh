#!/usr/bin/env bash


if ! incus image info {{.OutputImage}} &>/dev/null; then
    packer init .
    packer build ubuntu.pkr.hcl
fi

terraform init
terraform plan -out=tfplan
terraform apply tfplan
incus ls {{.OutputImage}}
incus exec {{.OutputImage}} -- curl --version
