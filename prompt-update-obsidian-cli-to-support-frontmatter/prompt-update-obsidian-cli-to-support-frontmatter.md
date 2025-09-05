We have an app named obsidian-cli that we just now added frontmatter support for and then we realized that we should switch to 
using goldmark-frontmatter libary instead of hand rolling fronmatter CRUD operations.

golmark-fronmatter package has already done the heavy lifting so we want to leverage that instead of hand rolling fronmatter CRUD ourselves.

I've included goldmark-fronmatter api here
```
<goldmark-fronmatter>
{{ include "goldmark-frontmatter_acfec953_subset.txtar" . | trim }}"
</goldmark-fronmatter>
```

Lets remove our code that handles fronttter CRUD and replace it with goldmark-frontmatter API.

Here is our obsidian-cli app 
```
<obsidian-cli>
{{ include "obsidian-cli_c1c62259_subset.txtarh" . | trim }}"
</obsidian-cli>
```


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