# Why You Need `tsconfig.json`

You will want to add this TypeScript configuration file if you want to:

**Build Chrome extensions with TypeScript** - TypeScript needs to understand Chrome extension APIs and module resolution in a browser context.

**Use modern bundlers like Vite** - You need `"moduleResolution": "bundler"` to properly resolve ES modules that bundlers process.

**Get IntelliSense for Chrome APIs** - Without `"types": ["chrome"]`, you won't get auto-completion or type checking for `chrome.storage`, `chrome.runtime`, etc.

**Import npm packages correctly** - Modern packages use ES modules that require proper module resolution configuration.

**Validate code without conflicting with your bundler** - `"noEmit": true` lets TypeScript do type checking while your bundler handles compilation.

**Use modern JavaScript features** - `"target": "ES2020"` enables async/await, optional chaining, and other modern syntax.

**Work with testing frameworks** - Including test types prevents TypeScript errors in your test files.

**Maintain code quality** - Strict TypeScript settings catch bugs early and enforce consistent coding patterns.

**Support team development** - Shared TypeScript configuration ensures all developers have the same type checking behavior.

This file is **foundational infrastructure** that enables the TypeScript toolchain to work properly with modern web development tools.
