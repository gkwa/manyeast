set shell := ["bash", "-uec"]

default:
    @just --list

fmt:
    packer fmt -recursive .
    terraform fmt .
    prettier --ignore-path=.prettierignore --config=.prettierrc.json --write .
    just --unstable --fmt
