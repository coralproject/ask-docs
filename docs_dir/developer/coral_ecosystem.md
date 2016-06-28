# Coral Ecosystem

Over the course of the project, we are building an ecosystem of products, tools and practices. These elements will work together and/or integrate with existing community tools.

![Architecture](/images/coral-ecosystem-current.png)

## Trust

Trust is our [first product](https://coralproject.net/first-product/). It enables newsroom users to identify different kinds of end users in order to take actions (eg. I want to block these trolls on this author; I want to highlight the best commenters on this subject.) It allows newsrooms to make manual or automated lists of users via a series of filters. 

Trust introduces a number of technological components:

![Trust Architecture](/images/trust-architecture.png)

## Repositories

### Sponge

[Sponge](https://github.com/coralproject/sponge) is a command line tool to import comments, authors, assets and other entities into the Coral system. It is designed to read data from a foreign _source_, translate the schema into Coral conventions, and POST entities to [our service layer](https://github.com/coralproject/pillar) for inserting.

Right now the foreign source could be any of the following:

  * MySQL
  * PostgreSQL
  * MongoDB
  * Web Service

### Pillar

[Pillar](https://github.com/coralproject/pillar) is a REST based web-service module written in golang. It provides the following services:

  * Imports external data into the Coral data model
  * Allows CRUD operation on Coral data model
  * Provides simple queries on Coral data model

### Xenia

[Xenia](https://github.com/coralproject/xenia) is a configurable service layer that publishes endpoints against [mongo aggregation pipeline queries](https://docs.mongodb.org/manual/core/aggregation-introduction/).


#### Xenia Driver

[This](https://github.com/coralproject/xenia-driver-js) is a javascript driver for Xenia. It performs queris to xenia from the browser and node.js.

### Cay

[Cay](https://github.com/coralproject/cay) is the front-end tool for the Coral Project.

### Elkhorn

[Elkhorn](https://github.com/coralproject/elkhorn) is the form composer.
