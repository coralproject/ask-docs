# Pillar

[Pillar](https://github.com/coralproject/pillar) is a REST based WebService written in Golang. It provides the following services:

  * Imports external data into Coral data model
  * Allows CRUD operation on Coral data model
  * Provides simple queries on Coral data model


## Key Points

* Pillar APIs strongly adhere to [REST style](https://en.wikipedia.org/wiki/Representational_state_transfer).

* Pillar APIs only work with [JSON](http://www.json.org/) data.

* Regular `CRUD` API pattern is `/api/*`, where as import API pattern is `/api/import/*`.

* Import related APIs allow you to import data into Coral from an existing Source system. The key to a successful import and tracking lies in `ImportSource`. This structure keeps the original identifiers. Most top-level model e.g. `User` or `Comment` embeds this source data in a field named `Source`.

* We understand that an import process can be challenging, hence all import APIs `upsert` data. By doing so, each time you import it overwrites existing entries.