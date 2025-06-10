```sh
#!/bin/bash
CATEGORY="${*:-frozen salmon}"
aws dynamodb query \
    --region us-east-1 \
    --table-name dreamydungbeetle \
    --key-condition-expression "#cat = :category_term" \
    --expression-attribute-names '{ "#cat": "category" }' \
    --expression-attribute-values '{ ":category_term": {"S": "'"$CATEGORY"'"} }' \
    > /tmp/data.json

cat /tmp/data.json | bouncingbeaver unmarshal --randomize -f - | jq '100 as $len | map(select(.Timestamp | contains("2025-06-09"))) | .[0:1] | map(with_entries(.value = (.value | tostring | if length > $len then .[0:$len] + "..." else . end)))'
```

## results

```
[
  {
    "ID": "b44cc703-2413-46c9-b57c-613bf839ac53",
    "Name": "365 By Whole Foods Market, Salmon Sockeye Fillets Frozen, 10 Ounce",
    "Price": "$9.99",
    "Category": "frozen salmon",
    "Domain": "www.amazon.com",
    "ImageURL": "https://m.media-amazon.com/images/I/51W1Z7y3WhL._AC_UL320_.jpg",
    "PricePerUnit": "",
    "EntityType": "category",
    "Timestamp": "2025-06-09#www.amazon.com#365 By Whole Foods Market, Salmon Sockeye Fillets Frozen, 10 Ounce",
    "URL": "https://www.amazon.com/365-Whole-Foods-Market-Sockeye/dp/B0D2LSNN77",
    "RawTextContent": "365 By Whole Foods Market , Salmon Sockeye Fillets Frozen , 10 Ounce HEADING : 365 By Whole Foods Ma...",
    "RawHTML": "eNrlWgtz2rgW/iu6zO7O7mwFmIeBbsmdPCClzashaR47O4ywBbixLUeyeWRn//s9km2wwJCk3Z3eubczJVg+Ojrn6DsviXe2M0Wc...",
    "RawHTMLExtracted": "<div role=\"listitem\" data-asin=\"B0D2LSNN77\" data-index=\"11\" data-uuid=\"8c642d77-3c71-464e-a6cc-ac935...",
    "TTL": "1752072121"
  }
]
```
