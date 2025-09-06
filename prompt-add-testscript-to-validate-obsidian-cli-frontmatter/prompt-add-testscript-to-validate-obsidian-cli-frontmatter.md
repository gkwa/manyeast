Lets add testscript tests to validate our fronmatter CRUD operations

Our source is here and we have implmeneted CRUD operaions for fronmatter but we don't yet have tests

```
<obsidian_cli>
{{ include "obsidian-cli_c1c62259_subset.txtar" . | trim }}"
</obsidian_cli>
```

{{ include (printf "%s/../prompt-add-golang-testscript/prompt-add-golang-testscript.md" (templateFolder)) . | trim}}

{{/* 
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
*/}}