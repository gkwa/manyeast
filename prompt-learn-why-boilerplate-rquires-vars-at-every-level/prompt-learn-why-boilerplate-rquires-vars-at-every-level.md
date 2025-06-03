Here's a log of using boilerplate:

```
(warmwalrus) ➜  mac manyeast git:(master) ✗ rm -rf /tmp/stuff && boilerplate --disable-dependency-prompt --non-interactive --output-folder=/tmp/stuff --template-url /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui && find /tmp/stuff
[boilerplate] 2025/06/01 16:59:56 Loading boilerplate config from /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui/boilerplate.yml
[boilerplate] 2025/06/01 16:59:56 Loading boilerplate config from /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui/boilerplate.yml
[boilerplate] 2025/06/01 16:59:56 Processing templates in /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui and outputting generated files to /tmp/stuff
[boilerplate] 2025/06/01 16:59:56 Following paths were picked up by Path attribute for SkipFile (README.md):
[boilerplate] 2025/06/01 16:59:56 	- /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui/README.md
[boilerplate] 2025/06/01 16:59:56 Skipping /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui
[boilerplate] 2025/06/01 16:59:56 Skipping /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui/README.md
[boilerplate] 2025/06/01 16:59:56 Skipping /Users/mtm/pdev/taylormonacelli/manyeast/prompt-reuse-vscode-components-in-webui/boilerplate.yml
ERROR[2025-06-01T16:59:56-07:00] template: prompt-reuse-vscode-components-in-webui.md:1:3: executing "prompt-reuse-vscode-components-in-webui.md" at <include "../add-google-search-links/add-links.md" .>: error calling include: template: prompt-reuse-vscode-components-in-webui.md:3:21: executing "prompt-reuse-vscode-components-in-webui.md" at <.LinkCount>: map has no entry for key "LinkCount"  binary=boilerplate version=v0.6.1
(warmwalrus) ➜  mac manyeast git:(master) ✗ 
```

Here are the templates I'm relying on

```
<template_dependencies>
{{  snippet "template-dependencies.txtar" | trim }}
</template_dependencies>
```

I am aware of a workaround but I think it should be unnecessary to do this workaround and possibly I'm simply not using boilerplate as intended.

Here is the workaround.  I could have adjusted the boilerplate.yml like this:

```
<workaround>
-- prompt-reuse-vscode-components-in-webui/boilerplate.yml --
variables:
  - name: LinkCount
    description: How many google search links should be generated
    type: int
    default: 10
</workaround>
```

but because I don't use that in the boilerplate.yml, we get an error.

But I expect that since this is in place:

```
-- add-google-search-links/boilerplate.yml --
variables:
  - name: LinkCount
    description: How many google search links should be generated
    type: int
    default: 10
```

I think that should be enough for the default LinkCount to be defined.

If I want to override the link count then I should use the workaround but under the conition that I want to leave the default link count 10, I think I should not need to specify the LinkCount in `prompt-reuse-vscode-components-in-webui/boilerplate.yml`.

I've included boilerplate source her for reference:

```
<boilerplate_source>
{{ snippet "../does-boilerplate-offer-option-as-library/boilerplate.txtar" | trim }}
</boilerplate_source>
```

