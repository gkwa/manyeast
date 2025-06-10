We're building a python package named {{ .ProjectName }} to help with html cleaner pipeline.

Our app would receive json from stdin and output json to stdout.

Because we're waiting for data from stdin, we should write message to stederr indicating that we're waiting for stdin data.

Our app should add a `CleanedText` field to each product record by removing HTML tags and normalizing whitespace from `RawHTMLExtracted`.

Our processing will only perform these actions

1. Remove all HTML tags (`<...>`) and replace with single space
2. Squeeze multiple consecutive whitespace characters into single space
3. Trim leading and trailing whitespace

- Preserve all existing fields
- Handle missing `RawHTMLExtracted` field gracefully
- Output valid JSON

and add the new `CleanedText` field to the json for each dict.

Our app will be another app in this pipline:

<sample_pipeline>
{{include "fetch1.md" . | trim}}
</sample_pipeline>

{{include "../python-package/python-package.md" . | trim}}
