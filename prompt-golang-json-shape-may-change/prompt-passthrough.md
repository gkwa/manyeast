Our data has this shape:

{{ include (printf "%s/shape1-desc.md" (templateFolder)) . | trim}}

I expect this data to come from stdin or from --input file.json and send it to output unchanged.

The shape of the incoming data should exactly equal the shape of the outgoing data as though we applied a null transform.

Next I want to be able to add a transform to a particular field.

For example suppose the rawHtml field was compressed using compress/flat and for the transform I'd like to expand that field value such that the input dictionary is same as output dictionary except for that decompressed field value.

Is it possible to do this without hard coding the schema from the start?

Let's not code for now but rather discuss options.

