If you need a build system and or test tool, use vite and vitest.

If you choose to use vite, then please follow this list of suggestions:

- follow this vite cjs node deprecation guide

<vite_cjs_node_deprecation>
{{ include (printf "%s/../use-vite/cjs.md" (templateFolder)) . | trim}}
</vite_cjs_node_deprecation>

- adjust these instructions to integegrate vite plugin checker into your build script

<vite_add_plugin_checker>
{{ include (printf "%s/../use-vite/vite-plugin-checker.md" (templateFolder)) . | trim}}
</vite_add_plugin_checker>
