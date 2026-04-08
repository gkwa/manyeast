# Spec: YAML-into-Markdown sync tool

Working name: TBD (referred to as `the tool` throughout this document).

A command-line tool written in Python that replaces a YAML code block inside a Markdown file with the contents of a standalone YAML file.

## The problem

You maintain YAML in a separate directory and iterate on it there. Periodically you want to copy that YAML into a specific code block inside an Obsidian Markdown file. This tool automates that copy-and-replace step.

## Identifying the target block

A Markdown file can contain many YAML code fence blocks. To identify which one to replace, the tool looks for an HTML comment anchor immediately above the code fence:

```
<!-- yaml-id: service-beta -->
```yaml
name: service-beta
replicas: 3
port: 8080
```
```

The anchor comment must appear on the line immediately above the opening ` ```yaml ` fence. The tool matches on the ID value you pass via the `--anchor` flag.

## Command-line interface

```
<tool> \
  --md-dir ~/obsidian/vault \
  --md-file notes.md \
  --yaml-dir ~/projects/configs \
  --yaml-file service-beta.yaml \
  --anchor service-beta \
  --dry-run
```

`--md-dir` is the base directory containing the Markdown file.

`--md-file` is the filename of the Markdown file relative to `--md-dir`.

`--yaml-dir` is the base directory containing the source YAML file.

`--yaml-file` is the filename of the YAML file relative to `--yaml-dir`.

`--anchor` is the ID to match inside the `<!-- yaml-id: ... -->` comment.

`--dry-run` is optional. When present, the tool prints a unified diff to stdout and does not modify the Markdown file.

## Behavior

### Normal run (no --dry-run)

The tool reads the Markdown file and locates every anchor comment matching the given ID. For each match, it identifies the YAML code fence block immediately below that comment and replaces the contents of that code fence with the contents of the source YAML file. It writes the updated Markdown file in place. It also prints a unified diff to stdout showing what changed.

### Dry run (--dry-run)

The tool does everything above except it does not write the updated Markdown file. It only prints the unified diff to stdout.

### Anchor not found

If no `<!-- yaml-id: ... -->` comment matching the given ID exists anywhere in the Markdown file, the tool appends the following to the end of the file:

```
<!-- yaml-id: service-beta -->
```yaml
name: service-beta
replicas: 3
port: 8080
```
```

This means the first run against a Markdown file that has no anchor yet will insert the block at the end. Subsequent runs will find the anchor and replace the YAML in place.

## Example

### Before

Source YAML file (`~/projects/configs/service-beta.yaml`):

```yaml
name: service-beta
replicas: 5
port: 9090
env: production
```

Markdown file (`~/obsidian/vault/notes.md`):

```
# Service Notes

Here are some thoughts about the architecture.

<!-- yaml-id: service-beta -->
```yaml
name: service-beta
replicas: 1
port: 9090
```

More notes below.
```

### Command

```
<tool> \
  --md-dir ~/obsidian/vault \
  --md-file notes.md \
  --yaml-dir ~/projects/configs \
  --yaml-file service-beta.yaml \
  --anchor service-beta
```

### After

The Markdown file now reads:

```
# Service Notes

Here are some thoughts about the architecture.

<!-- yaml-id: service-beta -->
```yaml
name: service-beta
replicas: 5
port: 9090
env: production
```

More notes below.
```

### Diff output

```diff
--- notes.md
+++ notes.md
@@ -5,4 +5,5 @@
 <!-- yaml-id: service-beta -->
 ```yaml
-name: service-beta
-replicas: 1
-port: 9090
+name: service-beta
+replicas: 5
+port: 9090
+env: production
 ```
```

## Constraints

One Markdown file, one YAML file, and one anchor ID per invocation. If the same anchor ID appears multiple times in the Markdown file, all matching blocks are updated.

No backup logic. The user manages version history with Git.

Python only. No external dependencies beyond the standard library if possible.

## Tests

Tests should use pytest. Each test creates temporary Markdown and YAML files, runs the tool's core logic, and asserts on the result. No real filesystem paths or Obsidian vaults should be required to run the test suite.

### Cases to cover

Replace a single YAML block. A Markdown file has one anchor matching the given ID. After running, the YAML inside that fence matches the source file. The rest of the Markdown is untouched.

Replace multiple YAML blocks with the same anchor. A Markdown file has the same anchor ID in two places. Both blocks are updated.

Dry run does not modify the file. Run with --dry-run. The Markdown file on disk is unchanged. Stdout contains a unified diff.

Append when anchor is missing. The Markdown file has no matching anchor. After running, the anchor comment and YAML fence block appear at the end of the file.

No diff when YAML is already identical. The source YAML matches what is already in the Markdown fence. The tool should produce no diff output and leave the file unchanged.

Other YAML blocks are not touched. A Markdown file has multiple YAML fences with different anchor IDs. Only the targeted one is replaced. The others remain exactly as they were.

Anchor comment without a YAML fence below it. The anchor comment exists but is not immediately followed by a YAML code fence. The tool should report an error and exit nonzero.