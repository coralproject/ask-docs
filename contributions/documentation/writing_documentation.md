# Writing Documentation

This section explains how the community can contribute to the Coral Project documentation.

You can contribute to the documentation by editing existing documents for clarity or correcting errors. Additionally, any new features or changes to the software should be thoroughly documented. We value clear, consistent, thorough, readable documentation!

Here is how our documentation works:

* The source documentation lives in GitHub at [https://github.com/coralproject/docs/](https://github.com/coralproject/docs/).
* The documentation is hosted at [Read the Docs](https://www.readthedocs.org).
* When the documentation is updated and pushed to the GitHub repository, this triggers a build of the Read the Docs site.

## Getting the documentation

All of the documentation for the Coral Project [resides in GitHub](https://github.com/coralproject/docs) in the "docs" repository.

To get a local version of the documentation, clone the repository:

```
git clone https://github.com/coralproject/docs.git
```

If you haven't worked with Git before, you can find [instructions on downloading it here](TODO).

## Getting started with MkDocs

The Coral Project's documentation uses the [MkDocs](http://www.mkdocs.org/) documentation system, which uses Markdown to format text. The [MkDocs website](http://www.mkdocs.org/) contains a lot of good information on writing documentation in MkDocs, and there are plenty of decent Markdown cheatsheets floating around, [like this one](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

## How the documentation is organized

The documentation is organized into several categories:

* **Introduction**: This offers a general overview of the Coral Project and its different components.
* **Developer Guide**: This provides information for technical users of the Coral Project. It offers installation instructions for the Coral Ecosystem as a whole, as well as installation instructions for each individual component.
* **User Guide**: This provides information for end users (publishers, journalists, moderators, readers) on how to use the features of Coral. It includes tutorials and how-to guides.
* **Contribute**: This provides information on how to contribute to the Coral Project through open source. There are sections for the developers (how to work with GitHub, etc.), as well as sections for those who want to contribute to other pieces of the Coral Project (such as the documentation!).
* **FAQ**

## Writing style

The key thing to remember when writing documentation is to be extremely explicit and detailed. Do not assume knowledge!

### Do not assume knowledge

* Whenever possible, include an actual instruction.
    * Good:
    * If there are command line instructions involved, include the precise command line instruction. Instructions that users can copy/paste into the command line are great!
* Show "expected results" wherever possible. If a command line instruction should return a certain result, show that expected result. If there is a URL you can visit to test whether or not something is working, provide that URL as a link.
* If there are variables to configure, explicitly state the purpose of the variables. This should be explained in a comment in the configuration file, but you should also provide an explanation in your instructions.
* Do not merely explain HOW to do something, but also WHY you are doing it in that way. This makes it easier for users to troubleshoot issues.

### Commands and code blocks

* Enclose commands and code blocks in triple-tick blocks (```). Yes, Markdown supports indentation to delineate code blocks, but the triple-ticks make things more explicit.
* Be sure you are using universal command line commands, not shortcuts available in some shells!
    * Good: `mkdir exampledirectory`
    * Bad: `md exampledirectory`

### Third-party components

Is there a third-party component the user needs to set up (for instance, MongoDB)?

* Don't include all setup instructions, but do link to the setup instructions on the website of the third-party app in question.
* Be sure to detail any specific instructions they will need to integrate this third-party component into the system.
* Currently, much of this "third party setup" information resides in the "Developer Setup" document. This reduces duplication if there is a component that needs to be set up for multiple items.

### Markup specific style

* When adding headlines and section dividers, keep in mind that H1 (#) and H2 (##) text shows up in the Table of Contents. H3 (###) and below does not.
* To avoid making the ToC too cluttered, try to only use H2 (##) for key large sections.

### Installation instructions

* Be sure to include _every single step_. Preferably copy paste.
* When working from the command line, include every step in code blocks.

### API documentation

When documenting a REST-style API, such as the [Pillar API](../../pillar/api), there are certain pieces of information to include. The [Pillar API documentation](../../pillar/api) is a useful template.

* Create an initial table that lists endpoints, which contains:
    * The endpoint URL.
    * The HTTP verb for that endpoint (GET, POST).
    * The basic functionality description for that endpoint. Make this into a targeted link that jumps to the full description for that endpoint.
* Create a full description for each endpoint. You can see the [Get Users](../../pillar/api/#get-users) Pillar endpoint for an example). Each description should include:
    * The parameters for the endpoint (include the parameter name, whether it is required or optional, the type, and the description).
    * An example call.
    * The response for the example call (whether that is a JSON object, or simply a status response).

## Terminology

Here are some commonly used terms:

#### Software specific
* **Coral**: Refers to the Coral product, which includes the three components Trust, Ask, and Talk.
* **Coral Project**: Refers to the project of building and crafting the Coral product.
* **Coral Ecosystem**: Refers to all of the pieces that make up Coral from a more technical or development perspective: includes all the technical components such as Pillar, Sponge, and Cay.

#### Users

* **Developers**: Refers to the technical users of Coral who will be installing Coral and working with the backend. Also refers to open-source contributors.
* **End Users**: Refers to anyone who will be interacting with the Coral front end. Examples of end users are publishers, moderators, journalists, and readers.

## Release notes

## Improving the documentation

Improvements are welcomed! Did you perform an installation, and found some of the language or instructions confusing or missing? Help us fix it!

## Translating documentation
