## absolute import only please

{{include "../python-imports-absolute/python-imports-absolute.md" . | trim}}

{{include "../common-apps/common-apps.md" . | trim}}

## our python code should have full type annotations

## add option to show version

We should be able to see our app's version number using `--version` param.

Here's a snippet of how we could show version without duplicating it in `__init__.py`:

```python
import argparse
parser = argparse.ArgumentParser(description="...")
parser.add_argument(
    "--version",
    action="version",
    version=f"%(prog)s {importlib.metadata.version('{{.PackageName}}')}"
)
```

## type hints are required

Always add type hints to your python code.

## python package scaffold

Please start with this scaffoling for our python package.

- update the description based off context of this discussion
- update package dendencies and dev package dependencies

```txtar
-- README.md --
-- src/{{ .PackageName }}/__init__.py --
def main() -> None:
    print("Hello from {{ .PackageName }}!")
-- .python-version --
{{ .PythonVersion }}
-- pyproject.toml --
[project]
name = "{{ .PackageName }}"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
authors = [
    { name = "{{ .PackageAuthorName }}", email = "{{ .PackageAuthorEmail }}" }
]
requires-python = ">={{ .PythonVersion }}"
dependencies = []

[project.scripts]
{{ .PackageName }} = "{{ .PackageName }}:main"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.ruff]
preview = true

[tool.ruff.lint]
select = ["F", "E", "W"]
extend-select = ["I"]
extend-safe-fixes = ["F401"]
```
