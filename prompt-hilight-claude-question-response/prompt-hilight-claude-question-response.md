We will create a chrome extension project named {{ .ProjectName }} for the purpose of highlighting elements on a web page.

Our purpose now is to be able to quickly see whether we have the right css or xpath or other selectors in place.  

By highlighting, we will be able to see whether we've got the right paths in place.

Also we will want some sort of message overly that appears showing what we've found as long as we have the debug switch enabled.  By having this debug on/off toggle on our extension popup we will be able to quickly see from all of the selectors we've added whether the page has changed and our selectors need updating to match upstream development.

I've included javascript as a proof of concept that we've tested in chrome dev tools that works with the page we're currently interested in, namely the claude chat interface.

```
<hilight_chat_items>
{{ snippet "highlight.js" | trim }}"
</hilight_chat_items>
```

We also will need to remove certain buttons or other items from the page and for this I've created a highlight javascript snippet that enables us to visually verify that we've got the right selectors.

We don't necessarily want to remove these items but possibly we will so for that we'll need both an option to highlight as well as to remove.


```
<hilight_chat_items>
{{ snippet "fetch-button.js" | trim }}"
</hilight_chat_items>
```

We need to keep these css selectors readably accessible because I assume the upstream pages will change often so for that we should be able to find them easily to adjust.

{{ include (printf "%s/../webui-common/webui-common.md" (templateFolder)) . | trim}}


