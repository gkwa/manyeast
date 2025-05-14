I want to learn how to use `jq` command more efficiently.

My `data.json` is embedded in `<data/>` xml element.

I want to generate the result within the `<result/>` xml element.
```
<result>{{.Result}}</result>
```

I can do that use this `jq` command:
```
{{.JqCommand}}
```

But instead of deleting fields I want to delete, I want to only list fields that I do want to keep.  There are far fewer fields that I want to keep than that I want to remove so it would be more efficient to only list the ones I want to keep.

```
<data>{{.Data}}</data>
```
