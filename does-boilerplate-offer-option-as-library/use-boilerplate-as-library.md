I would like to make use of Gruntwork's boilerplate app as a golang library.

I am aware that `boilerplate` is offered as a binary to download, but instead of wrapping golang `os.system` around commandline call to the boilerplate binary, I want to include it into my golang app.

I've included the boilerplate source code within `<code/>` block here.

```
<code>
{{ snippet (printf "%s/../does-boilerplate-offer-option-as-library/boilerplate.txtar" (templateFolder))  | trim}}
</code>
```
