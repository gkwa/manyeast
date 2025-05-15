Lets replace this perl script with golang

```
#!/usr/bin/perl

# Read the entire file
$/ = undef;
$content = <>;

# Process each template expression
while ($content =~ /(\{\{.*?\}\})/g) {
    $match = $1;

    # Skip if this match is already an escaped template
    if ($match =~ /\{\{`\{\{/) {
        next;
    }

    # Extract variable name with whitespace preserved
    $match =~ /\{\{(.*?)\}\}/;
    $var = $1;

    # Create escaped version and replace just this instance
    $escaped = "{{`{{ $var }}`}}";
    $content =~ s/\Q$match\E/$escaped/;
}

# Print the result
print $content;
```

{{ include "../golang-app/golang-app.md" . | trim }}

We will also use `https://pkg.go.dev/github.com/rogpeppe/go-internal/testscript` to test its

Our testscript that is passing in perl is embedded in perl_testscript xml element.

```
<perl_testscript>
{{ snippet "../use-perl-to-escape-golang-template/template-escape.txtar" | trim}}
</perl_testscript>
```
