We are building a golang app named {{ .ProjectName }}.

{{ include "../keep-lines-of-code-count-small-per-file/keep-lines-of-code-count-small-per-file.md" . | trim }}" {{/*  I've included this twice, once here and its also nested in a dependent template.  I included it twice since I really want claude to keep source files short */}}

Our app will have a number of subcommands.

`gather` is one subcommand:

gather { url | directory path | remote github or gitlab etc url } [{ url | directory path | remote github or gitlab etc url } ...]

Gather will fetch the argument(s) similar to how boilerplate does it using the go-getter package (see below).

Our app will fetch the endpoints using `boilerplate` api.

I've included the boilerplate source here:

```
<boilerplate_source>
{{ include "../does-boilerplate-offer-option-as-library/use-boilerplate-as-library.md" . | trim }}"
</boilerplate_source>
```

We can make use of the go-getter package to be able to efficiently fetch repositories. I've included the api readme here:

The API for go-getter is here for reference:
https://raw.githubusercontent.com/hashicorp/go-getter/refs/heads/main/README.md

If we're fetching a repo then we should recurse the repo searching for templates. A template is a directory that has a `boilerplate.yml` file in it.

If we're fetching a url then we should rely on go-getter to fetch it and confirm its a template and fail if not.

The gather subcommand will then report the list of templates it found and it will take arguments out with values yaml or json or toml and outfile which will cause it to write its output to the outfile target.

Another subcommand is `renderall` which will render all the templates it found concurrently with an option to limit concurrency to `n` rendering processes each in their own isolated temp directory and report back the templates that failed to render.

Its ok that the templates fail to render after all this application's purpose is to find the failing templates so that we can update them.

If the template fails to render then we should keep a note of this and continue testing the rest of the templates.

When boilerplate is not able to render the templte then we should track the error in the same toml file that we're using to track whether the template completed successfully.

We should not re-try templates that have failed unless we've given the retry-failed param and we know which ones have failed because we're tracking this in our toml file.

If we use the retry-failed param then we SHOULD run the failing templates again.

We have full access to the boilerplate source code so we know how to process the boilerplate.yml files.

From those files we know the list of variables we need. Some will have default values and others won't.

For the case where we haven't given a default value then we should provide one.

If the variable type is string then the default value will a fake one with value the name of the variable and then underscore and then a random 3 character string something like this: bucket_3ab

{{ include "../golang-app/golang-app.md" . | trim }}"
