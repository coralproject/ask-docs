# Using sample data with MongoDB

If you are installing locally, you will want to have a local MongoDB running with sample data. When you install the all-in-one Docker Compose installation, this portion is taken care of for you. However, if you are running from source, for example, you will want to set up your local MongoDB and import sample data.

## Download a sample data dump

We have provided an anonymized comments data dump for MongoDB, available to downlaod here: [MongoDB data dump](link here).
This data dump is 100MB. Download it to your computer.

## Download and install MongoDB

First, download and set up MongoDB. The MongoDB website offers [instructions on how to download and install](https://docs.mongodb.com/manual/installation/).

A nice GUI tool you can use with MongoDB is [MongoChef](http://3t.io/mongochef/download/), and it's quite easy to install and set up.

## Create your local coral database

TODO: add here

## Import data

The simplest way to do this is from the command line. First ensure you have MongoDB running.

Then, take the dump.tar.gz file you downloaded, place it in a folder, and extract it. Copy the directory path to the coral directory within the extracted file.

Then, run the below command (filling in your own directory path):
```
mongorestore -d coral /yourpath/dump/coral/
```

This will import all the data from the data dump into your own local MongoDB.
