# Module Setup Guide

## Motivation

This guide demonstrates how to create and test a Dagger module locally.

The key is "locally" - allowing you to develop and test your module before publishing.

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

## Configuration Files

### justfile

```makefile
default:
    @just --list
set working-directory := 'mymod/myapp'
test:
    dagger call container-echo --string-arg hello
functions:
    dagger functions
```

### Module Patches

#### myapp.patch

```diff
diff --git a/myapp/dagger/main.go b/myapp/dagger/main.go
index 2df7f6e..e035dd2 100644
--- a/myapp/dagger/main.go
+++ b/myapp/dagger/main.go
@@ -22,8 +22,8 @@ import (
 type Myapp struct{}
-func (m *Myapp) ContainerEcho(stringArg string) *dagger.Container {
-	return dag.Container().From("alpine:latest").WithExec([]string{"echo", stringArg})
+func (m *Myapp) ContainerEcho(ctx context.Context, stringArg string) (string, error) {
+	return dag.Mymod().ContainerEcho(stringArg).Stdout(ctx)
 }
```

#### mymod.patch

```diff
diff --git a/main.go b/main.go
index 53a5f8a..33dd3e4 100644
--- a/main.go
+++ b/main.go
@@ -23,7 +23,7 @@ type Mod3 struct{}
func (m *Mymod) ContainerEcho(stringArg string) *dagger.Container {
-	return dag.Container().From("alpine:latest").WithExec([]string{"echo", stringArg})
+	return dag.Container().From("alpine:latest").WithExec([]string{"echo", stringArg, "from mod mymod"})
 }
```

### Setup Script

```bash
rm -rf mymod
mkdir mymod
cd mymod
git init
dagger init --sdk=go --source=.
git add -A
git commit -am "boilerplate dagger module"
mkdir -p myapp
echo /myapp >>.gitignore
git add .gitignore
git commit -am "ignore test app in mymod repo"
cd myapp
dagger init --sdk=go --source=./dagger
dagger install ..
cd $(git rev-parse --show-toplevel)/
git apply /tmp/myapp.patch
git apply /tmp/mymod.patch
```

## References

- [just](https://just.systems) - Command runner
- [dagger](https://docs.dagger.io/api/module-structure) - Container-based CI/CD tool
- [boilerplate](https://github.com/gruntwork-io/boilerplate) - Template engine

## Great Module Examples

### golangci-lint

[GitHub Repository](https://github.com/sagikazarmark/daggerverse/tree/main/golangci-lint#golangci-lint)

[Daggerverse](https://daggerverse.dev/mod/github.com/sagikazarmark/daggerverse/golangci-lint@126b5fbbdad70dbf2a8689600baec2eb78c05ef4)
