# Introduction

[Pillar](https://github.com/coralproject/pillar) is a REST based web service written in Golang. It provides the following services:

  * Imports external data into Coral data model
  * Allows CRUD operation on Coral data model
  * Provides simple queries on Coral data model

## Key Points

* Pillar APIs strongly adhere to [REST style](https://en.wikipedia.org/wiki/Representational_state_transfer).

* Pillar APIs only work with [JSON](http://www.json.org/) data.

* There are two broad types of API endpoints:
    * The URL pattern for the regular `CRUD` endpoints is `/api/*`.
    * The URL pattern for the import endpoints is `/api/import/*`.

* The "import" API endpoints allow you to import data into Coral from an existing source data store.
    * The key to successful importing and tracking lies in the `ImportSource` structure. This structure keeps the original identifiers.
    * Most top-level models (for example, `User` or `Comment`) embed this source data in a field named `Source`.

* We understand that an import process can be challenging. Hence, all of the "import" API endpoints `upsert` data. This means that each time you perform an import, existing entries are overwritten by the new entries ("upsert" basically means "insert or update").
