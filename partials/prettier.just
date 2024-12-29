{{ define "just-prettier" }}

[group('maint')]
pre-commit-autoupdate:
    pre-commit autoupdate

[group('maint')]
pre-commit:
    pre-commit install --config .pre-commit-config.yaml
    pre-commit run --all-files

[group('maint')]
fmt:
    pre-commit run --all-files
{{ end }}
