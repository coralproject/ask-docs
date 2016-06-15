# Introduction

[Elkhorn](https://github.com/coralproject/elkhorn) is the form composer and embeddable builder.

## AskComposer:

- ...takes an **Ask spec** in some sort of serialization (JSON or any other), and renders it.
- ...does not know where the serialized spec came from.
- ...stores the state of the form (completed fields, current progress, etc)
- ...persists the state by sending the completed form to a server destination
- ...may persist partial states locally

## Embed Service:

- ...uses **rollup** (and it's amazing "tree-shaking" feature) to generate a build of minimum size.

## To view forms

### As a standalone page

A full page including the form is rendered from this endpoint:

```
https://[elkhornserver]/iframe/[form_id]
```

### via iFrame

The standalone page link is suitable for an iframe:

```
<iframe src="https://[elkhornserver]/iframe/[form_id]" width="100%" height="600px"></iframe>
```

* Note that the width and height parameters may need to be tweaked.

iframes can be embedded directly into pages

### Rendered directly into a page

We can also render a form directly into a page.  This provides the advantages of native css inheritance as well as all the other issues that come with iframes.

```
<div id="ask-form"></div><script src="[filewritelocation]/[formid].js"></script>
```
