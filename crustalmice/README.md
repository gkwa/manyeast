-- README.md --
# Incus Instance Terraform Project

A Terraform project that creates and manages Incus instances with automatic curl installation.

## Generate Boilerplate

```bash
boilerplate --template-url github.com/gkwa/manyeast/crustalmice --output-folder=/tmp/mytest
```

## Files Generated in /tmp/mytest/

- `/tmp/mytest/clean.sh`: Destroys the Terraform-managed infrastructure
- `/tmp/mytest/main.tf`: Terraform configuration for Incus instance
- `/tmp/mytest/provision.sh`: Cross-platform script for installing curl
- `/tmp/mytest/run.sh`: Main script that builds image and applies Terraform configuration
- `/tmp/mytest/ubuntu.pkr.hcl`: Packer configuration for building Ubuntu base image

## Prerequisites

- Incus
- Terraform
- Packer

## Usage

1. Run the startup script:
```bash
./run.sh
```

2. To destroy resources:
```bash
./clean.sh
```

## Features

- Creates Ubuntu Jammy-based Incus instance
- Cross-platform curl installation
- Automated image building with Packer
- Infrastructure as Code with Terraform

## Image Details

Base: Ubuntu Jammy  
Name: mytest  
Autostart: Disabled