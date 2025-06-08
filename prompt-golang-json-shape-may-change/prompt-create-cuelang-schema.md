Here's a quick intro about what cuelang is:

<cuelang_description>
{{ include (printf "%s/cuelang-desc.md" (templateFolder)) . | trim}}
</cuelang_description>

Lets generate 3 separate cuelang schemas

One for this:

{{ include (printf "%s/data-single-shape1.md" (templateFolder)) . | trim}}

One for this:

{{ include (printf "%s/data-single-shape2.md" (templateFolder)) . | trim}}

And the 3rd that attempts to merge the two schemas into a single schema.
