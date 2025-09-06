I have a JSON file where I keep adding key-value pairs over time.

After a week or two, the schema evolves.

The problem is that my older scripts rely on the old schema.

If I nest a variable inside a dictionary, for example, all my old scripts break and need updating.

What tools or approaches should I use to abstract the schema, so that all my scripts depend on this abstraction instead of the raw JSON?

That way, I only update one place when the schema changes, rather than fixing every script.

Since I am using multiple languages like Python and Go, perhaps I should rely on code generation.

Would something like Protobuf, CUE, or another abstraction that can auto-generate the data access layer be the right approach?

For example, here's my data today
<data>
{{ include "data.json" . | trim }}"
</data>

but I expect I will want to add and remove fields as time progresses.

I want my app to always run without worrying about versions.

Perhaps we should add a version to our json and our app will key off that to know how to load the json.

{{/*

// include and interpret
{{ include "../add-google-search-links/add-links.md" . | trim }}"

// webui example scaffold
{{ include "../webui-common/webui-common.md" . | trim }}"

// golang app example scaffold
{{ include "../golang-app/golang-app.md" . | trim }}"

// python package example scaffold
{{ include "../python-package/python-package.md" . | trim }}"

// no interpreting please
{{ snippet "../add-google-search-links/add-links.md" | trim }}"

*/}}