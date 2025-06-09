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
```

```sh
#!/bin/bash
cat /tmp/data.json | bouncingbeaver unmarshal --randomize -f - | jq '100 as $len | map(select(.Timestamp | contains("2025-06-09"))) | .[0:5] | map({Name, Category, Domain, URL, RawHTMLExtracted}) | map(with_entries(.value = (.value | tostring | if length > $len then .[0:$len] + "..." else . end)))'
```

# Detailed Product Query

```sh
cat /tmp/data.json | bouncingbeaver unmarshal --randomize -f - | jq '100 as $len | map(select(.Timestamp | contains("2025-06-09"))) | .[0:1] | map(with_entries(.value = (.value | tostring | if length > $len then .[0:$len] + "..." else . end)))'
```
