We have chrome extension `{{ .ProjectName }}` that we need to enhance.

The source for our project is here:

```
<{{ .ProjectName }}_source>
{{ include (printf "%s/../prompt-enhance-refinerobin-to-close-tab-after-export/source.md" (templateFolder)) . | trim}}
</{{ .ProjectName }}_source>
```
