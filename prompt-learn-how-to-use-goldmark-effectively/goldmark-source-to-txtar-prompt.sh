SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

subset_dir=$(mktemp -d /tmp/goldmark_XXXX)/goldmark

cd /tmp
test ! -d goldmark && git clone https://github.com/yuin/goldmark.git
cd goldmark

cat >/tmp/goldmark-exclude.txt <<'EOF'
.nearwait.txtar
LICENSE
_benchmark/cmark/Makefile
_benchmark/cmark/_data.md
_benchmark/cmark/cmark_benchmark.c
_benchmark/cmark/goldmark_benchmark.go
_benchmark/go/_data.md
_benchmark/go/benchmark_test.go
_benchmark/go/go.mod
_benchmark/go/go.sum
extension/_test/definition_list.txt
extension/_test/footnote.txt
extension/_test/linkify.txt
extension/_test/strikethrough.txt
extension/_test/table.txt
extension/_test/tasklist.txt
_tools/unicode-case-folding-map.json
extension/_test/typographer.txt
extension/cjk.go
extension/cjk_test.go
fuzz/fuzz_test.go
fuzz/oss_fuzz_test.go
go.sum
_tools/html5entities.json
renderer/html/html.go
util/html5entities.gen.go
util/html5entities.go
util/util_cjk.go
_test/
_test/spec.json
util/unicode_case_folding.gen.go
util/util_unsafe_go120.go
util/util_unsafe_go121.go
EOF

rg --files . | grep -vi --file=/tmp/goldmark-exclude.txt |
    cpio -pd --insecure $subset_dir

echo "find $subset_dir -type f | xargs du -s | sort -n"

txtar-c -quote -a $subset_dir >$SCRIPT_DIR/goldmark-subset.txtar

du -shc $SCRIPT_DIR/goldmark-subset.txtar
wc -l $SCRIPT_DIR/goldmark-subset.txtar
