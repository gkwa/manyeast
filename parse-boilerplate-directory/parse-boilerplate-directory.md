I have some Gruntwork boilerplate templates.

I've included them in the template_examples_txtar xml element here.

<template_examples_txtar>
{{snippet "boilerplate-template-examples.txtar"}}
</template_examples_txtar>

What we need is a

I would like to make use of Gruntwork's boilerplate app as a golang library.

I am aware that `boilerplate` is offered as a binary to download, but instead of wrapping golang `os.system` around commandline call to the boilerplate binary, I want to include it into my golang app.

I've included boilerplate source as reference in boilerplate_src xml element:

<boilerplate_src>
{{snippet "/tmp/does-boilerplate-offer-option-as-library/boilerplate.txtar"}}
</boilerplate_src>
