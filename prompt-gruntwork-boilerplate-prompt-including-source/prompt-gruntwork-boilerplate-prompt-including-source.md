I would like to make use of Gruntwork's boilerplate [app](https://github.com/gruntwork-io/boilerplate?tab=readme-ov-file#boilerplate) as a golang library.

I am aware that `boilerplate` is offered as a binary to download, but instead of wrapping golang `os.system` around commandline call to the boilerplate binary, I want to include it into my golang app.

I've included the boilerplate source code within `<boilerplate_source/>` block here.

```
<boilerplate_source>
{{ snippet "../does-boilerplate-offer-option-as-library/boilerplate.txtar" }}
</boilerplate_source>
```
