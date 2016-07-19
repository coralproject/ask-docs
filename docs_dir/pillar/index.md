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

# Pillar Installation

If you want to install Pillar as part of an all-in-one installation of the Coral Ecosystem, you can [find instructions to do that here](../quickstart/install.md).

When installing Pillar by itself, you can choose between installing Pillar as a Docker container, or installing from source.

* [Install Pillar from source](#install-pillar-from-source)
* [Install Pillar as a Docker container](#install-as-docker-container)

### Before you begin

Before you install Pillar, you must have the following items installed and running:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
    * There are [instructions on importing sample comment data into MongoDB here](../../quickstart/mongodb)
* **RabbitMQ**: You can find instructions on installing RabbitMQ [on the RabbitMQ website](https://www.rabbitmq.com/download.html).
* **Xenia**: Xenia is a configurable service layer that publishes endpoints against MongoDB aggregation pipeline queries. It is part of the Coral ecosystem. You can find instructions on how to install Xenia [here](../../xenia/install).

## Install Pillar from source

### Before you begin

If you want to install from source, you will need to have Go installed.

You can install [install Go from their website](https://golang.org/dl/). The [installation and setup instructions](https://golang.org/doc/install) on the Go website are quite good. Ensure that you have exported your $GOPATH environment variable, as detailed in the [installation instructions](https://golang.org/doc/install).

If you are not on a version of Go that is 1.7 or higher, you will also have to set the GO15VENDOREXPERIMENT flag.
```
export GO15VENDOREXPERIMENT=1
```

_If you are not on a version of Go 1.7 or higher, we recommend adding this to your ~/.bash_profile or other startup script._

### Get the source code

You can install the source code via using the `go get` command, or by manually cloning the code.

#### Using the go get command
```
go get github.com/coralproject/pillar
```
If you see a message about "no buildable Go source files" as shown below, you can ignore it. It simply means that there are no buildable source files in the uppermost pillar directory (though there are buildable source files in subdirectories).
```
package github.com/coralproject/pillar: no buildable Go source files in [directory]
```

#### Cloning manually
You can also clone the code manually (this does the same thing as the `go get` command above).

```
mkdir $GOPATH/src/github.com/coralproject/pillar
cd $GOPATH/src/github.com/coralproject/pillar

git clone https://github.com/coralproject/pillar.git
```

### Set your environment variables

Setting your environment variables tells Pillar the URLs and other information for communicating with MongoDB, RabbitMQ, and Xenia.

Make your own copy of the `config/dev.cfg` file (you can edit this configuration file with your own values, and then ensure that you don't commit it back to the repository). Call your config file whatever you like; we'll call it "custom" in this example.
```
cd $GOPATH/src/github.com/coralproject/pillar
cp config/dev.cfg config/custom.cfg
```

Now edit the values in your custom.cfg file:
```
#Resources
export MONGODB_URL="mongodb://localhost:27017/coral"
export AMQP_URL="amqp://localhost:5672/"
export AMQP_EXCHANGE="PillarMQ"

#Pillar
export PILLAR_ADDRESS=":8080"
export PILLAR_HOME="/opt/pillar"
export PILLAR_CRON="false"
export PILLAR_CRON_SEARCH="@every 30m"
export PILLAR_CRON_STATS="@every 1m"

#Xenia
export XENIA_URL="http://localhost:4000/1.0/exec/"
export XENIA_QUERY_PARAM="?skip=0&limit=100"
export XENIA_AUTH="<auth token>"

# Stats
export MONGODB_ADDRESS="127.0.0.1:27017"
export MONGODB_USERNAME=""
export MONGODB_PASSWORD=""
export MONGODB_DATABASE=""
export MONGODB_SSL="False"
```

* For `XENIA_URL`:
    * If you installed [locally from source](../xenia/install), `XENIA_URL` should be `http://localhost:4000/1.0/exec/`.
* For `MONGODB_URL`:
    * If your MongoDB is a local installation, `MONGODB_URL` should be `mongodb://localhost:27017/coral`.
* For `AMQP_URL`:
    * If your RabbitMQ is a local installation, `AMQP_URL` should be `amqp://localhost:5672/`.

Once you've edited and saved your custom.cfg file, source it with the following command:

```
source $GOPATH/src/github.com/coralproject/pillar/config/custom.cfg
```

### Run Pillar

```
$GOPATH/bin/pillar
```
You should see:
```
[negroni] listening on :8080
```

## Install as Docker Container

### Install Docker
You can find more information on installing Docker on your machine [on the Docker website](https://docs.docker.com/engine/installation/).

* On the server, you can install Docker with the following command:
```
sudo yum install docker
```

### Clone the Pillar repository

Clone the Pillar repository:
```
git clone https://github.com/coralproject/pillar.git
```

Then cd into the Pillar directory.
```
cd pillar
```

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. This will usually be in your Applications folder, or (if on Mac) you can type "docker quickstart" into Spotlight to find it quickly. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.
     * If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.

### Build Pillar server

Build the Pillar server using `docker build`.
```
docker build -t pillar-server:0.1 .
```

* If you are building on the server, you may have to use `sudo`:
```
sudo docker build -t pillar-server:0.1 .
```

### Edit environment variables

The env.list file contains environment variables you need to set. Edit this file to reflect the settings on your own system.

```
MONGODB_URL="mongodb://localhost:27017/coral"
AMQP_URL="amqp://localhost:5672/"
AMQP_EXCHANGE="PillarMQ"

PILLAR_ADDRESS=":8080"
PILLAR_HOME="/opt/pillar"
PILLAR_CRON="false"
PILLAR_CRON_SEARCH="@every 30m"
PILLAR_CRON_STATS="@every 1m"

XENIA_URL="http://localhost:4000/1.0/exec/"
XENIA_QUERY_PARAM="?skip=0&limit=100"
XENIA_AUTH="<auth token>"

MONGODB_ADDRESS="127.0.0.1:27017"
MONGODB_USERNAME=""
MONGODB_PASSWORD=""
MONGODB_DATABASE=""
MONGODB_SSL="False"
```

* For `XENIA_URL`:
    * If you installed [locally](../xenia/install), `XENIA_URL` should be `http://localhost:4000/1.0/exec/`.
* For `MONGODB_URL`:
    * If your MongoDB is a local installation, `MONGODB_URL` should be `mongodb://localhost:27017/coral`.
    * If your MongoDB is a local installation, `MONGODB_ADDRESS` should be `127.0.0.1:27017`.
* For `AMQP_URL`:
    * If your RabbitMQ is a local installation, `AMQP_URL` should be `amqp://localhost:5672/`.

### Run Docker

First, find the Image ID for the Pillar server:
```
docker images
```

* If you are running on a server, you may have to use `sudo`.

This shows you the Image ID:
```
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
pillar-server       0.1                 24b7acf7a4b3        4 hours ago         771 MB
golang              1.6                 024309f28934        8 days ago          744.1 MB
```

Then run the docker run command with the Image ID:
```
docker run --env-file env.list --publish 8080:8080 24b7acf7a4b3
```
You should see the following:
```
[negroni] listening on :8080
```

### Test it out

To see if Pillar is working correctly, visit this url: [http://10.0.4.105:8080/about](http://10.0.4.105:8080/about). `http://10.0.4.105` is the URL generated by Docker for Pillar.

If things are running properly, you should see this text:
```
{"App":"Coral Pillar Web Service","Version":"Version - 0.0.1"}
```

## Shutting Pillar down

### Shutting Pillar down when running from source

If you installed and ran Pillar from source using the command `$GOPATH/bin/pillar`, you can shut it down by using the Ctrl + C command.

### Shutting Pillar down when running as a Docker container

To shut Pillar down when running as Docker container, first find the container ID (if you are running on a server, you may have to use `sudo`):
```
docker ps
```
Find the container ID for Pillar:
```
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                                                                                        NAMES
b30f4fa5f497        coralproject/pillar      "/bin/sh -c /go/bin/p"   3 days ago          Up 3 days           0.0.0.0:32776->8080/tcp                                                                      proxy_pillarapp_1
```
Run `docker stop` with the container ID (if you are running on a server, you may have to use `sudo`):
```
docker stop b30f4fa5f497
```

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

```
Body: [
  {
    "id": "577c197810780b3401e7a3af",
    "form_id": "577c18f4a969c805f7f8c889",
    "status": "",
    "replies": [
      {
        "widget_id": "1",
        "identity": false,
        "answer": "Gophers everywhere",
        "edited": null,
        "question": "Is there anybody out there?",
        "props": {
          "a": "B",
          "c": 4
        }
      },
      {
        "widget_id": "2",
        "identity": true,
        "answer": "Dave",
        "edited": null,
        "question": "Name",
        "props": {
          "a": "B",
          "c": 4
        }
      },
      {
        "widget_id": "3",
        "identity": true,
        "answer": "D@ve.name",
        "edited": null,
        "question": "Email",
        "props": {
          "a": "B",
          "c": 4
        }
      }
    ],
    "flags": [],
    "header": {
      "description": "of the rest of your life",
      "title": "This is the first form"
    },
    "footer": {
      "conditions": "lots of conditions"
    },
    "finishedScreen": null,
    "created_by": null,
    "updated_by": null,
    "date_created": "2016-07-01T21:31:45-06:00",
    "date_updated": "2016-07-01T21:31:45-06:00"
  }
]
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
