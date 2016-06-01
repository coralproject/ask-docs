# All-in-One Docker Installation

## Before you begin

You must have the following items installed and running:

* **MongoDB Server**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **RabbitMQ**: You can find instructions on installing RabbitMQ [on the RabbitMQ website](https://www.rabbitmq.com/download.html).

## Install Docker Toolbox

If you do not already have Docker installed, do that first. You can install Docker Toolbox using the Docker instructions [located here](https://docs.docker.com/mac/). 

If you do have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check to see which version you have by XXX. If you are not at v1.7 or later, you can upgrade via the [Docker website](https://docs.docker.com/mac/).

## Set environment variables

First, clone the docker-setup repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.

    git clone https://github.com/coralproject/docker-setup.git
    
Then cd into the docker-setup directory, and edit the `env.conf` file.

    export FRONTEND_HOST=xxxx

    # optional Google Analytics
    export GAID_VALUE=xxxx
    
    # optional custom auth token
    export AUTH_TOKEN_VALUE=xxxx
    
    # rabbitmq
    export RABBIT_USER=rabbitmq
    export RABBIT_PASS=welcome
    
    # mongo:
    export MONGO_DUMP=xxxx
    export MONGO_AUTHDB=admin
    export MONGO_USER=coral-user
    export MONGO_PASS=welcome
    export MONGO_DB=coral

    # sponge:
    export STRATEGY_CONF=/usr/local/strategy.json
    
Optional edits:

* If you're using Google Analytics, set your token at `export GAID_VALUE=xxxx`. Otherwise, delete this line.
* If you're using a custome auth token, set that at `export AUTH_TOKEN_VALUE=xxxx`. Otherwise, delete this line.

Required edits:

* `export MONGO_DUMP=xxxx`
* `export MONGO_USER=xxxx` Enter the username for your MongoDB.
* `export MONGO_PASS=xxxx` Enter the password for your MongoDB.

Finally, while inside the `docker-setup` directory, run the following command to export your edited variables and set the environment variables.

    source env.conf
    
## Spin up the Docker container

You can now spin up the Docker container:

    docker-compose -f compose.yml up -d
    
The `compose.yml` file contained in the docker-setup directory contains all the instructions that Docker Compose needs to set up the Coral Ecosystem.

## Test it out

To make sure it's working, try this URL in your browser:

To see if the instances are running from the command line:

    docker-compose -f compose.yml ps

To see the logs:

    docker-compose -f compose.yml logs
    
