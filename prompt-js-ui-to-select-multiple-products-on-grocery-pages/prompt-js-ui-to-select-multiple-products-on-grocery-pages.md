We will create project {{ .ProjectName }} which is Chrome Extension project using typescript.

Project {{ .ProjectName }} will be a successor project to a previous project named lovelylark.  

Project {{ .ProjectName }} will use a lot of similar features of lovelylark which is why I've included
lovelyark's source code within xml element here:

<lovelylark_source>
{{ include "lovelylark.txtar" . | trim }}"
</lovelylark_source>

Here is the spec for our new project {{ .ProjectName }}

<{{ .ProjectName}}_spec >
{{ include "spec1.md" . | trim }}"
</{{ .ProjectName}}_spec >

{{ include "../webui-common/webui-common.md" . | trim }}"
