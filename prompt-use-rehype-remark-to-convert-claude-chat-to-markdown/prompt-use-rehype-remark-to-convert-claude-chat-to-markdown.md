We will create a chrome extension project named {{ .ProjectName }} parse the current page html and convert it to markdown.

We will use the rehype-remark npm package.

I've included a sample html page that is representative of what we're going to need to parse.

```
<sample>
{{ snippet "sample.html" }}"
</sample>
```

{{ include "../webui-common/webui-common.md" . | trim }}"
