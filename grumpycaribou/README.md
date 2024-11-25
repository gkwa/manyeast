# Grumpycaribou - Homebrew Template for Incus

A template project that automates Homebrew installation and configuration in Incus containers.

## Overview

This template creates a standardized Homebrew environment in Incus containers. It handles installation, configuration, and sets up proper user permissions and environment variables.

## Quick Start

```bash
boilerplate --non-interactive --template-url github.com/gkwa/manyeast/grumpycaribou --output-folder=test
cd test
bash -xe run.sh
```

## Configuration

Template variables are configurable through `boilerplate.yml`. For example:

```yaml
variables:
  # Base image configuration
  - name: Distro
    type: string
    default: ubuntu
  - name: Release
    type: string
    default: jammy

  # Output naming
  - name: OutputImage1
    type: string
    default: "{{ base outputFolder }}-homebrew"
```

These variables control the base distro, release version, and output naming patterns.

## Generated Files

- `001-homebrew-base.sh`: Base Homebrew installation script
- `001-ubuntu-homebrew.pkr.hcl`: Packer config for base Ubuntu image
- `002-homebrew-configured.sh`: Homebrew environment configuration
- `002-homebrew-configured.pkr.hcl`: Packer config for configured image
- `main.tf`: Terraform configuration for instance creation
- `run.sh`: Main execution script
- `clean.sh`: Cleanup script

## Features

- Automated Homebrew installation
- Proper user permissions setup
- Environment variable configuration
- Cross-distribution package management
- Automated image building
- Infrastructure as Code deployment
- Customizable naming through boilerplate.yml

## Process Flow

1. Creates base Ubuntu Jammy image with Homebrew
2. Configures Homebrew environment variables
3. Sets up user permissions and shell configurations
4. Creates final container with working Homebrew installation

## Example Usage

After installation, Homebrew is ready to use:

```bash
incus exec test-homebrew-configured -- bash -l -c 'brew install hashicorp/tap/packer'
```

## Cleanup

To remove all created resources:

```bash
cd test
./clean.sh
```

## Dependencies

- [Incus](https://github.com/lxc/incus#incus) - Container and VM manager
- [Packer](https://developer.hashicorp.com/packer/install) - Machine image builder
- [Terraform](https://developer.hashicorp.com/terraform/install) - Infrastructure as Code tool
- [Boilerplate](https://github.com/gruntwork-io/boilerplate) - Template engine
- [Packer Incus Plugin](https://github.com/bketelsen/incus) - Packer plugin for Incus