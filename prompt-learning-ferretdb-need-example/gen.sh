

mkdir -p /tmp/prompt-learning-ferretdb-need-example

if test -f /tmp/prompt-learning-ferretdb-need-example/out.txt; then
    cat /tmp/prompt-learning-ferretdb-need-example/out.txt
    exit 0
fi

lynx -dump https://docs.ferretdb.io/guides/vector-search/ > /tmp/prompt-learning-ferretdb-need-example/out.txt
cat /tmp/prompt-learning-ferretdb-need-example/out.txt
