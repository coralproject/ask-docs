# Ask

## What is Ask?

Ask is a tool that enables editors to create embeddable calls for contributions, including text, photo, video, and audio. The contributions can be connected to existing user profiles. Editors can manage high volumes of contributions, and display the best ones alongside the call. [Read more about Ask here.](https://coralproject.net/products/ask.html)

## Who is Ask for?

* **Engagement editors and journalists**: People who invite, manage, and publish user-generated content in order to improve the quality of the journalism.
* **End users**: People who consume content and contribute their own knowledge and experiences, in order to improve the quality of the coverage so that it is closer to their own needs and experiences.
* **Publishers**: People who want to understand the value of engaging more deeply with segments of the users, in order to better assess how and why to invest smartly in community.

We've created a guide on how to write a well-considered form. [You can read it here.](https://blog.coralproject.net/forms-audience-engagement/)

## Architecture

![ask-architecture](/images/ask-architecture.svg)

## Latest Install

Public beta of Ask, 0.40, was released on 9/14/16. 

## Ask components

### Create form

The form builder is located under "Create Form."

#### Question fields

Ask allows for multiple input field types to be added to a form. All fields are validated, except for phone number. Each input field also has the option to add a description.

* **Short Answer**: Provides a single line text input area. You can set the character limits.
* **Long Answer**: Provides a paragraph text input area. You can set the character limits.
* **Numbers**: Only number characters can be entered in this field.
* **Multiple Choice**: Provides multiple choice answer options.
* **Email**
* **Date**
* **Phone number**

#### Additional fields

The form also has options for:

* A customizable "thank you" message after submitting.
* Adding text without an entry field to the top of the form (a "headline" and instructions or description).
* Terms and conditions that will appear as text at the bottom of the form.

### Embedding the generated form

Once a form has been saved, an embed code is generated. You can then use this code to embed the form into your own page. Three options are presented for using the forms:

#### Embed code
You can render a form directly into a page, using a `script src` tag. This offers the advantages of native CSS inheritance (as iframes won't inherit any CSS from the parent page). Note that the div-id does need to be `ask-form`: the name is hardcoded.
```
<div id="ask-form"></div><script src="[filewritelocation]/[formid].js"></script>
```

#### Embed code (iframe)
You can take the standalone page link and use it in an iframe, which you can then embed directly into your page. You may have to tweak the width and height parameters.
```
<iframe src="https://[elkhornserver]/iframe/[form_id]" width="100%" height="600px"></iframe>
```

#### Standalone form
The "Standalone Form" button takes you to the form as a standalone page that you can link to.

### View forms

The "View forms" area allows you the create, edit, and view forms, as well as view the submissions made to your forms.

You can:

* see which forms are currently active.
* see the number of submissions.
* sort and search forms by creator/status/date created/words used in the questions.

# Ask installation

You can install the Ask product through a straightforward Docker Compose installation. This installs only the parts of Coral that are required for Ask.

There are two options currently available for installing Ask:

* **[Basic demo setup](#ask-installation-basic-demo-setup)**: The first option is an extremely simple demo setup: all variables are hardcoded, so all you have to do is run a few simple commands to get up and running on your laptop.
    * **_Probably best for you if:_** you just want to install and demo Ask.
* **[Advanced setup](#ask-installation-advanced-setup)**: The second option is still simple, but has a few more steps where you can set some variables and customize your setup (for instance, set up your own S3 bucket instead of using our hardcoded demo S3 bucket).
    * **_Probably best for you if:_** you want to do more with Ask than just a basic demo.

# Ask installation: basic demo setup

We currently support Mac, Linux, and Windows. Choose your operating system to view installation instructions.

* **[Mac OS X](#basic-demo-setup-mac)**: We support OS X El Capitan (10.11) or newer.
* **[Linux](#basic-demo-setup-linux)**: We support Ubuntu 15.10 or newer.
* **[Windows](#basic-demo-setup-windows)**: We support Windows 7 or newer.

## Basic demo setup: Mac OS X

### Before you begin

You must have the following items installed:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **Docker Toolbox**: You can install Docker Toolbox from the [Docker Toolbox product page](https://www.docker.com/products/docker-toolbox).
    * If you already have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose --version`.

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space: 4GB

#### Browser requirements
We currently support Chrome.

### Get the source code

Clone the Ask repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/ask.git
```
Then cd into the `ask/docker` directory.
```
cd ask/docker
```

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. This will usually be in your Applications folder, or (if on Mac) you can type "docker quickstart" into Spotlight to find it quickly. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.

#### Troubleshooting

* You may have to use the command `eval $(docker-machine env)` before proceeding to get Docker to work.
* If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.
* If you see an error like the one below, try closing and reopening Docker Quickstart Terminal again, or simply waiting (sometimes it can take a few moments).

```
(default) Check network to re-create if needed...
(default) Waiting for an IP...
```

### Spin up the Docker container

Ensure you are in the `ask/docker` directory.

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f ask-basic-local.yaml up -d
```
The `ask-basic-local.yaml` file contained in the `ask/docker` directory contains all the instructions that Docker Compose needs to set up the Ask product.

**Troubleshooting note**: If you see an error, such as the one below, make sure that your Docker Compose installation is version 1.7 or above. You can check your version using the command `docker-compose --version`.
```
Unsupported config option for services service: 'mongodata'
```

2\. Docker will now download and install a number of Docker images. This may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating network "docker_default" with the default driver
Creating docker_mongodata_1
Creating docker_pillarapp_1
Creating docker_elkhorn_1
Creating docker_cayapp_1
```

4\. If this is your first time installing Ask, you'll now have to shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f ask-basic-local.yaml down
```

5\. Finally, start the Docker container back up. In future, you can simply use this command to start your Docker container (instead of bringing Docker up, then down, then up again).
```
docker-compose -f ask-basic-local.yaml up -d
```

### Access Ask

You can now use Ask by accessing the front end URL in your browser.

* On Mac, the default Docker Machine IP for local machines is `192.168.99.100`: [http://192.168.99.100](http://192.168.99.100)

## Basic demo setup: Linux

### Before you begin

You must have the following items installed:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **Docker Toolbox**: You can install Docker Toolbox from the [Docker Toolbox product page](https://www.docker.com/products/docker-toolbox).
    * If you already have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose --version`.

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space: 4GB

#### Browser requirements
We currently support Chrome.

### Get the source code

Clone the Ask repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/ask.git
```
Then cd into the `ask/docker` directory.
```
cd ask/docker
```

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.

#### Troubleshooting

* You may have to use the command `eval $(docker-machine env)` before proceeding to get Docker to work.
* If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.
* If you see an error like the one below, try closing and reopening Docker Quickstart Terminal again, or simply waiting (sometimes it can take a few moments).

```
(default) Check network to re-create if needed...
(default) Waiting for an IP...
```

### Set frontend URL variables

On Linux, you will have to manually edit a few variables in the `ask-basic-local.yaml` file. This is because the current basic demo setup is geared toward Macs, and the Docker Machine IP for local installations on Mac is different from the IP for Linux machines.

Basically, anywhere that you see `192.168.99.100` in the `ask-basic-local.yaml` file, you want to change it to `127.0.0.1`.

Open up your `ask-basic-local.yaml` file and set these variables:

* `PILLAR_URL` (under "cayapp"): Set to `http://127.0.0.1:8080`.
* `ELKHORN_URL` (under "cayapp"): Set to `http://127.0.0.1:4444`.
* `PILLAR_URL` (under "elkhorn"): Set to `http://127.0.0.1:8080`.

### Spin up the Docker container

Ensure you are in the `ask/docker` directory.

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f ask-basic-local.yaml up -d
```
The `ask-basic-local.yaml` file contained in the `ask/docker` directory contains all the instructions that Docker Compose needs to set up the Ask product.

**Troubleshooting note**: If you see an error, such as the one below, make sure that your Docker Compose installation is version 1.7 or above. You can check your version using the command `docker-compose --version`.
```
Unsupported config option for services service: 'mongodata'
```

2\. Docker will now download and install a number of Docker images. This may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating network "docker_default" with the default driver
Creating docker_mongodata_1
Creating docker_pillarapp_1
Creating docker_elkhorn_1
Creating docker_cayapp_1
```

4\. If this is your first time installing Ask, you'll now have to shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f ask-basic-local.yaml down
```

5\. Finally, start the Docker container back up. In future, you can simply use this command to start your Docker container (instead of bringing Docker up, then down, then up again).
```
docker-compose -f ask-basic-local.yaml up -d
```

### Access Ask

You can now use Ask by accessing the front end URL in your browser.

* On Linux, this should be set to `127.0.0.1` (the URL we set back in the [setting frontend URL variables](#set-frontend-URL-variables) step): [http://127.0.0.1](http://127.0.0.1)

## Basic demo setup: Windows

### Before you begin

You must have the following items installed:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **Docker Toolbox**: You can install Docker Toolbox from the [Docker Toolbox product page](https://www.docker.com/products/docker-toolbox).
    * If you already have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose --version`.

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space: 4GB

#### Browser requirements
We currently support Chrome.

### Get the source code

Clone the Ask repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/ask.git
```
Then cd into the `ask/docker` directory.
```
cd ask/docker
```

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.

#### Troubleshooting

* You may have to use the command `eval $(docker-machine env)` before proceeding to get Docker to work.
* If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.
* If you see an error like the one below, try closing and reopening Docker Quickstart Terminal again, or simply waiting (sometimes it can take a few moments).

```
(default) Check network to re-create if needed...
(default) Waiting for an IP...
```

### Spin up the Docker container

Ensure you are in the `ask/docker` directory.

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f ask-basic-local.yaml up -d
```
The `ask-basic-local.yaml` file contained in the `ask/docker` directory contains all the instructions that Docker Compose needs to set up the Ask product.

**Troubleshooting note**: If you see an error, such as the one below, make sure that your Docker Compose installation is version 1.7 or above. You can check your version using the command `docker-compose --version`.
```
Unsupported config option for services service: 'mongodata'
```

2\. Docker will now download and install a number of Docker images. This may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating network "docker_default" with the default driver
Creating docker_mongodata_1
Creating docker_pillarapp_1
Creating docker_elkhorn_1
Creating docker_cayapp_1
```

4\. If this is your first time installing Ask, you'll now have to shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f ask-basic-local.yaml down
```

5\. Finally, start the Docker container back up. In future, you can simply use this command to start your Docker container (instead of bringing Docker up, then down, then up again).
```
docker-compose -f ask-basic-local.yaml up -d
```

### Access Ask

You can now use Ask by accessing the front end URL in your browser.

* On Windows, this should be set to `127.0.0.1` by default: [http://127.0.0.1](http://127.0.0.1)


# Ask installation: advanced setup

We currently support Mac, Linux, and Windows. Choose your operating system to view installation instructions.

* **[Mac OS X](#basic-demo-setup-mac)**: We support OS X El Capitan (10.11) or newer.
* **[Linux](#basic-demo-setup-linux)**: We support Ubuntu 15.10 or newer.
* **[Windows](#basic-demo-setup-windows)**: We support Windows 7 or newer.

## Advanced setup: Mac OS X

### Before you begin

You must have the following items installed and running:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **Docker Toolbox**: You can install Docker Toolbox from the [Docker Toolbox product page](https://www.docker.com/products/docker-toolbox).
    * If you already have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose --version`.

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space: 4GB

#### Browser requirements
We currently support Chrome.

### Set up your external storage system (optional)

Ask uses an external storage system as a cache to store pre-built bundled files of your created form. This allows the forms to be quickly served up when embedded on your page. Each bundled file runs about ~100KB, and there is one bundled file per form.

There are currently a couple of different options available for the external storage system you can use.

* **Amazon S3**: Amazon S3 is a storage system that is relatively easy to set up and use, and scales well: it allows many concurrent users to access the files.
* **Local file system**: If you don't set up an external storage system in the [set environment variables](#set-environment-variables) step, Ask will default to using your local file system for storage. This can be a good option if you are developing locally, or just installing Ask for demo purposes. If you want to scale, however, this can get unwieldy, and it will be best to set up a storage system that is fast and handles concurrency well.

#### Amazon S3

[Amazon S3](https://aws.amazon.com/s3/) is a good option for your external storage system because it is fast, handles concurrency, and will scale well.

The setup of S3 is straightforward, and Amazon has good documentation. For the purposes of setting S3 up for Ask, you can follow Amazon's instructions [here](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html).

1. Follow the directions for [Sign Up for Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html) and [Create a Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html). There is no need to continue further to the demos for "Add an Object to a Bucket" and beyond: those are simply examples showing you how to use S3.

* For my example, I named my bucket "ask-bucket-test" and chose region "Northern California" (which corresponds to us-west-2).
* During the sign up process, you will create an AWS Access Key. Hang on to that information (you have the option to download it).

2. Once you have signed up and set up a bucket, go to your [S3 console](https://console.aws.amazon.com/s3) to set up your permissions under "Security Credentials."

3. Ensure that under "Permissions," the only Grantee is you. This means that nobody but you can access your bucket (using your AWS Access Key).

You're all set! You can now use your AWS Access Key to connect Ask to your S3 bucket (you'll set this up in the [Set environment variables](#set-environment-variables) section below). If you didn't save your AWS Access Key during the set up process, you can go to the "Security Credentials" section and create a new one.

### Get the source code

Clone the Ask repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/ask.git
```
Then cd into the `ask/docker` directory.
```
cd ask/docker
```

### Set environment variables

The `env.conf` file contains environment variables you need to set. Setting your environment variables tells Docker which IP address your Coral front end will have, as well as other information such as your MongoDB username and password.

```
export FRONTEND_HOST=192.168.99.100

# mongo:
export MONGO_AUTHDB=admin
export MONGO_USER=coral-user
export MONGO_PASS=welcome
export MONGO_DB=coral
```

* `FRONTEND_HOST`: set to your desired IP address for the front end.
    * On Mac, the default Docker Machine IP for laptops is `192.168.99.100`.

MongoDB:

* `MONGO_USER`: set to the username for your MongoDB
* `MONGO_PASS`: set to the password for your MongoDB
* `MONGO_DB`: set to the name of your MongoDB (in this instance, "coral")
* `MONGO_AUTHDB`: set to the admin user of your database

Amazon S3 (optional):

* `S3_BUCKET`: set to the name of your S3 bucket (in this example, `ask-bucket-test`)
* `AWS_REGION`: set to the AWS region that you selected in your S3 setup. You can find it in your S3 console URL. In this example, it is `us-west-2`.
* `AWS_ACCESS_KEY`: set to your AWS Access Key ID that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.
* `AWS_ACCESS_KEY`: set to your AWS Access Key that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. This will usually be in your Applications folder, or (if on Mac) you can type "docker quickstart" into Spotlight to find it quickly. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.

#### Troubleshooting

* You may have to use the command `eval $(docker-machine env)` before proceeding to get Docker to work.
* If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.
* If you see an error like the one below, try closing and reopening Docker Quickstart Terminal again, or simply waiting (sometimes it can take a few moments).

```
(default) Check network to re-create if needed...
(default) Waiting for an IP...
```

### Spin up the Docker container

Ensure you are in the `ask/docker` directory.

First, run the following command to export your edited variables and set the environment variables.
```
source env.conf
```

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f docker-compose.yml up -d
```
The `docker-compose.yml` file contained in the `ask/docker` directory contains all the instructions that Docker Compose needs to set up the Ask product.

**Troubleshooting note**: If you see an error, such as the one below, make sure that your Docker Compose installation is version 1.7 or above. You can check your version using the command `docker-compose --version`.
```
Unsupported config option for services service: 'mongodata'
```

2\. Docker will now download and install a number of Docker images. This may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating docker_mongodata_1
Creating docker_pillarapp_1
Creating docker_elkhorn_1
Creating docker_cayapp_1
```

4\. If this is your first time installing Ask, you'll now have to shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f docker-compose.yml down
```

5\. Finally, start the Docker container back up. In future, you can simply use this command to start your Docker container (instead of bringing Docker up, then down, then up again).
```
docker-compose -f docker-compose.yml up -d
```

### Access Ask

You can now use Ask by accessing the front end URL in your browser. This is the URL you specified as `FRONTEND_HOST` in the `env.conf` setup above.

* On Mac, the default Docker Machine IP for laptops is `192.168.99.100`: [http://192.168.99.100](http://192.168.99.100)

## Advanced setup: Linux

### Before you begin

You must have the following items installed and running:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **Docker Toolbox**: You can install Docker Toolbox from the [Docker Toolbox product page](https://www.docker.com/products/docker-toolbox).
    * If you already have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose --version`.

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space: 4GB

#### Browser requirements
We currently support Chrome.

### Set up your external storage system (optional)

Ask uses an external storage system as a cache to store pre-built bundled files of your created form. This allows the forms to be quickly served up when embedded on your page. Each bundled file runs about ~100KB, and there is one bundled file per form.

There are currently a couple of different options available for the external storage system you can use.

* **Amazon S3**: Amazon S3 is a storage system that is relatively easy to set up and use, and scales well: it allows many concurrent users to access the files.
* **Local file system**: If you don't set up an external storage system in the [set environment variables](#set-environment-variables) step, Ask will default to using your local file system for storage. This can be a good option if you are developing locally, or just installing Ask for demo purposes. If you want to scale, however, this can get unwieldy, and it will be best to set up a storage system that is fast and handles concurrency well.

#### Amazon S3

[Amazon S3](https://aws.amazon.com/s3/) is a good option for your external storage system because it is fast, handles concurrency, and will scale well.

The setup of S3 is straightforward, and Amazon has good documentation. For the purposes of setting S3 up for Ask, you can follow Amazon's instructions [here](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html).

1. Follow the directions for [Sign Up for Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html) and [Create a Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html). There is no need to continue further to the demos for "Add an Object to a Bucket" and beyond: those are simply examples showing you how to use S3.

* For my example, I named my bucket "ask-bucket-test" and chose region "Northern California" (which corresponds to us-west-2).
* During the sign up process, you will create an AWS Access Key. Hang on to that information (you have the option to download it).

2. Once you have signed up and set up a bucket, go to your [S3 console](https://console.aws.amazon.com/s3) to set up your permissions under "Security Credentials."

3. Ensure that under "Permissions," the only Grantee is you. This means that nobody but you can access your bucket (using your AWS Access Key).

You're all set! You can now use your AWS Access Key to connect Ask to your S3 bucket (you'll set this up in the [Set environment variables](#set-environment-variables) section below). If you didn't save your AWS Access Key during the set up process, you can go to the "Security Credentials" section and create a new one.

### Get the source code

Clone the Ask repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/ask.git
```
Then cd into the `ask/docker` directory.
```
cd ask/docker
```

### Set environment variables

The `env.conf` file contains environment variables you need to set. Setting your environment variables tells Docker which IP address your Coral front end will have, as well as other information such as your MongoDB username and password.

```
export FRONTEND_HOST=192.168.99.100

# mongo:
export MONGO_AUTHDB=admin
export MONGO_USER=coral-user
export MONGO_PASS=welcome
export MONGO_DB=coral
```

* `FRONTEND_HOST`: set to your desired IP address for the front end.
    * On Linux, this should be set to `127.0.0.1` or a private IP address.

MongoDB:

* `MONGO_USER`: set to the username for your MongoDB
* `MONGO_PASS`: set to the password for your MongoDB
* `MONGO_DB`: set to the name of your MongoDB (in this instance, "coral")
* `MONGO_AUTHDB`: set to the admin user of your database

Amazon S3 (optional):

* `S3_BUCKET`: set to the name of your S3 bucket (in this example, `ask-bucket-test`)
* `AWS_REGION`: set to the AWS region that you selected in your S3 setup. You can find it in your S3 console URL. In this example, it is `us-west-2`.
* `AWS_ACCESS_KEY`: set to your AWS Access Key ID that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.
* `AWS_ACCESS_KEY`: set to your AWS Access Key that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.

#### Troubleshooting

* You may have to use the command `eval $(docker-machine env)` before proceeding to get Docker to work.
* If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.
* If you see an error like the one below, try closing and reopening Docker Quickstart Terminal again, or simply waiting (sometimes it can take a few moments).

```
(default) Check network to re-create if needed...
(default) Waiting for an IP...
```

### Spin up the Docker container

Ensure you are in the `ask/docker` directory.

First, run the following command to export your edited variables and set the environment variables.
```
source env.conf
```

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f docker-compose.yml up -d
```
The `docker-compose.yml` file contained in the `ask/docker` directory contains all the instructions that Docker Compose needs to set up the Ask product.

**Troubleshooting note**: If you see an error, such as the one below, make sure that your Docker Compose installation is version 1.7 or above. You can check your version using the command `docker-compose --version`.
```
Unsupported config option for services service: 'mongodata'
```

2\. Docker will now download and install a number of Docker images. This may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating docker_mongodata_1
Creating docker_pillarapp_1
Creating docker_elkhorn_1
Creating docker_cayapp_1
```

4\. If this is your first time installing Ask, you'll now have to shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f docker-compose.yml down
```

5\. Finally, start the Docker container back up. In future, you can simply use this command to start your Docker container (instead of bringing Docker up, then down, then up again).
```
docker-compose -f docker-compose.yml up -d
```

### Access Ask

You can now use Ask by accessing the front end URL in your browser. This is the URL you specified as `FRONTEND_HOST` in the `env.conf` setup above.

* On Linux, this should be set to `127.0.0.1` or a private IP address (the IP you set when [setting your environment variables](#set-environment-variables)): [http://127.0.0.1](http://127.0.0.1)

## Advanced setup: Windows

### Before you begin

You must have the following items installed and running:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **Docker Toolbox**: You can install Docker Toolbox from the [Docker Toolbox product page](https://www.docker.com/products/docker-toolbox).
    * If you already have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker-compose --version`.

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space: 4GB

#### Browser requirements
We currently support Chrome.

### Set up your external storage system (optional)

Ask uses an external storage system as a cache to store pre-built bundled files of your created form. This allows the forms to be quickly served up when embedded on your page. Each bundled file runs about ~100KB, and there is one bundled file per form.

There are currently a couple of different options available for the external storage system you can use.

* **Amazon S3**: Amazon S3 is a storage system that is relatively easy to set up and use, and scales well: it allows many concurrent users to access the files.
* **Local file system**: If you don't set up an external storage system in the [set environment variables](#set-environment-variables) step, Ask will default to using your local file system for storage. This can be a good option if you are developing locally, or just installing Ask for demo purposes. If you want to scale, however, this can get unwieldy, and it will be best to set up a storage system that is fast and handles concurrency well.

#### Amazon S3

[Amazon S3](https://aws.amazon.com/s3/) is a good option for your external storage system because it is fast, handles concurrency, and will scale well.

The setup of S3 is straightforward, and Amazon has good documentation. For the purposes of setting S3 up for Ask, you can follow Amazon's instructions [here](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html).

1. Follow the directions for [Sign Up for Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html) and [Create a Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html). There is no need to continue further to the demos for "Add an Object to a Bucket" and beyond: those are simply examples showing you how to use S3.

* For my example, I named my bucket "ask-bucket-test" and chose region "Northern California" (which corresponds to us-west-2).
* During the sign up process, you will create an AWS Access Key. Hang on to that information (you have the option to download it).

2. Once you have signed up and set up a bucket, go to your [S3 console](https://console.aws.amazon.com/s3) to set up your permissions under "Security Credentials."

3. Ensure that under "Permissions," the only Grantee is you. This means that nobody but you can access your bucket (using your AWS Access Key).

You're all set! You can now use your AWS Access Key to connect Ask to your S3 bucket (you'll set this up in the [Set environment variables](#set-environment-variables) section below). If you didn't save your AWS Access Key during the set up process, you can go to the "Security Credentials" section and create a new one.

### Get the source code

Clone the Ask repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/ask.git
```
Then cd into the `ask/docker` directory.
```
cd ask/docker
```

### Set environment variables

The `env.conf` file contains environment variables you need to set. Setting your environment variables tells Docker which IP address your Coral front end will have, as well as other information such as your MongoDB username and password.

```
export FRONTEND_HOST=192.168.99.100

# mongo:
export MONGO_AUTHDB=admin
export MONGO_USER=coral-user
export MONGO_PASS=welcome
export MONGO_DB=coral
```

* `FRONTEND_HOST`: set to your desired IP address for the front end.
    * On Windows, this should be set to `127.0.0.1` or a private IP address.

MongoDB:

* `MONGO_USER`: set to the username for your MongoDB
* `MONGO_PASS`: set to the password for your MongoDB
* `MONGO_DB`: set to the name of your MongoDB (in this instance, "coral")
* `MONGO_AUTHDB`: set to the admin user of your database

Amazon S3 (optional):

* `S3_BUCKET`: set to the name of your S3 bucket (in this example, `ask-bucket-test`)
* `AWS_REGION`: set to the AWS region that you selected in your S3 setup. You can find it in your S3 console URL. In this example, it is `us-west-2`.
* `AWS_ACCESS_KEY`: set to your AWS Access Key ID that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.
* `AWS_ACCESS_KEY`: set to your AWS Access Key that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. This will usually be in your Applications folder, or (if on Mac) you can type "docker quickstart" into Spotlight to find it quickly. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.

#### Troubleshooting

* You may have to use the command `eval $(docker-machine env)` before proceeding to get Docker to work.
* If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.
* If you see an error like the one below, try closing and reopening Docker Quickstart Terminal again, or simply waiting (sometimes it can take a few moments).

```
(default) Check network to re-create if needed...
(default) Waiting for an IP...
```

### Spin up the Docker container

Ensure you are in the `ask/docker` directory.

First, run the following command to export your edited variables and set the environment variables.
```
source env.conf
```

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f docker-compose.yml up -d
```
The `docker-compose.yml` file contained in the `ask/docker` directory contains all the instructions that Docker Compose needs to set up the Ask product.

**Troubleshooting note**: If you see an error, such as the one below, make sure that your Docker Compose installation is version 1.7 or above. You can check your version using the command `docker-compose --version`.
```
Unsupported config option for services service: 'mongodata'
```

2\. Docker will now download and install a number of Docker images. This may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating docker_mongodata_1
Creating docker_pillarapp_1
Creating docker_elkhorn_1
Creating docker_cayapp_1
```

4\. If this is your first time installing Ask, you'll now have to shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f docker-compose.yml down
```

5\. Finally, start the Docker container back up. In future, you can simply use this command to start your Docker container (instead of bringing Docker up, then down, then up again).
```
docker-compose -f docker-compose.yml up -d
```

### Access Ask

You can now use Ask by accessing the front end URL in your browser. This is the URL you specified as `FRONTEND_HOST` in the `env.conf` setup above.

* On Windows, this should be set to `127.0.0.1` or a private IP address (the IP you set when [setting your environment variables](#set-environment-variables)): [http://127.0.0.1](http://127.0.0.1)

# Troubleshooting

## Old version of Docker

If you see an error while running the Docker Compose commands, make sure that your Docker Compose installation is version 1.7 or above. You can check your version using the command `docker-compose --version`.
Example error:
```
Unsupported config option for services service: 'mongodata'
```

## Viewing running Docker containers
To see all of the Docker containers currently running, use the command `docker ps` (you can read more about this command and its options at the [Docker website](https://docs.docker.com/engine/reference/commandline/ps/)).
```
docker ps
```
You should have all of the following containers running:

* nginx:stable-alpine
* coralproject/cay:release
* coralproject/elkhorn
* coralproject/pillar:release
* coralproject/mongodata

## Viewing installed Docker images
To see all of the Docker images you have installed, use the command `docker images` (you can read more about this command and its options at the [Docker website](https://docs.docker.com/engine/reference/commandline/images/)).
```
docker images
```

## Viewing Docker logs
To view Docker logs for a container, use the command `docker logs <container id>` (you can read more about this command and its options at the [Docker website](https://docs.docker.com/engine/reference/commandline/logs/)).

First you have to find the container id:
```
docker ps
```

Then use the container id to view the logs:
```
docker logs e0bbd7be19c7
```

## Removing Docker images

There are a few reasons you might want to remove Docker images. You may wish to ensure that you are getting the latest build of the image. Or maybe something has gone awry with one or more of the images, and you just want to perform a fresh install of all images.

To remove all Docker images, use this command:

```
docker rmi $(docker images -q)
```

## Removing old Docker machines

Another option for a "fresh install" is to remove old Docker machines. You could try this in combination with [removing Docker images](#removing-docker-images) and then reinstalling Ask to see if that fixes your issue.

```
docker rm -f $(docker ps -a -q)
```

## Other issues while installing

* You may have to use the command `eval $(docker-machine env)` after you've started Docker in order to get Docker to work.
* If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.
* If you see an error like the one below, try closing and reopening Docker Quickstart Terminal again, or simply waiting (sometimes it can take a few moments).

```
(default) Check network to re-create if needed...
(default) Waiting for an IP...
```

# Ask tutorials

We are still developing our Ask tutorials. In the meantime, you can read our guide on [how to approach asking your readers for information.](https://coralproject.net/forms-audience-engagement/)

# Ask Docker Compose Installation

You can install the Ask product through a straightforward Docker Compose installation. This installs only the parts of Coral that are required for Ask.

## Before you begin

You must have the following items installed and running:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space: 4GB

## Install Docker Toolbox

If you do not already have Docker installed, do that first. You can install Docker Toolbox using the Docker instructions [located here](https://docs.docker.com/).

If you do have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker version`.

## Set up your external storage system (optional)

Ask uses an external storage system as a cache to store pre-built bundled files of your created form. This allows the forms to be quickly served up when embedded on your page. Each bundled file runs about ~100KB, and there is one bundled file per form.

There are currently a couple of different options available for the external storage system you can use.

* **Amazon S3**: Amazon S3 is a storage system that is relatively easy to set up and use, and scales well: it allows many concurrent users to access the files.
* **Local file system**: If you don't set up an external storage system in the [set environment variables](#set-environment-variables) step, Ask will default to using your local file system for storage. This can be a good option if you are developing locally, or just installing Ask for demo purposes. If you want to scale, however, this can get unwieldy, and it will be best to set up a storage system that is fast and handles concurrency well.

### Amazon S3

[Amazon S3](https://aws.amazon.com/s3/) is a good option for your external storage system because it is fast, handles concurrency, and will scale well.

The setup of S3 is straightforward, and Amazon has good documentation. For the purposes of setting S3 up for Ask, you can follow Amazon's instructions [here](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html).

1. Follow the directions for [Sign Up for Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html) and [Create a Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html). There is no need to continue further to the demos for "Add an Object to a Bucket" and beyond: those are simply examples showing you how to use S3.

* For my example, I named my bucket "ask-bucket-test" and chose region "Northern California" (which corresponds to us-west-2).
* During the sign up process, you will create an AWS Access Key. Hang on to that information (you have the option to download it).

2. Once you have signed up and set up a bucket, go to your [S3 console](https://console.aws.amazon.com/s3) to set up your permissions under "Security Credentials."

3. Ensure that under "Permissions," the only Grantee is you. This means that nobody but you can access your bucket (using your AWS Access Key).

You're all set! You can now use your AWS Access Key to connect Ask to your S3 bucket (you'll set this up in the [Set environment variables](#set-environment-variables) section below). If you didn't save your AWS Access Key during the set up process, you can go to the "Security Credentials" section and create a new one.

## Get the source code

Clone the Ask repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/ask.git
```
Then cd into the `ask/docker` directory.
```
cd ask/docker
```

## Set environment variables

The `env.conf` file contains environment variables you need to set. Setting your environment variables tells Docker which IP address your Coral front end will have, as well as other information such as your MongoDB username and password.

```
export FRONTEND_HOST=xxx

export AUTH_TOKEN_VALUE='Basic xxx'
export GAID_VALUE=xxx

export MONGO_USER=xxx
export MONGO_PASS=xxx
export MONGO_DB=xxx
export MONGO_AUTHDB=xxx

export RABBIT_USER=xxx
export RABBIT_PASS=xxx

export S3_BUCKET=xxx
export AWS_REGION=xxx
export AWS_ACCESS_KEY_ID=xxx
export AWS_ACCESS_KEY=xxx
```

* `FRONTEND_HOST`: set to your desired IP address for the front end. For this example, we will use `192.168.99.100`.

MongoDB:

* `MONGO_USER`: set to the username for your MongoDB
* `MONGO_PASS`: set to the password for your MongoDB
* `MONGO_DB`: set to the name of your MongoDB (in this instance, "coral")
* `MONGO_AUTHDB`: set to the admin user of your database

Amazon S3:

* `S3_BUCKET`: set to the name of your S3 bucket (in this example, `ask-bucket-test`)
* `AWS_REGION`: set to the AWS region that you selected in your S3 setup. You can find it in your S3 console URL. In this example, it is `us-west-2`.
* `AWS_ACCESS_KEY`: set to your AWS Access Key ID that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.
* `AWS_ACCESS_KEY`: set to your AWS Access Key that you received when you set up S3. You can also create a new key and key ID in the "Security Credentials" area of your S3 console.

Optional edits:

* `GAID_VALUE=xxxx`: If you're using Google Analytics, set your token at `export GAID_VALUE=xxxx`. Otherwise, delete or comment out this line.
* `export AUTH_TOKEN_VALUE=xxxx`: If you're using a custom auth token, set that at `export AUTH_TOKEN_VALUE=xxxx`. Otherwise, delete or comment out this line.

## Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. This will usually be in your Applications folder, or (if on Mac) you can type "docker quickstart" into Spotlight to find it quickly. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.
     * If, at any point, you see the error message `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`, this probably means that you are not running Docker commands within the Docker Quickstart Terminal. Make sure that you've opened up the Docker Quickstart Terminal and are running your Docker commands there.

Ensure you are in the `ask/docker` directory.

## Spin up the Docker container

First, run the following command to export your edited variables and set the environment variables.
```
source env.conf
```

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f docker-compose.yml up -d
```
The `docker-compose.yml` file contained in the `ask/docker` directory contains all the instructions that Docker Compose needs to set up the Ask product.

2\. Docker will now download and install a number of Docker images. This may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating network "docker_default" with the default driver
Creating docker_mongodata_1
Creating docker_pillarapp_1
Creating docker_elkhorn_1
Creating docker_cayapp_1
Creating docker_proxy_1
```

4\. If this is your first time installing Ask, you'll now have to shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f docker-compose.yml down
```

5\. Finally, start the Docker container back up. In future, you can simply use this command to start your Docker container (instead of bringing Docker up, then down, then up again).
```
docker-compose -f docker-compose.yml up -d
```

## Access Ask

You can now use Ask by accessing the front end URL in your browser. This is the URL you specified as `FRONTEND_HOST` in the `env.conf` setup above. In this example, we set it to [http://192.168.99.100](http://192.168.99.100).

## Troubleshooting

### Viewing running Docker containers
To see all of the Docker containers currently running, use the command `docker ps` (you can read more about this command and its options at the [Docker website](https://docs.docker.com/engine/reference/commandline/ps/)).
```
docker ps
```
You should have all of the following containers running:

* nginx:stable-alpine
* coralproject/cay:release
* coralproject/elkhorn
* coralproject/pillar:release
* coralproject/mongodata

### Viewing installed Docker images
To see all of the Docker images you have installed, use the command `docker images` (you can read more about this command and its options at the [Docker website](https://docs.docker.com/engine/reference/commandline/images/)).
```
docker images
```

### Viewing Docker logs
To view Docker logs for a container, use the command `docker logs <container id>` (you can read more about this command and its options at the [Docker website](https://docs.docker.com/engine/reference/commandline/logs/)).

First you have to find the container id:
```
docker ps
```

Then use the container id to view the logs:
```
docker logs e0bbd7be19c7
```

### Operating system requirements
On Mac, we support OS X El Capitan (10.11) or newer. If you are on an older OS, you may have to upgrade.

## Uninstalling Docker images

# Ask tutorials

This page will get filled in as we unroll the Ask product. In the meantime, you can find out more on the Ask product on [our website](https://www.coralproject.net).

