In `.codespellrc` I can skip files using this format:

```
[codespell]
skip = ./nlp-product-classification/product-data.json,./prompt-use-gruntwork-boilerplate-as-library-to-parse-yaml/sample-boilerplates.txtar
```

This will skip running codespell checker on both these files:

1. `./nlp-product-classification/product-data.json`
1. `./prompt-use-gruntwork-boilerplate-as-library-to-parse-yaml/sample-boilerplates.txtar`

It works fine but the skip line can get very long as I have to specify many paths on a single line which is not ergonomic and I expect there is a better way.

I've included codespell's source in the <codespell_source/> xml element.

Do you see a more ergonomic way to specify many paths?

```
<codespell_source>
{{ snippet "codespell_subset.txtar" | trim }}"
</codespell_source>
```
