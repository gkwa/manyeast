```
# local testing
rm -rf /tmp/t && boilerplate --missing-key-action zero --non-interactive --output-folder=/tmp/t --template-url /Users/mtm/pdev/taylormonacelli/manyeast/use-golang-to-escape-golang-template --var GoModuleName=jestingjaguar && find /tmp/t && cat /tmp/t/use-golang-to-escape-golang-template.tmpl | pbcopy

# remote
rm -rf /tmp/t && boilerplate --missing-key-action zero --non-interactive --output-folder=/tmp/t --template-url github.com/gkwa/manyeast/use-golang-to-escape-golang-template --var GoModuleName=jestingjaguar && find /tmp/t && cat /tmp/t/use-golang-to-escape-golang-template.tmpl | pbcopy
```