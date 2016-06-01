# Installation

## Run it from Docker Image

### Building image

To build the docker image run this command:

docker build -t "sponge:latest" -f Dockerfile ./

### Edit env.list

``STRATEGY_CONF=<path to strategy file>
PILLAR_URL=<url where pillar is running>``

``// DATABASE (optional if you want to overwrite strategy file values)
- DB_database= ""
- DB_username= ""
- DB_password= ""
- DB_host= ""
- DB_port= ""``

`// WEB SERVICE (optional if you want to overwrite strategy file values)
WS_appkey= ""
WS_endpoint= ""
WS_records= ""
WS_pagination= ""
WS_useragent= ""
WS_attributes= ""``

### Running the container

It will start imorting everything setup in the [strategy file](strategy.md).

``docker run --env-file env.list -d sponge``

## Development environment

You will need an instance of mysql running for the external source and an instance of [Pillar](http://github.com/coralproject/pillar) running to send the data to.

### Install Go

**Mac OS X**  
http://www.goinggo.net/2013/06/installing-go-gocode-gdb-and-liteide.html

**Windows**  
http://www.wadewegner.com/2014/12/easy-go-programming-setup-for-windows/

**Linux**  
I do not recommend using `apt-get`. Go is easy to install. Just download the
archive and extract it into /usr/local, creating a Go tree in /usr/local/go.

https://golang.org/doc/install


### Vendor Flag

Make sure your go vendor experiment flag is set (will be set by default in a couple of months).

```
export GO15VENDOREXPERIMENT=1
```

_We recommend adding this to your ~/.bash_profile or other startup script as it will become default go behavior soon._

### Get the source code

```
go get github.com/coralproject/xenia
```

You can also clone the code manually. The project must be cloned inside the `github.com/coralproject/sponge` folder from inside your GOPATH.

```
md $GOPATH/src/github.com/coralproject/sponge
cd $GOPATH/src/github.com/coralproject/sponge

git clone git@github.com:CoralProject/sponge.git
```

### Setup up your environment variables

This tells sponge which strategy file you want to use, and which [Pillar](https://github.com/coralproject/pillar)'s instance you are pushing data into.

* Specify a strategy configuration file with the environment variable STRATEGY_CONF

```
// Mandatory
export STRATEGY_CONF=/path/to/my/strategy.json
```

* Copy strategy file

There is one strategy file for publisher. It tells us how to do the transformation between the publisher's data and the coral data schema. It also tells us how to connect to the external publisher's source. There is a strategy file example in app/sponge/strategy.json.example.

```
cp app/sponge/strategy.json.example /path/to/my/strategy.json
```

* Specify the URL where pillar services are running

```
// Mandatory
export PILLAR_URL=http://localhost:8080
```

### Running tests

You can run tests in the `pkg` folder.

If you plan to run tests in parallel please use this command:

```
go test -cpu 1 ./...
```

You can alway run individual tests in each package using just:

```
go test
```

Do not run tests in the vendor folder.

### How to run

```
cd cmd/sponge
 go run main.go
```


### Build the CLI tool

```
cd $GOPATH/src/github.com/coralproject/cmd/cmd/sponge
go build
```

### Run the CLI tool

```
 ./sponge -h
```

will give you all the options to run it