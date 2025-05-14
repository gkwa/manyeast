## use this module setup

I've already gotten started with:

```bash
go mod init {{ .GoModuleNamespace }}/{{ .GoModuleName }}
```

## provide a version subcommand that will show the version to stdout

We can use `runtime/debug.BuildInfo` to gather the binary version number and output when using the 'version' subcommand.

## I've included some requirements here

- don't use deprecated packages, for example `io/ioutil` is deprecated, let's not use that

- when you reply, don't include files `go.mod` or `go.sum` since I can generate that using `go mod init {{ .GoModuleNamespace }}/{{ .GoModuleName }}` and `go mod tidy`.  By not sending me these files we save resources/time as you don't have to write those out.

## use cobra-cli and viper please

{{include "../go-app-use-cobra-cli/go-app-use-cobra-cli.md" . | trim}}

{{include "../common-apps/common-apps.md" .}}
