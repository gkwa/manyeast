set shell := ["bash", "-uec"]

default:
    @just --list

fmt:
    shfmt -w -s -i 4 grumpycaribou/*.sh
    prettier --ignore-path=.prettierignore --config=.prettierrc.json --write .
    just --unstable --fmt
