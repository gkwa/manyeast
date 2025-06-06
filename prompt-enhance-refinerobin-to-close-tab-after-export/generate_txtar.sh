#!/usr/bin/env bash

cat <<'EOF'
BaseDir = /tmp/tt
clonedDir = /tmp/tt/refinedrobin_818fda4d_1749228573
excludeTmpFile = refinedrobin_818fda4d_1749228573_exclude.tmp
filterManifest = /tmp/tt/refinedrobin_818fda4d_1749228573_filter.txt
manifest = /tmp/tt/refinedrobin_818fda4d_1749228573.txt
mimeTypesFile = /tmp/tt/refinedrobin_818fda4d_1749228573_mime.txt
OutputFolder = /tmp/stuff
repoBase = refinedrobin
repoName = refinedrobin
RepoURL = https://github.com/gkwa/refinedrobin
safeDirName = refinedrobin_818fda4d_1749228573
subsetDir = /tmp/tt/refinedrobin_818fda4d_1749228573_subset
txtarFile = /tmp/stuff/refinedrobin_818fda4d_1749228573_subset.txtar
urlHash = 818fda4d
EOF

test ! -d /tmp/tt/refinedrobin_818fda4d_1749228573 && git clone https://github.com/gkwa/refinedrobin /tmp/tt/refinedrobin_818fda4d_1749228573

rm -rf /tmp/tt/refinedrobin_818fda4d_1749228573_subset

cd /tmp/tt/refinedrobin_818fda4d_1749228573

if [[ -s /tmp/tt/refinedrobin_818fda4d_1749228573.txt ]]; then
    echo skipping /tmp/tt/refinedrobin_818fda4d_1749228573.txt creation since it already exists
else
    rg --files . -0 | xargs -0 file --mime-type >/tmp/tt/refinedrobin_818fda4d_1749228573.txt
fi

if test ! -f /tmp/tt/refinedrobin_818fda4d_1749228573_mime.txt; then
    cat /tmp/tt/refinedrobin_818fda4d_1749228573.txt |
        cut --delimiter : --fields 2 |
        perl -p -e 's#^ *##' |
        sort --unique > /tmp/tt/refinedrobin_818fda4d_1749228573_mime.txt

    cat >refinedrobin_818fda4d_1749228573_exclude.tmp <<EOF
AUTHORS
BENCHMARKS
CHANGELOG
CHANGES
CONTRIBUTING
CODE_OF_CONDUCT
poetry.lock
COPYING
LICENSE
MANIFEST
application/zip
application/octet-stream
image/
font/
go.sum
yarn.lock
package-lock
pnpm-lock
EOF
    cat refinedrobin_818fda4d_1749228573_exclude.tmp

    cat refinedrobin_818fda4d_1749228573_exclude.tmp >>/tmp/tt/refinedrobin_818fda4d_1749228573_mime.txt
    rm -f refinedrobin_818fda4d_1749228573_exclude.tmp

    perl -i -ne '
        chomp;
        next if $_ eq "application/json";
        next if $_ eq "text/html";
        next if $_ eq "text/plain";
        next if $_ eq "text/x-c++";
        print "$_\n";
    ' /tmp/tt/refinedrobin_818fda4d_1749228573_mime.txt
fi

grep --invert-match --file /tmp/tt/refinedrobin_818fda4d_1749228573_mime.txt /tmp/tt/refinedrobin_818fda4d_1749228573.txt |
    cut --delimiter : --fields 1 |
    cpio --insecure --pass-through --make-directories /tmp/tt/refinedrobin_818fda4d_1749228573_subset

txtar-c /tmp/tt/refinedrobin_818fda4d_1749228573_subset >/tmp/stuff/refinedrobin_818fda4d_1749228573_subset.txtar
du -sh /tmp/stuff/refinedrobin_818fda4d_1749228573_subset.txtar
echo

echo nvim /tmp/tt/refinedrobin_818fda4d_1749228573_mime.txt
echo

echo \#run this again
echo bash -e /tmp/stuff/generate_txtar.sh
echo

echo \#find how you can reduce
echo find /tmp/tt/refinedrobin_818fda4d_1749228573_subset -not -path \'*/\.git*\' -type f -print0 \| xargs -0 wc -l \| sort -n
echo find /tmp/tt/refinedrobin_818fda4d_1749228573_subset -not -path \'*/\.git*\' -type f -print0 \| xargs -0 du -s \| sort -n
echo ncdu /tmp/tt/refinedrobin_818fda4d_1749228573_subset
echo

echo du -shc /tmp/stuff/refinedrobin_818fda4d_1749228573_subset.txtar
echo cat /tmp/stuff/refinedrobin_818fda4d_1749228573_subset.txtar \| pbcopy
