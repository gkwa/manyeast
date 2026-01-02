I have JavaScript project named {{ .ProjectName }} that I used to paste into Chrome DevTools, and this is working fine. 

However, what I need is a Chrome extension. So I'd like my chrome etension  to use TypeScript.  so we need to convert JavaScript to TypeScript and make an extension 

I've included a spec here as the README. 

<readme>
{{ include "README.md" . | trim }}"
</readme>

<JavaScript>
{{ include "product-card-copier.js" . | trim }}"
</JavaScript>

// webui example scaffold
{{ include "../webui-common/webui-common.md" . | trim }}"
