You are tasked with removing tracking parameters from a URL to create a minimal URL that will still render the intended page correctly.

Tracking parameters are often used for analytics and marketing purposes but are not necessary for the page to load properly.

The url we should clean is within the url xml tag:

```
<url>
{{.URL}}
</url>
```

Tracking parameters are typically added to the end of a URL after a question mark (?) or ampersand (&).

They often include terms like "utm_source", "fbclid", "gclid", or other similar identifiers.

These parameters don't affect the content of the page but are used to track where the traffic came from.

To clean the URL:

1. Identify the base URL (everything before the question mark).
1. Look for the query string (everything after the question mark).
1. Analyze each parameter in the query string.
1. Remove parameters that are clearly for tracking purposes.
1. Keep parameters that seem essential for the page content or functionality.
1. Make a markdown table that includes all parameters found and a short description of what each one is along with it's value. Add a column indicating whether this parameter was kept because it was essential versus whether its a tracking url that we can remove. Show the table with these column headers in this order:

- Parameter - The name of the URL parameter
- Keep/Remove - Whether the parameter
- Description - A brief explanation of what the parameter is used for
- Value - The actual value assigned to the parameter in the URL
- Orignal url minus this param - The orignal url with all the parameters except for this parameter.  This will allow us to test if the link works after having removed this parameter.

1. Construct a list of google search links in markdown that helps me find more information about each parameter and how other people use this parameter in the wild.

Be cautious not to remove parameters that might be necessary for the page to function correctly. If you're unsure about a parameter, it's better to keep it.

After cleaning the URL, provide the minimal URL that should still render the intended page but do not wrap the url in code blocks. This way the url will be clickable.

Then, explain what changes you made and why.

Mention any parameters you removed and any you decided to keep, with your reasoning.

In addition, please write the param keys as a go slice similar to this:

```go
var ParamsToRemove = []string{
	"bih",
	"biw",
	"client",
	"cshid",
}
```

So for example if our link containss the `bih` param and the `cshid` param then you'd create this slice code snippet in a code block:

```go
var ParamsToRemove = []string{
	"bih",
	"cshid",
}
```
