We are building a chrome extension named "{{ .ProjectName }}".

I have never used the mutationobserver but I want to experiment with capturing certain stages of claude chat and I think mutation observer can help.

For example I want to log when various events happen like the following:

- when the url is first being rendered
- various dom elements "coming to life"
- when a specify string appears in the page

For now I'm only interested in exploring and not triggering functions but later I will want to tirgger functions based off these events.

{{ include "../webui-common/webui-common.md" . | trim }}"
