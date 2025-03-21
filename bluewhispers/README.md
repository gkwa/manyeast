# Module Setup Exploration

## Motivation

This project was created to solve a specific challenge: how to properly test Dagger modules **locally** during development. While developing Dagger modules, I discovered that the setup process can be tricky and error-prone, with several approaches leading to cryptic errors.

I tested four different module setup configurations:

1. `t1` (✅ Works): Using git, with module/app directory order
2. `t2` (❌ Fails): No git, with module/app directory order
3. `t3` (❌ Fails): Using git, with app/module directory order
4. `t4` (❌ Fails): No git, with app/module directory order

Through our testing, I found that **only the t1 configuration works reliably**. The other approaches result in hard-to-debug errors that can be especially confusing for developers new to Dagger modules.

Key requirements for successful local module testing:

1. Initialize git repository for the module
2. Place the test client app as a subdirectory of the module
3. Follow the specific module/app directory order
4. Use proper relative path references in dagger.json

This exploration provides a working boilerplate that you can use to avoid common pitfalls when setting up local Dagger module development environments.

This exploration demonstrates how to create and test a Dagger module locally.

The key is **locally** - allowing you to develop and test your module before publishing.

Testing dagger modules locally requires creating a specific hierarchy:

```
mymod/           # Your module
└── myapp/       # Your module test client
```

**Important**:

1. The test client (`myapp`) should be temporary and excluded from git in the module's repository.

2. In a real-world scenario, client applications would live in their own repositories. However, for local testing, the client needs to be a subdirectory--at any depth--of the module to enable local development and testing.

## Usage

Single-line command:

```bash
dir=$(mktemp -d /tmp/testXXX) && cd $dir && boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/bluewhispers --var ModuleConsumer=myapp --var Module=mymod && just t1
```

After running boilerplate command:

```
[boilerplate] 2025/01/03 11:12:39 Downloading templates from github.com/gkwa/manyeast/bluewhispers to /var/folders/qk/
...
[boilerplate] 2025/01/03 11:12:41 Cleaning up working directory.
```

Expected directory structure:

```
.
├── README.md
├── justfile
├── myapp.patch
├── mymod.patch
└── setup
1 directory, 5 files
```

Multi-line equivalent for readability:

```bash
dir=$(mktemp -d /tmp/testXXX) && cd $dir
boilerplate \
  --output-folder=. \
  --template-url github.com/gkwa/manyeast/bluewhispers \
  --var ModuleConsumer=myapp \
  --var Module=mymod
just t1
```

### Expected Output

```
just t1
...
dagger call container-echo --string-arg hello
...
✔ .containerEcho(stringArg: "hello"): String! 1.9s

hello from mod mymod

Setup tracing at https://dagger.cloud/traces/setup. To hide: export STOPIT=1
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

### Dagger Configurations

#### Module Configuration (mymod/dagger.json)

```json
{
  "name": "mymod",
  "engineVersion": "v0.15.1",
  "sdk": "go"
}
```

#### Test Client Configuration (mymod/myapp/dagger.json)

```json
{
  "name": "myapp",
  "engineVersion": "v0.15.1",
  "sdk": "go",
  "dependencies": [
    {
      "name": "mymod",
      "source": "../."    # Local path to parent module
    }
  ],
  "source": "dagger"
}
```

The test client's configuration references the local module via relative path, enabling local development and testing.

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

- [just](https://just.systems/man/en/) - Command runner
- [dagger](https://docs.dagger.io/api/module-structure) - Container-based CI/CD tool
- [boilerplate](https://github.com/gruntwork-io/boilerplate?tab=readme-ov-file#boilerplate) - Template engine
- https://discord.com/channels/707636530424053791/708371226174685314/1281659163176603669
- https://discord.com/channels/707636530424053791/708371226174685314/1281644196033462324
- https://github.com/dagger/dagger/issues/9311

## Great Module Examples

### golangci-lint

[GitHub Repository](https://github.com/sagikazarmark/daggerverse/tree/main/golangci-lint#golangci-lint)

[Daggerverse](https://daggerverse.dev/mod/github.com/sagikazarmark/daggerverse/golangci-lint@126b5fbbdad70dbf2a8689600baec2eb78c05ef4)
