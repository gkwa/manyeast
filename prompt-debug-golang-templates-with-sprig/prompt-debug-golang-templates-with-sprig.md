I want to learn how to use golang templates along with the [sprig library](https://github.com/Masterminds/sprig?tab=readme-ov-file#sprig-template-functions-for-go-templates).

Lets create a demo app to run this test.

For example I expect to get the word "boilerplate" from this.

```
{{"{{"}} $repoName := base "https://github.com/gruntwork-io/boilerplate.git" | trimSuffix ".git" {{"}}"}}
```

{{ include "../add-google-search-links/add-links.md" . | trim }}"

{{ include "../golang-app/golang-app.md" . | trim }}"
