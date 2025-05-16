#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

test ! -d /tmp/go-getter && git clone https://github.com/hashicorp/go-getter.git /tmp/go-getter
cd /tmp/go-getter

test ! -f /tmp/go-getter.txt && bash -c 'rg --files . -0 | xargs -0 file --mime-type >/tmp/go-getter.txt'

rm -rf /tmp/go-getter-subset

cat >/tmp/go-getter-exclude.txt <<EOF
application/gzip
application/x-bzip2
application/x-tar
application/x-xz
application/zip
application/zstd
testdata/
go.sum
LICENSE
EOF

grep -v --file /tmp/go-getter-exclude.txt /tmp/go-getter.txt | cut -d: -f1 | cpio --insecure -pd /tmp/go-getter-subset

cd /tmp/go-getter-subset
txtar-c . >$SCRIPT_DIR/go-getter-subset.txtar
du -shc $SCRIPT_DIR/go-getter-subset.txtar
