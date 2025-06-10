{{ include "categories.md" . | trim }}

{{ include (printf "%s/../add-google-search-links/add-links.md" (templateFolder)) . | trim}}

