# The Coral Project Docs

This is the documentation for The Coral Project, an initative by the [Mozilla Foundation](https://www.mozilla.org/en-US/foundation/) in partnership with [The New York Times](http://nytimes.com/), and [The Washington Post](http://washingtonpost.com/) to build an open source comment moderation system for newsrooms and media sites.

Please report bugs and corrections via [Github issues](https://github.com/coralproject/docs/issues) in this repository.

Our live documentation lives at [https://docs.coralproject.net](https://docs.coralproject.net).


# Contributing to the Docs

Make all documentation changes to the markdown files in the `docs_dir` directory.

Documentation is built with [mkdocs](http://www.mkdocs.org), a static document generator. 

To build the documentation:

1. Verify that you have python and pip installed on your local or virtual machine (version numbers may vary):
  ```python --version && pip --version```

Here are a few ways you can install python and pip:

-  [a direct install of pip](https://pip.pypa.io/en/stable/installing/) for a direct install
- via a package manager like [Homebrew for OSX](http://brew.sh/), [Ubuntu's apt-get](https://help.ubuntu.com/12.04/serverguide/apt-get.html) and others - [Quora - How is Homebrew different from apt-get or Yum?](https://www.quora.com/How-is-Homebrew-different-from-apt-get-or-Yum)


2. git clone this repository to a local development folder.

3. Install mkdocs and associated themes, dependencies and extensions:
  ```pip install mkdocs```
  ```pip install mkdocs-material```
4. Install the mkdocs themes that 

5. Build the documentation from the root directory of this repo.
  ```mkdocs build --clean```

6. Start a branch on your system, make your awesome contributions, commit them via git and submit a pull request.

7. Your contributions will be peer reviewed and merged with the master branch. 

8. There is a script connecting github to the AWS S3/Cloudfront hosting area via an Iron.io worker. 

Upon a successful update to master, it triggers an update to wipe the existing site files and copy over a new set which will appear at [https://docs.coralproject.net](https://docs.coralproject.net) within 2-3 minutes. This script information can be found in the docsync directory for details.

There is a development environment mirroring production which can be viewed at [https://testdocs.coralproject.net](https://testdocs.coralproject.net)


