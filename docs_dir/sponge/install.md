# Installation

## Before you begin

### Pillar
You will need to have an instance of [Pillar](http://github.com/coralproject/pillar) running, where your translated data will be sent. Instructions on installing Pillar [can be found here](/pillar/install.md).

### External database source
You will also have your external database running. This external database is the source of your existing comment data that will be extracted by Sponge and sent to Pillar, which will then load it into the Coral ecosystem.

The external sources we currently support are: PostgreSQL, MySQL, MongoDB, and REST APIs.

### Vendoring dependencies

You should be vendoring the packages you choose to use ("vendoring" is the moving of all third party items such as packages into the `/vendor` directory). We recommend using [govendor](https://github.com/kardianos/govendor). This tool will manage your dependencies from the vendor folder associated with this project repository.

## Install from source

### Before you begin

If you want to install from source, you will need to have Go installed.

First [install Go](https://golang.org/dl/). The [installation and setup instructions](https://golang.org/doc/install) on the Go website are pretty good. Ensure that you have exported your $GOPATH environment variable, as detailed in the [installation instructions](https://golang.org/doc/install).

If you are not on a version of Go that is 1.7 or higher, you will also have to set the GO15VENDOREXPERIMENT flag.
```
export GO15VENDOREXPERIMENT=1
```

_If you are not on a version of Go 1.7 or higher, we recommend adding this to your ~/.bash_profile or other startup script._

### Get the source code

You can install the source code via using the `go get` command, or by manually cloning the code.

#### Using the go get command
```
go get github.com/coralproject/sponge
```
If you see a message about "no buildable Go source files" like the below, you can ignore it. It simply means that there are buildable source files in subdirectories, just not the uppermost sponge directory.
```
package github.com/coralproject/sponge: no buildable Go source files in [directory]
```

#### Cloning manually
You can also clone the code manually.

```
mkdir $GOPATH/src/github.com/coralproject/sponge
cd $GOPATH/src/github.com/coralproject/sponge

git clone git@github.com:CoralProject/sponge.git
```

### Set up your strategy.json file

You can read about [strategy files in depth here](strategy).

The strategy.json file tells Sponge how to do the transformation between the publisher's existing data and the Coral data schema. It also tells us how to connect to the external publisher's source data. We currently support the following sources: PostgreSQL, MySQL, MongoDB, and REST APIs.

We have example strategy.json files for each of those source types. You can see those example strategy.json files in the `examples` folder: `$GOPATH/src/github.com/coralproject/sponge/examples`

To copy one of the example strategy.json files to another folder, where you can then customize it:
```
cp $GOPATH/src/github.com/coralproject/sponge/examples/strategy.json.example $GOPATH/src/github.com/coralproject/sponge/strategy/strategy.json
```

### Set your environment variables

Setting your environment variables tells Sponge which strategy file you want to use, and the URL for the [Pillar](https://github.com/coralproject/pillar) instance you are pushing data to.

Make your own copy of the `config/dev.cfg` file (you can edit this configuration file with your own values, and then ensure that you don't commit it back to the repository). Call your config file whatever you like; we'll call it "custom" in this example.
```
cd $GOPATH/src/github.com/coralproject/sponge
cp config/dev.cfg config/custom.cfg
```

Now edit the values in your custom.cfg file:
```
export STRATEGY_CONF=/path/to/my/strategy.json
export PILLAR_URL=http://localhost:8080
```

* The `STRATEGY_CONF` variable specifies the path to your strategy.json file.
* The `PILLAR_URL` variable specifies the URL where your Pillar instance is running. If you installed Pillar locally from source, this will probably be `http://localhost:8080`.

Once you've edited and saved your custom.cfg file, source it:

```
source $GOPATH/src/github.com/coralproject/sponge/config/custom.cfg
```

### Run Sponge

You can either run Sponge using Go, or via a CLI tool.

#### Running Sponge using go run
```
cd $GOPATH/src/github.com/coralproject/sponge/cmd/sponge
go run main.go
```

#### Running Sponge using the CLI tool

First build the CLI tool:
```
cd $GOPATH/src/github.com/coralproject/cmd/cmd/sponge
go build
```

Then run the CLI tool
```
./sponge -h
```

## Install as a Docker container

### Building image

To build the docker image run this command:

```
docker build -t "sponge:latest" -f Dockerfile ./
```

### Edit env.list

Setting your environment variables tells Sponge which strategy file you want to use, and the URL for the [Pillar](https://github.com/coralproject/pillar) instance you are pushing data to.

```
PILLAR_URL=http://192.168.99.100:8080
STRATEGY_CONF=/strategy/strategy_psql.json

# DATABASE
# (optional if you want to overwrite strategy file values)
DB_database= ""
DB_username= ""
DB_password= ""
DB_host= ""
DB_port= ""

# WEB SERVICE
# (optional if you want to overwrite strategy file values)
WS_appkey= ""
WS_endpoint= ""
WS_records= ""
WS_pagination= ""
WS_useragent= ""
WS_attributes= ""
```

* The `STRATEGY_CONF` variable specifies the path to your strategy.json file.
* The `PILLAR_URL` variable specifies the URL where your Pillar instance is running. If you installed Pillar as a Docker container, this will probably be `http://192.168.99.100:8080`.

### Running the container

It will start importing everything setup in the [strategy file](strategy).

```docker run --env-file env.list -d sponge```
