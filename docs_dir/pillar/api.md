# API Overview

**This section is under construction, and is not currently complete.**

* The Pillar API adheres strongly to [REST style](https://en.wikipedia.org/wiki/Representational_state_transfer).

* The Pillar API works only with [JSON](http://www.json.org/) data.

* The regular `CRUD` endpoint URL pattern is `/api/*`, where as the URL pattern for import endpoints is `/api/import/*`.

* Import-related endpoints allow you to import data into Coral from an existing source system (i.e., an existing database of comment information).
    * Coral keeps track of the original identifiers (i.e., the user id), and stores that data (using a structure called `ImportSource`) in a field named `Source`. That means you won't lose the original identifier data from your original source when you import into Coral.

* All import endpoints `upsert` data. This means that when you import an entry, it will overwrite the information for that entry if the entry already exists. This prevents duplications and other problems.

## Import endpoints
| URL           | HTTP Verb     | Description             |
|:------------- |:--------------|:------------------------|
| /api/import/action   |GET            |[Import action](#import-action) |
| /api/import/asset    |GET            |[Import asset](#import-asset) |
| /api/import/comment  |GET            |[Import comment](#import-comment) |
| /api/import/note     |GET            |[Import note](#import-note) |
| /api/import/user     |GET            |[Import user](#import-user) |

## Tag endpoints
| URL           | HTTP Verb     | Description             |
|:------------- |:--------------|:------------------------|
| /api/tags     |GET            |[Get tags](#get-tags) |
| /api/tag      |POST           |[Create or update tag](#create-or-update-tag)  |
| /api/tag      |DELETE         |[Delete tag](#delete-tag)  |

## Search endpoints
| URL               | HTTP Verb     | Description             |
|:----------------- |:--------------|:------------------------|
| /api/searches     |GET            |[Get searches](#get-searches) |
| /api/search/{id}  |GET            |[Get search by id](#get-search-by-id)  |
| /api/search       |PUT            |[Create or update search](#create-or-update-search-put)  |
| /api/search       |POST           |[Create or update search](#create-or-update-search-post)  |
| /api/search/{id}  |DELETE         |[Delete search by id](#delete-search-by-id)  |

## Manage user activities endpoints
| URL                  | HTTP Verb     | Description             |
|:-------------------- |:--------------|:------------------------|
| /api/cay/useraction  |POST           |[Create or update user action](#create-or-update-user-action) |

## Create / update endpoints
| URL           | HTTP Verb     | Description             |
|:------------- |:--------------|:------------------------|
| /api/author   |POST            |[Create or update author](#create-or-update-author) |
| /api/asset    |POST            |[Create or update asset](#create-or-update-asset) |
| /api/comment  |POST            |[Create or update comment](#create-or-update-comment) |
| /api/index    |POST            |[Create index](#create-index) |
| /api/metadata |POST            |[Update metadata](#update-metadata) |
| /api/section  |POST            |[Create or update section](#create-or-update-section) |
| /api/user     |POST            |[Create or update user](#create-or-update-user) |

## Form endpoints
| URL           | HTTP Verb     | Description             |
|:------------- |:--------------|:------------------------|
| /api/form     |POST           |[Create or update form](#create-or-update-form-post) |
| /api/form     |PUT            |[Create or update form](#create-or-update-form-put) |
| /api/form/{id}/status/{status}    |POST            |[Update form status](#update-form-status) |
| /api/forms    |GET            |[Get forms](#get-forms) |
| /api/form/{id}  |GET            |[Get form by id](#get-form-by-id) |
| /api/form/{id}  |DELETE            |[Delete form](#delete-form) |

## Form submission endpoints
| URL                             | HTTP Verb     | Description             |
|:------------------------------- |:--------------|:------------------------|
| /api/form_submission/{form_id}  |POST           |[Create form submission](#create-form-submission) |
| /api/form_submission/{id}/status/{status}  |PUT           |[Update form submission status](#update-form-submission-status) |
| /api/form_submissions/{form_id} |GET           |[Get form submissions by form](#get-form-submissions-by-form) |
| /api/form_submission/{id}       |GET           |[Get form submission](#get-form-submission) |
| /api/form_submission/{id}/{answer_id}       |PUT           |[Edit form submission answer](#edit-form-submission-answer) |
| /api/form_submission/{id}/flag/{flag}       |PUT           |[Add flag to form submission](#add-flag-to-form-submission) |
| /api/form_submission/{id}/flag/{flag}       |DELETE           |[Delete flag from form submission](#delete-flag-from-form-submission) |
| /api/form_submission/{id}       |DELETE           |[Delete form submission](#delete-form-submission) |
| /api/form_submission/search       |POST           |[Search a string on the answers of the form submissions](#search-form-submissions) |

## Form galleries endpoints
| URL                             | HTTP Verb     | Description             |
|:------------------------------- |:--------------|:------------------------|
| /api/form_gallery/{id}          |GET            |[Get form gallery](#get-form-gallery) |
| /api/form_galleries/{form_id}   |GET            |[Get form galleries by form](#get-form-galleries-by-form) |
| /api/form_galleries/form/{form_id}  |GET            |[Get form galleries by form (version 2)](#get-form-galleries-by-form-version-2) |
| /api/form_gallery/{id}/add/{submission_id}/{answer_id}  |PUT    |[Add answer to form gallery](#add-answer-to-form-gallery) |
| /api/form_gallery/{id}/remove/{submission_id}/{answer_id}  |DELETE  |[Remove answer from form gallery](#remove-answer-from-form-gallery) |


### Import action
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/import/action   |GET            |Import action    |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/import/action
```

#### Example response
```
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
```

### Import asset
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/import/asset   |GET            |Import asset    |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/import/asset
```

#### Example response
```
Status: 200 OK
```

### Import comment
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/import/comment   |GET            |Import comment   |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/import/comment
```

#### Example response
```
Status: 200 OK
```

### Import note
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/import/note     |GET            |Import note   |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/import/note
```

#### Example response
```
Status: 200 OK
```

### Import user
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/import/user   |GET            |Import user   |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/import/user
```

#### Example response
```
Status: 200 OK
```

### Get tags
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/tags   |GET            |Get tags   |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/tags
```

#### Example response
```
.
```

### Create or update tag
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/tag   |POST            |Create or update tag   |

#### Parameters
None

#### Message body
```
body here
```

#### Example call
```
POST
https://localhost:8080/api/tag
```

#### Example response
```
Status: 200 OK
```

### Delete tag
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/tag   |POST            |Create or update tag   |

#### Parameters
None

#### Message body
```
body
```

#### Example call
```
DELETE
https://localhost:8080/api/tag
```

#### Example response
```
Status: 200 OK
```

### Get searches
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/searches   |GET            |Get searches   |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/searches
```

#### Example response
```
.
```

### Get search by id
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/search/{id}   |GET            |Get search by id   |

#### Parameters

* `id`: search id

#### Example call
```
GET
https://localhost:8080/api/search/123
```

#### Example response
```
.
```

### Create or update search (put)
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/search   |PUT            |Create or update search   |

#### Parameters

* `id`: search id

#### Example call
```
PUT
https://localhost:8080/api/search
```

#### Example response
```
Status: 200 OK
```

### Create or update search (post)
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/search   |PUT            |Create or update search   |

#### Parameters

* `id`: search id

#### Example call
```
POST
https://localhost:8080/api/search
```

#### Example response
```
Status: 200 OK
```

### Delete search
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/search{id}   |DELETE           |Delete search by id   |

#### Parameters

* `id`: search id

#### Example call
```
DELETE
https://localhost:8080/api/search/123
```

#### Example response
```
Status: 200 OK
```

### Create or update user action
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/cay/useraction  |POST           |Create or update user action   |

#### Parameters

* `id`: user id

#### Message body
```
.
```

#### Example call
```
POST
https://localhost:8080/api/cay/useraction?userid=123
```

#### Example response
```
Status: 200 OK
```

### Create or update author
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/author/{id}          |POST           |Create or update author   |

#### Parameters

* `id`: author id

#### Message body
```
.
```

#### Example call
```
POST
https://localhost:8080/api/author/456
```

#### Example response
```
Status: 200 OK
```

### Create or update asset
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/asset/{id}          |POST           |Create or update asset   |

#### Parameters

* `id`: asset id

#### Message body

#### Example call
```
POST
https://localhost:8080/api/asset/456
```

#### Example response
```
Status: 200 OK
```

### Create or update comment
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/comment/{id}          |POST           |Create or update comment   |

#### Parameters

* `id`: comment id

#### Message body


#### Example call
```
POST
https://localhost:8080/api/comment/456
```

#### Example response
```
Status: 200 OK
```

### Create index
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/index/{id}          |POST           |Create index   |

#### Parameters

* `id`: index id

#### Message body


#### Example call
```
POST
https://localhost:8080/api/index/678
```

#### Example response
```
Status: 200 OK
```
### Update metadata
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/metadata/{id}          |POST           |Update metadata   |

#### Parameters

* `id`: metadata id

#### Message body


#### Example call
```
POST
https://localhost:8080/api/metadata/789
```

#### Example response
```
Status: 200 OK
```

### Create or update section
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/section/{id}          |POST           |Create or update section   |

#### Parameters

* `id`: section id

#### Message body


#### Example call
```
POST
https://localhost:8080/api/section/123
```

#### Example response
```
Status: 200 OK
```

### Create or update user
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/user/{id}          |POST           |Create or update user   |

#### Parameters

* `id`: user id

#### Message body

#### Example call
```
POST
https://localhost:8080/api/user/234
```

#### Example response
```
Status: 200 OK
```

### Create or update form (post)
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form/{id}          |POST           |Create or update form   |

#### Parameters

* `id`: form id

#### Message body


#### Example call
```
POST
https://localhost:8080/api/form/123
```

#### Example response
```
Status: 200 OK
```

### Create or update form (put)
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form/{id}          |PUT          |Create or update form   |

#### Parameters

* `id`: asset id

#### Message body


#### Example call
```
PUT
https://localhost:8080/api/form/123
```

#### Example response
```
Status: 200 OK
```

### Update form status
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form/{id}/status/{status}  |POST           |Update form status   |

#### Parameters

* `id`: form id
* `id`: updated form status (what are the available form status options?)

#### Message body

#### Example call
```
POST
https://localhost:8080/api/form/123/status/complete
```

#### Example response
```
Status: 200 OK
```

### Get forms
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/forms  |GET          |Get all forms   |

#### Parameters
None

#### Example call
```
GET
https://localhost:8080/api/forms
```

#### Example response
```
.
```

### Get form by id
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form/{id}  |GET          |Get form by id   |

#### Parameters

* `id`: form id

#### Example call
```
GET
https://localhost:8080/api/form/123
```

#### Example response
```
.
```

### Delete form
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form/{id}  |DELETE          |Delete form by id   |

#### Parameters

* `id`: form id

#### Example call
```
DELETE
https://localhost:8080/api/form/123
```

#### Example response
```
Status: 200 OK
```

### Create form submission
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form/{form_id}  |POST          |Create form submission by id   |

#### Parameters

* `form_id`: form id

#### Message body

#### Example call
```
POST
https://localhost:8080/api/form/123
```

#### Example response
```
Status: 200 OK
```

### Update form submission status
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submission/{id}/status/{status}  |PUT          |Update form submission status   |

#### Parameters

* `id`: form id
* `status`: updated form submission status

#### Example call
```
PUT
https://localhost:8080/api/form_submission/123/status/completed
```

#### Example response
```
Status: 200 OK
```

### Get form submissions by form
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submissions/{form_id}  |GET          |Get form submission by form   |

#### Parameters

* `form_id`: form id

#### Example call
```
GET
https://localhost:8080/api/form_submissions/123
```

#### Example response
```
Status: 200 OK
```

### Get form submission
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submission/{id}  |GET         |Get form submission   |

#### Parameters

* `id`: form id

#### Example call
```
GET
https://localhost:8080/api/form_submission/123
```

#### Example response
```
Status: 200 OK
```

### Edit form submission answer
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submission/{id}/{answer_id}  |PUT          |Edit form submission answer   |

#### Parameters

* `id`: form id
* `answer_id`: answer id

#### Message body

#### Example call
```
PUT
https://localhost:8080/api/form_submission/123/456
```

#### Example response
```
Status: 200 OK
```

### Add flag to form submission
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submission/{id}/flag/{flag}  |PUT          |Add flag to form submission   |

#### Parameters

* `id`: form id
* `flag`: updated flag

#### Example call
```
PUT
https://localhost:8080/api/form_submission/123/flag/g
```

#### Example response
```
Status: 200 OK
```


### Delete flag from form submission
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submission/{id}/flag/{flag}  |DELETE          |Delete flag from form submission  |

#### Parameters

* `id`: form id
* `flag`: flag to delete

#### Example call
```
DELETE
https://localhost:8080/api/form_submission/123/flag/g
```

#### Example response
```
Status: 200 OK
```

### Delete form submission
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submission/{id}  |DELETE          |Delete form submission  |

#### Parameters

* `id`: form id

#### Example call
```
DELETE
https://localhost:8080/api/form_submission/123
```

#### Example response
```
Status: 200 OK
```

### Search form submissions
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_submission/search  |POST          |Search form submissions  |


#### Example call
```
POST
https://localhost:8080/api/form_submission/search
```

```
{
  "search": "Gophers"
}
```

#### Example response
```
Status: 200 OK
```

### Get form gallery
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_gallery/{id}  |GET         |Get form gallery |

#### Parameters

* `id`: form gallery id

#### Example call
```
GET
https://localhost:8080/api/form_gallery/123
```

#### Example response
```
Status: 200 OK
```

### Get form galleries by form
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_galleries/{form_id}  |GET         |Get form galleries by form |

#### Parameters

* `form_id`: form gallery id

#### Example call
```
GET
https://localhost:8080/api/form_galleries/123
```

#### Example response
```
Status: 200 OK
```

### Get form galleries by form (version 2)
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_galleries/form/{form_id}  |GET         |Get form galleries by form |

#### Parameters

* `form_id`: form gallery id

#### Example call
```
GET
https://localhost:8080/api/form_galleries/form/123
```

#### Example response
```
Status: 200 OK
```

### Add answer to form gallery
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_gallery/{id}/add/{submission_id}/{answer_id} |PUT    |Add answer to form gallery|

#### Parameters

* `id`: form gallery id
* `submission_id`: submission id
* `answer_id`: answer id

#### Message body

#### Example call
```
GET
https://localhost:8080/api/form_gallery/123/add/456/789
```

#### Example response
```
Status: 200 OK
```

### Remove answer from form gallery
| URL                  | HTTP Verb     | Functionality   |
|:-------------------- |:--------------|:----------------|
| /api/form_gallery/{id}/remove/{submission_id}/{answer_id} |DELETE    |Remove answer from form gallery|

#### Parameters

* `id`: form gallery id
* `submission_id`: submission id
* `answer_id`: answer id

#### Example call
```
GET
https://localhost:8080/api/form_gallery/123/remove/456/789
```

#### Example response
```
Status: 200 OK
```
