This is an example of a markdown file:

```
# top header
apple

## sub heading
pear

### sub sub heading
peanut

## sub heading 2
orange
```

We can model this as a graph.

Please do so using neo4j and create cypher query language script.

Use the python package `markdown` to load the markdown into an AST when you need to parse the markdown.

Next, please create python script to traverse this graph and print the output in the same markdown heading order.

Here are some requirements for our project:

{{include "../python-package/python-package.md" .}}
