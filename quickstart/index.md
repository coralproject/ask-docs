# Introduction

## Architecture

![Architecture](/images/trust-architecture.png)

This installation includes:

  * MongoDB server
  * [Sponge Application](https://github.com/coralproject/sponge)
  * [Pillar Service](https://github.com/coralproject/pillar)
  * [Xenia Service](https://github.com/coralproject/xenia)
  * [Cay Application](https://github.com/coralproject/cay)

# Step By Step Guide

We use [docker hub](https://hub.docker.com/) to host all the images for the Coral apps. And we are using [docker compose](https://docs.docker.com/compose/) to compose an image for all the apps needed to run the system. It will install the coral system based on the last updates from the projects in the coralproject's github.

## Requirements

#### Docker ToolBox

[Compose](https://docs.docker.com/compose/overview/) is a tool for defining and running multi-container Docker applications. You will need to [install it](https://docs.docker.com/compose/install/) to be able to run instances of apps from the coral system.

## Configuration

We are using [compose.yml](quickstart/compose.yml) to create all the containers needed to run the Coral system.

### Step 1

Setup environment variables:

Google Analytics ID (not needed for local test):

> export GAID_VALUE=<entervalue>

> export AUTH_TOKEN_VALUE=<entervalue>

Where your app is going to be running on:


> export FRONTEND_HOST=localhost

### Step 2

Spin all the apps


> docker-compose -f compose.yml up -d

### Step 3

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


To access Trust App browse to http://192.168.99.100:81


# Where to go from here?

You can read on how each application is being build and [how to contribute to the project](/contributions/index.md).
