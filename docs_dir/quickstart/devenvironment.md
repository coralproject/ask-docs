# Setting up your development environment

If you are going to work on Coral components on your machine, you will need to have certain components installed and configured.

## Go

If you want to install from source, you will need to have Go installed.

First [install Go](https://golang.org/dl/). The [installation and setup instructions](https://golang.org/doc/install) on the Go website are pretty good. Ensure that you have exported your $GOPATH environment variable, as detailed in the [installation instructions](https://golang.org/doc/install).

If you are not on a version of Go that is 1.7 or higher, you will also have to set the GO15VENDOREXPERIMENT flag.
```
export GO15VENDOREXPERIMENT=1
```

_If you are not on a version of Go 1.7 or higher, we recommend adding this to your ~/.bash_profile or other startup script._ TODO: add insx

## Git

You can find instructions on installing git [on the git website](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

## MongoDB
