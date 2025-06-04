As part of the build process we should always check 


npx tsc --noEmit --project tsconfig.json

reminders for how to include templates

// include and interpret
{{ include "../add-google-search-links/add-links.md" . | trim }}"

// webui
{{ include "../webui-common/webui-common.md" . | trim }}"

// golang app
{{ include "../golang-app/golang-app.md" . | trim }}"

// no interpreting please
{{ snippet "../add-google-search-links/add-links.md" | trim }}"
