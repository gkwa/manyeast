# speedysquirrel Spec

## Purpose
A Python package for managing LLM prompts using Jinja2 template inheritance, enabling well-organized, DRY prompt libraries.

## Core Concept
Leverage Jinja2's `{% extends %}` and `{% block %}` system to build composable prompt hierarchies. Common patterns, instructions, and formatting live in base templates; specific use cases override only what they need.

### Template Hierarchy Example
```
base_assistant.j2
  └── coding_assistant.j2
        └── python_expert.j2
        └── code_review.j2
```

## CLI Interface

```bash
$ speedysquirrel prompt                  # fuzzy picker, full list
$ speedysquirrel prompt py               # fuzzy picker, pre-filtered to "py"
$ speedysquirrel prompt python_expert    # exact match → outputs immediately
$ speedysquirrel prompt --list           # print all templates (non-interactive)
```

Output is plain text to stdout. Warnings to stderr.

### Selection Behavior
- **No argument:** opens FZF-style interactive picker
- **Partial match:** opens picker pre-filtered by substring
- **Exact filename match:** bypasses picker, outputs prompt directly
- Matching is on **filenames only** (no keyword aliases)

## Template Locations

Templates are loaded from two locations:
1. **Bundled** — shipped with the package
2. **User** — `~/.config/speedysquirrel/templates/`

User templates can extend bundled templates:
```jinja
{% extends 'base_assistant.j2' %}  {# resolves from bundled package #}
```

Loader searches user templates first, then bundled.

## Variables

Templates can use Jinja2 variables:
```jinja
You are an expert in {{`{{  language  }}`}}.
```

Jinja2 defaults are supported:
```jinja
{{`{{  framework | default("FastAPI")  }}`}}
```

### Context File

Variables are provided via YAML:

```bash
$ speedysquirrel prompt pye --data ./context.yaml
```

**Default location:** `~/.config/speedysquirrel/context.yaml` (used when `--data` not specified)

### Missing Variables
- **Has Jinja default:** use default
- **No default:** error out

## Dependencies
- `jinja2` — template rendering with inheritance
- `pzp` (or similar) — pure Python fuzzy finder