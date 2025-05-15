{{ include "../does-boilerplate-offer-option-as-library/use-boilerplate-as-library.md" . | trim }}

Included here is sample_boilerplate_templates which is a sample of the templates that I have.

```
<sample_boilerplate_templates>
{{ snippet "sample-boilerplates.txtar" }}
</sample_boilerplate_templates>

You'll notice that we have variables stored in `boilerplate.yml` along with templates stored in arbitrary set of files that are golang templates.

Our goal then is to build a data structure that can hold

- the paths to our templates
- the paths to our boilerplate files
- the parse boilerplate files
- the template files as strings

```

{{ include "../golang-app/golang-app.md" . | trim }}

```

```
