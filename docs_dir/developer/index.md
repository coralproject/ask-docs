# Introduction

Welcome! This is the place to be if you want to learn more about Coral from the standpoint of a developer or a technical user. Here you can learn about the inner workings of Coral, how to install the products, how to use the APIs, and more.

If you are a developer who is interested in contributing to our code, great! You can read more about contributing in our [Contribute section](../contribute/).

# The Coral Ecosystem

Coral is made up of a number of component apps that work together to power three products (Trust, Ask, and Talk). You can read more about how this ecosystem fits together [here](../coral_ecosystem).

# Installation

There are a few different installation options to choose from. Which one is right for you?

### Install a fully functioning single-server Coral Ecosystem, using Docker.
This is a quick, easy, packaged solution that requires few steps and should get all components up and running quickly. The downside is that this may not scale well, as everything is installed on one server. After a certain number of users (perhaps 50 or so), the server could become overloaded.

You should also have the following resources on your machine before installing:

* Minimum CPU: 2.0 GHz
* Minimum RAM: 4GB
* Minimum disk space required: 4GB

You can find instructions on how to install Coral as a single Docker Compose installation [here](../quickstart/install.md).

**_Probably best for you if:_**

* You want to install Coral to perform a demo.
* You want to get Coral running on your local machine to get a sense of its functionality and capabilities.
* You want to get Coral up and running, and aren't worried about scaling right now.

### Installing each component individually, using Docker.
This will install each component on a separate server, which allows for scaling up in future. It does require some more work to get each component talking and interacting with each other, but will scale better.

If you choose this option, you can visit the installation page for each Coral component, which has installation instructions for Docker and source.

* [Cay installation instructions](../cay/#cay-installation)
* [Elkhorn installation instructions](../elkhorn/#elkhorn-installation)
* [Pillar installation instructions](../pillar/#pillar-installation)
* [Sponge installation instructions](../sponge/#sponge-installation)
* [Xenia installation instructions](../xenia/#xenia-installation)

**_Probably best for you if:_**

* You have multiple servers, and are concerned about scalability.
* You have a sysadmin to help manage installation and maintenance.

### Installing each component individually from source code.

This option will have you install each component individually from source code, which will either be Go (most components) or Node.js.

If you choose this option, you can visit the installation page for each Coral component, which has installation instructions for Docker and source.

* [Cay installation instructions](../cay/#cay-installation)
* [Elkhorn installation instructions](../elkhorn/#elkhorn-installation)
* [Pillar installation instructions](../pillar/#pillar-installation)
* [Sponge installation instructions](../sponge/#sponge-installation)
* [Xenia installation instructions](../xenia/#xenia-installation)

**_Probably best for you if:_**

* You are a developer that wants to work on Coral and potentially [contribute to our code base](../contribute/development/writing_code.md) (thank you!).
