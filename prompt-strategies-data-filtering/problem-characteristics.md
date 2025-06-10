### we have ~200 product records for each category

### `categories` are another name for search terms

{{ include "categories.md" . | trim }}

### each record is in html that includes product name, price and more fields

### each domain has its own html wrapping code for each product

## data fetching examples

{{ include "fetch3.md" . | trim }}


