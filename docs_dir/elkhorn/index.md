# Introduction

[Elkhorn](https://github.com/coralproject/elkhorn) is the form composer and embeddable builder.

Elkhorn lets you create forms to solicit feedback from readers. You can then take the resulting forms and embed them in your website. The resulting data you collect is viewable in the [Ask](../ask) interface.

Elkhorn consists of the AskComposer and the embed service.

## AskComposer

AskComposer is a component that takes a spec in JSON format and turns it into a reader-facing form.

* AskComposer doesn't know where the JSON originates from. In our case, in will come from the Ask interface in Cay, but in theory it could come from anywhere.
* AskComposer stores the state of the form (completed fields, current progress, etc.).
* AskComposer persists or saves the state of the form by sending the form to a data storage destination (this could be S3 if you set that up during the installation process, or on your local drive if you've installed this locally without an S3 setup).
* Partial states may be stored locally, even if S3 has been set up.

## Embed service

The embed service uses the [rollup](http://rollupjs.org/) module bundler to generate a build of the form.

## Using the generated forms

### As a standalone page

The form can be viewed on a full standalone page, using the following URL:

```
https://[elkhornserver]/iframe/[form_id]
```

### Embedded as an iframe

You can take the standalone page link and use it in an iframe, which you can then embed directly into your page:

```
<iframe src="https://[elkhornserver]/iframe/[form_id]" width="100%" height="600px"></iframe>
```

* You may have to tweak the width and height parameters.

### Embedded directly into your page

You can render a form directly into a page, using a `script src` tag. This offers the advantages of native CSS inheritance, in addition to the benefits that come with iframes.

```
<div id="ask-form"></div><script src="[filewritelocation]/[formid].js"></script>
```
