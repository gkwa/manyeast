package main

import (
	"flag"
	"log"
	"os"
	"path/filepath"
	"text/template"
)

type Config struct {
	UseGit    bool
	ModFirst  bool
	Module    string
	AppName   string
	PatchDir  string
	OutputDir string
}

func main() {
	var cfg Config

	flag.BoolVar(&cfg.UseGit, "git", false, "Initialize git repos")
	flag.BoolVar(&cfg.ModFirst, "mod-first", false, "Start with module instead of app")
	moduleFlag := flag.String("module", "mymodule", "Module name")
	appFlag := flag.String("app", "myapp", "App name")
	patchDirFlag := flag.String("patches", "patches", "Patches directory")
	outDirFlag := flag.String("out", ".", "Output directory")
	flag.Parse()

	cfg.Module = *moduleFlag
	cfg.AppName = *appFlag
	cfg.PatchDir = *patchDirFlag
	cfg.OutputDir = *outDirFlag

	tmpl := template.New("script")
	tmpl.Delims("<%", "%>")
	tmpl, err := tmpl.Parse(`#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

<% if .ModFirst %>
rm -rf "${SCRIPT_DIR}/<% .Module %>"
mkdir "${SCRIPT_DIR}/<% .Module %>"
cd "${SCRIPT_DIR}/<% .Module %>" || exit 1
<% if .UseGit %>git init<% end %>
dagger init --sdk=go --source=.
<% if .UseGit %>
git add -A
git commit -am "boilerplate dagger module"
<% end %>
mkdir -p "${SCRIPT_DIR}/<% .Module %>/<% .AppName %>"
echo /<% .AppName %> >>.gitignore
<% if .UseGit %>
git add .gitignore
git commit -am "ignore test app in <% .Module %> repo"
<% end %>
cd "${SCRIPT_DIR}/<% .Module %>/<% .AppName %>" || exit 1
dagger init --sdk=go --source=./dagger
dagger install ..
cd "${SCRIPT_DIR}" || exit 1
patch --forward --batch --directory="${SCRIPT_DIR}/<% .Module %>" --input="<% .PatchDir %>/<% .Module %>.patch"
patch --forward --batch --directory="${SCRIPT_DIR}/<% .Module %>/<% .AppName %>/dagger" --input="<% .PatchDir %>/<% .AppName %>.patch"
<% else %>
rm -rf "${SCRIPT_DIR}/<% .AppName %>"
mkdir "${SCRIPT_DIR}/<% .AppName %>"
cd "${SCRIPT_DIR}/<% .AppName %>" || exit 1
<% if .UseGit %>git init<% end %>
dagger init --sdk=go --source=./dagger
<% if .UseGit %>
git add -A
git commit -am "boilerplate dagger app"
<% end %>
mkdir -p "${SCRIPT_DIR}/<% .AppName %>/<% .Module %>"
echo /<% .Module %> >>.gitignore
<% if .UseGit %>
git add .gitignore
git commit -am "ignore test app in <% .AppName %> repo"
<% end %>
cd "${SCRIPT_DIR}/<% .AppName %>/<% .Module %>" || exit 1
dagger init --sdk=go --source=.
dagger install ..
cd "${SCRIPT_DIR}" || exit 1
patch --forward --batch --directory="${SCRIPT_DIR}/<% .AppName %>/dagger" --input="<% .PatchDir %>/<% .AppName %>.patch"
patch --forward --batch --directory="${SCRIPT_DIR}/<% .AppName %>/<% .Module %>" --input="<% .PatchDir %>/<% .Module %>.patch"
<% end %>`)
	if err != nil {
		log.Fatal(err)
	}

	f, err := os.Create(filepath.Join(cfg.OutputDir, "setup"))
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	os.Chmod(f.Name(), 0o755)
	if err := tmpl.Execute(f, cfg); err != nil {
		log.Fatal(err)
	}
}
