

```sh
(warmwalrus) ➜  mac dreamydungbeetle git:(master) cat query_catetory.sh 
#!/bin/bash

CATEGORY="${*:-apples}"

aws dynamodb query \
    --region us-east-1 \
    --table-name dreamydungbeetle \
    --key-condition-expression "#cat = :category_term" \
    --expression-attribute-names '{ "#cat": "category" }' \
    --expression-attribute-values '{ ":category_term": {"S": "'"$CATEGORY"'"} }'
(warmwalrus) ➜  mac dreamydungbeetle git:(master)
```



```sh
(warmwalrus) ➜  mac dreamydungbeetle git:(master) bash query_catetory.sh frozen salmon >/tmp/data.json
```


```sh
(warmwalrus) ➜  mac dreamydungbeetle git:(master) cat /tmp/data.json | bouncingbeaver unmarshal --randomize -f - | jq '100 as $len | map(select(.Timestamp | contains("2025-06-09"))) | .[0:5] | map({Name, Category, Domain, URL, RawHTMLExtracted}) | map(with_entries(.value = (.value | tostring | if length > $len then .[0:$len] + "..." else . end)))'
[
  {
    "Name": "Today Gourmet Foods of NC - Sushi-Grade Norwegian Salmon Fillets (12-6/7oz fillets) (Kosher)",
    "Category": "frozen salmon",
    "Domain": "www.amazon.com",
    "URL": "https://www.amazon.com/Today-Gourmet-Foods-NC-Sushi-Grade/dp/B071VKVZG9",
    "RawHTMLExtracted": "<div role=\"listitem\" data-asin=\"B071VKVZG9\" data-index=\"34\" data-uuid=\"fc317632-2cba-4db3-9a8a-33694..."
  },
  {
    "Name": "New York's Delicacy, Whole Smoked Salmon Nova Fillet - [2.9 Lb. / 1 Fillet] - Most Awarded, Non-Slic...",
    "Category": "frozen salmon",
    "Domain": "www.amazon.com",
    "URL": "https://www.amazon.com/New-Yorks-Delicacy-Smoked-Salmon/dp/B071NTKLM6",
    "RawHTMLExtracted": "<div role=\"listitem\" data-asin=\"B071NTKLM6\" data-index=\"27\" data-uuid=\"ffc0df36-cf4a-4d73-833d-287cd..."
  },
  {
    "Name": "Amazon Fresh Brand, Wild Caught Pacific Whiting Skin-On Fillets Value Pack, Frozen, Sustainably Sour...",
    "Category": "frozen salmon",
    "Domain": "www.amazon.com",
    "URL": "https://www.amazon.com/Fresh-Brand-Pacific-Whiting-Skin/dp/B07ZS3QV9T",
    "RawHTMLExtracted": "<div role=\"listitem\" data-asin=\"B07ZS3QV9T\" data-index=\"66\" data-uuid=\"0c9f47f8-f1f2-4333-9a39-72a3a..."
  },
  {
    "Name": "Great Value Premium Skinless & Boneless Pink Salmon, 2.5 oz",
    "Category": "frozen salmon",
    "Domain": "www.walmart.com",
    "URL": "https://www.walmart.com/ip/Great-Value-Premium-Skinless-Boneless-Pink-Salmon-2-5-oz/293367468",
    "RawHTMLExtracted": "<div role=\"group\" data-item-id=\"3Y6YXJFXFXBB\" data-dca-catalog-id=\"3Y6YXJFXFXBB\" data-dca-item-id=\"2..."
  },
  {
    "Name": "Fresh Atlantic Whole Salmon Fillet Farm Raised (sustainably sourced)",
    "Category": "frozen salmon",
    "Domain": "www.qfc.com",
    "URL": "https://www.qfc.com/p/fresh-atlantic-whole-salmon-fillet-farm-raised-sustainably-sourced-/0023858840...",
    "RawHTMLExtracted": "<div class=\"kds-Card ProductCard border border-neutral-less-subtle border-solid flex flex-col w-full..."
  }
]
(warmwalrus) ➜  mac dreamydungbeetle git:(master) 
```


```sh
(warmwalrus) ➜  mac manyeast git:(master) cat /tmp/data.json | bouncingbeaver unmarshal --randomize -f - | jq '100 as $len | map(select(.Timestamp | contains("2025-06-09"))) | .[0:1] | map(with_entries(.value = (.value | tostring | if length > $len then .[0:$len] + "..." else . end)))'
[
  {
    "ID": "cade6fc4-bd2a-48d8-b453-a3584fc7c53a",
    "Name": "Amazon Fresh Brand, Wild Caught Pacific Cod Skinless Fillet Portions, Frozen, Sustainably Sourced, P...",
    "Price": "$6.19",
    "Category": "frozen salmon",
    "Domain": "www.amazon.com",
    "ImageURL": "https://m.media-amazon.com/images/I/71v5nlk01eL._AC_UL320_.jpg",
    "PricePerUnit": "",
    "EntityType": "category",
    "Timestamp": "2025-06-09#www.amazon.com#Amazon Fresh Brand, Wild Caught Pacific Cod Skinless Fillet Portions, Froz...",
    "URL": "https://www.amazon.com/Fresh-Brand-Pacific-Skinless-Portions/dp/B07ZS35KP9",
    "RawTextContent": "Amazon Fresh Brand , Wild Caught Pacific Cod Skinless Fillet Portions , Frozen , Sustainably Sourced...",
    "RawHTML": "eNrtWglz2zYW/itYTdtJp4Ek6rTSyK1sy0d8RocTp9PRQCQkwSIJmiB1uNP/vg8AKZESZTvJptmd2YwjieDDw3sf3gnyrcVmyOc2...",
    "RawHTMLExtracted": "<div role=\"listitem\" data-asin=\"B07ZS35KP9\" data-index=\"43\" data-uuid=\"e71737b5-76fd-4552-b38f-61be9...",
    "TTL": "1752072121"
  }
]
(warmwalrus) ➜  mac manyeast git:(master) 
```
