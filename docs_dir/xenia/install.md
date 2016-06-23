# Xenia Installation

Xenia is a configurable service layer that publishes endpoints against [mongo aggregation pipeline queries](https://docs.mongodb.org/manual/core/aggregation-introduction/).

## Before you begin

Before you install Xenia, you will want to have the following installed.

#### MongoDB
You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).

There are [instructions on importing sample comment data into MongoDB here](../../quickstart/mongodb)

#### Go

If you want to install from source, you will need to have Go installed.

You can install [install Go from their website](https://golang.org/dl/). The [installation and setup instructions](https://golang.org/doc/install) on the Go website are quite good. Ensure that you have exported your $GOPATH environment variable, as detailed in the [installation instructions](https://golang.org/doc/install).

If you are not on a version of Go that is 1.7 or higher, you will also have to set the GO15VENDOREXPERIMENT flag.
```
export GO15VENDOREXPERIMENT=1
```

_If you are not on a version of Go 1.7 or higher, we recommend adding this to your ~/.bash_profile or other startup script._

## Obtaining the source code

You can install the source code via using the `go get` command, or by manually cloning the code.

### Using the go get command
```
go get github.com/coralproject/xenia
```
If you see a message about "no buildable Go source files" like the below, you can ignore it. It simply means that there are buildable source files in subdirectories, just not the uppermost xenia directory.
```
package github.com/coralproject/xenia: no buildable Go source files in [directory]
```

### Cloning manually
You can also clone the code manually.

```
mkdir $GOPATH/src/github.com/coralproject/xenia
cd $GOPATH/src/github.com/coralproject/xenia

git clone git@github.com:CoralProject/xenia.git
```

## Set up your environment variables

This tells Xenia which database you want to use, sets your port, and sets your database password.

Make your own copy of the `config/dev.cfg` file (this edited cfg file will contain your own values for things like your database password, and will not be committed back to the repository if you are doing development work on Xenia). Call your config file whatever you like; we'll call it "custom" in this example.

```
cd $GOPATH/src/github.com/coralproject/xenia
cp config/dev.cfg config/custom.cfg
```
Edit the environment variables to reflect your MongoDB setup.
_Remember, you're entering your password here, so be sure not to commit this file to the repository!_
```
export XENIA_MONGO_HOST=localhost:27017
export XENIA_MONGO_USER=coral-user
export XENIA_MONGO_AUTHDB=coral
export XENIA_MONGO_DB=coral

export XENIA_LOGGING_LEVEL=1
export XENIA_HOST=:4000

# Use to have the CLI tooling hit the web service.
export XENIA_WEB_HOST=
export XENIA_WEB_AUTH=

# Set host to Anvil if configured.
# export XENIA_ANVIL_HOST=https://HOST

# Use to apply extra key:value pairs to the header
# export XENIA_HEADERS=key:value,key:value

# DO NOT PUSH TO REPO
export XENIA_MONGO_PASS=
```

Required edits:

* `XENIA_MONGO_HOST`: set to your MongoDB where you will be communicating with.
    * If you are running MongoDB locally on your machine, you should set this to `localhost:27017`.
    * If you are pointing to a MongoDB running on a server somewhere, set this to the IP address and port of your MongoDB.
* `XENIA_MONGO_DB`: the database you are running queries against (`coral`).
* `XENIA_MONGO_USER`: your MongoDB username.
* `XENIA_MONGO_PASS`: the password for your MongoDB user.
* `XENIA_MONGO_AUTHDB`: the database you are authenticating against (in most cases, should be the same `coral` database as XENIA_MONGO_DB).

Optional edits:

* `XENIA_WEB_HOST`: this is required for the CLI tool. It is the address of the Xenia web service (i.e., an instance of Xenia that you are running on a server).
    * If you are running everything locally, comment this variable out. This means that the CLI tool will connect directly to your local database, instead of connecting to a running web service.
* `XENIA_HOST`: default is `:4000` if this variable is not set.
* `XENIA_LOGGING_LEVEL`: default is `2` if this variable is not set.
* `XENIA_WEB_AUTH`: your Anvil token, if you have Anvil authentication set up. If you do not have authentication set up, leave this commented out.
* `XENIA_ANVIL_HOST`: the URL to the Anvil host, if you have Anvil authentication set up. If you do not have authentication set up, leave this commented out.
* `XENIA_HEADERS`: leave this commented out.

Once you've finished editing, source your config file using the source command:
```
source $GOPATH/src/github.com/coralproject/xenia/config/custom.cfg
```

## Build the CLI tool

Xenia has a CLI tool that allows you to manage endpoints and perform other actions.

To build to the tool:

```
cd $GOPATH/src/github.com/coralproject/xenia/cmd/xenia
go build
```

_Note: It is best to run with logging level 0 when using the xenia command:_

```
export XENIA_LOGGING_LEVEL=0
```

## Creating a Xenia database for the first time

If you are running Xenia on a MongoDB database for the first time you will need the Xenia command line tool to set up the MongoDB for use with Xenia. The CLI tool will create collections and sets of indexes that you can use to execute queries: a sort of dictionary of pre-made queries for you to use.

1) First cd into cmd/xenia directory (this contains the CLI tool):
```
cd $GOPATH/src/github.com/coralproject/xenia/cmd/xenia
```

