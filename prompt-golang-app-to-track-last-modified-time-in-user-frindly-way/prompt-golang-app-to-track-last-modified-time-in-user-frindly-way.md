We need a golang app named {{ .ProjectName }} to watch

- file access time
- file modified time

for 1 or more file paths.

We should show in a tui so that its realtime

- the absolute time
- the time since the last time in user friendly duration like 10s, 1.3m, 1h, 2d, etc.

{{ include "../golang-app/golang-app.md" . | trim }}"
