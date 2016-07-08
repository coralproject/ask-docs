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
* `DateTimeFormat`: Tells us how to parse date/time fields in the external data source. You should populated this field with the date and time of `2006 Mon Jan 2 15:04:05`, written in the format that appears in your external database.

## Entity fields
`Entities` is a JSON object that describes all of the different entities in the Coral database, and how to perform the transformation for that entity.

* `Foreign`: The name of the foreign entity.
* `Local`: The collection into which we are importing this entity.
* `Priority`: This is a number that specifies which entity to import first (the highest priority is 0).
* `OrderBy`: The field to order the results by when querying the foreign source.
* `ID`: The identifier field for the foreign entity. We use this field when we need to import only some records and not the whole entity.
* `Endpoint`: This is the [Pillar endpoint URL](../pillar/api) where we will push the data.
* `Fields`: All the fields that are being mapped.
* `foreign`: The name of the field in the foreign entity.
* `local`: The name of the field in our local database.
* `relation`: The relationship between the foreign field and the local one. We have this options:
    * `Passthrough`: when the value is the same
    * `Source`: when it needs to be added to our source struct for the local collection (the original identifiers have to go into source)
    * `ParseTimeDate`: when we need to parse the foreign value as date time.
    * `Constant`: when the local field should always be the same value. In this case we will have "foreign" blank and we will have other field called "value" with the value of the local field.
    * `SubDocument`: when the local field has an array of documents in one of the fields.
    * `Status`: when the field need to be translated based on the status map that is declared in that same strategy file for the entity.
* `Type`: The type of the value we are converting.
    * `String`
    * `Timedate`

## Credentials
This contains the credentials for the external data source. It could be a REST API or a database (MySQL, PostgreSQL or MongoDB).

* `adapter`: This tells us which driver we need to use to extract data. Right now, the options available are `mysql`, `postgresql`, `mongodb`, or `service`.
* `type`: Right now this is always `foreign`, but in future it could tell us what type of credential this is.
