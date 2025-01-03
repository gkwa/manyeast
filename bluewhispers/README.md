# Module Setup Guide

## Motivation

This guide demonstrates how to create and test a Dagger module locally.

The key is "locally".

The setup requires creating a specific hierarchy:

```
mod/
└── mod client/
```

Where the module client exists as a subdirectory of the created module.

## Usage

Single-line command:

```bash
cd /tmp && boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/bluewhispers --var ModuleConsumer=myapp --var Module=mymod && bash -x setup && just test
```

Multi-line equivalent for readability:

```bash
cd /tmp
boilerplate \
  --output-folder=. \
  --template-url github.com/gkwa/manyeast/bluewhispers \
  --var ModuleConsumer=myapp \
  --var Module=mymod
bash -x setup
just test
```

### Expected Output

```
just test
...
dagger call container-echo --string-arg hello
...
✔ .containerEcho(stringArg: "hello"): String! 1.9s

hello from mod mymod

Setup tracing at https://dagger.cloud/traces/setup. To hide: export STOPIT=1
```

## references

- [just](https://just.systems) - Command runner
- [dagger](https://docs.dagger.io/api/module-structure) - Container-based CI/CD tool
- [boilerplate](https://github.com/gruntwork-io/boilerplate) - Template engine

## Great Module Examples

### golangci-lint

[GitHub Repository](https://github.com/sagikazarmark/daggerverse/tree/main/golangci-lint#golangci-lint)

[Daggerverse](https://daggerverse.dev/mod/github.com/sagikazarmark/daggerverse/golangci-lint@126b5fbbdad70dbf2a8689600baec2eb78c05ef4)
