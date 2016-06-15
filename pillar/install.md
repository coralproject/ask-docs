# Pillar Installation

If you want to install Pillar as part of an all-in-one installation of the Coral Ecosystem, you can [find instructions to do that here](../../quickstart/install.md).

When installing Pillar by itself, you can choose between installing Pillar as a Docker container, or installing from source.

* [Install Pillar from source](#install-pillar-from-source)
* [Install Pillar as a Docker container](#install-as-docker-container)

### Before you begin

Before you install Pillar, you must have the following items installed and running:

* **MongoDB**: You can find instructions on installing MongoDB [on the MongoDB website](https://docs.mongodb.com/getting-started/shell/).
    * There are [instructions on importing sample comment data into MongoDB here](../../quickstart/mongodb)
* **RabbitMQ**: You can find instructions on installing RabbitMQ [on the RabbitMQ website](https://www.rabbitmq.com/download.html).
* **Xenia**: Xenia is a configurable service layer that publishes endpoints against mongo aggregation pipeline queries. It is part of the Coral ecosystem. You can find instructions on how to install Xenia [here](../../xenia/install).

## Install Pillar from source

### Before you begin

If you want to install from source, you will need to have Go installed.

You can install [install Go from their website](https://golang.org/dl/). The [installation and setup instructions](https://golang.org/doc/install) on the Go website are quite good. Ensure that you have exported your $GOPATH environment variable, as detailed in the [installation instructions](https://golang.org/doc/install).

If you are not on a version of Go that is 1.7 or higher, you will also have to set the GO15VENDOREXPERIMENT flag.
```
export GO15VENDOREXPERIMENT=1
```

_If you are not on a version of Go 1.7 or higher, we recommend adding this to your ~/.bash_profile or other startup script._

### Get the source code

You can install the source code via using the `go get` command, or by manually cloning the code.

#### Using the go get command
```
go get github.com/coralproject/pillar
```
If you see a message about "no buildable Go source files" as shown below, you can ignore it. It simply means that there are no buildable source files in the uppermost pillar directory (though there are buildable source files in subdirectories).
```
package github.com/coralproject/pillar: no buildable Go source files in [directory]
```

#### Cloning manually
You can also clone the code manually.

```
mkdir $GOPATH/src/github.com/coralproject/pillar
cd $GOPATH/src/github.com/coralproject/pillar

git clone https://github.com/coralproject/pillar.git
```

### Set your environment variables

Setting your environment variables tells Pillar the URLs and other information for communicating with MongoDB, RabbitMQ, and Xenia.

Make your own copy of the `config/dev.cfg` file (you can edit this configuration file with your own values, and then ensure that you don't commit it back to the repository). Call your config file whatever you like; we'll call it "custom" in this example.
```
cd $GOPATH/src/github.com/coralproject/pillar
cp config/dev.cfg config/custom.cfg
```

Now edit the values in your custom.cfg file:
```
#Resources
export MONGODB_URL="mongodb://localhost:27017/coral"
export AMQP_URL="amqp://localhost:5672/"
export AMQP_EXCHANGE="PillarMQ"

#Pillar
export PILLAR_ADDRESS=":8080"
export PILLAR_HOME="/opt/pillar"
export PILLAR_CRON="false"
export PILLAR_CRON_SEARCH="@every 30m"
export PILLAR_CRON_STATS="@every 1m"

#Xenia
export XENIA_URL="http://localhost:4000/1.0/exec/"
export XENIA_QUERY_PARAM="?skip=0&limit=100"
export XENIA_AUTH="<auth token>"

# Stats
export MONGODB_ADDRESS="127.0.0.1:27017"
export MONGODB_USERNAME=""
export MONGODB_PASSWORD=""
export MONGODB_DATABASE=""
export MONGODB_SSL="False"
```

* For `XENIA_URL`:
    * If you installed [locally from source](../xenia/install), `XENIA_URL` should be `http://localhost:4000/1.0/exec/`.
* For `MONGODB_URL`:
    * If your MongoDB is a local installation, `MONGODB_URL` should be `mongodb://localhost:27017/coral`.
* For `AMQP_URL`:
    * If your RabbitMQ is a local installation, `AMQP_URL` should be `amqp://localhost:5672/`.

Once you've edited and saved your custom.cfg file, source it:

```
source $GOPATH/src/github.com/coralproject/pillar/config/custom.cfg
```

### Run Pillar

```
$GOPATH/bin/pillar
```
You should see:
```
[negroni] listening on :8080
```

## Install as Docker Container

### Install Docker
You can find more information on installing Docker on your machine [on the Docker website](https://docs.docker.com/engine/installation/).

* On the server, you can install Docker with the following command:
```
sudo yum install docker
```

### Clone the Pillar repository

Clone the Pillar repository:
```
git clone https://github.com/coralproject/pillar.git
```

Then cd into the Pillar directory.

### Start Docker

Start Docker.

* On the server, you can do this via the command:
  ```
  sudo service docker start
  ```
* On your local machine, you can start Docker via the Docker Quickstart Terminal. This will usually be in your Applications folder, or (if on Mac) you can type "docker quickstart" into Spotlight to find it quickly. The Docker Quickstart Terminal will open a new terminal window, running Docker, that you will then use to run the rest of the Docker related commands below.

### Build Pillar server

Build the Pillar server using `docker build`.
```
docker build -t pillar-server:0.1 .
```

* If you are building on the server, you may have to use `sudo`:
```
sudo docker build -t pillar-server:0.1 .
```

### Edit environment variables

The env.list file contains environment variables you need to set. Edit this file to reflect the settings on your own system.

```
# TODO: include finished env.list here
```

* For `XENIA_URL`:
    * If you installed [locally from source](../xenia/install), `XENIA_URL` should be `http://localhost:4000/1.0/exec/`.
* For `MONGODB_URL`:
    * If your MongoDB is a local installation, `MONGODB_URL` should be `mongodb://localhost:27017/coral`.


### Run Docker

First, find the Image ID for the Pillar server:
```
docker images
```

* If you are running on a server, you may have to use `sudo`.

This shows you the Image ID:
```
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
pillar-server       0.1                 24b7acf7a4b3        4 hours ago         771 MB
golang              1.6                 024309f28934        8 days ago          744.1 MB
```

Then run the docker run command with the Image ID:
```
docker run --env-file env.list --publish 8080:8080 24b7acf7a4b3
```
You should see the following:
```
[negroni] listening on :8080
```

### Test it out

To see if Pillar is working correctly, visit this url: [http://10.0.4.105:8080/about](http://10.0.4.105:8080/about). `http://10.0.4.105` is the URL generated by Docker for Pillar.

If things are running properly, you should see this text:
```
{"App":"Coral Pillar Web Service","Version":"Version - 0.0.1"}
```

## Shutting Pillar down

### Shutting Pillar down when running from source

If you installed and ran Pillar from source using the command `$GOPATH/bin/pillar`, you can shut it down by using the Ctrl + C command.

### Shutting Pillar down when running as a Docker container

To shut Pillar down when running as Docker container, first find the container ID (if you are running on a server, you may have to use `sudo`):
```
docker ps
```
Find the container ID for Pillar:
```
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                                                                                        NAMES
b30f4fa5f497        coralproject/pillar      "/bin/sh -c /go/bin/p"   3 days ago          Up 3 days           0.0.0.0:32776->8080/tcp                                                                      proxy_pillarapp_1
```
Run `docker stop` with the container ID (if you are running on a server, you may have to use `sudo`):
```
docker stop b30f4fa5f497
```
