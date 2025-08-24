reminders for how to include templates

// include and interpret
{{ include "../add-google-search-links/add-links.md" . | trim }}"

// webui example scaffold
{{ include "../webui-common/webui-common.md" . | trim }}"

// golang app example scaffold
{{ include "../golang-app/golang-app.md" . | trim }}"

// python package example scaffold
{{ include "../python-package/python-package.md" . | trim }}"

// no interpreting please
{{ snippet "../add-google-search-links/add-links.md" | trim }}"
