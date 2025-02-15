# Playwright Testing Setup Q&A Documentation

This Q&A document covers the setup and configuration of a Playwright testing environment, including both standard Playwright setup and additional custom configurations.

## Q: How do I set up a basic Playwright testing environment?

A: The setup is done in two phases:

### Phase 1: Standard Playwright Setup

First, create a temporary directory and initialize the project with standard Playwright:

```bash
pnpm create playwright --lang=Typescript --gha --quiet --browser=chromium --install-deps . && git init && git add -A && git commit -am boilerplate
```

This creates the standard Playwright files and structure:

```
.
├── node_modules
│   ├── @playwright
│   │   └── test
│   └── @types
│       └── node
├── package.json
├── playwright.config.ts
├── pnpm-lock.yaml
├── tests
│   └── example.spec.ts
└── tests-examples
    └── demo-todo-app.spec.ts
```

After the standard setup, additional custom files are added and configurations are modified using a template:

```bash
boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/zoomingzeebra
```

This step adds the following custom files:

- `custom-runner.js`: A custom test runner script
- `justfile`: Configuration for test execution

And modifies:

- `playwright.config.ts`: Adds debugging capabilities

The final directory structure looks like this:

```
.
├── custom-runner.js        # Added by template
├── justfile                # Added by template
├── node_modules
│   ├── @playwright
│   │   └── test
│   └── @types
│       └── node
├── package.json
├── playwright.config.ts   # Modified by template
├── pnpm-lock.yaml
├── tests
│   └── example.spec.ts
└── tests-examples
    └── demo-todo-app.spec.ts
```

## Q: What are the custom files and their purposes?

### custom-runner.js

This is a custom runner script that extends Playwright's functionality:

```javascript
#!/usr/bin/env node
const { program } = require("playwright/lib/program")
// Custom commands can be added before parsing
// program.command('custom')
//   .description('custom command')
//   .action(() => {
//     console.log('custom command');
//   });
program.parse(process.argv)
```

### justfile

Configures the test execution environment:

```makefile
default:
    @just --list
test:
    #!/usr/bin/env bash
    set -euo pipefail
    basedir=$(dirname "$(echo "node_modules/.bin/playwright" | sed -e 's,\\,/,g')")
    # Set up NODE_PATH for Playwright modules
    PLAYWRIGHT_PATHS=$(find $PWD/node_modules/.pnpm -type d \( -path "*/@playwright+test*/node_modules/@playwright/test/node_modules" -o -path "*/@playwright+test*/node_modules/@playwright/node_modules" -o -path "*/@playwright+test*/node_modules" \) 2>/dev/null | tr '\n' ':')
    if [ -z "${NODE_PATH:-}" ]; then
        export NODE_PATH="${PLAYWRIGHT_PATHS}"
    else
        export NODE_PATH="${PLAYWRIGHT_PATHS}:$NODE_PATH"
    fi
    # Execute custom runner with test command
    exec node custom-runner.js test "$@"
```

### Modified playwright.config.ts

The configuration file is patched to include debugging capabilities:

```typescript
import { defineConfig, devices } from "@playwright/test"
// Enable internal debugging
// process.env.DEBUG = "pw:*"
```

## Q: What should I expect when running the tests?

A: After completing both setup phases, running `just test` should produce output similar to this:

```bash
Running 2 tests using 2 workers
  2 passed (2.2s)
To open last HTML report run:
  npx playwright show-report
```

This indicates:

- All tests are running successfully
- Tests are executed in parallel using multiple workers
- A HTML report is generated and can be viewed using the show-report command
- The entire test suite completes in a few seconds
