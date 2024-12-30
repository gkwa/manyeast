mod fmt

set shell := ["bash", "-uec"]

[group('maint')]
default:
    @just --list
