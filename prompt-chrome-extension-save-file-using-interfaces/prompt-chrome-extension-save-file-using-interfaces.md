We will create a chrome extension project named {{ .ProjectName }} to save some content.  

Where it will save it will be variable and we'll use dependency injection to dictate the action to take to save it.

I don't yet know all the actions we'll take but we should stub out the call now.  For at least one call we should write console log saying that we've not yet implemented this function.

For another save opteration I do know what we'll do and that is as follows.

We will perform HTTP POST request to dump the file to obsidian.  

I've included API usage example in bash script.  You'll notice here we're required to use api key so for that we'll need popup to prompt and store credentials.  We should rely on secure chrome api for storing credentials.

The UI for configuring credentials pertains only to obsidian so we should design the UI accordingly.  

We'll also need a vault name for the obsidian based storage.

We'll also need an endpoint for where to send the HTTP post request.

Remember that we'll have multiple ways to "store" and obsidian will be just one and we'll choose using dependency injection.

```
<bash_script>
{{ snippet "obsidian-curl.sh" | trim }}
</bash_script>
```

The function should be invoked via Shift-Cmd-M keyboard shortcut.

{{ include "../webui-common/webui-common.md" . | trim }}"
