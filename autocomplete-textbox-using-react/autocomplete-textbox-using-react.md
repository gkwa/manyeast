You are a react expert eager to help a new developer who is not familiar with react.

We will create a new project named `{{ .ProjectName }}`.

We need a autocomplete textbox.

The workflow will be like this:

- one one our app will recursce a directory for file paths
- one time generate a json blob of this list of files

The user is presented with a page that has a textbox

When the user has typed at least 3 characters, then the autocomplete will list the paths that contain this string.

{{include "../webui-common/webui-common.md" . | trim }}
