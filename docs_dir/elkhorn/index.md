# Introduction

[Elkhorn](https://github.com/coralproject/elkhorn) is the form composer and embeddable builder.

Elkhorn lets you create forms to solicit feedback from readers. You can then take the resulting forms and embed them in your website. The resulting data you collect is viewable in the [Ask](../ask) interface.

Elkhorn consists of the AskComposer and the Embed Service, which acts as an API.

## Composition

<img src="/images/elkhorn-architecture.svg">

## Ask Composer

Ask Composer is a JavaScript class that takes a spec in JSON format and turns it into a reader-facing form.

* Ask Composer doesn't know where the JSON originates from. In our case, in will come from the Ask interface in Cay (passed via the Embed Service), but in theory it could come from anywhere.
* Ask Composer stores the state of the form (completed fields, current progress, etc.).
* Ask Composer persists or saves the state of the form by sending the form to a data storage destination (this could be S3 if you set that up during the [installation process](#set-up-configuration-file), or on your local file system if you didn't set up S3).
* Partial states may be stored locally, even if S3 has been set up.

## Embed Service

The Embed Service is a REST-style API.

* The Embed Service talks to Cay, to receive the form spec in JSON format and pass that on to Ask Composer, and to pass the fully rendered form from Ask Composer to Cay.
* The Embed Service generates a bundle (using the [rollup](http://rollupjs.org/) module bundler) with all the required JavaScript to build and run the form, and sends this to the external storage system (S3 or local file system, depending on your installation set up).
* The Embed Service receives the form submission data from the embedded forms on the partner sites, and passes this data on to Pillar.

## Using the generated forms

### As a standalone page

The form can be viewed on a full standalone page, using the following URL:

```
https://[elkhornserver]/iframe/[form_id]
```

### Embedded as an iframe

You can take the standalone page link and use it in an iframe, which you can then embed directly into your page:

```
<iframe src="https://[elkhornserver]/iframe/[form_id]" width="100%" height="600px"></iframe>
```

* You may have to tweak the width and height parameters.

### Embedded directly into your page

You can render a form directly into a page, using a `script src` tag. This offers the advantages of native CSS inheritance (as iframes won't inherit any CSS from the parent page).

```
<div id="ask-form"></div><script src="[filewritelocation]/[formid].js"></script>
```

* The div does need to be named "ask-form": the name is hardcoded.

# Elkhorn Installation

## Install from source

### Before you begin

Before you begin, be sure you have the following installed and running:

* [Pillar](../../pillar/install)

In addition, you must have Node.js installed:

* [Node.js](https://nodejs.org/en/download/)
    * You must be running version 5.0.0 or higher of node. You can check your current version of node with the command `node --version`
    * We recommend using [nvm](https://www.npmjs.com/package/nvm) to manage your node installations.

### Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory.
```
cd elkhorn
```

Build Elkhorn.
```
npm install
```

### Set up configuration file

The Elkhorn directory has a configuration file, called `config.sample.json`. Copy this file to a new file called `config.json`, that you will edit:
```
cp config.sample.json config.json
```

Now edit the config.json file.
```
{
  "pillarHost": "",
  "basicAuthorization": "Basic 123123123123213",
  "s3": {
    "bucket": "",
    "region": "",
    "accessKeyId": "",
    "secretAccessKey": ""
  }
}
```

* For `pillarHost`, enter the URL where the service is running. If you installed [locally from source](../pillar/install), `pillarHost` should be `http://localhost:8080`.
* For `s3`, you can enter the values for your S3 setup. This is where Elkhorn will save

### Run the app

You can now start Elkhorn by running npm start:
```
npm start
```
Elkhorn will now be running locally on port 4444. You can now visit Elkhorn by visiting the URL [http://localhost:4444](http://localhost:4444).


## Install as a Docker container

### Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory.
```
cd elkhorn
```

### Build and run Elkhorn

Build Elkhorn:
```
docker build -t elkhorn .
```

Run Elkhorn:
```
docker run  --name elkhorn -d -p 4444:4444 elkhorn
```

Elkhorn will now be running locally on port 4444. You can now visit Elkhorn by visiting the URL [http://localhost:4444](http://localhost:4444).

# Embed Service API

The Embed Service is a REST-style API.

## Endpoints
| URL           | HTTP Verb     | Description             |
|:------------- |:--------------|:------------------------|
| /create       |POST           |[Create a form](#create) |
| /preview.js   |GET            |[Preview form](#preview) |
| /iframe       |GET            |[Get iframe form](#iframe) |

### Create
1. Cay sends a form specification in JSON format to Elkhorn.
2. Elkhorn creates the form and sends it to Pillar.
3. Elkhorn returns the ID to Cay.
4. Cay has now the form ID.

| URL           | HTTP Verb     | Functionality   |
|:--------------|:--------------|:----------------|
| /create       |POST           |Create a form    |

#### Parameters
None

#### Example call
```
POST
https://localhost:4444/create
```
#### Example message body
```
.
```

#### Example response
```
Status: 200 OK
```

### Preview.js

1. Cay sends a form as JSON to Elkhorn.
2. Elkhorn returns the rendered public-facing form preview.

| URL           | HTTP Verb     | Functionality   |
|:--------------|:--------------|:----------------|
| /preview.js   |GET            |Preview form    |

#### Parameters

* `id`: form id

#### Example call
```
GET
https://localhost:4444/preview.js?id=1234
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

### Iframe
| URL           | HTTP Verb     | Functionality   |
|:--------------|:--------------|:----------------|
| /iframe       |GET            |Get iframe form    |

#### Parameters

* `id`: form id

#### Example call
```
GET
https://localhost:4444/iframe?id=1234
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

# Contributing an answer field

We've included a variety of question field types in Elkhorn that can be used in building your forms. These include:

* **Short Answer**: Provides a single line text input area. You can set the character limits.
* **Long Answer**: Provides a paragraph text input area. You can set the character limits.
* **Numbers**: Only number characters can be entered in this field.
* **Multiple Choice**: Provides multiple choice answer options.
* **Email**
* **Date**
* **Phone number**

However, you may find that there is a question field we haven't included yet that you'd like to have. You can create your own, and then [add it to our code base](../development) so others can use it too!

## How to create a new question field

In order to create a new question field, there are two main things you must do:

* **Extend the AskInterface interface**: Your question field class will extend the `AskField` interface.
* **Expose `validate` and `getValue` methods**: You will have to implement these methods from the `AskField` interface.

A good place to start is to [check out the source](https://github.com/coralproject/elkhorn/tree/master/src/components/fields) for our existing question fields.
