# manyeast

Quick config deployment with boilerplate.

> ⚠️ **Warning**: This README and the list of affected files will be out of date as templates evolve. The files in your local directory will be overwritten with the latest remote templates.

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

Visit [golangci/](https://github.com/gkwa/manyeast/tree/master/golangci) to see what files will be overwritten before running.

Current templates (as of November 12, 2024):

- `./golangci.yml` ([view template](https://github.com/gkwa/manyeast/blob/master/golangci/.golangci.yml))

### manyeast/prettier

```bash
# Deploy prettier config
boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/prettier
```

Visit [prettier/](https://github.com/gkwa/manyeast/tree/master/prettier) to see what files will be overwritten before running.

Current templates (as of November 12, 2024):

- `./.prettierrc.json` ([view template](https://github.com/gkwa/manyeast/blob/master/prettier/.prettierrc.json))
- `./.prettierignore` ([view template](https://github.com/gkwa/manyeast/blob/master/prettier/.prettierignore))
- `./justfile` ([view template](https://github.com/gkwa/manyeast/blob/master/prettier/justfile))

### manyeast/crustalmice

```bash
boilerplate --non-interactive --output-folder=my-ubuntu --template-url github.com/gkwa/manyeast/crustalmice
cd my-ubuntu
just setup
incus image ls my-ubuntu # list image
incus ls my-ubuntu # list running container
incus exec my-ubuntu -- cat /etc/os-release
tree
```

```
.
├── README.md
├── justfile
├── main.tf
├── provision.sh
└── ubuntu.pkr.hcl

1 directory, 5 files
```

### manyeast/grumpycaribou

Deploy homebrew to ubuntu image

```bash
boilerplate --non-interactive --output-folder=homebrew --template-url github.com/gkwa/manyeast/grumpycaribou
cd homebrew
bash -xe run.sh
```
