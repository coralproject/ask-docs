# Packages included in Sponge

* [Strategy](/strategy) reads the translations file.
* [Source](#source) does the extraction.
* [Fiddler](#fiddler) does the transformations.
* [Coral](#coral) send data to Pillar.
* [Sponge](#sponge) ties all the pieces together.


## Strategy

```
import "github.com/coralproject/sponge/pkg/strategy"
```

The Strategy package handles the loading and distribution of configuration related with external sources. It handles the translation from the external database to our Coral schema.

### Variables

```
var pillarURL string
```
URL of where Pillar is currently running.

```
var uuid      string
```
Universally Unique Identifier used for the logs.

### Fields in the strategy JSON file

#### Name

The name of the strategy that we are describing.

#### Map

Contains all the information to map fields from the external source to our local Coral database.

#### Foreign

It describes the foreign database source. Right now our supported data sources are mySQL, PostgreSQL, MongoDB, and web services (REST APIs).

#### DateTimeFormat

If your source has date/time fields, we need to know how to parse them. In order to tell Sponge how to parse your date/time field, you will write out the date and time `2006 Mon Jan 2 15:04:05` in the format that it appears in your source database.

For more information on date and time layouts you can read the Golang documentation on [pkg-constants](https://golang.org/pkg/time/#pkg-constants).

#### Entities

Entities describes all of the different entities we have in the Coral database and how to perform the transformations.

Example of an entity:
```
"asset": {
  "Foreign": "crnr_asset",
  "Local": "asset",
  "Priority": 1,
  "OrderBy": "assetid",
  "ID": "assetid",
  "Index": [
    {
      "name": "asset-url",
      "key": "asseturl",
      "unique": "true",
      "dropdups": "true"
    }
  ],
  "Fields": [
    {
      "foreign": "assetid",
      "local": "asset_id",
      "relation": "Source",
      "type": "int"
    },
    {
      "foreign": "asseturl",
      "local": "url",
      "relation": "Passthrough",
      "type": "int"
    },
    {
      "foreign": "updatedate",
      "local": "date_updated",
      "relation": "ParseTimeDate",
      "type": "dateTime"
    },
    {
      "foreign": "createdate",
      "local": "date_created",
      "relation": "ParseTimeDate",
      "type": "dateTime"
    }
  ],
  "Endpoint": "http://localhost:8080/api/import/asset"
}
```
##### Foreign

The name of the foreign entity.

##### Local

The collection to where we are importing this entity into.

##### Priority

This is a number that specifies which entity to import first. The first priority starts in Zero.

##### OrderBy

A default order by when quering the foreign source.

##### ID

The identifier field for the foreign entity. We use this field when we need to import only some records and not the whole entity.

##### Endpoint

This is the endpoint in the coral system were we are going to push the data into.

##### Fields

All the fields that are being mapped.

###### foreign

The name of the field in the foreign entity.

###### local

The name of the field in our local database.

###### relation

The relationship between the foreign field and the local one. We have the following options:

* Passthrough: when the value is the same
* Source: when it needs to be added to our source struct for the local collection (the original identifiers have to go into source)
* ParseTimeDate: when we need to parse the foreign value as date time.
* Constant: when the local field should always be the same value. In this case we will have "foreign" blank and we will have other field called "value" with the value of the local field.
* SubDocument: when the local field has an array of documents in one of the fields.
* Status: when the field need to be translated based on the status map that is declared in that same strategy file for the entity.

###### type

The type of the value we are converting. This can be one of the following:

* String
* Timedate

#### Credentials

This has the credentials for the source database. It could be a web service or a database (MySQL, PostgreSQL or MongoDB).

##### adapter

This tells us which driver we need to use to pull data. Right now, the available options are "mysql", "postgresql", "mongodb" or "service".

##### type

This tells us which type of credential this is. Right now, it is always "foreign".

## Source

```
import "github.com/coralproject/sponge/pkg/source"
```

The package "Source" has the drivers to connect to the external source and retrieve data. The credentials for the external source are setup in the strategy file.

### Variables
```
var strategy str.Strategy
```
Holds the credentials for the external source as well as all the entities that needs to be extracted.
```
var uuid     string
```
Universally Unique Identifier used for the logs.
```
var credential str.Credential
```
Credential for the external source (database or web service).

### Interface Sourcer

This is the interface that needs to be implemented by any driver to databases that want to be included.

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

### Driver mySQL

Structure mySQL that implements interface Sourcer. It gets data from a mySQL database.

### Driver PostgreSQL

Structure PostgreSQL that implements interface Sourcer. It gets data from a PostgreSQL database.

### Driver MongoDB

Structure to hold a connection to a MongoDB that implements interface Sourcer. It gets data from the MongoDB database.

### API

Structure the way to get data from a web service that implements interface Sourcer.

### How to add a new source

If you need to add a new external source, you can implement the Sourcer interface over a structure with the connection to the database.


## Fiddler
```
import "github.com/coralproject/sponge/pkg/fiddler"
```
The Fiddler package does the translation from the external database schema into Coral's database, through a translation file called Strategy.

### Variables
```
var (
	strategy   str.Strategy
)
```
Holds the translation to apply to the data.
```
var (
	dateLayout string
)
```
Date Layout as specified in the translation's file.
```
var (
	uuid       string
)
```
Universally Unique Identifier used for the logs.

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

### Examples

```
TODO
```

## Coral

**Note**: The "Coral" package is not to be confused with the Coral ecosystem as a whole. In this instance, this is merely the name of a package included in Sponge.

```
import "github.com/coralproject/sponge/pkg/coral"
```

Interact with Pillar endpoints to import data into the Coral system.

### Constants

```
const (
  	retryTimes int    = 3
  	methodGet  string = "GET"
  	methodPost string = "POST"
  )
```
`retryTimes` determines how many times to retry if it fails.


### Variables

```
var (
	endpoints map[string]string // model -> endpoint
)
```
`endpoints` is a map containing all of the services to send data to. Right now, that is only Pillar.

```
var (
	uuid string
	str  strategy.Strategy
)
```
`uuid` is the universal identifier we are using for logging.
`str` is the strategy configuration.

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

The Sponge package imports the external source database into the local database. It transforms it and sends it to the Coral system, through Pillar.

### Constants

```
const (
	VersionNumber = 0.1
)
```
`VersionNumber` provides the version number of Sponge.

### Variables

```
var (
	dbsource source.Sourcer
	uuid     string
	options  source.Options
)
```

### Functions

#### func AddOptions

```
func AddOptions(limit int, offset int, orderby string, query string, types string, importonlyfailed bool, reportOnFailedRecords bool, reportdbfile string)
```
`AddOptions` sets options for how Sponge will run. The options are:

	*	Limit: limit for the query
	*	Offset: offset for the query
	*	Orderby:  order by this field
	*	Query:  we use this field if we want to specific a filter on WHERE for mySQL/PostgreSQL and Find for MongoDB
	*	Types: it specifies which entities to import (default is everything)
	*	Importonlyfailed: import only the documents that are in the report
	*	ReportOnFailedRecords: create a report with all the documents that failed the import
	*	Reportdbfile: name of the file for the report on documents that fail the import

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
