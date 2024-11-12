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

this overwrites these files:

```
./golangci.yml
```

### manyeast/prettier

```bash
# Deploy prettier config
boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/prettier
```

this overwrites these files:

```
./.prettierrc.json
./.prettierignore
./justfile
```
