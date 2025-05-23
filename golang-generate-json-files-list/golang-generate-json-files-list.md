We need a golang app that recurses a directory structure scanning for file paths.

If our app encounters an error when reading the file paths, then simply log it and move to the next one.

Our app should have `scan` subcommand and we should allow for 1 or more discontiguous directory paths.

Our app should require `--outfile` which is path to where json will be stored.

Our app should allow exclude paths from our json that match a substring. We should allow 0 or more substrings.

For example --filter=.git will exclude any path that contains .git in it anywhere.

The resulting structure should have this shape:

```
{
  "files": [
    {
      "path": "src/main.ts"
    },
    {
      "path": "src/components/FileSearchApp.ts"
    }
  ]
}
```

Lets also add metadata key dictionary that shows statistics about the scan including

- average file size
- path count found
- directory count found

{{ include "../golang-app/golang-app.md" . | trim }}
