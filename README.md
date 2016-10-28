# The Coral Project Docs

This is the documentation for The Coral Project, an initative by the [Mozilla Foundation](https://www.mozilla.org/en-US/foundation/) in partnership with [The New York Times](http://nytimes.com/), and [The Washington Post](http://washingtonpost.com/) to build an open source comment moderation system for newsrooms and media sites.

Please report bugs and corrections via [Github issues](https://github.com/coralproject/docs/issues) in this repository.

Our live documentation lives at [https://docs.coralproject.net](https://docs.coralproject.net).


# Coral Team Notes and Instructions to edit the Docs


Make all documentation changes to the markdown files in the `docs_dir` directory.


Documentation is built via [mkdocs](http://www.mkdocs.org). To build the documentation:

1) Verify that you have python and pip installed (version numbers may vary): 
  ```python --version && pip --version```

If not follow [these steps](https://pip.pypa.io/en/stable/installing/).

2) Install mkdocs:
  ```pip install mkdocs```

3) Install the mkdocs themes that are located in the /themes directory:
  ```pip install mkdocs-cinder```

3) Build the documentation from the root directory of this repo.
  ```mkdocs build```

4) Push to master. This will trigger an update of docs.coralproject.net that will take about 10 minutes. See the docsync directory for details.
