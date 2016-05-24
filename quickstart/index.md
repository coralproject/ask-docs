# Welcome!

This guide will take you from scratch through a fully functioning single-server Coral Ecosystem in 3 or 4 steps.

## Step 0, Install Docker ToolBox

The most direct way to get up an running is to use our Dockerized environment.

If you do not already have a Docker environment (including Docker Compose) setup on MAC OSX 10.9, we recommend installing via [Docker Toolbox] (https://docs.docker.com/mac/step_one/).

Docker has you covered with [quickstart guides for Toolbox](https://docs.docker.com/mac/).

Docker Toolbox is all you need to begin installing the Coral Ecosystem on a single machine!

(Note: you must have docker-compose v1.7 or later.)

## Step 1 - Set Environment Variables

**Required**

Set up your http host.  If you're running locally, you should use the ip address your ```docker-machine```.

To find your docker-machine ip, run this command:

> docker-machine ip default

(note, if you are not using the *default* docker machine, use the name of your docker-machine env above.)

Next you will need to clone the setup git repo to get started, we reccomend you check out git repo into desired folder and make that your starting location.

> git clone https://github.com/coralproject/Proxy.git

Now, cd into Proxy directory , set an evnironment var in env.conf file  using that value like so:

> export FRONTEND_HOST=docker-machine ip value

**Optional**

If you're using Google Analytics, set the token here:

> export GAID_VALUE=entervalue

If you're using a custom auth token, set it like so:

> export AUTH_TOKEN_VALUE=entervalue

> export RABBIT_USER=entervalue
> export RABBIT_PASS=entervalue

# mongo:
>export MONGO_DUMP=entervalue
>export MONGO_AUTHDB=admin
>export MONGO_USER=entervalue
>export MONGO_PASS=entervalue
>export MONGO_DB=coral

# sponge:
>export STRATEGY_CONF=/usr/local/strategy.json

Now run command inside Proxy folder , source env.conf to make sure teh environment variables are set correctly. 

## Step 2 - Spin up all the apps!

Save this file somewhere on your system: [compose.yml](compose.yml).  This file contains all the instructions Docker Compose needs to set up the Coral Ecosystem.

You can run the file like so:

> docker-compose -f compose.yml up -d

## Step 3 - That's it!

You should now have a fully operational Coral Ecosystem. If anything has gone wrong, please let us know!


## What just happened?!

You just installed the following coral components:

![Architecture](/images/trust-architecture.png)

* MongoDB server
  * [Sponge Application](https://github.com/coralproject/sponge)
  * [Pillar Service](https://github.com/coralproject/pillar)
  * [Xenia Service](https://github.com/coralproject/xenia)
  * [Cay Application](https://github.com/coralproject/cay)



# Working with the Coral Single Server Docker Ecosystem

to see if the instances are running :

> docker-compose -f compose.yml ps


to see the logs:

> docker-compose -f compose.yml logs



### Step 4

How to use it


> $ docker ps

gives you the name for Cay (front-end app)


get the port available:

> $ docker port quickstart_cayapp_1
80/tcp -> 0.0.0.0:81


get the ip for your docker machine:


> $ docker-machine ip default
192.168.99.100


To view the logs:


> $ docker logs -f quickstart_cayapp_1


To access Trust App browse to http://192.168.99.100

## Architecture

The Coral ecosystem consists of several appliations that work together to form our products. The following diagram lays out the full install.  

![Architecture](/images/trust-architecture.png)


# Where to go from here?

You can read on how each application is being build and [how to contribute to the project](/contributions/index.md).
