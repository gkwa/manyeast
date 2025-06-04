We need golang app named {{ .ProjectName }} to enable us to easily pick out json dicts from a list.

The data the app will process will come in a variety of shapes and will probably change over time.

Currently we have

- one nested
- the other flat list of dictionaries

Lets discuss strategies for handling this.

I have suspicion this is a task that protobufs can help with.

Specifically I want to future proof my app while still getting strong typing.

Lets not code for now, lets discuss option for being flexible about handling the shape of our data.

{{ include (printf "%s/../prompt-golang-json-shape-may-change/base.md" (templateFolder)) . | trim}}
