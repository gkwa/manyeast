{{include "../common-apps/common-apps.md" . | trim }}

## our app will use typescript

## for build and test

{{include "../use-vite/use-vite.md" . | trim }}

## make sure to add source maps

For debugging we need to have source maps available. Vite allows you to set this.

## package manager

{{include "../pnpm/pnpm.md" . | trim }}

## for orchestration, we'll use just instead of make

{{include "../justfile/justfile.md" . | trim }}

## we most likely will need tsconfig.json too

{{ include (printf "%s/../webui-common/add-tsconfig.md" (templateFolder)) . | trim}}

## if we're building chrome extension and using vite keep these extra chrome extension instructions in mind

<chrome_extension_extra_instructions>
{{ include "../prompt-chrome-extension-multiple-entry-points/prompt-chrome-extension-multiple-entry-points.md" . | trim }}
</chrome_extension_extra_instructions>