2) Configure the database using `db create`. The database.json file contains the information necessary to create the collections and indexes.

```
./xenia db create -f scrdb/database.json
```
Expected output:
```
Configuring MongoDB
Creating collection query_sets
Creating collection query_sets_history
Creating collection query_scripts
Creating collection query_scripts_history
Creating collection query_masks
Creating collection query_masks_history
Creating collection query_regexs
Creating collection query_regexs_history
```

* **Troubleshooting note #1**: if you get a response that contains `ERROR: Invalid DB provided`, you may have an incorrectly set environment variable. If you are running everything locally and using a local MongoDB, use `printev` to see if `XENIA_WEB_HOST` is set:

```
printenv XENIA_WEB_HOST
```

  If you are using a local MongoDB, this should not return a value. If it does return a value, unset the variable using `unset`, and then try step 2 again:

```
unset XENIA_WEB_HOST
```

* **Troubleshooting note #2**: instead of the expected output shown above, you may see something like:

```
Configuring MongoDB
Creating collection query_sets
ERROR: collection already exists
```

  That's okay! It means that your database is already set up with Xenia. Perhaps you imported data that already had configured collections set up. Continue on to step 3.

3) Load all the existing queries:
```
./xenia query upsert -p scrquery
```
Expected output:
```
Configuring MongoDB
Upserting Set : Path[scrquery]
Upserting Set : Upserted
```

4) Load all the existing masks:
```
./xenia mask upsert -p scrmask
```
Expected output:
```
Configuring MongoDB
Upserting Set : Path[scrquery]
Upserting Set : Upserted
```

5) Load all the existing regexes:
```
./xenia regex upsert -p scrregex
```
Expected output:
```
Configuring MongoDB
Upserting Regex : Path[scrregex]
Upserting Regex : Upserted
```

6) That's it! If you are using MongoChef, you should be able to see your newly created collections, which will look something like this:

![Screenshot](../images/xeniacollections.png)

## Run the web service

1) First cd into the directory containing the web service, xeniad (the Xenia daemon):
```
cd $GOPATH/src/github.com/coralproject/xenia/cmd/xeniad
```

2) Build the Xenia web service:
```
go build
```

3) Run the web service:
```
./xeniad
```
Expected output:
```
2016/06/08 10:26:38 app.go:173: USER : startup : Init :

Config Settings:
MONGO_USER=coral-user
MONGO_AUTHDB=coral
MONGO_DB=coral
HOST=:4000
LOGGING_LEVEL=1
MONGO_HOST=localhost:27017

2016/06/08 10:26:38 main.go:24: USER : startup : Init : Revision     : "<unknown>"
2016/06/08 10:26:38 main.go:25: USER : startup : Init : Version      : "<unknown>"
2016/06/08 10:26:38 main.go:26: USER : startup : Init : Build Date   : "<unknown>"
2016/06/08 10:26:38 main.go:27: USER : startup : Init : Int Version  : "201606081030"
2016/06/08 10:26:38 main.go:28: USER : startup : Init : Go Version   : "go1.6.2"
2016/06/08 10:26:38 main.go:29: USER : startup : Init : Go Compiler  : "gc"
2016/06/08 10:26:38 main.go:30: USER : startup : Init : Go ARCH      : "amd64"
2016/06/08 10:26:38 main.go:31: USER : startup : Init : Go OS        : "darwin"
```

4) You can test your web service by going to the following URL in your browser: [http://localhost:4000/1.0/query](http://localhost:4000/1.0/query).

In your browser, you will see some json displayed. In your terminal, you should see something like:
```
2016/06/08 13:30:58 app.go:104: USER : 6bd28905-8a92-4aa9-80fd-5e9cff199b3e : Request : Started : Method[GET] URL[/1.0/query] RADDR[[::1]:62121]
2016/06/08 13:30:58 context.go:65: USER : 6bd28905-8a92-4aa9-80fd-5e9cff199b3e : api : Respond : Started : Code[200]
2016/06/08 13:30:58 context.go:72: USER : startup : api : Respond : Setting user headers : Access-Control-Allow-Origin:*
2016/06/08 13:30:58 context.go:110: USER : 6bd28905-8a92-4aa9-80fd-5e9cff199b3e : api : Respond : Completed
2016/06/08 13:30:58 app.go:126: USER : 6bd28905-8a92-4aa9-80fd-5e9cff199b3e : Request : Completed : Status[200] Duration[46.497305ms]
```

## Troubleshooting

###

## Authorization

TODO

<!-- The Anvil.io system is used for authentication and authorization. This requires the creation of a user against the Anvil system.

** NEED MORE **

TODO: Update with Anvil info
```
Authorization "Basic NmQ3MmU2ZGQtOTNkMC00NDEzLTliNGMtODU0NmQ0ZDM1MTRlOlBDeVgvTFRHWjhOdGZWOGVReXZObkpydm4xc2loQk9uQW5TNFpGZGNFdnc9"
```

Xenia is secured via an authorization token.  If you are using it through an application that provides this token (aka, Trust) then you're good to go.

If you intend to hit endpoints through a browser, install an Addon/plugin/extension that will allow you to add headers to your requests.

You can turn off authentication by setting

```
export XENIA_AUTH=off
``` -->
