I need a golang app that will escape golang template brackets so this:

```
{{ snippet "partial_a.md" }}
```

becomes this:

```
{{ snippet "partial_b.md" }}
```

and likewise for all other instances of golang's standard template open and closed delimiters.

So what we're doing is essentially preventing interpolation so that we can show template syntax raw.

We also need to prevent double escaping.

We need extensive tests too.

We need to test to ensure that we're not double escaping and that we're handling both single and double quotes since golang templates allow for this.

We should use escape subcommand and the command should take either a directory or a path to a file. If the argument is a directory then our app should recursively escape on files in directories and subdirectories.

If argument is just a file path then the escaping should be performed on the file itself.

We should show metadata in logs indicating how many escapes we've performed.

{{ include "../golang-app/golang-app.md" . | trim }}"
