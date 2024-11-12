# manyeast

Quick config deployment with boilerplate.

## Install

```bash
# MacOS
brew install boilerplate

# Other platforms - download latest release
# https://github.com/gruntwork-io/boilerplate/releases
```

## Usage

### manyeast/golangci

```bash
# Deploy golangci-lint config
boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/golangci
```

Your local files will be updated with these remote templates:

- `./golangci.yml` ([view template](https://github.com/gkwa/manyeast/blob/master/golangci/.golangci.yml))

### manyeast/prettier

```bash
# Deploy prettier config
boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/prettier
```

Your local files will be updated with these remote templates:

- `./.prettierrc.json` ([view template](https://github.com/gkwa/manyeast/blob/master/prettier/.prettierrc.json))
- `./.prettierignore` ([view template](https://github.com/gkwa/manyeast/blob/master/prettier/.prettierignore))
- `./justfile` ([view template](https://github.com/gkwa/manyeast/blob/master/prettier/justfile))