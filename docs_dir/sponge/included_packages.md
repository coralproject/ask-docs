# Packages included in Sponge

* [Strategy](/strategy) reads the translations file.
* [Source](#source) performs the extraction of data from the external data source.
* [Fiddler](#fiddler) performs the transformation of data.
* [Coral](#coral) sends data to Pillar.
* [Sponge](#sponge) ties all the pieces together.

![sponge_diagram](../images/sponge.png)

## Strategy

```
import "github.com/coralproject/sponge/pkg/strategy"
```

The Strategy package reads in the external [strategy JSON file](strategy) and creates a structure containing translation information.

### Variables

* `var pillarURL string`: URL that points to the Pillar instance, where the data will be sent.
    * This is initialized by the `PILLAR_URL` environment variable.
* `var uuid string`: Universally Unique Identifier used for the logs.

To read more about strategy JSON files, you can read [our page on strategy files](strategy).

## Source

```
import "github.com/coralproject/sponge/pkg/source"
```

The Source package contains the drivers that we use to connect to the external source and retrieve data. The credentials for the external data source are set up in the [strategy file](strategy).

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
Returns all the data (query by options in Options) in the format []map[string]interface{}

#### func IsWebService
```
IsWebService() bool
```
Returns true if the implementation of sourcer is a web service.

#### func New
```
func New(d string) (Sourcer, error)
```
Depending on the parameter, it returns a structure with the connection to the external source that implements the interface Sourcer.

#### func GetEntities
```
func GetEntities() ([]string, error)
```
Gets all the entities' names from the source

#### func GetforeignEntity
```
func GetForeignEntity(name string) string
```
Gets the foreign entity's name for the Coral collection.

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
Adds data to the collection "tableName".

#### func CreateIndex

```
func CreateIndex(collection string) error
```
Calls the service to create index for "collection".

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

*	`Limit`: limit for the query
*	`Offset`: offset for the query
*	`Orderby`:  order by this field
*	`Query`:  we use this field if we want to specific a filter on WHERE for mySQL/PostgreSQL and Find for MongoDB
*	`Types`: it specifies which entities to import (default is everything)
*	`Importonlyfailed`: import only the documents that are in the report
*	`ReportOnFailedRecords`: create a report with all the documents that failed the import
*	`Reportdbfile`: name of the file for the report on documents that fail the import

#### func Import

```
func Import()
```
Gets data, transforms it and sends it to Pillar. It bases everything on the STRATEGY_CONF environment variable and the PILLAR_URL environment variable.

### func CreateIndex

```
func CreateIndex(collection string)
```
Creates index on the collection 'collection'. This feature creates indexes on the Coral database, depending on data in the strategy file.

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
