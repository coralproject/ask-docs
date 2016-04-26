# Step By Step Guide

We use docker hub to host all the images for the Coral apps. And we are using docker compose to compose an image for all the apps needed to run the system.


## Architecture

![Architecture](/images/coral-ecosystem-current.png)

## Requirements

### Install

- docker toolbox
    - docker compose https://docs.docker.com/compose/install/



### Create Docker MongoDB instance

##### mongo

We are using mongo db for the coral database. Docker will launch one mongo instance to manage all the databases we work on.

Manually:

- Setup credentials
- Import sample data


### Configuration for Docker compose

Configure Docker Compose file <compose.yml> to create all the containers needed to run the Coral system.


##### pillar / MONGODB_URL

Pillar is the service layer that receives data from the partners. You will need to change the configuration MONGODB_URL for the IP of the docker instance for mongo.


##### xenia / XENIA_MONGO_*

Xenia is the service layer based on MongoDB aggregation framwork queries. It serves the front end. You will need to change the configuration XENIA_MONGO_* for the credentials of the mongo on the docker instance.

## Step 1

Spin all the apps

docker-compose -f compose.yml up -d


## Step 2

to see if the instances are running :

docker-compose -f compose.yml ps

to see the logs:

docker-compose -f compose.yml logs


## Step 3

How to use it

$ docker ps

$ docker port quickstart_cayapp_1
80/tcp -> 0.0.0.0:81

$ docker-machine ip default
192.168.99.100

$ docker logs -f quickstart_cayapp_1

To look at the Trust App:

192.168.99.100:81


#### References

Standalone Application deployment <https://github.com/coralproject/reef/wiki/Standalone-Application-deployment>

Ecosystem <https://github.com/coralproject/reef/blob/master/ECOSYSTEM.md>
