This creates a script that helps me pose a question to claude regarding some repo.








## example


When I do this:

```
rm -rf /tmp/stuff && boilerplate --disable-dependency-prompt --non-interactive --output-folder=/tmp/stuff --template-url github.com/gkwa/manyeast/littlelark --var RepoURL=https://github.com/gruntwork-io/boilerplate.git --var BaseDir=/tmp/test2 && cat /tmp/stuff/generate_txtar.sh
```

I see this:

```
#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

test ! -d /tmp/test2/boilerplate && git clone https://github.com/gruntwork-io/boilerplate.git /tmp/test2/boilerplate

rm -rf /tmp/test2/boilerplate_subset

cd /tmp/test2/boilerplate

test ! -f /tmp/test2/boilerplate.txt &&
    rg --files . -0 | xargs -0 file --mime-type >/tmp/test2/boilerplate.txt

test ! -f /tmp/test2/boilerplate_mime.txt &&
    cat /tmp/test2/boilerplate.txt | cut -d: -f2 | perl -p -e 's#^ *##' | sort -u > /tmp/test2/boilerplate_mime.txt

grep --invert-match --file /tmp/test2/boilerplate_mime.txt /tmp/test2/boilerplate.txt |
    cut --delimiter : --fields 1 |
    cpio --insecure --pass-through --make-directories /tmp/test2/boilerplate_subset

txtar-c /tmp/test2/boilerplate_subset >$SCRIPT_DIR/boilerplate_subset.txtar
du -shc $SCRIPT_DIR/boilerplate_subset.txtar

echo you should customize /tmp/test2/boilerplate_mime.txt
```

Then I run this:

```
bash -e /tmp/stuff/generate_txtar.sh
```

Next, I update `/tmp/test3/boilerplate_mime.txt` to reduce the exclusion filtering and re-run this:


```
bash -e /tmp/stuff/generate_txtar.sh
```


## example



When I do this:

```
rm -rf /tmp/stuff && boilerplate --disable-dependency-prompt --non-interactive --output-folder=/tmp/stuff --template-url github.com/gkwa/manyeast/littlelark --var RepoURL=https://github.com/gruntwork-io/boilerplate.git --var BaseDir=/tmp/test2 && cat /tmp/test2/boilerplate_mime.txt
```

I see this:

```
application/json
application/pdf
application/x-mach-binary
application/zip
image/jpeg
image/png
inode/x-empty
text/html
text/plain
text/x-c
text/x-java
text/x-shellscript
text/xml
```








