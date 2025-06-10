# Basic Product Query

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

cat /tmp/data.json | bouncingbeaver unmarshal --randomize -f - | jq '100 as $len | map(select(.Timestamp | contains("2025-06-09"))) | .[0:5] | map({Name, Category, Domain, URL, RawHTMLExtracted}) | map(with_entries(.value = (.value | tostring | if length > $len then .[0:$len] + "..." else . end)))'
```

The result has price per unit embedded in html although its truncated here.

```
[
  {
    "Name": "Gorton’s Breaded Fish Sandwich Cut from Whole Fish Fillets (Not Minced), Wild Caught, Frozen",
    "Category": "frozen salmon",
    "Domain": "www.qfc.com",
    "URL": "https://www.qfc.com/p/gorton-s-breaded-fish-sandwich-cut-from-whole-fish-fillets-not-minced-wild-cau...",
    "RawHTMLExtracted": "<div class=\"kds-Card ProductCard border border-neutral-less-subtle border-solid flex flex-col w-full..."
  },
  {
    "Name": "Vital Choice Wild Caught Pacific King Salmon, Frozen, 6 Oz Portions, Skin-On/boneless (Pack of 6), K...",
    "Category": "frozen salmon",
    "Domain": "www.amazon.com",
    "URL": "https://www.amazon.com/Vital-Choice-Pacific-portions-Boneless/dp/B08LMY7JML",
    "RawHTMLExtracted": "<div role=\"listitem\" data-asin=\"B08LMY7JML\" data-index=\"62\" data-uuid=\"1c136b87-d84f-44d3-b25a-6b26f..."
  },
  {
    "Name": "Sea Cuisine Teriyaki Sesame Salmon",
    "Category": "frozen salmon",
    "Domain": "www.fredmeyer.com",
    "URL": "https://www.fredmeyer.com/p/sea-cuisine-teriyaki-sesame-salmon/0003549301467?fulfillment=PICKUP",
    "RawHTMLExtracted": "<div class=\"kds-Card ProductCard border border-neutral-less-subtle border-solid flex flex-col w-full..."
  },
  {
    "Name": "Freshe Moroccan Tagine, Gourmet Salmon Meal, 4.25 Ounce Can",
    "Category": "frozen salmon",
    "Domain": "www.walmart.com",
    "URL": "https://www.walmart.com/ip/Freshe-Moroccan-Tagine-Gourmet-Salmon-Meal-4-25-Ounce-Can/115173852",
    "RawHTMLExtracted": "<div role=\"group\" data-item-id=\"5DG3LZA0YT8G\" data-dca-catalog-id=\"5DG3LZA0YT8G\" data-dca-item-id=\"1..."
  },
  {
    "Name": "Fresh Atlantic Whole Salmon Fillet Farm Raised (sustainably sourced)",
    "Category": "frozen salmon",
    "Domain": "www.qfc.com",
    "URL": "https://www.qfc.com/p/fresh-atlantic-whole-salmon-fillet-farm-raised-sustainably-sourced-/0023858840...",
    "RawHTMLExtracted": "<div class=\"kds-Card ProductCard border border-neutral-less-subtle border-solid flex flex-col w-full..."
  }
]
```
