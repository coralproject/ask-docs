# Strategy files

Strategy files are JSON configuration files that contain all the information Sponge needs to extract data from a source, translate it to the Coral schema, and send it on to Pillar and from there to the Coral MongoDB.

The external data sources we currently support are: PostgreSQL, MySQL, MongoDB, and REST APIs.

The strategy spec is still being refined. We have examples that you can view in the [examples directory](https://github.com/coralproject/sponge/tree/master/examples).

# Fields in the strategy.json file

## Name

The name of the strategy that we are describing.

## Map

Contains all the information to map fields from the external source to our local coral database.

### Foreign

It describes the foreign database source. Right now we have only "mysql" available.

### DateTimeFormat

If your source have date time fields, we need to know how to parse them. You should write the representation of 2006 Mon Jan 2 15:04:05 in the desired format. More more info read [pkg-constants](https://golang.org/pkg/time/#pkg-constants)

### Entities

It describe all the different entities we have at the Coral database and how to do its transformations.

#### Name of the entity

Example:
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
  "Endpoint": "/api/import/asset"
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

###### Foreign

The name of the field in the foreign entity.

###### Local

The name of the field in our local database.

###### Relation

The relationship between the foreign field and the local one. We have this options:
- Passthrough: when the value is the same
- Source: when it needs to be added to our source struct for the local collection (the original identifiers have to go into source)
- ParseTimeDate: when we need to parse the foreign value as date time.
- Constant: when the local field should always be the same value. In this case we will have "foreign" blank and we will have other field called "value" with the value of the local field.
- SubDocument: when the local field has an array of documents in one of the fields.
- Status: when the field need to be translated based on the status map that is declared in that same strategy file for the entity.

###### Type

The type of the value we are converting.

- String
- Timedate

## Credentials

This has the credentials for the source database to pull data from. It could be a web service or a database (MySQL, PostgreSQL or MongoDB).

### adapter

It tells us which drivers we need to use to pull data. Right now we have "mysql", "postgresql", "mongodb" or "service"

### type

Right now it is always "foreign" but it could tell us which type of credential this one is.

# Examples

## Washington Post

[Translations](examples/translations.md)
