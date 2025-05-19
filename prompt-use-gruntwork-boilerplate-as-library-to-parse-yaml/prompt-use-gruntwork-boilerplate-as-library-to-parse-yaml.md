{{ include "../does-boilerplate-offer-option-as-library/use-boilerplate-as-library.md" . | trim }}

Included here is sample_boilerplate_templates which is a sample of the boilerplate templates that I have.

```
<sample_boilerplate_templates>
{{ snippet "sample-boilerplates.txtar" }}
</sample_boilerplate_templates>
```

You'll notice that we have variables stored in `boilerplate.yml` along with templates stored in arbitrary set of files that are golang templates.

Our goal is to create a golang app with subcommand `gather` that will
recurse 1 or more direcotries for boilerplate templates along with the templates config files `boilerplate.yml`.

We are generating a manifest of the templates and their config files.

We need a data strucutre 

- the paths to our templates
- the paths to our boilerplate files
- the parse boilerplate files
- the template files as strings

Since our app has imported the gruntwork boilerplate packages, it is fully aware of how to parse `boilerplate.yml` config files and given a boilerplate template along with a discovered boilerplate config file, our app could render that template if we asked it to using the `render` subcommand.

{{ include "../golang-app/golang-app.md" . | trim }}
