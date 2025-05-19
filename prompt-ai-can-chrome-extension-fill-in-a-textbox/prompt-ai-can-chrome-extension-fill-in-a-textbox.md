I need a chrome extension that will perform these steps:

1. navigate to this url: https://claude.ai/new
1. find the textbox in the html. I've listed the code for the page with the textbox below
1. populate the textbox with some pre-defined text which I've included below
1. find the submit button. the button may not be named submmit, it might be something else, the point is that the form needs to be submitted
1. submit the form

{{ include "../prompt-ai-new-npm-package/prompt-ai-new-npm-package.md" . | trim }}"

```
<textbox_related_code>
{{ snippet "textbox.html" | trim }}"
</textbox_related_code>
```

```
<pre_defined_text>
{{ include "../tldr/tldr.md" . | trim }}"
</pre_defined_text>
```

In addition to the npm package, we also need to find if someone else has created a chrome extension that does something similar in the sense that it navigates to a page and fills in a form.

{{ include "../add-google-search-links/add-links.md" . | trim }}"
