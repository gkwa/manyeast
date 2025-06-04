Lets discuss DAO - data access layer strategies in golang.

Our data can come in a variety of formats that we don't know all of them on the outset.

Today we have the data coming in two shapes, but over time I expect this will change and we need to choose the right strategy to make this maleable.

Lets not code for now, lets discuss option for being flexible about handling the shape of our data.

{{ include (printf "%s/../prompt-golang-json-shape-may-change/base.md" (templateFolder)) . | trim}}
