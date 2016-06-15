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
