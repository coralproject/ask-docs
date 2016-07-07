# Overview

[Pillar](https://github.com/coralproject/pillar) is a REST based API written in Go. It provides the following services:

  * Imports external data (working with Sponge) into the Coral database.
  * Allows CRUD (Create, Read, Update, Delete) operations on the Coral database.

Pillar is one of the primary services that interacts with the Coral database. The other service that interacts with the Coral database is [Xenia](../xenia), but Xenia's queries are much more complex than Pillar's. Pillar does use Xenia to perform one specific, more complex search, but they largely serve different purposes.

If you'd like to see more about how Pillar fits into the Coral Ecosystem, you can find some drawings and diagrams on the [Architectural Overview](../architectural_overview) page.

## Key Points

* The Pillar API adheres strongly to [REST style](https://en.wikipedia.org/wiki/Representational_state_transfer).

* The Pillar API works only with [JSON](http://www.json.org/) data.

* The regular `CRUD` endpoint URL pattern is `/api/*`, where as the URL pattern for import endpoints is `/api/import/*`.

* Import-related endpoints allow you to import data into Coral from an existing source system (i.e., an existing database of comment information).
    * Coral keeps track of the original identifiers (i.e., the user id), and stores that data (using a structure called `ImportSource`) in a field named `Source`. That means you won't lose the original identifier data from your original source when you import into Coral.

* All import endpoints `upsert` data. This means that when you import an entry, it will overwrite the information for that entry if the entry already exists. This prevents duplications and other problems.
