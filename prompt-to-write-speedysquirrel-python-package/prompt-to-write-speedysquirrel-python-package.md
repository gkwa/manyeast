We will write python package named {{ .ProjectName }}.

Here is project spec:

{{ include "spec.md" . | trim }}"

{{ include "../python-package/python-package.md" . | trim }}"
