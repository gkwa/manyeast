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

test ! -f {{ $mimeTypesFile }} && cat {{ $manifest }} | cut -d: -f2 |
    perl -p -e 's#^ *##' | sort -u > {{ $mimeTypesFile }}

grep --invert-match --file {{ $mimeTypesFile }} {{ $manifest }} |
    cut --delimiter : --fields 1 |
    cpio --insecure --pass-through --make-directories {{ $subsetDir }}

txtar-c {{ $subsetDir }} >{{ $txtarFile }}
du -shc {{ $txtarFile }}

find {{ .BaseDir }} -maxdepth 1

echo you should customize {{ $mimeTypesFile }}
