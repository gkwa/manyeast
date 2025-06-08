Lets 3 separate cuelang schemas

One for this:
{{ include (printf "%s/data-single-shape1.md" (templateFolder)) . | trim}}

One for this:
{{ include (printf "%s/data-single-shape2.md" (templateFolder)) . | trim}}

Another that attempts to merge the two schemas into a single schema

<cuelang_description>
{{ include (printf "%s/cuelang-desc.md" (templateFolder)) . | trim}}
</cuelang_description>
