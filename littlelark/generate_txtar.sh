#!/usr/bin/env bash

{{/* Get repository name using path API and replaceAll for .git */ -}}
{{ $repoBase := base .RepoURL -}}
{{ $repoName := replaceAll ".git" "" $repoBase -}}
{{ $clonedDir := printf "%s/%s" .BaseDir $repoName -}}
{{ $subsetDir := printf "%s_subset" $clonedDir -}}
{{ $manifest := printf "%s.txt" $clonedDir -}}
{{ $filterManifest := printf "%s_filter.txt" $clonedDir -}}
{{ $mimeTypesFile := printf "%s_mime.txt" $clonedDir -}}
{{ $txtarFile := printf "%s/%s_subset.txtar" .OutputFolder $repoName -}}

test ! -d {{ $clonedDir }} && git clone {{ .RepoURL }} {{ $clonedDir }}

rm -rf {{ $subsetDir }}

cd {{ $clonedDir }}

if [[ -s {{ $manifest }} ]]; then
    echo skipping {{ $manifest }} creation since it already exists
else
    rg --files . -0 | xargs -0 file --mime-type >{{ $manifest }}
fi

test ! -f {{ $mimeTypesFile }} && cat {{ $manifest }} |
    cut --delimiter : --fields 2 |
    perl -p -e 's#^ *##' |
    sort --unique > {{ $mimeTypesFile }}

grep --invert-match --file {{ $mimeTypesFile }} {{ $manifest }} |
    cut --delimiter : --fields 1 |
    cpio --insecure --pass-through --make-directories {{ $subsetDir }}

txtar-c {{ $subsetDir }} >{{ $txtarFile }}
du -sh {{ $txtarFile }}
cat {{ $mimeTypesFile }}

echo

echo \#customize this {{ $mimeTypesFile }}
echo nvim {{ $mimeTypesFile }}
echo

echo \#run this again
echo bash -e {{ .OutputFolder }}/generate_txtar.sh
echo

echo \#find how you can reduce
echo find {{ $subsetDir }} -not -path \'*/\.git*\' -type f -print0 \| xargs -0 wc -l \| sort -n
echo find {{ $subsetDir }} -not -path \'*/\.git*\' -type f -print0 \| xargs -0 du -s \| sort -n
echo ncdu {{ $subsetDir }}
echo

echo du -shc {{ $txtarFile }}
echo cat {{ $txtarFile }} \| pbcopy
