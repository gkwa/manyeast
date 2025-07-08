{{ include (printf "%s/spec.md" (templateFolder)) . | trim}}

I've included meilisearch options to give you an idea of what the latest
version of meilisearch can do:

<meilisearch_cli_options>
{{ include (printf "%s/meilisearch-cli.md" (templateFolder)) . | trim}}
</meilisearch_cli_options>

<sample_markdown_file>
{{ include (printf "%s/creamy-kale-soup.md" (templateFolder)) . | trim}}
</sample_markdown_file>

<sample_markdown_file>
{{ include (printf "%s/secrets-mydocs.md" (templateFolder)) . | trim}}
</sample_markdown_file>

<sample_markdown_file>
{{ include (printf "%s/onions.md" (templateFolder)) . | trim}}
</sample_markdown_file>

I will use python with a package

{{include "../python-package/python-package.md" . | trim}}

