# Markdown Files Indexing with Meilisearch - Intern Spec

## Overview
Index a directory of markdown files (with frontmatter) using Meilisearch for fast search capabilities.

## Requirements

### Input
- Directory containing markdown files
- Files may include YAML frontmatter at the top
- Mixed content structure expected

### Core Tasks
1. **File Processing**
   - Recursively scan directory for `.md` files
   - Support directory exclusions (`.git`, `.trash`, `node_modules`, etc.)
   - Parse frontmatter (YAML) from markdown content
   - Extract and clean markdown body content

2. **Meilisearch Integration**
   - Set up Meilisearch instance/connection
   - Define initial schema (optional - Meilisearch auto-detects)
   - Batch upload processed documents
   - Configure search settings and filters

3. **CLI Search Interface**
   - Python script using argparse
   - Support query parameters, filters, limits
   - Return formatted results with file paths

3. **Document Structure**
   - Include frontmatter fields as searchable attributes
   - Index markdown content (stripped of markup)
   - Maintain file path/name for reference
   - Handle missing frontmatter gracefully

### Deliverables
- Justfile for setup/teardown orchestration
- Python indexing script with exclusions
- Python CLI search tool with argparse
- Schema definition (if needed beyond auto-detection)
- Documentation on usage and commands

### Example Commands
```bash
# Setup and index
just setup
just index /path/to/docs

# Search
python search.py "query text" --limit 10 --filter "tag:python"

# Teardown
just teardown
```

### Tech Stack
- Python (preferred)
- Meilisearch client library
- Markdown parsing library (python-frontmatter)
- argparse for CLI interface
- Just for task orchestration

## Success Criteria
- All markdown files indexed successfully
- Fast search across both content and metadata
- Proper error handling for malformed files
