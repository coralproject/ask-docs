# Introduction

Sponge is a data import service used to get your existing community (comments, authors, assets, and other entities) into the Coral ecosystem.

It is an Extract, Transform, and Load command line tool designed to:

* Read data from a foreign source,
* Translate the schema into Coral conventions, and
* POST entities to our service layer for insertion.

Sponge uses strategy files to assist with data import. Strategy files are JSON files that are used to tell Sponge where to get the data, and how to translate it. You can read more about [strategy files here](#strategy-files), including information on their structure and examples.

## Composition

Sponge is made up of several different packages, and you can read more about them on the [included packages section](#packages-included-in-sponge). They work together as shown in the diagram below:

<img src="/images/sponge-architecture.svg">

## Data import sources supported

Sponge currently only supports importing data from mySQL, PostgreSQL, MongoDB or web services with REST APIs.

## Command line tool

### Usage:

```
sponge --flag [command]
```

### Available Commands:

* `import`: Import data to the coral database.
* `index`: Work with indexes in the coral database.
* `show`: Read the report on errors.
* `version`: Print the version number of Sponge.
* `all`: Import and Create Indexes.

### Flags

```      
--dbname="report.db": set the name for the db to read
--filepath="report.db": set the file path for the report on errors (default is report.db)
-h, --help[=false]: help for sponge
--limit=9999999999: number of rows that we are going to import (default is 9999999999)
--offset=0: offset for rows to import (default is 0)
--onlyfails[=false]: import only the the records that failed in the last import(default is import all)
--orderby="": order by field on the external source (default is not ordered)
--query="": query on the external table (where condition on mysql, query document on mongodb). It only works with a specific --type. Example updated_date >'2003-12-31 01:02:03'
--report[=false]: create report on records that fail importing (default is do not report)
--type="": import or create indexes for only these types of data (default is everything)
```

# Sponge installation  

## Before you begin

### Pillar
You will need to have an instance of [Pillar](http://github.com/coralproject/pillar) running, where your translated data will be sent. Instructions on installing Pillar [can be found here](/pillar#pillar-installation).

### External database source
You will also have your external database running. This external database is the source of your existing comment data that will be extracted by Sponge and sent to Pillar, which will then load it into the Coral ecosystem.

The external sources we currently support are: PostgreSQL, MySQL, MongoDB, and REST APIs.

### Vendoring dependencies

You should be vendoring the packages you choose to use ("vendoring" is the moving of all third party items such as packages into the `/vendor` directory). We recommend using [govendor](https://github.com/kardianos/govendor). This tool will manage your dependencies from the vendor folder associated with this project repository.

## Install from source

### Before you begin

If you want to install from source, you will need to have Go installed.

First [install Go](https://golang.org/dl/). The [installation and setup instructions](https://golang.org/doc/install) on the Go website are pretty good. Ensure that you have exported your $GOPATH environment variable, as detailed in the [installation instructions](https://golang.org/doc/install).

If you are not on a version of Go that is 1.7 or higher, you will also have to set the GO15VENDOREXPERIMENT flag.
```
export GO15VENDOREXPERIMENT=1
```

_If you are not on a version of Go 1.7 or higher, we recommend adding this to your ~/.bash_profile or other startup script._

### Get the source code

You can install the source code via using the `go get` command, or by manually cloning the code.

#### Using the go get command
```
go get github.com/coralproject/sponge
```
If you see a message about "no buildable Go source files" like the below, you can ignore it. It simply means that there are buildable source files in subdirectories, just not the uppermost sponge directory.
```
package github.com/coralproject/sponge: no buildable Go source files in [directory]
```

#### Cloning manually
You can also clone the code manually.

```
mkdir $GOPATH/src/github.com/coralproject/sponge
cd $GOPATH/src/github.com/coralproject/sponge

git clone https://github.com/coralproject/sponge.git
```

### Set up your strategy.json file

You can read about [strategy files in depth here](#strategy-files).

The strategy.json file tells Sponge how to do the transformation between the publisher's existing data and the Coral data schema. It also tells us how to connect to the external publisher's source data. We currently support the following sources: PostgreSQL, MySQL, MongoDB, and REST APIs.

We have example strategy.json files for each of those source types. You can see those example strategy.json files in the `examples` folder: `$GOPATH/src/github.com/coralproject/sponge/examples`

To copy one of the example strategy.json files to another folder, where you can then customize it:
```
cp $GOPATH/src/github.com/coralproject/sponge/examples/strategy.json.example $GOPATH/src/github.com/coralproject/sponge/strategy/strategy.json
```

### Set your environment variables

Setting your environment variables tells Sponge which strategy file you want to use, and the URL for the [Pillar](https://github.com/coralproject/pillar) instance you are pushing data to.

Make your own copy of the `config/dev.cfg` file (you can edit this configuration file with your own values, and then ensure that you don't commit it back to the repository). Call your config file whatever you like; we'll call it "custom" in this example.
```
cd $GOPATH/src/github.com/coralproject/sponge
cp config/dev.cfg config/custom.cfg
```

Now edit the values in your custom.cfg file:
```
export STRATEGY_CONF=/path/to/my/strategy.json
export PILLAR_URL=http://localhost:8080
```

* `STRATEGY_CONF`: Specifies the path to your strategy.json file.
* `PILLAR_URL`: Specifies the URL where your Pillar instance is running. If you installed Pillar locally from source, this will probably be `http://localhost:8080`.

Once you've edited and saved your custom.cfg file, source it:

```
source $GOPATH/src/github.com/coralproject/sponge/config/custom.cfg
```

### Run Sponge

You can either run Sponge using Go, or via a CLI tool.

#### Running Sponge using go run
```
cd $GOPATH/src/github.com/coralproject/sponge/cmd/sponge
go run main.go
```

#### Running Sponge using the CLI tool

First build the CLI tool:
```
cd $GOPATH/src/github.com/coralproject/cmd/cmd/sponge
go build
```

Then run the CLI tool
```
./sponge -h
```

## Install as a Docker container

### Building image

To build the docker image, run this command:

```
docker build -t "sponge:latest" -f Dockerfile ./
```

### Edit env.list

Setting your environment variables tells Sponge which strategy file you want to use, and the URL for the [Pillar](https://github.com/coralproject/pillar) instance you are pushing data to.

```
PILLAR_URL=http://192.168.99.100:8080
STRATEGY_CONF=/strategy/strategy_psql.json

# DATABASE
# (optional if you want to overwrite strategy file values)
DB_database= ""
DB_username= ""
DB_password= ""
DB_host= ""
DB_port= ""

# WEB SERVICE
# (optional if you want to overwrite strategy file values)
WS_appkey= ""
WS_endpoint= ""
WS_records= ""
WS_pagination= ""
WS_useragent= ""
WS_attributes= ""
```

Required edits:

* `STRATEGY_CONF`: Specifies the path to your strategy.json file.
* `PILLAR_URL`: Specifies the URL where your Pillar instance is running. If you installed Pillar locally from source, this will probably be `http://localhost:8080`.

### Running the container

Spinning up the container will start importing everything setup in the [strategy file](#strategy-files).

```
docker run --env-file env.list -d sponge
```

# Packages included in Sponge

* [Strategy](/strategy) reads the translations file.
* [Source](#source) performs the extraction of data from the external data source.
* [Fiddler](#fiddler) performs the transformation of data.
* [Coral](#coral) sends data to Pillar.
* [Sponge](#sponge) ties all the pieces together.

<img src="/images/sponge-architecture.svg">

## Strategy

```
import "github.com/coralproject/sponge/pkg/strategy"
```

The Strategy package reads in the external [strategy JSON file](#strategy-files) and creates a structure containing translation information.

### Variables

* `var pillarURL string`: URL that points to the Pillar instance, where the data will be sent.
    * This is initialized by the `PILLAR_URL` environment variable.
* `var uuid string`: Universally Unique Identifier used for the logs.

To read more about strategy JSON files, you can read [our section on strategy files](#strategy-files).

## Source

```
import "github.com/coralproject/sponge/pkg/source"
```

The Source package contains the drivers that we use to connect to the external source and retrieve data. The credentials for the external data source are set up in the [strategy file](#strategy-files).

### Variables

* `var strategy str.Strategy`: Holds the credentials for the external source, as well as all the entities that need to be extracted.
* `var uuid string`: Universally Unique Identifier used for the logs.
* `var credential str.Credential`: Credential for the external source (database or web service).

### Sourcer interface

This is the interface that needs to be implemented by any driver that connects to an external data source.

#### func GetData
```
GetData(string, *Options) ([]map[string]interface{}, error)
```
Returns all the data (query by options in Options) in the format `[]map[string]interface{}`

#### func IsWebService
```
IsWebService() bool
```
Returns true if the implementation of Sourcer is a web service.

#### func New
```
func New(d string) (Sourcer, error)
```
Returns a structure with the connection to the external source that implements the interface Sourcer.

#### func GetEntities
```
func GetEntities() ([]string, error)
```
Gets all of the entity names from the external data source.

#### func GetforeignEntity
```
func GetForeignEntity(name string) string
```
Gets a single foreign entity's name.

### mySQL driver

The mySQL driver is contained in the `mysql.go` file. It has a mySQL struct that implements the Sourcer interface, and enables data extraction from a mySQL database.

### PostgreSQL driver

The PostgreSQL driver is contained in the `postgresql.go` file. It has a PostgreSQL struct that implements the Sourcer interface, and enables data extraction from a PostgreSQL database.

### MongoDB driver

The MongoDB driver is contained in the `mongodb.go` file. It has a MongoDB struct that implements the Sourcer interface, and enables data extraction from a MongoDB database.

### API driver

The API driver is contained in the `api.go` file. It has an API struct that implements the Sourcer interface, and enables data extraction from an API interface.

### How to add a new source

Currently, we offer the four drivers listed above (mySQL, PostgreSQL, MongoDB, and REST API). If you need to add a new type of external source, you can write your own driver. To write your own driver, you will implement the Sourcer interface for your type of external data source.

## Fiddler
```
import "github.com/coralproject/sponge/pkg/fiddler"
```
The Fiddler package performs the translation from the external database schema into Coral's database schema.

### Variables

* `strategy   str.Strategy` Holds the translation, in JSON form, to apply to the data.
* `dateLayout string` Date Layout as specified in the strategy file.
* `uuid string` Universally Unique Identifier used for the logs.

### Functions

#### func GetID

```
func GetID(modelName string) string
```
Returns the field that is the identifier for that model

#### func GetCollections

```
func GetCollections() []string
```
Returns the names of all the collections in the strategy file.

#### func TransformRow
```
func TransformRow(row map[string]interface{}, coralName string) (interface{}, []map[string]interface{}, error)
```
Applies the coral schema to a row of data from the external source.

## Coral

**Note**: The "Coral" package is not to be confused with the Coral ecosystem as a whole. In this instance, this is merely the name of a package included in the Sponge app.

```
import "github.com/coralproject/sponge/pkg/coral"
```

Coral interacts with Pillar endpoints to import data into the Coral system.

### Constants

* `retryTimes int    = 3` Determines how many times to retry communication with Pillar, if it initially fails.
* `methodGet  string = "GET"`
* `methodPost string = "POST"`

### Variables

* `endpoints map[string]string` `endpoints` is a map containing all of the services where we can send data. Right now, that is only Pillar.
* `uuid string` Universally Unique Identifier used for the logs.
* `str  strategy.Strategy` Holds the translation, in JSON form, to apply to the data.

### Functions

#### func AddRow

```
func AddRow(data map[string]interface{}, tableName string) error
```
Adds data to the collection `tableName`.

#### func CreateIndex

```
func CreateIndex(collection string) error
```
Calls the service to create index for `collection`.

## Sponge

**Note**: The "Sponge" package is not to be confused with the Sponge app as a whole. In this instance, this is merely the name of a package included in the larger Sponge app.

```
import "github.com/coralproject/sponge/pkg/sponge"
```
The Sponge package ties together all of the other packages, so that they all communicate and work with each other.

### Constants

*	`VersionNumber = 0.1` Provides the version number of Sponge.

### Variables

* `dbsource source.Sourcer`
* `uuid     string`
* `options  source.Options`

### Functions

#### func AddOptions

```
func AddOptions(limit int, offset int, orderby string, query string, types string, importonlyfailed bool, reportOnFailedRecords bool, reportdbfile string)
```
`AddOptions` sets options for how Sponge will run. The options are:

*	`Limit`: Limit for the query.
*	`Offset`: Offset for the query.
*	`Orderby`:  Order by this field
*	`Query`:  We use this field if we want to specific a filter on WHERE for mySQL/PostgreSQL and Find for MongoDB.
*	`Types`: Specifies which entities to import (the default is "everything").
*	`Importonlyfailed`: Import only the documents that are in the report.
*	`ReportOnFailedRecords`: Create a report with all the documents that failed the import.
*	`Reportdbfile`: Name of the file for the report on documents that fail the import.

#### func Import

```
func Import()
```
Gets data, transforms it and sends it to Pillar. It bases everything on the STRATEGY_CONF environment variable and the PILLAR_URL environment variable.

### func CreateIndex

```
func CreateIndex(collection string)
```
Creates index on the collection `collection`. This feature creates indexes on the Coral database, depending on the data in the strategy file.

For example:
```
"Index": [
  {
    "name": "asset-url",
    "keys": ["asseturl"],
    "unique": "true",
    "dropdups": "true"
  }
],
```

You can read more information at the [mongodb's create index definition](https://docs.mongodb.org/manual/reference/method/db.collection.createIndex/#db.collection.createIndex).

# Strategy files

Strategy files are JSON configuration files that contain all the information Sponge needs to extract data from a source, translate it to the Coral schema, and send it on to Pillar and from there to the Coral MongoDB.

The external data sources we currently support are: PostgreSQL, MySQL, MongoDB, and REST APIs.

The strategy spec is still being refined. We have examples that you can view in the [examples directory](https://github.com/coralproject/sponge/tree/master/examples).

Examples:

* [API example](https://github.com/coralproject/sponge/blob/master/examples/strategy_api.json.example)
* [MongoDB example](https://github.com/coralproject/sponge/blob/master/examples/strategy_mongo.json.example)
* [mySQL example](https://github.com/coralproject/sponge/blob/master/examples/strategy_mysql.json.example)
* [PostgreSQL example](https://github.com/coralproject/sponge/blob/master/examples/strategy_psql.json.example)

## Fields in the strategy.json file

## General fields
* `Name`: The name of the strategy that we are describing.
* `Map`: Contains all the information to map fields from the external data source to our local Coral database.
* `Foreign`: Describes the type of external database source (for example, "mysql" or "mongodb").
* `DateTimeFormat`: Tells us how to parse date/time fields in the external data source. You should populate this field with the date and time of `2006 Mon Jan 2 15:04:05`, written in the format that appears in your external database.

## Entity fields
`Entities` is a JSON object that describes all of the different entities in the Coral database, and how to perform the transformation for that entity.

* `Foreign`: The name of the foreign entity.
* `Local`: The collection into which we are importing this entity.
* `Priority`: This is a number that specifies which entity to import first (the highest priority is 0).
* `OrderBy`: The field to order the results by when querying the foreign source.
* `ID`: The identifier field for the foreign entity. We use this field when we need to import only some records and not the whole entity.
* `Endpoint`: This is the [Pillar endpoint URL](../pillar#pillar-api) where we will push the data.
* `Fields`: All the fields that are being mapped.
* `foreign`: The name of the field in the foreign entity.
* `local`: The name of the field in our local database.
* `relation`: The relationship between the foreign field and the local one. We have the following options:
    * `Passthrough`: When the value is the same.
    * `Source`: When it needs to be added to our source struct for the local collection (the original identifiers have to go into source).
    * `ParseTimeDate`: When we need to parse the foreign value as date time.
    * `Constant`: When the local field should always be the same value. In this case we will have "foreign" blank and we will have other field called "value" with the value of the local field.
    * `SubDocument`: When the local field has an array of documents in one of the fields.
    * `Status`: When the field need to be translated based on the status map that is declared in that same strategy file for the entity.
* `Type`: The type of the value we are converting.
    * `String`
    * `Timedate`

## Credentials
This contains the credentials for the external data source. It could be a REST API or a database (MySQL, PostgreSQL or MongoDB).

* `adapter`: This tells us which driver we need to use to extract data. Right now, the options available are `mysql`, `postgresql`, `mongodb`, or `service`.
* `type`: Right now this is always `foreign`, but in future it could tell us what type of credential this is.

# Logging

We are using (Ardanlabs Log's package)[https://github.com/ardanlabs/kit/tree/master/log] for all of the tools we are developing in Go.

### Logging levels:

* `Dev`: To be outputted in development environment only.
* `User` (prod): To be outputted in dev and production environments.

### All logs should contain:

* Context uuid to identify a particular execution (aka, run of Sponge or a Request/Response execution from a web server).
* The name of the function that is executing.
* A readable message including relevant data.

Logs should write to `stdout` so that they can be flexibly directed.

# Roadmap

There are features we would like to incorporate into Sponge at a future date, but that we haven't yet prioritized into issues or releases.

### API Import

Pull data from HTTP(S) sources:

* Disqus - https://disqus.com/api/docs/
* Wordpress Core - https://codex.wordpress.org/XML-RPC_WordPress_API/Comments
* Lyvewire - http://answers.livefyre.com/developers/api-reference/
* Facebook - https://developers.facebook.com/docs/graph-api/reference/v2.5/comment

### Rate Limit Counter

In order to protect source databases, we want to be able to throttle the number of queries that Sponge is making.

* Keep a sliding count of how many requests were made in the past time frame based on the strategy.
* Expose isOkToQuery() to determine if we are currently at the limit.
* Each request will send a message to this routine each time a request is made.

### Synchronization

An internal mechanism that regularly polls the source and imports any updates.

#### Basic polling specification

The main loop that keeps the data up to date.  Gets _slices_ of records based on _updated_at_ timestamps to account for changing records.

For each table or api in the strategy:

* Ensure maximum rate limit is not met
* Determine which slice of data to get next
	* Find the last updated timestamp in the _log collection_ (or the collection itself?)
* Use the strategy to request the slice (either db query or api call)
	* Update the rate limit counter
* For each record returned
	* Check to ensure the document isn't already added
	* If not, add the document and kick off _import actions_
	* If it's there, update the document
	* Update the _log collection_
