# API Overview

* The Pillar API adheres strongly to [REST style](https://en.wikipedia.org/wiki/Representational_state_transfer).

* The Pillar API works only with [JSON](http://www.json.org/) data.

* The regular `CRUD` endpoint URL pattern is `/api/*`, where as the URL pattern for import endpoints is `/api/import/*`.

* Import-related endpoints allow you to import data into Coral from an existing source system (i.e., an existing database of comment information).
    * Coral keeps track of the original identifiers (i.e., the user id), and stores that data (using a structure called `ImportSource`) in a field named `Source`. That means you won't lose the original identifier data from your original source when you import into Coral.

* All import endpoints `upsert` data. This means that when you import an entry, it will overwrite the information for that entry if the entry already exists. This prevents duplications and other problems.

## CRUD endpoints
| URL           | HTTP Verb     | Description             |
|:------------- |:--------------|:------------------------|
| /api/user     |GET            |[Queries users](#get-users) |
| /api/user     |POST           |[Creates and updates users](#create-and-update-users)  |
| /api/user     |POST           |[Deletes users](#delete-users)  |
| /api/asset    |GET            |[Queries assets](#get-assets) |
| /api/asset    |POST           |[Creates and updates assets](#create-and-update-assets) |
| /api/asset    |POST           |[Deletes assets](#delete-assets)  |
| /api/actions  |GET            |[Queries actions](#get-actions) |
| /api/actions  |POST           |[Creates and updates actions](#create-and-update-actions)  |
| /api/actions  |POST           |[Deletes actions](#delete-actions)  |

## Import endpoints

| URL           | HTTP Verb     | Description             |
|:------------- |:--------------|:------------------------|
| /api/import/user     |GET            |[Import users](#import-users) |
| /api/import/asset    |GET            |[Import assets](#import-assets) |
| /api//import/actions  |GET            |[Import actions](#import-actions) |

### Get Users
| URL           | HTTP Verb     | Functionality   |
|:------------- |:--------------|:----------------|
| /api/user     |GET            |Queries users    |

#### Parameters
| Name          | Required?          | Type                     | Description     |
|:------------- |:------------- |:-------------------------|:----------------|
| Name          |Y|string                    |                 |
| Avatar        | |string                    |                 |
| Status        | |status                    |                 |

#### Example Call
You can retrieve multiple objects at once by sending a GET request to the class URL. Without any URL parameters, this simply lists objects in the class:
~~~
> curl -i -H "Accept: application/json" -XPOST -d '  {
    "name" : "IamSam",
    "avatar" : "https://wpidentity.s3.amazonaws.com/assets/images/avatar-default.png",
    "status" : "New",
    "source" : {
      "id":"original-id-for-iam-sam"
    },
    "tags" : ["top_commentor", "powerball"]
  }
' http://localhost:8080/api/import/user
~~~

#### Response
The return value is a JSON object that contains a results field with a JSON array that lists the objects.
~~~
{
  "results": [
    {
      "playerName": "Jang Min Chul",
      "updatedAt": "2011-08-19T02:24:17.787Z",
      "cheatMode": false,
      "createdAt": "2011-08-19T02:24:17.787Z",
      "objectId": "A22v5zRAgd",
      "score": 80075
    },
    {
      "playerName": "Sean Plott",
      "updatedAt": "2011-08-21T18:02:52.248Z",
      "cheatMode": false,
      "createdAt": "2011-08-20T02:06:57.931Z",
      "objectId": "Ed1nuqPvcm",
      "score": 73453
    }
  ]
}
~~~

### Create and Update Users
| URL           | HTTP Verb     | Functionality   |
|:------------- |:--------------|:----------------|
| /api/user     |GET            |Queries users    |

#### Parameters
| Name          | Required?          | Type                     | Description     |
|:------------- |:------------- |:-------------------------|:----------------|
| Name          |Y|string                    |                 |
| Avatar        | |string                    |                 |
| Status        | |status                    |                 |
| LastLogin     | |time.Time                 |                 |
| MemberSince   |Y|time.Time                 |                 |
| Actions       | |[]Action                  |                 |
| Notes         | |[]Note                    |                 |
| Tags          | |[]string                  |                 |
| Stats         | |bson.M                    |                 |
| Metadata      | |bson.M                    |                 |
| Source        | |*ImportSource             |                 |


#### Example Call
You can retrieve multiple objects at once by sending a GET request to the class URL. Without any URL parameters, this simply lists objects in the class:
~~~
> curl -i -H "Accept: application/json" -XPOST -d '  {
    "name" : "IamSam",
    "avatar" : "https://wpidentity.s3.amazonaws.com/assets/images/avatar-default.png",
    "status" : "New",
    "source" : {
      "id":"original-id-for-iam-sam"
    },
    "tags" : ["top_commentor", "powerball"]
  }
' http://localhost:8080/api/import/user
~~~

#### Response
The return value is a status response.
~~~
Status: 200 OK
~~~
<!--
| Model         | Import                   | CRUD            |
|:------------- |:-------------------------|:----------------|
| User          |/api/import/user          |/api/user        |
| Asset         |/api/import/asset         |/api/asset       |
| Action        |/api/import/action        |/api/action      |
| Comment       |/api/import/comment       |/api/comment     |
| Tag           |None                      |/api/tag         |
| Search        |None                      |/api/search      |


Here is a generic example of how you might use these end-points. See [model](https://github.com/coralproject/pillar/tree/master/pkg/model) for the structure of data to be passed for various APIs.

~~~
> curl -i -H "Accept: application/json" -XPOST -d '  {
    "name" : "IamSam",
    "avatar" : "https://wpidentity.s3.amazonaws.com/assets/images/avatar-default.png",
    "status" : "New",
    "source" : {
      "id":"original-id-for-iam-sam"
    },
    "tags" : ["top_commentor", "powerball"]
  }
' http://localhost:8080/api/import/user
~~~
### Mystery endpoints thing
Here is a list of end-points

| Model         | Import                   | CRUD            |
|:------------- |:-------------------------|:----------------|
| User          |/api/import/user          |/api/user        |
| Asset         |/api/import/asset         |/api/asset       |
| Action        |/api/import/action        |/api/action      |
| Comment       |/api/import/comment       |/api/comment     |
| Tag           |None                      |/api/tag         |
| Search        |None                      |/api/search      | -->
