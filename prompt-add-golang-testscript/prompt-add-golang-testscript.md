## Here is testscript api

```
<testscript_api>
{{ include (printf "%s/../prompt-add-golang-testscript/testscript.txt" (templateFolder)) . | trim}}
</testscript_api>
```

## Here is tescript source for more context

```
<testscript_source>
{{ include (printf "%s/../prompt-add-golang-testscript/testscript_31dff63d_subset.txtar" (templateFolder)) . | trim}}
</testscript_source>
```

## Here are some example testscripts

```
<testscript_example>
{{ include (printf "%s/../prompt-add-golang-testscript/example0100.txtar" (templateFolder)) . | trim}}
</testscript_example>
```

## Here is a blog post demonstrating testscript with stdout

```
<testscript_blog_post>
{{ include (printf "%s/../prompt-add-golang-testscript/blogpost-about-testscript.txt" (templateFolder)) . | trim}}
</testscript_blog_post>
```
