# Chrome Extension Build Setup Guide

## The Problem

When building Chrome extensions, you typically need **multiple entry points**:
- `background.js` (service worker)
- `content.js` (runs on web pages) 
- `popup.js` (extension popup UI)

Modern bundlers like Vite try to optimize by creating **shared chunks** for common dependencies, but Chrome extensions **cannot reliably load these chunks** across different execution contexts due to security restrictions.

## Common Build Errors You'll Hit

If you try the "normal" multi-entry approach, you'll see these errors:

### Vite/Rollup Errors:
```
❌ "Cannot use import statement outside a module"
❌ "Invalid value for option 'output.inlineDynamicImports' - multiple inputs are not supported"  
❌ "Invalid value 'iife' for option 'output.format' - UMD and IIFE output formats are not supported for code-splitting builds"
```

### Webpack Errors:
```
❌ Module not found: Can't resolve './chunk-abc123.js'
❌ Loading chunk failed
```

### Parcel Errors:
```
❌ Could not load asset
❌ Failed to fetch dynamically imported module
```

## Does This Only Apply to Vite?

**No!** This problem affects **all modern bundlers**:
- **Vite/Rollup** - Tries to create shared chunks, conflicts with IIFE format
- **Webpack** - Code splitting breaks in extension contexts
- **Parcel** - Dynamic imports fail across extension boundaries
- **esbuild** - Similar chunking issues

The root cause is that Chrome extensions run scripts in **isolated contexts** that can't share modules like regular web apps.

## The Solution: Separate Builds

Instead of fighting the bundler, embrace separate builds for each entry point.

### Project Structure
```
my-extension/
├── src/
│   ├── background/
│   │   └── background.ts
│   ├── content/
│   │   └── content.ts
│   ├── popup/
│   │   ├── popup.ts
│   │   ├── popup.html
│   │   └── popup.css
│   └── manifest.json
├── vite.background.config.ts
├── vite.content.config.ts
├── vite.popup.config.ts
└── package.json
```

### Package.json Setup
```json
{
  "scripts": {
    "build": "shx rm -rf dist && shx mkdir -p dist && pnpm run build:all && pnpm run copy:assets",
    "build:all": "pnpm run build:background && pnpm run build:content && pnpm run build:popup",
    "build:background": "vite build --config vite.background.config.ts",
    "build:content": "vite build --config vite.content.config.ts", 
    "build:popup": "vite build --config vite.popup.config.ts",
    "copy:assets": "shx cp src/manifest.json src/popup/popup.html src/popup/popup.css dist/",
    "dev": "pnpm run build && pnpm run build --watch"
  },
  "devDependencies": {
    "@types/chrome": "^0.0.323",
    "typescript": "^5.8.3",
    "vite": "^6.3.5",
    "shx": "^0.3.4"
  }
}
```

### Individual Vite Configs

**vite.background.config.ts**
```typescript
import { defineConfig } from "vite"
import { resolve } from "path"

export default defineConfig({
  build: {
    emptyOutDir: false,
    rollupOptions: {
      input: resolve(__dirname, "src/background/background.ts"),
      output: {
        entryFileNames: "background.js",
        dir: "dist",
        format: "iife",
        inlineDynamicImports: true,
      },
    },
    target: "es2020",
  },
  define: {
    'process.env': {},
    'global': 'globalThis'
  },
})
```

**vite.content.config.ts**
```typescript
import { defineConfig } from "vite"
import { resolve } from "path"

export default defineConfig({
  build: {
    emptyOutDir: false,
    rollupOptions: {
      input: resolve(__dirname, "src/content/content.ts"),
      output: {
        entryFileNames: "content.js",
        dir: "dist",
        format: "iife",
        inlineDynamicImports: true,
      },
    },
    target: "es2020",
  },
  define: {
    'process.env': {},
    'global': 'globalThis'
  },
})
```

**vite.popup.config.ts**
```typescript
import { defineConfig } from "vite"
import { resolve } from "path"

export default defineConfig({
  build: {
    emptyOutDir: false,
    rollupOptions: {
      input: resolve(__dirname, "src/popup/popup.ts"),
      output: {
        entryFileNames: "popup.js",
        dir: "dist",
        format: "iife",
        inlineDynamicImports: true,
      },
    },
    target: "es2020",
  },
  define: {
    'process.env': {},
    'global': 'globalThis'
  },
})
```

### Manifest.json
```json
{
  "manifest_version": 3,
  "name": "My Extension",
  "version": "1.0.0",
  "description": "Extension description",
  "permissions": ["activeTab", "scripting"],
  "background": {
    "service_worker": "background.js"
  },
  "content_scripts": [
    {
      "matches": ["<all_urls>"],
      "js": ["content.js"]
    }
  ],
  "action": {
    "default_popup": "popup.html",
    "default_title": "My Extension"
  }
}
```

### popup.html
```html
<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>My Extension</title>
    <link rel="stylesheet" href="popup.css" />
  </head>
  <body>
    <div id="app">
      <!-- Your popup UI -->
    </div>
    <script src="popup.js"></script>
  </body>
</html>
```

## Key Points

### ✅ Do This:
- **Separate config files** for each entry point
- **IIFE format** (`format: "iife"`)
- **Inline dynamic imports** (`inlineDynamicImports: true`)
- **Cross-platform scripts** (use `shx` instead of bash commands)
- **Accept dependency duplication** (each file bundles its own deps)

### ❌ Don't Try This:
- Single Vite config with multiple inputs
- ES module format for Chrome extensions
- Fighting code-splitting (just disable it)
- Trying to share chunks between contexts

## Why This Works

Chrome extensions run scripts in **isolated contexts**:
- **Background scripts** run as service workers
- **Content scripts** run in web page context  
- **Popup scripts** run in extension popup context

These contexts **cannot share modules** due to Chrome's security model. By building separate self-contained files, we avoid all the cross-context loading issues.

## Alternative: Webpack Example

If you prefer Webpack:

```javascript
// webpack.config.js
const path = require('path');

module.exports = {
  entry: {
    background: './src/background/background.ts',
    content: './src/content/content.ts',
    popup: './src/popup/popup.ts'
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].js'
  },
  optimization: {
    splitChunks: false  // Disable code splitting
  },
  // ... rest of webpack config
}
```

But you'll still need plugins to copy manifest.json, handle TypeScript, etc.

## Summary

**The Mental Shift:** Chrome extensions are not web apps. They're multiple independent scripts that happen to communicate. Build them as separate applications, not as one app with multiple entry points.

This approach works with any bundler - the key is **one entry point per build** and **no code splitting**.
