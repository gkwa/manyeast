You are a web developer expert eager to help a new developer who is not familiar with writing web ui applications.

We will create a new project named `{{ .ProjectName }}`.

We need a fuzzy search textbox that has these characteristics:

when I type some characters into some input field and some candidates appear, I should be able to select from one of the candidates by using
- `Ctrl-n` to move down through the list or
- `Ctrl-k` to move up through the list

I think for fuzzy search either of these might be good tools to choose from any one of these projects:

### @nozbe/microfuzz

- https://github.com/nozbe/microfuzz?tab=readme-ov-file#--a-tiny-simple-fast-js-fuzzy-search-library

### fuse.js

- https://github.com/krisk/fuse?tab=readme-ov-file#fusejs

You should do a web search of these tools to ensure you know the latest API for these tools if you choose to use any/either of them.

Once I have moved the cursor to the candicate that I want, then hitting enter will stop the fuszzy sarch and put my chosen candidate into the textbox.

The workflow will be like this:

- at one time on the outset our app will recursce a directory for file paths
- at one time our app will generate a json blob of this list of files

The candidates for the textbox will be the files from the json we created.  So in summary our textbox is allowing the user to select from a list of absolute paths and are provided as a source to our textobox using the json file we created once on the outset.

The user is presented with a page that has a textbox

{{include "../webui-common/webui-common.md" . | trim }}
