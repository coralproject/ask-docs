# Introduction

Sponge is a data import service used to get your existing community (comments, authors, assets, and other entities) into the Coral ecosystem.

It is an Extract, Transform, and Load command line tool designed to:

* Read data from a foreign source,
* Translate the schema into Coral conventions, and
* POST entities to our service layer for insertion.

Sponge uses strategy files to assist with data import. Strategy files are JSON files that are used to tell Sponge where to get the data, and how to translate it. You can read more about [strategy files here](strategy), including information on their structure and examples.

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

## Sponge roadmap

This document tracks features that are not yet prioritized into issues and releases.

### API Import

Pull data from Http(s) sources

* Disqus - https://disqus.com/api/docs/
* Wordpress Core - https://codex.wordpress.org/XML-RPC_WordPress_API/Comments
* Lyvewire - http://answers.livefyre.com/developers/api-reference/
* Facebook - https://developers.facebook.com/docs/graph-api/reference/v2.5/comment

### Rate Limit Counter

In order to protect source databases, we want to be able to throttle the number of queries sponge is making.

* Keeps a sliding count of how many requests were made in the past time frame based on the strategy.
* Exposes isOkToQuery() to determine if we are currently at the limit.
* Each request sends a message to this routine each time a request is made.

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

#### Challenges

Data synchronization between complex living systems is a difficult challenge. Approach with caution.
