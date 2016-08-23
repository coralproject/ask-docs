# The Coral Project

This is the documentation for The Coral Project, and it is a work in progress. Please report any issues in [Github](https://github.com/coralproject/docs/issues).

You can view the Coral Project documentation at [https://coralprojectdocs.herokuapp.com](https://coralprojectdocs.herokuapp.com).

## Building Documentation

Documentation is build via [mkdocs](http://www.mkdocs.org). To build the documentation:

1) Verify that you have python and pip installed (version numbers may vary): 
  `$ python --version
    Python 2.7.2
  $ pip --version
    pip 1.5.2`

If not follow [these steps](https://pip.pypa.io/en/stable/installing/).

2) Install mkdocs:
  `pip install mkdocs`

3) Build the documentation from the root directory of this repo.
  `mkdocs build`

4) Push to master. This will trigger an update of docs.coralproject.net that will take about 10 minutes. See the docsync directory for details.
