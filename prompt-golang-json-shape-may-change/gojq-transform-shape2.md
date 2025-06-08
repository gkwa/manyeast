```
<transform.jq>
# Data is already in the desired flat format, just need basic filtering/transformation
map(select(.category != null) | {
  badge: .badge,
  category: .category,
  domain: .domain,
  entity_type: .entity_type,
  id: .id,
  imageUrl: .imageUrl,
  name: .name,
  price: .price,
  pricePerUnit: .pricePerUnit,
  rawHtml: (.rawHtml | .[0:20] + "..."),
  rawTextContent: .rawTextContent,
  timestamp: .timestamp,
  ttl: .ttl,
  url: .url
})
</transform.jq>
```

