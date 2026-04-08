Lets write some python code for project {{ .ProjectName }}.

Please fetch this for context:
https://github.com/zed-industries/zed/issues/4824#issuecomment-2797391831

TLDR; to work around this problem for now we can copy the contents of our global ignore file into our project .zed/settings.json file_scan_exclusions stanza.

We should use arparse allowing to specify project directory but assume . is our project directory.  

For debugging we should add --dry-run option to show what would be done at info level logging.

I've included example files in bash_log_listing_file_contents xml stanza below.

Make sure to handle directories and files appropriately.

<bash_log_listing_file_contents>
➜  mac prettier git:(master) ✗ head ~/.config/git/ignore
.env
.fmt/
.terraform.lock.hcl
.nearwait.yml
.nearwait.txtar
.project_rsync.sh
.project_watchexec.sh
make_txtar.sh
.DS_Store
scratch/
➜  mac prettier git:(master) ✗ cat ~/.config/zed/settings.json
// Zed settings
//
// For information on how to configure Zed, see the Zed
// documentation: https://zed.dev/docs/configuring-zed
//
// To see all of Zed's default settings without changing your
// custom settings, run the `open default settings` command
// from the command palette or from `Zed` application menu.
{
  "file_scan_exclusions": [
    "**/.DS_Store",
    "**/.classpath",
    "**/.git",
    "**/.hg",
    "**/.jj",
    "**/.settings",
    "**/.svn",
    "**/CVS",
    "**/Thumbs.db",
    "**/node_modules/**"
  ],
  "restore_on_startup": "none",
  "autosave": {
    "after_delay": {
      "milliseconds": 2000
    }
  },
  "project_panel": {
    "hide_gitignore": true
  },
  "agent": {
    "default_model": {
      "provider": "anthropic",
      "model": "claude-sonnet-4-latest"
    }
  },
  "vim_mode": true,
  "ui_font_size": 16,
  "buffer_font_size": 16
}
➜  mac prettier git:(master) ✗
</bash_log_listing_file_contents>

{{ include "../python-package/python-package.md" . | trim }}"
