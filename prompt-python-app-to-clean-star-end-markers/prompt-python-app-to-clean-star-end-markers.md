I need a python app named {{ .ProjectName }} that has subcommand cleanmarkers that takes as arguments 1 or more directory paths or file paths

Our app will do the following.  It will delete everything from the start of the file up to and including this exact string found at the beginning of the line:

.......... START ..........

Next, our app will remove everying staring with this string:

.......... END ..........

to the end of the file.  That dilemeter must be found at the beginning of the line similar to the start delimiter.

These start and end strings might exist anywhere in the file but we should not consider them as delimiters unless they're at the beginning of the line.

Our app will have --dry-run to only report what would be done without actually writing the file.

Our app will only operate on files that have extension defined by --ext param and the default will be --ext=md but we can overwrite this.

Our app will use argparse.

Our app will not recursively descend into directories that have absolute paths that contain --exclude={substring}.  We can specify multiple excludes like this: --exlucde=.git --exclude=trash.  Our default exclude list will be .git so that it doesn't descend into directories that have absolute paths with .git in it.

Our app will have the option to only operate on files that have modification times within --age=10m or 1d or 2.3w for example.  So if I specified --age=60s then our app would only operate on files modified within the last 1m.  The default

{{ include "../python-package/python-package.md" . | trim }}"
