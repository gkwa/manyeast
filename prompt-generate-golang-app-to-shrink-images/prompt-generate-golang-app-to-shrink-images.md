I have collection of images that I need shrunk in file size.

The each time we shrink a file we should show 

- the original size 
- the new size
- the shrink percentage

the file sizes should be showing in user frindly MB format.

We should also see summary saying original total size and new total size.

If you need to take advantage of imagemagick, that's fine.

We should be able to specify globs on cli similar to this:

```
{{ .GoModuleName }} shrink *.jpg /tmp/*.jpg
```

Here's a sample of our files to give you perspective:

```
➜  mac /tmp ls 202*.jpg
20250520_134715.jpg  20250520_134721.jpg  20250520_134730.jpg  20250520_134739.jpg  20250520_134751.jpg
20250520_134717.jpg  20250520_134724.jpg  20250520_134734.jpg  20250520_134741.jpg  20250520_134754.jpg
20250520_134719.jpg  20250520_134727.jpg  20250520_134737.jpg  20250520_134743.jpg  20250520_134801.jpg
➜  mac /tmp
```

Maybe we should offer param to specify shrink level.


Lets use go for this.

{{ include "../golang-app/golang-app.md" . | trim }}"
