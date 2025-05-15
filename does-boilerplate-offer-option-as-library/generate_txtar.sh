#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

dir=$(mktemp -d /tmp/boilerplate_XXXX) && cd $dir

test ! -d boilerplate && git clone https://github.com/gruntwork-io/boilerplate.git
cd boilerplate
rm -rf d

test ! -f /tmp/b && bash -c 'rg --files . -0 | xargs -0 file --mime-type >/tmp/b'

cat >/tmp/f <<'EOF'
application/pdf
application/x-mach-binary
application/zip
image/jpeg
image/png
test-fixtures/
examples/
README.md
NOTICE
CODEOWNERS
go.mod
LICENSE
go.sum
EOF

grep -v --file /tmp/f /tmp/b | cut -d: -f1 | cpio -pd d

cd d
txtar-c . >$SCRIPT_DIR/boilerplate.txtar
du -shc $SCRIPT_DIR/boilerplate.txtar
