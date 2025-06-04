{{ include (printf "%s/../prompt-golang-json-shape-may-change/header.md" (templateFolder)) . | trim}}

One option is that we use gojq from here:
https://github.com/itchyny/gojq?tab=readme-ov-file#pure-go-implementation-of-jq

```
<transform.jq>
# Transform JSON: Extract Items array and flatten the structure by removing "Value" objects
# Also truncate rawHtml field to first 20 characters and append "..."
.Items | map({
  badge: .badge.Value,
  category: .category.Value,
  domain: .domain.Value,
  entity_type: .entity_type.Value,
  id: .id.Value,
  imageUrl: .imageUrl.Value,
  name: .name.Value,
  price: .price.Value,
  pricePerUnit: .pricePerUnit.Value,
  rawHtml: (.rawHtml.Value | .[0:20] + "..."),
  rawTextContent: .rawTextContent.Value,
  timestamp: .timestamp.Value,
  ttl: .ttl.Value,
  url: .url.Value
})
</transform.jq>
```

{{ include (printf "%s/../prompt-golang-json-shape-may-change/footer.md" (templateFolder)) . | trim}}
