# Pillar Installation

## Before you begin

Before you install Pillar, you must have the following items installed and running:
* *MongoDB Server*. You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* *RabbitMQ*. You can find instructions on installing RabbitMQ [on the RabbitMQ website](https://www.rabbitmq.com/download.html).

## Install Docker Toolbox

If you do not already have Docker installed, do that first. You can install Docker Toolbox using the Docker instructions [located here](https://docs.docker.com/mac/). 

If you do have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check to see which version you have by XXX. If you are not at v1.7 or later, you can upgrade via the [Docker website](https://docs.docker.com/mac/).

## Set environment variables

Set the environment variables on your machine by exporting the variables indicated below. An easy way to do this is to copy and paste the export statements below into a file, and naming it "varexport":

    export MONGO_AUTHDB=xxx
    export MONGO_USER=xxx
    export MONGO_PASS=xxxx
    export RABBIT_USER=rabbitmq
    export RABBIT_PASS=welcome
    
Then, source the file by running this command:

    source varexport
    
## Clone the Pillar repository

Clone the Pillar repository:

    git clone https://github.com/coralproject/pillar.git
    
## Save the compose.yml folder

Save the compose.yml file [linked here](https://github.com/coralproject/docs/blob/master/quickstart/compose.yml) into the Pillar repository directory.

Remove every section except the "pillar:", "rabbitmq:", and "mongodata:" sections (delete "xeniaapp:", "atoll:", etc.).

This file contains all the instructions Docker Compose needs to set up your Pillar instance.

## Spin up the Pillar app

Use the following command to spin up the Pillar app:

    docker-compose -f compose.yml up -d


