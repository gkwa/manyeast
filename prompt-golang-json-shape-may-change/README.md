# Usage examples

## remote

```
rm -rf /tmp/stuff && boilerplate --disable-dependency-prompt --non-interactive --output-folder=/tmp/stuff --template-url git::https://github.com/gkwa/manyeast//prompt-golang-json-shape-may-change && find /tmp/stuff && cat /tmp/stuff/prompt-gojq.md | pbcopy && cat /tmp/stuff/prompt-gojq.md | less
```

or 

```
rm -rf /tmp/stuff && boilerplate --disable-dependency-prompt --non-interactive --output-folder=/tmp/stuff --template-url github.com/gkwa/manyeast//prompt-golang-json-shape-may-change && find /tmp/stuff && cat /tmp/stuff/prompt-gojq.md | pbcopy && cat /tmp/stuff/prompt-gojq.md | less
```

## local 

```
rm -rf /tmp/stuff && boilerplate --disable-dependency-prompt --non-interactive --output-folder=/tmp/stuff --template-url /Users/mtm/pdev/taylormonacelli/manyeast/prompt-golang-json-shape-may-change && find /tmp/stuff && cat /tmp/stuff/prompt-gojq.md | pbcopy && cat /tmp/stuff/prompt-gojq.md | less
```
