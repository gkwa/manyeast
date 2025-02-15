# Playwright Testing Setup Q&A Documentation

This Q&A document has been created from a technical thread discussing the setup and configuration of a Playwright testing environment. It includes information about custom runners, configuration files, and setup procedures.

## Q: How do I set up a basic Playwright testing environment?

A: The basic setup can be accomplished using the following steps:

1. Create a temporary directory and initialize the project:

```bash
dir=$(mktemp -d /tmp/testXXX) && cd $dir
pnpm create playwright --lang=Typescript --gha --quiet --browser=chromium --install-deps .
git init && git add -A && git commit -am boilerplate
```

2. Use the boilerplate command with either a remote or local template:

Remote template:

```bash
boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/zoomingzeebra
```

## Q: What files are created in a standard Playwright setup?

A: A standard setup creates the following directory structure:

```
.
├── custom-runner.js
├── justfile
├── node_modules
│   ├── @playwright
│   │   └── test
│   └── @types
│       └── node
├── package.json
├── patch
├── playwright.config.ts
├── pnpm-lock.yaml
├── tests
│   └── example.spec.ts
└── tests-examples
    └── demo-todo-app.spec.ts
```

## Q: How is the custom runner configured?

A: The custom runner (custom-runner.js) is configured as follows:

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

## Q: How do I set up the test execution environment?

A: The test execution environment is set up using a justfile with the following configuration:

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

## Q: What modifications are made to the Playwright configuration?

A: The playwright.config.ts file is modified through a patch that adds debugging capabilities:

```typescript
import { defineConfig, devices } from "@playwright/test"
// Enable internal debugging
// process.env.DEBUG = "pw:*"
```

This configuration:

- Applies patches after template generation
- Skips README.md from being overwritten
- Executes hooks in the specified output folder

## Q: What should I expect when running the tests?

A: After setting up everything correctly, running `just test` should produce output similar to this:

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
