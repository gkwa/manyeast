#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd /tmp

rm -rf /tmp/codespell_subset

test ! -d codespell && git clone https://github.com/codespell-project/codespell
cd codespell
rm -rf d

test ! -f /tmp/codespell.txt && bash -c 'rg --files . -0 | xargs -0 file --mime-type >/tmp/codespell.txt'

cut -d: -f1 /tmp/codespell.txt | xargs du -sc | sort -n

cat >/tmp/codespell_filter.txt <<'EOF'
codespell_lib/data/dictionary_code.txt
codespell_lib/data/dictionary_informal.txt
codespell_lib/data/dictionary_names.txt
codespell_lib/data/dictionary_usage.txt
codespell_lib/data/linux-kernel.exclude
codespell_lib/tests/data/en_GB-additional.wordlist
codespell_lib/tests/data/en_US-additional.wordlist
example/dict.txt
codespell_lib/data/dictionary_rare.txt
codespell_lib/data/dictionary_en-GB_to_en-US.txt
COPYING
codespell_lib/data/dictionary.txt
EOF

grep -v --file /tmp/codespell_filter.txt /tmp/codespell.txt | cut -d: -f1 | cpio --insecure -pd /tmp/codespell_subset

cd /tmp/codespell_subset
txtar-c . >$SCRIPT_DIR/codespell_subset.txtar
du -shc $SCRIPT_DIR/codespell_subset.txtar
