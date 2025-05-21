# Request: JavaScript Vertical Spacing Tool

## Problem Statement

I have a JavaScript codebase where the code lacks sufficient vertical whitespace ("breathing room") between logical sections. This makes the code more difficult to read and navigate. While I'm already using Prettier for formatting, it doesn't provide options for controlling vertical spacing between logical sections of code.

## Example

Current code format (lacking vertical spacing):

```javascript
import { ConsoleLogger } from "./services/logger.js"
import { ContentBuilderService } from "./services/content-builder.js"
import { FormFinderService } from "./services/form-finder.js"
import { FormFillerService } from "./services/form-filler.js"
import { PageExtractorService } from "./services/page-extractor.js"
import { PageData } from "./types/extension.js"
import { DEFAULT_PROMPT } from "./config/prompt-templates.js"
const DEFAULT_CONFIG = {
  targetUrl: "https://claude.ai/new",
  extractionStrategy: "readability",
  preferHTML: false,
  predefinedText: DEFAULT_PROMPT,
}
async function initializeExtension(): Promise<void> {
  const verboseLevel = 0 // Default verbose level
  const logger = new ConsoleLogger(verboseLevel)
  logger.debug("Content script loaded")
  // Listen for messages from background script
  chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.action === "execute") {
      const config = { ...DEFAULT_CONFIG, ...message.config }
      const pageData = message.pageData as PageData | null
      // If we're in custom mode and have predefined text from config, use it
      if (config.mode === "custom" && config.predefinedText) {
        config.predefinedText = config.predefinedText
      } else {
        // Otherwise, use default prompt from constants
        config.predefinedText = DEFAULT_PROMPT
      }
      executeDirectly(config, pageData, logger)
        .then(() => sendResponse({ success: true }))
        .catch((error) => sendResponse({ success: false, error: error.message }))
      return true // Indicates we will send a response asynchronously
    }
  })
}
```

Desired code format (with vertical spacing between logical sections):

```javascript
import { ConsoleLogger } from "./services/logger.js"
import { ContentBuilderService } from "./services/content-builder.js"
import { FormFinderService } from "./services/form-finder.js"
import { FormFillerService } from "./services/form-filler.js"
import { PageExtractorService } from "./services/page-extractor.js"
import { PageData } from "./types/extension.js"
import { DEFAULT_PROMPT } from "./config/prompt-templates.js"

const DEFAULT_CONFIG = {
  targetUrl: "https://claude.ai/new",
  extractionStrategy: "readability",
  preferHTML: false,
  predefinedText: DEFAULT_PROMPT,
}

async function initializeExtension(): Promise<void> {
  const verboseLevel = 0 // Default verbose level
  const logger = new ConsoleLogger(verboseLevel)
  logger.debug("Content script loaded")
  
  // Listen for messages from background script
  chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.action === "execute") {
      const config = { ...DEFAULT_CONFIG, ...message.config }
      const pageData = message.pageData as PageData | null
      
      // If we're in custom mode and have predefined text from config, use it
      if (config.mode === "custom" && config.predefinedText) {
        config.predefinedText = config.predefinedText
      } else {
        // Otherwise, use default prompt from constants
        config.predefinedText = DEFAULT_PROMPT
      }
      
      executeDirectly(config, pageData, logger)
        .then(() => sendResponse({ success: true }))
        .catch((error) => sendResponse({ success: false, error: error.message }))
      return true // Indicates we will send a response asynchronously
    }
  })
}
```

## Requirements

1. Create a tool that parses JavaScript code into an AST and adds vertical whitespace between logical sections
2. The tool should work alongside Prettier, applying additional spacing as a post-processing step
3. The tool should identify common logical boundaries in the code, such as:
   - After import statement blocks
   - Between function declarations
   - Between variable declaration blocks and other code
   - Between logical sections within functions
   - Around control flow statements
4. The tool should be configurable and easy to integrate into our existing build process

## Preferred Solution Approach

A Node.js script that uses Babel's AST tools to parse the code, identify logical sections, and insert blank lines at appropriate positions, without interfering with other formatting applied by Prettier.

{{ include "../pnpm-project/pnpm-project.md" . | trim }}"

