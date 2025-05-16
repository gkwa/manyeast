#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

test ! -d /tmp/boilerplate && git clone https://github.com/gruntwork-io/boilerplate.git /tmp/boilerplate

rm -rf /tmp/boilerplate_subset

cd /tmp/boilerplate

test ! -f /tmp/boilerplate.txt && { 
    rg --files . -0 | xargs -0 file --mime-type >/tmp/boilerplate.txt
}

cat >/tmp/boilerplate_filter.txt <<'EOF'
application/json
application/pdf
application/x-mach-binary
application/zip
image/jpeg
image/png
CODEOWNERS
LICENSE
NOTICE
EOF

grep -v --file /tmp/boilerplate_filter.txt /tmp/boilerplate.txt | 
    cut -d: -f1 | 
    grep examples/ |
    cpio --insecure -pd /tmp/boilerplate_subset

cd /tmp/boilerplate_subset
txtar-c . >$SCRIPT_DIR/boilerplate_subset.txtar
du -shc $SCRIPT_DIR/boilerplate_subset.txtar
