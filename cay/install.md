# Install from source

## Before you begin

Before you begin, be sure you have the follow installed and running:

* [Xenia](../../xenia/install)
* [Pillar](../../pillar/install)
* [Node.js](https://nodejs.org/en/download/)
    * You must be running version 5.0.0 or higher of node. You can check your current version of node with the command `node --version`
    * We recommend using [nvm](https://www.npmjs.com/package/nvm) to manage your node installations.

## Get the source

Clone the Cay repository onto your machine:
```
git clone https://github.com/coralproject/cay.git
```
cd into the Cay directory:
```
cd cay
```
Do an npm install to install the node code:
```
npm install
```

## Set up configuration file

The folder called `public` has a sample configuration file, called `config.sample.json`. Copy this file to a new file called `config.json`, that you will edit:
```
cp public/config.sample.json public/config.json
```

Now edit the config.json file.
```{
  "xeniaHost": "",
  "pillarHost": "",
  "elkhornHost": "http://localhost:4444",
  "environment": "development",
  "brand": "",
  "googleAnalyticsId": "UA-12345678-9",
  "requireLogin": false,
  "basicAuthorization": "",
  "features": {
    "ask": false
  }
}
```

* For `xeniaHost`, `pillarHost`, and `elkhornHost`, enter the URLs for each service.
* Under `features`, for the time being, only "ask" will have a value of "true". Later, we will be adding fields for our additional two products, Trust and Talk. By setting the value to "true", you are turning on the features that can be seen in Cay.

## Run the app

You can now start Cay by running npm start:
```
npm start
```
You can now visit Cay by visiting the URL [http://localhost:3000](http://localhost:3000).
