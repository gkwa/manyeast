
{{ include "problem-characteristics.md" . | trim }}

{{ include (printf "%s/../add-google-search-links/add-links.md" (templateFolder)) . | trim}}

{{ include "../txtar/txtar.md" . | trim }}


