# Developer tools setup

In order to install and work on Coral, there are a number of tools and software components you'll need to install first. You may not need everything on this page, but we've collected all of the setup information here in one place for convenience.

## Git

If you don't already have Git installed, you'll want to get that set up first. You'll have to [download and install Git](https://git-scm.com/download). You can read more about Git on [their website](https://git-scm.com/).

You will also have to [create a GitHub account](https://help.github.com/articles/signing-up-for-a-new-github-account/), which is a very straightforward process.

After installing Git, the first thing you should do is setup your name and email using the following commands:
```
git config --global user.name "Your Real Name"
git config --global user.email "you@email.com"
```
Note that user.name should be your real name, not your GitHub username. The email you use in the user.email field will be used to associate your commits with your GitHub account.

## Go

You will need to have Go installed if you want to work on and/or install Coral components written in Go (these include Pillar, Sponge, and Xenia).

You can [download and install Go from their website](https://golang.org/dl/). The [installation and setup instructions](https://golang.org/doc/install) on the Go website are quite good.

Ensure that you have exported your $GOPATH environment variable, as detailed in the [installation instructions](https://golang.org/doc/install).

If you are not on a version of Go that is 1.7 or higher, you will also have to set the GO15VENDOREXPERIMENT flag.
```
export GO15VENDOREXPERIMENT=1
```

_If you are not on a version of Go 1.7 or higher, we recommend adding this to your ~/.bash_profile or other startup script._


## Node.js

You will need to have Node.js installed if you want to work on and/or install Coral components written in Node.js (these include Cay, Elkhorn, and Xenia Driver).

You can [download and install Node.js from their website](https://nodejs.org/en/download/).

* You must be running version 5.0.0 or higher of node. You can check your current version of node with the command `node --version`
* We recommend using [nvm](https://www.npmjs.com/package/nvm) to manage your node installations.

## Docker

If you want to install Coral or Coral components using Docker, you will have to install Docker Toolbox.

You can install Docker Toolbox from the [Docker Toolbox page](https://www.docker.com/products/docker-toolbox).

If you do have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose version`.

* On the server, you can install Docker with the following command:
```
sudo yum install docker
```

## MongoDB

### Using sample data with MongoDB

If you are installing locally, you will want to have a local MongoDB running with sample data. When you install the all-in-one Docker Compose installation, this portion is taken care of for you.

However, if you are running from source, for example, you will want to set up your local MongoDB and import sample data.

Additionally, if you ran into any problems with the automatic MongoDB setup portion of the installation, you can follow these instructions to import the data and set up your MongoDB manually.

### Download and install MongoDB

First, download and set up MongoDB. The MongoDB website offers [instructions on how to download and install](https://docs.mongodb.com/manual/installation/).

A nice GUI tool you can use with MongoDB is [MongoChef](http://3t.io/mongochef/download/), and it's quite easy to install and set up.

### Download the sample data dump

We have provided a sample data dump for MongoDB, available to download here: [MongoDB data dump](https://s3.amazonaws.com/coral-demo-dataset/dump.tar.gz).

### Import data

The simplest way to do this is from the command line. First, ensure you have MongoDB running.

Then, take the dump.tar.gz file you downloaded, place it in a folder, and extract it. Copy the path to the coral directory within the extracted file.

Then, run the below command (filling in your own directory path):
```
mongorestore -d coral /yourpath/dump/coral/
```

This will import all the data from the data dump into your own local MongoDB. You're all set!
