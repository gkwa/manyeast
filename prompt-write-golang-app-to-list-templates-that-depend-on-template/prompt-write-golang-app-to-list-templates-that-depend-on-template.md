Our application name will be {{ .ProjectName }}


# Boilerplate Template Dependency Detection Plan

## Motivation

When using boilerplate to generate templates like this:
```bash
rm -rf /tmp/stuff && boilerplate --disable-dependency-prompt --non-interactive \
  --output-folder=/tmp/stuff \
  --template-url /Users/mtm/pdev/taylormonacelli/manyeast/prompt-hilight-claude-question-response \
  && less /tmp/stuff/prompt-hilight-claude-question-response.md
```

We want to be able to **reflect on the complete dependency graph** that contributed to the final generated output. This includes understanding:

1. **What templates were involved** in the generation process
2. **How they depend on each other** (both explicitly and implicitly)
3. **What files were included or referenced** during template rendering

Currently, there's no way to query boilerplate to ask: "What templates and files contributed to generating this final output?"

## Problem: Two Types of Dependencies

Boilerplate templates have two distinct types of dependencies that need to be tracked:

### 1. Explicit Dependencies (in `boilerplate.yml`)
```yaml
dependencies:
  - name: pre-render
    template-url: ../does-boilerplate-offer-option-as-library
    output-folder: /tmp/does-boilerplate-offer-option-as-library
```

### 2. Implicit Template Dependencies (in template files)
```go
{{"{{"}} include "/tmp/does-boilerplate-offer-option-as-library/use-boilerplate-as-library.md" . | trim {{"}}"}}

{{"{{"}} snippet "sample-boilerplates.txtar" {{"}}"}}
```

## Solution: Create `gather` Subcommand

Build a golang app that imports the gruntwork boilerplate packages and adds a `gather` subcommand to:

1. **Recursively discover** boilerplate templates and config files across directories
2. **Parse and analyze** both explicit and implicit dependencies
3. **Generate a manifest** of the complete dependency graph
4. **Enable future rendering** through a `render` subcommand

## Implementation Plan

### Phase 1: Discovery and Parsing

1. **Directory Walking**
   - Recursively scan directories for `boilerplate.yml` files
   - Identify associated template files for each config
   - Build initial inventory of templates and configs

2. **Config Parsing**
   - Use existing `config.LoadBoilerplateConfig()` to parse `boilerplate.yml`
   - Extract explicit dependencies from config
   - Store parsed config structures

3. **Template Content Extraction**
   - Read template files as strings
   - Store content for later analysis

### Phase 2: Dependency Analysis

1. **Explicit Dependency Tracking**
   - Extract `dependencies` section from parsed configs
   - Build dependency graph from explicit declarations

2. **Implicit Dependency Detection**
   - Parse template files for boilerplate custom functions:
     - `include` calls
     - `snippet` calls
     - Other file-reading template helpers
   - Extract file paths from function arguments
   - Map template-to-file relationships

3. **Graph Construction**
   - Combine explicit and implicit dependencies
   - Create complete dependency graph
   - Detect circular dependencies (if any)

### Phase 3: Manifest Generation

Create data structure to capture complete template information:

```go
type TemplateManifest struct {
    Templates []TemplateInfo `json:"templates"`
}

type TemplateInfo struct {
    // File paths
    TemplatePath     string   `json:"template_path"`
    ConfigPath       string   `json:"config_path"`
    
    // Parsed content
    Config           *config.BoilerplateConfig `json:"config"`
    TemplateContent  string                    `json:"template_content"`
    
    // Dependencies
    ExplicitDeps     []variables.Dependency    `json:"explicit_deps"`
    ImplicitDeps     []string                 `json:"implicit_deps"`
}
```

### Phase 4: Future Rendering Capability

With the manifest, the app can:
- Understand the complete template ecosystem
- Render any discovered template using existing boilerplate logic
- Provide dependency graph visualization
- Enable "what-if" analysis of template changes

## Technical Considerations

### Template Function Detection
- Need comprehensive list of boilerplate's file-reading functions
- Implement robust parsing to extract file paths from template syntax
- Handle variable substitution in file paths (e.g., `{{"{{"}} include .SomeVar . {{"}}"}}`)

### Path Resolution
- Resolve relative paths correctly based on template locations
- Handle cross-directory references
- Account for boilerplate's path resolution logic

### Performance
- Efficient directory walking for large template repositories
- Lazy loading of template content where appropriate
- Caching of parsed configurations

## Deliverables

1. **`gather` subcommand** - Discovers and analyzes templates
2. **Dependency manifest** - Complete template and dependency inventory
3. **`render` subcommand** - Uses manifest to render templates
4. **Dependency graph output** - Visualization of template relationships

## Success Criteria

Given any boilerplate template execution, we can:
- Identify all templates that contributed to the output
- Map the complete dependency chain
- Understand both explicit and implicit file relationships
- Reproduce the generation process from the manifest



I've included boilerplate source her for reference:

```
<boilerplate_source>
{{ snippet (printf "%s/../does-boilerplate-offer-option-as-library/boilerplate.txtar" (templateFolder))  | trim}}
</boilerplate_source>
```


{{ include "../golang-app/golang-app.md" . | trim }}

