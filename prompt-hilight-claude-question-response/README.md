Description


```
rm -rf /tmp/stuff && 
boilerplate \
    --disable-dependency-prompt \
    --non-interactive \
    --output-folder=/tmp/stuff \
    --template-url git@github.com:gkwa/manyeast.git//prompt-hilight-claude-question-response?ref=master && \
    less /tmp/stuff/prompt-hilight-claude-question-response.md
```
