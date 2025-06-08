{{ include (printf "%s/dal-strategies-intro.md" (templateFolder)) . | trim}}

Our data can come in a variety of formats that we don't know all of them on the outset.

Today we have the data coming in multiple shapes, but over time I expect this will change and we need to choose the right strategy to make this maleable.

<data_description>
{{ include (printf "%s/data.md" (templateFolder)) . | trim}}
</data_description>

