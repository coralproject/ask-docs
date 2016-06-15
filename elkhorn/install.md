# Elkhorn Installation

## Install from source

### Before you begin

Before you begin, be sure you have the following installed and running:

* [Pillar](../../pillar/install)

In addition, you must have Node.js installed:

* [Node.js](https://nodejs.org/en/download/)
    * You must be running version 5.0.0 or higher of node. You can check your current version of node with the command `node --version`
    * We recommend using [nvm](https://www.npmjs.com/package/nvm) to manage your node installations.

### Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory.
```
cd elkhorn
```

Build Elkhorn.
```
npm install
```

### Set up configuration file

The Elkhorn directory has a configuration file, called `config.sample.json`. Copy this file to a new file called `config.json`, that you will edit:
```
cp config.sample.json config.json
```

Now edit the config.json file.
```
{
  "pillarHost": "",
  "basicAuthorization": "Basic 123123123123213",
  "s3": {
    "bucket": "",
    "region": "",
    "accessKeyId": "",
    "secretAccessKey": ""
  }
}
```

For `pillarHost`, enter the URL where the service is running. If you installed [locally from source](../pillar/install), `pillarHost` should be `http://localhost:8080`.

### Run the app

You can now start Elkhorn by running npm start:
```
npm start
```
Elkhorn will now be running on port 4444. You can now visit Elkhorn by visiting the URL [http://localhost:4444](http://localhost:4444).


## Install as a Docker container

### Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory.
```
cd elkhorn
```

### Build and run Elkhorn

Build Elkhorn:
```
docker build -t elkhorn .
```

Run Elkhorn:
```
docker run  --name elkhorn -d -p 4444:4444 elkhorn
```

Elkhorn will now be running on port 4444.
