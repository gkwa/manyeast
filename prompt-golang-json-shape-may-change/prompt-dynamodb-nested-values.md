Our data has this shape:

{{ include (printf "%s/shape1-desc.md" (templateFolder)) . | trim}}

You can see it has dynamodb characteristics where each value is nested under the .Value property.  

Why is this?

Why does AWS decide this format?

Does aws/v2 golang api provide api to flatten?
