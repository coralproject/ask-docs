# Introduction

[Elkhorn](https://github.com/coralproject/elkhorn) is the form composer and embeddable builder.

Elkhorn lets you create forms to solicit feedback from readers. You can then take the resulting forms and embed them in your website. The resulting data you collect is viewable in the [Ask](../ask) interface.

Elkhorn consists of the AskComposer and the Embed Service, which acts as an API.

## Composition

<img src="/images/elkhorn-architecture.svg">

## Ask Composer

the Embed Service generates a Bundle with all the required Javascript to build & run the form, including Ask Composer which is just a javascript class

AskComposer is a component that takes a spec in JSON format and turns it into a reader-facing form.

* AskComposer doesn't know where the JSON originates from. In our case, in will come from the Ask interface in Cay, but in theory it could come from anywhere.
* AskComposer stores the state of the form (completed fields, current progress, etc.).
* AskComposer persists or saves the state of the form by sending the form to a data storage destination (this could be S3 if you set that up during the installation process, or on your local drive if you've installed this locally without an S3 setup).
* Partial states may be stored locally, even if S3 has been set up.

## Embed Service

The Embed Service is a REST-style API.

* The Embed Service talks to Cay, to receive the form spec in JSON format, and to pass the fully rendered form from Ask Composer to Cay.
* The Embed Service passes the completed rendered form to Pillar.
* The Embed Service receives the form submission data from the embedded forms on the partner sites, and passes this data on to Pillar.

The Embed Service uses the [rollup](http://rollupjs.org/) module bundler to generate a build of the form.

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
