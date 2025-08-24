We need a python app named {{ .ProjectName }} that will generate some test markdown files

# {{ .ProjectName }} - Test Markdown Generator

## Overview
Python app that generates test markdown files for products and stores.

## Input Sources
- **Products**: `products.txt` or `--products` flag
- **Stores**: `stores.txt` or `--stores` flag
- annotate-test: --annotate-test bool flag

## Sample Data
### products.txt
```
{{ include "products.txt" . | trim }}
```

### stores.txt
```
{{ include "stores.txt" . | trim }}
```

## Output Format
Filename: ricotta cheese - test.md
contents:
```markdown
{{ include "ricotta cheese.md" . | trim }}
```

Notice how when we add boolean --annotate-test the the file name get the '- test.md' suffix


- we need to use python-frontmatter package
- we need to parse file's pre-existing frontmatter and append our own or overwrite if our data is the same as whats there
- we need to assume file is being created from scratch as well so that fronmatter is added as necessary
- file names we generate should be lowercased
- notice too how we added filetype: product to frontmatter


## Requirements
{{ include "../python-package/python-package.md" . | trim }}

