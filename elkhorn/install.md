# Install from source

Before you install from source, you'll have to have [Node.js](https://nodejs.org/en/download/) installed.

* You must be running version 5.0.0 or higher of node. You can check your current version of node with the command `node --version`
* We recommend using [nvm](https://www.npmjs.com/package/nvm) to manage your node installations.

## Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory.
```
cd elkhorn
```

## Build and run Elkhorn

Build Elkhorn:
```
npm install
```

Run Elkhorn:
```
npm run server
```

Elkhorn will now be running on port 4444.

# Install as a Docker container

## Clone the Elkhorn repository

Clone the Elkhorn repository:

```
git clone https://github.com/coralproject/elkhorn.git
```

Then cd into the Elkhorn directory.
```
cd elkhorn
```

## Build and run Elkhorn

Build Elkhorn:
```
docker build -t elkhorn .
```

Run Elkhorn:
```
docker run  --name elkhorn -d -p 4444:4444 elkhorn
```

Elkhorn will now be running on port 4444.
