We need golang app named {{ .ProjectName }} to enable us to easily pick out json dicts from a list.

Our data can appear in two different shapes; one nested and the other flat list of dicts.

The data the app will process will come in a variety of shapes.

Lets discuss strategies for handling this.

I have suspicion this is a task that protobufs can help with.

Specifically i want to future proof my app while still getting strong typing.

Lets not code for now, lets discuss option for being flexible about handling the shape of our data.

{{ include (printf "%s/../prompt-golang-json-shape-may-change/shape2.transcript" (templateFolder)) . | trim}}

{{ include (printf "%s/../prompt-golang-json-shape-may-change/shape1.transcript" (templateFolder)) . | trim}}


