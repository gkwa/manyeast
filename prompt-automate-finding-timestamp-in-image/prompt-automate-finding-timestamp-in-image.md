Our project name is {{ .ProjectName }}.

We need to automate claude to extract timestamp.

- sample image is included
- so we will run sub command and claude will return the timestamp from bottom right corner of image
- we should use .env for keys/credentials

The workflow is this:

1. i will call subcommand tsextract with absolute path to filename
1. our app will upload the image to claude along with instructions to extract timestamp to iso 8601 format
1. claude will perform extraction and return its answer with no additonal comments or preamble
1. our app will copy the timestamp to our system clipboard

{{ include "../python-package/python-package.md" . | trim }}"

