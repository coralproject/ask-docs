# Writing Documentation

This section explains how the community can contribute to the Coral Project documentation.

You can contribute to the documentation by editing existing documents for clarity or correcting errors. Additionally, any new features or changes to the software should be thoroughly documented. We value clear, consistent, thorough, readable documentation!

Here is, briefly, how our documentation works:

* The source documentation lives in GitHub at [https://github.com/coralproject/docs/](https://github.com/coralproject/docs/).
* The documentation is hosted on [GitHub pages](https://pages.github.com/).
* The documentation is built using [MkDocs](http://www.mkdocs.org/), a Markdown-based static site generator (geared towards building project documentation).
* The document is deployed using a simple Mkdocs command that builds the documentation and deploys it to GitHub pages.

## Style Guide

There is a separate page for the [documentation style guide](style_guide), that covers guidelines for how to organize and write instructions and tutorials, how to format text for consistency, and terminology.

## How the documentation is organized

The documentation is organized into several categories:

* **Introduction**: This offers a general overview of the Coral Project and its different components.
* **Developer Guide**: This provides information for technical users of the Coral Project. It offers installation instructions for the Coral Ecosystem as a whole, as well as installation instructions for each individual component.
    * **Release Notes** also live within the Developer Guide section.
* **User Guide**: This provides information for end users (publishers, journalists, moderators, readers) on how to use the features of Coral. It includes tutorials and how-to guides.
* **Contribute**: This provides information on how to contribute to the Coral Project through open source. There are sections for the developers (how to work with GitHub, etc.), as well as sections for those who want to contribute to other pieces of the Coral Project (such as the documentation!).
* **FAQ**

# How to obtain, write, and deploy documentation

Our documentation is hosted and deployed through GitHub. This guide will take you step by step through the process of getting the documentation on to your local machine, editing the documentation, and submitting your changes. If you've never worked with Git before, it might seem a little intimidating, but we've broken it down for you into manageable chunks.

Briefly, the process is as follows:

1. First, you will get the documentation source code, using Git.
2. Then, you will work on the documentation. You will use Mkdocs and Markdown to write the documentation.
3. Then, you will push your changes to GitHub.
4. Finally, you will deploy the documentation. This is done using a simple Mkdocs commands that builds the documentation and deploys it to GitHub pages.

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

As you are writing the documentation, refer to the [Documentation Style Guide](style_guide) to make sure you are remaining consistent with our current documentation standards, and writing the best and clearest documentation possible.

## Commit your changes

Once you've finished your edits, it's time to commit your changes back up to the remote repository on GitHub.

First, you'll add your changes, where `<filename>` is the name of the file or files that you have changed.
```
git add <filename>
```

Then, you'll commit your changes. Be sure to add a commit message (the portion within the single quotations) to let everyone know what it is that you've changed. The `-m` flag is what tells Git that you're adding a commit message.
```
git commit -m 'Updated the Ask tutorial'
```

Finally, push your changes up to the remote repository:
```
git push origin master
```

## Deploy the documentation

Now that the documentation has been updated and committed to the repository, you can deploy the documentation. The documentation is hosted on Heroku, so in order to deploy it, we need to first build the files that make up the site, and then push those files up to Heroku.

First ensure that you have the latest version of the documentation on your local machine:
```
git pull
```

Then, run the following command:
```
mkdocs build --clean
```

The `build` command builds the documentation, creating the HTML pages that make up the site, and places those files in the `site` directory.

Now you'll add the changed files using Git, in preparation for pushing them to Heroku to deploy them. Add a meaningful commit message.
```
git add -A
```

There is one file that you have to "unadd" before you push to Heroku: the `index.php` file. Put briefly, it's a file that Heroku needs to serve up the site, but that the `mkdocs build` process deletes.
```
git reset HEAD index.php
```
Now commit your changes, adding a meaningful commit message.
```
git commit -m "Updated writing documentation page"
```

Now you'll push the `site` directory, containing the pages that make up the website, to Heroku.
```
git subtree push --prefix site heroku master
```

## Translating documentation

To come.
