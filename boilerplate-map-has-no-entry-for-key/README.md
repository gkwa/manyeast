```
map has no entry for key "ProjectName"
```

This error was driving me batty since i'm using the ["snippet" function](https://github.com/gruntwork-io/boilerplate?tab=readme-ov-file#template-helpers)

but it turns out I had another file that has a golang temple embedded that was being copied over too and as a result of being copied over, it too must go through the transformation...until I asked boilerplate to skip it which I should have done anyway since I'm already embedding it in my document using the snippet function.

The solution is this:

```
-- boilerplate.yml --
skip_files:
- path: test.txtar
```

## this fails

```
rm -rf /tmp/t; boilerplate --output-folder /tmp/t --template-url github.com/gkwa/manyeast/boilerplate-map-has-no-entry-for-key/unhappy-path
```

## this succeeds

```
rm -rf /tmp/t; boilerplate --output-folder /tmp/t --template-url github.com/gkwa/manyeast/boilerplate-map-has-no-entry-for-key/happy-path
```

## this is the difference

```
➜  mac manyeast git:(master) ✗ diff -uw --recursive /Users/mtm/pdev/taylormonacelli/manyeast/boilerplate-map-has-no-entry-for-key/unhappy-path /Users/mtm/pdev/taylormonacelli/manyeast/boilerplate-map-has-no-entry-for-key/happy-path
diff -uw --recursive /Users/mtm/pdev/taylormonacelli/manyeast/boilerplate-map-has-no-entry-for-key/unhappy-path/boilerplate.yml /Users/mtm/pdev/taylormonacelli/manyeast/boilerplate-map-has-no-entry-for-key/happy-path/boilerplate.yml
--- /Users/mtm/pdev/taylormonacelli/manyeast/boilerplate-map-has-no-entry-for-key/unhappy-path/boilerplate.yml	2025-05-12 15:35:26.000000000 -0700
+++ /Users/mtm/pdev/taylormonacelli/manyeast/boilerplate-map-has-no-entry-for-key/happy-path/boilerplate.yml	2025-05-12 15:35:37.000000000 -0700
@@ -0,0 +1,2 @@
+skip_files:
+- path: test.txtar
➜  mac manyeast git:(master) ✗
```

## log

```
➜  mac manyeast git:(master) rm -rf /tmp/t; boilerplate --output-folder /tmp/t --template-url github.com/gkwa/manyeast/boilerplate-map-has-no-entry-for-key/unhappy-path
[boilerplate] 2025/05/12 15:41:19 Downloading templates from github.com/gkwa/manyeast/boilerplate-map-has-no-entry-for-key/unhappy-path to /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3696773479
[boilerplate] 2025/05/12 15:41:20 Loading boilerplate config from /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3696773479/wd/boilerplate.yml
[boilerplate] 2025/05/12 15:41:20 Loading boilerplate config from /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3696773479/wd/boilerplate.yml
[boilerplate] 2025/05/12 15:41:20 Processing templates in /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3696773479/wd and outputting generated files to /tmp/t
[boilerplate] 2025/05/12 15:41:20 Skipping /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3696773479/wd
[boilerplate] 2025/05/12 15:41:20 Skipping /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3696773479/wd/boilerplate.yml
[boilerplate] 2025/05/12 15:41:20 Cleaning up working directory.
ERROR[2025-05-12T15:41:20-07:00] template: test.txtar:1:11: executing "test.txtar" at <.ProjectName>: map has no entry for key "ProjectName"  binary=boilerplate version=v0.6.1
➜  mac manyeast git:(master) rm -rf /tmp/t; boilerplate --output-folder /tmp/t --template-url github.com/gkwa/manyeast/boilerplate-map-has-no-entry-for-key/happy-path
[boilerplate] 2025/05/12 15:41:26 Downloading templates from github.com/gkwa/manyeast/boilerplate-map-has-no-entry-for-key/happy-path to /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486
[boilerplate] 2025/05/12 15:41:27 Loading boilerplate config from /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486/wd/boilerplate.yml
[boilerplate] 2025/05/12 15:41:27 Loading boilerplate config from /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486/wd/boilerplate.yml
[boilerplate] 2025/05/12 15:41:27 Processing templates in /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486/wd and outputting generated files to /tmp/t
[boilerplate] 2025/05/12 15:41:27 Following paths were picked up by Path attribute for SkipFile (test.txtar):
[boilerplate] 2025/05/12 15:41:27 	- /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486/wd/test.txtar
[boilerplate] 2025/05/12 15:41:27 Skipping /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486/wd
[boilerplate] 2025/05/12 15:41:27 Skipping /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486/wd/boilerplate.yml
[boilerplate] 2025/05/12 15:41:27 Skipping /var/folders/qk/5rcd35wx00jcj3zylnxcfvrr0000gn/T/boilerplate-cache3169320486/wd/test.txtar
[boilerplate] 2025/05/12 15:41:27 Cleaning up working directory.
➜  mac manyeast git:(master)
```
