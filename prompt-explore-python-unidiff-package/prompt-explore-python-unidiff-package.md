We will be working on project {{ .ProjectName }}.

We want to explore parsing git patches using unidiff python package

Readme for unidiff is here:
https://raw.githubusercontent.com/matiasb/python-unidiff/refs/heads/master/README.rst

Please fetch it to learn the api.

Please create example diff/patch and parse it

Make sure example has at least one empty line patch, namely one patch diff piece that adds a newline/empty line to a file and one that deletes empty line.

{{ include "../txtar/txtar.md" . | trim }}


{{/*

reminders for how to include templates

// include and interpret
{{ include "../add-google-search-links/add-links.md" . | trim }}"

// webui
{{ include "../webui-common/webui-common.md" . | trim }}"

// golang app
{{ include "../golang-app/golang-app.md" . | trim }}"

// no interpreting please
{{ snippet "../add-google-search-links/add-links.md" | trim }}"

*/}}
