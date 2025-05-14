This is my test file in txtar format.

```
-- test.tmpl --
The variable's value is {{ .MyVar }}
```

Write a bash script and keep it simple.

The bash script should use perl to escape the golng template.

Use inplace editing in perl.

{{ include "../txtar/txtar.md" . | trim }}
