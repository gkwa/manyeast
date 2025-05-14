We need a golang app to recurse a directory structure renaming files from .tmpl to .md.

Also the files we're replacing along with other files will reference the files we're renaming so we'll need to update the references to the files we've renamed.

Our app should off the option to exclude recursing into a directory whose absolute path contains a substring and we should be allowed to specify this param multiple times for example --exclude .git --exclude trash.  By default this exclusion list should include .git.  The substring matching should be case insensitive.

Our app should offer --dry-run to not actually make the changes but in logging show what would be done.

If our app can't read a file or directory, it should not fail.  Instead it should log that and contine to the next file.

{{ include "../golang-app/golang-app.md" . | trim }}"
