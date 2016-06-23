# Introduction

Sponge is used to get your existing community (comments, authors, assets, and other entities) into the Coral ecosystem.

Sponge is Coral's Data Import Layer. It is an Extract, Transform, and Load command line tool designed to:

* Read data from a foreign source,
* Translate the schema into Coral conventions, and
* POST entities to our service layer for insertion.

_Strategy files_ are JSON files that are used to tell Sponge where to get the data, and how to translate it. You can read more about [strategy files here](strategy), including information on their structure and examples.

## Data import sources supported

Sponge currently only supports importing data from mySQL, PostgreSQL, MongoDB or web services with REST APIs.

## Command line tool

### Usage:

  sponge --flag [command]

### Available Commands:

  * import      Import data to the coral database
  * index       Work with indexes in the coral database
  * show        Read the report on errors
  * version     Print the version number of Sponge
  * all         Import and Create Indexes

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

### Roadmap

You can find out more about potential upcoming features [on our roadmap](roadmap).
