# Writing Documentation

This section explains how the community can contribute to the Coral Project documentation.

You can contribute to the documentation by editing existing documents for clarity or correcting errors. Additionally, any new features or changes to the software should be thoroughly documented.

Here is, briefly, how our documentation works:

* The source documentation lives in GitHub at [https://github.com/coralproject/docs/](https://github.com/coralproject/docs/).
* The documentation is built using [MkDocs](http://www.mkdocs.org/), a Markdown-based static site generator (geared towards building project documentation).
* The document is deployed using a simple Mkdocs command that builds the documentation, and then the resulting generated site is pushed.

## Style Guide

There is a separate page for the [documentation style guide](docs_style_guide), that covers guidelines for how to organize and write instructions and tutorials, how to format text for consistency, and terminology.

## How the documentation is organized

The documentation is organized into several categories:

* **Introduction**: This offers a general overview of the Coral Project and its different components.
* **Developer Guide**: This provides information for technical users of the Coral Project. It offers installation instructions for the Coral Ecosystem as a whole, as well as installation instructions for each individual component.
* **User Guide**: This provides information for end users (publishers, journalists, moderators, readers) on how to use the features of Coral. It includes tutorials and how-to guides.
* **Contribute**: This provides information on how to contribute to the Coral Project through open source. There are sections for the developers (how to work with GitHub, etc.), as well as sections for those who want to contribute to other pieces of the Coral Project (such as the documentation!).
* **FAQ**

## How to obtain, write, and deploy documentation

Our documentation is hosted and deployed through GitHub. This guide will take you step by step through the process of getting the documentation on to your local machine, editing the documentation, and submitting your changes. If you've never worked with Git before, it might seem a little intimidating, but we've broken it down for you into manageable chunks.

Briefly, the process is as follows:

1. First, you will get the documentation source code, using Git.
2. Then, you will work on the documentation. You will use Mkdocs and Markdown to write the documentation.
3. Then, you will push your changes to GitHub.
4. Finally, you will deploy the documentation. The documentation is deployed using a simple Mkdocs command that builds the documentation, and then the resulting generated site is pushed to Heroku.

## Install and set up Git

If you don't already have Git installed, you'll want to get that set up first. You'll have to [download and install Git](https://git-scm.com/download). You can read more about Git on [their website](https://git-scm.com/).

You will also have to [create a GitHub account](https://help.github.com/articles/signing-up-for-a-new-github-account/), which is a very straightforward process.

After installing Git, the first thing you should do is setup your name and email using the following commands:
```
git config --global user.name "Your Real Name"
git config --global user.email "you@email.com"
```
Note that user.name should be your real name, not your GitHub username. The email you use in the user.email field will be used to associate your commits with your GitHub account.

## Install MkDocs

The Coral Project's documentation uses the [MkDocs](http://www.mkdocs.org/) documentation system, which uses [Markdown](http://daringfireball.net/projects/markdown/) to format text. Before you can get started on writing and editing the documentation, you will need to have MkDocs installed.

You can [download and install MkDocs](http://www.mkdocs.org/#installation) using the instructions on their website. The [MkDocs website](http://www.mkdocs.org/) also contains a lot of good information on writing documentation in MkDocs, and there are plenty of decent Markdown cheatsheets floating around, [like this one](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

## Getting the documentation

All of the documentation for the Coral Project [resides in GitHub](https://github.com/coralproject/docs) in the `docs` repository.

To get a local version of the documentation, clone the repository using this command:

```
git clone https://github.com/coralproject/docs.git
```

You now have a local copy of the documentation on your local machine, that you can modify and add to.

**Note**: If you already have a local copy of the documentation repository on your computer, be sure to perform a `git pull` before you start editing. This will ensure that you are working on the most recent available version of the documentation, which will prevent potential merge conflicts when you're ready to commit your changes.

## Writing and editing the documentation

The documents you'll be editing are the .md Markdown files located in the `docs_dir` directory. **DO NOT edit the files in the `site` directory.** Those files are the static HTML files generated by MkDocs and pushed to Heroku. If you edit the static HTML files, those changes won't get saved to the Markdown files.

As you are writing and editing the documentation, refer to the [Documentation Style Guide](docs_style_guide) to make sure you are remaining consistent with our current documentation standards, and writing the best and clearest documentation possible.
