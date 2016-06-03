# Pillar Installation

There are two options for installing Pillar: installing as a Docker container, or installing it from source code.

There are slight differences between installing on a server, and installing on your local desktop machine.

## Before you begin

Before you install Pillar, you must have the following items installed and running:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **RabbitMQ**: You can find instructions on installing RabbitMQ [on the RabbitMQ website](https://www.rabbitmq.com/download.html).
* **Git**: You can find instructions on installing git [on the git website](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
* **Docker**: You can find more information on installing Docker [on the Docker website](https://docs.docker.com/engine/installation/).
    * On the server, you can install Docker with the following command:

      ```sudo yum install docker```

* **Xenia**: Xenia is a XXX, and is part of the Coral Ecosystem. You can find instructions on how to install Xenia on your server [here](xenia/install.md).

# Install as Docker Container

## Clone the Pillar repository

Clone the Pillar repository:

    git clone https://github.com/coralproject/pillar.git

Then cd into the Pillar directory.

## Start Docker

First, start Docker.

    sudo service docker start

Then, build the Pillar server.

    sudo docker build -t pillar-server:0.1 .

## Set environment variables

Edit the file `config/dev.cfg` in the Pillar directory to set your environment variables.

The dev.cfg file already has some default values, but you should edit the following variables to match the values on your system:

* MONGODB_URL : Edit with your MongoDB URL.
* AMQP_URL : Edit with your RabbitMQ URL.
* XENIA_URL : Edit with your Xenia URL.
* XENIA_AUTH : Edit with your Xenia auth token.

## Run Docker

First, find the Image ID for the Pillar server:
    sudo docker images

This shows you the Image ID:

    REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    pillar-server       0.1                 24b7acf7a4b3        4 hours ago         771 MB
    golang              1.6                 024309f28934        8 days ago          744.1 MB

Then run the docker run command with the Image ID:

    sudo docker run --env-file config/dev.cfg --publish 8080:8080 24b7acf7a4b3

You should see the following:

    [negroni] listening on :8080

## Test it out

To see if Pillar is working correctly, visit this url: [http://10.0.4.105:8080/about](http://10.0.4.105:8080/about).

If things are running as they should, you should see this text:

    {"App":"Coral Pillar Web Service","Version":"Version - 0.0.1"}

# Pillar installation from source

First, you must have the following installed:
- MongoDB
- RabbitMQ
- Xenia

export MONGODB_URL=username:password@host/database
export MONGODB_URL=mongodb://localhost:27017/coral
