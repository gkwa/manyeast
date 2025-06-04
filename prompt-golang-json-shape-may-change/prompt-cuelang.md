{{ include (printf "%s/../prompt-golang-json-shape-may-change/header.md" (templateFolder)) . | trim}}

I think it might apply in our context, but maybe you can inspire how cuelang can be used to help with our needs.

<cuelang_description>
{{ include (printf "%s/../prompt-golang-json-shape-may-change/cuelang.md" (templateFolder)) . | trim}}
</cuelang_description>

{{ include (printf "%s/../prompt-golang-json-shape-may-change/footer.md" (templateFolder)) . | trim}}
