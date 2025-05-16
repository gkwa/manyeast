#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

test ! -d /tmp/codespell && git clone https://github.com/codespell-project/codespell /tmp/codespell

rm -rf /tmp/codespell_subset

cd /tmp/codespell

test ! -f /tmp/codespell.txt && bash -c 'rg --files . -0 | xargs -0 file --mime-type >/tmp/codespell.txt'

cat >/tmp/codespell_filter.txt <<'EOF'
dictionary
/data/
wordlist
example/dict.txt
COPYING
EOF

grep -v --file /tmp/codespell_filter.txt /tmp/codespell.txt | cut -d: -f1 | cpio --insecure -pd /tmp/codespell_subset

cd /tmp/codespell_subset
txtar-c . >$SCRIPT_DIR/codespell_subset.txtar
du -shc $SCRIPT_DIR/codespell_subset.txtar
