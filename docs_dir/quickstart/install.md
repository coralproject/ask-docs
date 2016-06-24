# All-in-One Docker Compose Installation

The all-in-one Docker Compose installation is a quick, easy, packaged solution that requires few steps and should get all components up and running quickly. The downside is that this may not scale well, as everything is installed on one server. After a certain number of users (perhaps 50 or so), the server could become overloaded.

You can read about the different types of installation options on the [developer introduction page](introduction.md).

## Before you begin

You must have the following items installed and running:

* **MongoDB Server**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
* **RabbitMQ**: You can find instructions on installing RabbitMQ [on the RabbitMQ website](https://www.rabbitmq.com/download.html).

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space required: 4GB

## Install Docker Toolbox

If you do not already have Docker installed, do that first. You can install Docker Toolbox using the Docker instructions [located here](https://docs.docker.com/mac/).

If you do have Docker installed, you'll want to make sure that you have Docker Compose version 1.7 or later. You can check your version using the command `docker version`.

## Get the source code

Clone the Proxy repository. This repository contains a number of setup files that you can edit, and will help you easily spin up a Docker container.
```
git clone https://github.com/coralproject/Proxy.git
```
Then cd into the Proxy directory.
```
cd Proxy
```

## Set environment variables

The `env.conf` file contains environment variables you need to set. Setting your environment variables tells Docker which IP address your Coral frontend will have, as well as other information such as your MongoDB username and password.

```
export FRONTEND_HOST=

export GAID_VALUE=xxxx
export AUTH_TOKEN_VALUE=xxxx
export RABBIT_USER=rabbitmq
export RABBIT_PASS=welcome
# mongo:
export MONGO_AUTHDB=admin
export MONGO_USER=coral-user
export MONGO_PASS=welcome
export MONGO_DB=coral

#elkhorn
export accessKeyId=xxx
export secretAccessKey=xxx
export pillarHost=xxx
export basicAuthorization=xxx
export bucket=xxx
export region=xxx
# sponge:
export STRATEGY_CONF=/usr/local/strategy.json
```

Required edits:

* `FRONTEND_HOST`: set to your desired IP address for the front end. For this example, we will use `192.168.99.100`.

Optional edits:

* `GAID_VALUE=xxxx`: If you're using Google Analytics, set your token at `export GAID_VALUE=xxxx`. Otherwise, delete or comment out this line.
* `export AUTH_TOKEN_VALUE=xxxx`: If you're using a custom auth token, set that at `export AUTH_TOKEN_VALUE=xxxx`. Otherwise, delete or comment out this line.

Finally, while inside the `Proxy` directory, run the following command to export your edited variables and set the environment variables.
```
source env.conf
```

## Spin up the Docker container

The very first time that you spin up the Docker container, this will be a multi-step process:

1\. Spin up the Docker container:
```
docker-compose -f docker-compose.yml up -d
```
The `docker-compose.yml` file contained in the docker-setup directory contains all the instructions that Docker Compose needs to set up the Coral Ecosystem.

2\. **Note:** If this is your first time spinning up the Docker container, Docker is going to download and install a number of Docker images first. These can be fairly large (~500MB per image), so it may take a few minutes.

3\. Once all Docker images have been downloaded, you'll see something like the following in your terminal:
```
Creating proxy_mongodata_1
Creating proxy_sponge_1
Creating proxy_rabbitmq_1
Creating proxy_atollapp_1
Creating proxy_xeniaapp_1
Creating proxy_pillarapp_1
Creating proxy_cayapp_1
Creating proxy_proxy_1
```

4\. Now, shut everything down with the Docker `down` command. This up-down-up sequence initializes authentication on MongoDB.
```
docker-compose -f docker-compose.yml down
```

5\. Finally, start the Docker container back up. In future (now that the Docker images have all been downloaded and set up), you can simply use this command to start your Docker container.
```
docker-compose -f docker-compose.yml up -d
```


## Test it out

To make sure it's working, try to hit the front-end URL in your browser. This is the URL you specified as `FRONTEND_HOST` in the `env.conf` setup above; in this case, [https://192.168.99.100](https://192.168.99.100).

## Troubleshooting

### Viewing running Docker containers
To see all of the Docker containers currently running, use the command `docker ps` (you can read more about this command and its options at the [Docker website](https://docs.docker.com/engine/reference/commandline/ps/)).
```
docker ps
```
You should have all of the following containers running:

* nginx:stable-alpine
* coralproject/cay
* coralproject/elkhorn
* coralproject/pillar
* coralproject/atoll
* coralproject/xenia
* coralproject/sponge
* rabbitmq:management
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
