#!/usr/bin/env bash


terraform plan -out=tfplan -destroy
terraform apply tfplan
