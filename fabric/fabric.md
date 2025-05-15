I am trying to learn how to use fabric to help with templates. For example this works fine:
`echo "hello my name is  "[[ name ]]" | ./fabric --dry-run --input-has-vars -v=name:taylor`

but when I have many variables in my template, it becomes a new task to try to manage these commandlines.

It would be ideal if I could fetch the variables from some config file...and that's why I thought this would work:
`echo "hello my name is "[[ name ]]" | ./fabric --dry-run --input-has-vars --config=/tmp/o1.yaml`

but it doesn't work

Are you ble to detect if `--config` is the correct switch and if not which switch I should use or maybe you can detect that the functionality I'm after isn't supported?

I've included the fabric source in the <fabric_source/> xml element.

<fabric_source>
{{.FabricSource}}
</fabric_source>
