#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

{{/* Get repository name using path API and replaceAll for .git */ -}}
{{ $repoBase := base .RepoURL -}}
{{ $repoName := replaceAll ".git" "" $repoBase -}}
{{ $clonedDir := printf "%s/%s" .BaseDir $repoName -}}
{{ $subsetDir := printf "%s_subset" $clonedDir -}}
{{ $manifest := printf "%s.txt" $clonedDir }}
{{ $filterManifest := printf "%s_filter.txt" $clonedDir }}
{{ $mimeTypesFile := printf "%s_mime.txt" $clonedDir }}

test ! -d {{ $clonedDir }} && git clone {{ .RepoURL }} {{ $clonedDir }}

rm -rf {{ $subsetDir }}

cd {{ $clonedDir }}

test ! -f {{ $manifest }} &&
    rg --files . -0 | xargs -0 file --mime-type >{{ $manifest }}

test ! -f {{ $mimeTypesFile }} &&
    cat {{ $manifest }} | cut -d: -f2 | perl -p -e 's#^ *##' | sort -u > {{ $mimeTypesFile }}

grep --invert-match --file {{ $mimeTypesFile }} {{ $manifest }} |
    cut --delimiter : --fields 1 |
    cpio --insecure --pass-through --make-directories {{ $subsetDir }}

txtar-c {{ $subsetDir }} >$SCRIPT_DIR/{{ $repoName }}_subset.txtar
du -shc $SCRIPT_DIR/{{ $repoName }}_subset.txtar

find {{ .BaseDir }} -maxdepth 1

echo you should customize {{ $mimeTypesFile }}
