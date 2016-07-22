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

You can read more information about generating forms on the [Ask](../user/ask/#ask-components) user page.

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

# Elkhorn installation

## Install from source

### Before you begin

Before you begin, be sure you have the following installed and running:

* [Pillar](../../pillar/#pillar-installation)

In addition, you must have Node.js installed:

* [Node.js](https://nodejs.org/en/download/)
    * You must be running version 5.0.0 or higher of node. You can check your current version of node with the command `node --version`
    * We recommend using [nvm](https://www.npmjs.com/package/nvm) to manage your node installations.

## Set up your external storage system (optional)

Elkhorn uses an external storage system as a cache to store pre-built bundled files of your created form. This allows the forms to be quickly served up when embedded on your page. Each bundled file runs about ~100KB, and there is one bundled file per form.

There are currently a couple of different options available for the external storage system you can use.

* **Amazon S3**: Amazon S3 is a storage system that is relatively easy to set up and use, and scales well: it allows many concurrent users to access the files.
* **Local file system**: If you don't set up an external storage system in the [set environment variables](#set-environment-variables) step, Elkhorn will default to using your local file system for storage. This can be a good option if you are developing locally, or just installing Elkhorn for demo purposes. If you want to scale, however, this can get unwieldy, and it will be best to set up a storage system that is fast and handles concurrency well.

### Amazon S3

[Amazon S3](https://aws.amazon.com/s3/) is a good option for your external storage system because it is fast, handles concurrency, and will scale well.

The setup of S3 is straightforward, and Amazon has good documentation. For the purposes of setting S3 up for Ask, you can follow Amazon's instructions [here](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html).

1. Follow the directions for [Sign Up for Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html) and [Create a Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html). There is no need to continue further to the demos for "Add an Object to a Bucket" and beyond: those are simply examples showing you how to use S3.

* For my example, I named my bucket "ask-bucket-test" and chose region "Northern California" (which corresponds to us-west-2).
* During the sign up process, you will create an AWS Access Key. Hang on to that information (you have the option to download it).

2. Once you have signed up and set up a bucket, go to your [S3 console](https://console.aws.amazon.com/s3) to set up your permissions under "Security Credentials."

3. Ensure that under "Permissions," the only Grantee is you. This means that nobody but you can access your bucket (using your AWS Access Key).

You're all set! You can now use your AWS Access Key to connect Elkhorn to your S3 bucket (you'll set this up in the [Set up configuration file](#set-up-configuration-file) section below). If you didn't save your AWS Access Key during the set up process, you can go to the "Security Credentials" section and create a new one.


### Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory:
```
cd elkhorn
```

And perform an `npm install`:
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

Required edits:

* `pillarHost`: The URL where Pillar is running.
    * If you installed Pillar [locally from source](../pillar/#install-pillar-from-source), `pillarHost` should be `http://localhost:8080`.
    * If you installed Pillar [locally as a Docker container](../pillar/#install-as-docker-container), `pillarHost` should be `http://10.0.4.105:8080`. `http://10.0.4.105` is the URL generated by Docker.
* `s3`: If you [set up Amazon S3](#amazon-s3) above, here is where you will enter that information. If you leave these fields blank, Elkhorn will default to using your local file system for external storage.
    * `bucket`: The name of your S3 bucket (in the example setup above, `ask-bucket-test`)
    * `region`: The AWS region that you selected in your S3 setup. You can find it in your S3 console URL. In the example setup above, it is `us-west-2`.
    * `accessKeyId`: Your AWS Access Key ID that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.
    * `secretAccessKey`: Your AWS Access Key that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.

Optional edits:
* `basicAuthorization`:

### Run the app

You can now start Elkhorn by running npm start:
```
npm start
```
Elkhorn will now be running locally on port 4444. You can now visit Elkhorn by visiting the URL [http://localhost:4444](http://localhost:4444).


## Install as a Docker container

### Install Docker Toolbox

If you do not already have Docker installed, do that first. You can install Docker Toolbox from the [Docker Toolbox product page](https://www.docker.com/products/docker-toolbox).

If you do have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose version`.

### Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory:
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

However, you may find that there is a question field we haven't included yet that you'd like to have. You can create your own, and then [add it to our code base](../contribute) so others can use it too!

## How to create a new question field

In order to create a new question field, there are two main things you must do:

* **Extend the AskInterface interface**: Your question field class will extend the `AskField` interface.
* **Expose `validate` and `getValue` methods**: You will have to implement these methods from the `AskField` interface.

A good place to start is to [check out the source](https://github.com/coralproject/elkhorn/tree/master/src/components/fields) for our existing question fields.
