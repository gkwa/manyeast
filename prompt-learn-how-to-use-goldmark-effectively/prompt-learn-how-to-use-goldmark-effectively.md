I'm interested in learning more about how I can read and write Markdown files.

More specifically, for example, suppose I wanted to query a specific second level header for some section value.

Suppose also I wanted to update that section with some other text.

This would be two different examples.

These are CRUD operations on a Markdown file.

For these markdown related CRUD tasks, I would like to use the goldmark package from here: https://github.com/yuin/goldmark?tab=readme-ov-file#goldmark

For example I want to be able to parse the markdown into an Abstract Syntax Tree and then query this graph as well as perform modifications to this graph and then write the graph back to a markdown file.

I've included the goldmark source below to give you a clear understanding of the current API.

```
<goldmark_source>
{{ snippet "goldmark-subset.txtar" | trim }}"
</goldmark_source>
```

# add tests using golang's golden testing methodology

We will need extensive tests to verify that our output is what we expect using golang testing golden testing methodology. If you're not familiar with what that is, I've included a description below

```
<golang_golden_file_testing_reference>
{{ include "../prompt-learn-how-to-reference-the-concept-of-golang-golden-files-for-testing/golden-files-article.md" . | trim }}
</golang_golden_file_testing_reference>
```

{{ include "../golang-app/golang-app.md" . | trim }}
