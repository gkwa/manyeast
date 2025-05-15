{{ include "../add-google-search-links/add-links.md" . | trim }}"

## Request for YAML-Driven Web Form Generator

I'm seeking a tool that generates web forms based on variables extracted from YAML files. This tool would provide the following functionality:

### Core Requirements

- Parse YAML files to extract variables and their properties
- Present users with a template alongside required variables
- Allow users to input values for each variable
- Render the completed template with populated variables

### Desired User Flow

1. User opens a catalog page listing available templates
1. User selects a template
1. Template appears with labeled variables and input fields
1. User completes the form
1. User clicks a button to copy the filled-in template to their system clipboard

### Implementation Approach

- Convert YAML to structured data (list of dictionaries)
- Generate dynamic form fields based on variable definitions
- Provide real-time preview or rendering capability
- Implement clipboard functionality for the final output

### Example YAML Files

<examples>
{{ snippet "examples.txtar" }}"
</examples>

I would appreciate recommendations for existing solutions or guidance on building this functionality.
