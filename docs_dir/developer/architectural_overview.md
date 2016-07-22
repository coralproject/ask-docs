# Architectural overview

Over the course of the project, we are building an ecosystem of products, tools and practices. These elements will work together and/or integrate with existing community tools.

## Coral Ecosystem

The Coral Ecosystem consists of five apps working together with the Coral MongoDB database. You can see how these apps communicate with each other in the diagram below.

* [Cay](../cay) is the front end application for Coral.
* [Elkhorn](../elkhorn) is the embeddable form builder. Cay sends a form specification in JSON format to Elkhorn, and Elkhorn sends back a rendered reader-facing form.
* [Pillar](../pillar) is the primary service that interacts with the Coral database. It works with Sponge to import external data, and performs CRUD (Create, Read, Update, Delete) operations on the Coral database.
* [Sponge](../sponge) is the data import service that extracts data from an external data source, and passes that data on to Pillar.
* [Xenia](../xenia) is a service layer that performs aggregated pipelines queries on the data in the Coral database.

![coral-architecture](/images/coral-architecture.svg)


## Ask

[Ask](../user/ask) is a product that enables editors to create embeddable calls for contributions, including text, photo, video, audio.

<img src="/images/ask-architecture.svg">

## Trust

[Trust](../user/trust) is a product that enables newsroom users to identify different kinds of end users in order to take actions (for instance, "I want to block these trolls on this author," or "I want to highlight the best commenters on this subject"). It allows newsrooms to make manual or automated lists of users via a series of filters.

<img src="/images/trust-architecture.svg">

## Talk

Talk is still in development.
