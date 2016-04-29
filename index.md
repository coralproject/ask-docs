# The Coral Project: build community

The Coral Project is an open source project helping publishers of all sizes to build better communities around their journalism.

We seek to accomplish this by

* creating open source community building software, and
* creating, refining and disseminating practices, tools and studies to improve communities around journalism on the web.

![Coral Logo](/images/coralWordMark-1.5.png)

## Build a Community for your Audience

The Coral Project inspires conversations that lead organizations to discover the particular kinds of community that work for them and provides open source tools to make that community a reality.

The relationship between a reader and a journalistic organization is profound, nuanced, and of great value to both parties. In order to nurture that relationship, it is essential to foster a community that allows the particular tenor of the organization to thrive. Building this community around the very content that inspires it is extremely valuable both in terms of profits and culture. In order to best serve communities of varying shapes and sizes, all coral software is conceived from the ground up to be:

* __Configurable__: We strive to use configuration to deliver as much business logic, data modeling, and other aspects of our systems as _is practical._ Doing so gives us the ability to quickly configure precise UI experiences, data structures, and data science analysis with minimal need for coding, upgrades, server work, etc... Ultimately, we want the community managers who run our software to feel like they are decorating their own house. This means trying things out, seeing how they feel, looking at the data and trying the next thing. We take our inspiration from the ever-changing, adaptable ecosystems of coral reefs.
* __Modular__: Coral products can be used together to form a fully functioning community platform or be used in pieces to complement existing software. In order to accomplish this, we are building core api features, message passing and import/export strategies into everything we do.  In addition, we refining, documenting and publishing deployment strategies for each of our products in isolation as well as groups of our products configured to work in concert.
* __Privacy Minded__: There is an implicit act of trust involved in registration for and engagement in an online community. Maintaining that trust is a top priority for us. Privacy for us begins with security concerns and stretches deep into our product thinking. Whenever information is entered into our systems, we want to make it clear who will be able to see that information and how it will be used. We want to build safe, comfortable places that allow for conversations of varying levels of exposure without incorrect expectations and nasty surprises.
* __Secure, Stable and Scalable__: Our deployment recommendations, if followed, provide usable and secure environments. Each piece of our software has internal checks to catch any error states and trigger alarms as well as external restart mechanisms. All of our platforms have proven records for stability and well known upgrade paths. We will publish auto-scaling deployment workflows where appropriate for large sites with varying loads.

## What's going on and how can I get involved?

We are still actively developing this open presence and we always looking for [contributions](/contributions/index.md). We want to build this project with all of you.

## Under the hood

Coral products are based on the following technologies:

* The [Go](https://golang.org) programming language
* The [MongoDB](https://www.mongodb.org/) database
* [React](https://facebook.github.io/react/) and [Redux](https://github.com/rackt/redux)
* [Webpack](https://webpack.github.io/) and [Babel](https://babeljs.io/)
* [Docker](https://www.docker.com/)


## Technical Documentation

You can use Docker Compose to [quick start](quickstart/index.md) the Coral System or read more about how the whole ecosystem and [each of its pieces work](coral_ecosystem.md).



For more information about us and to see our blog, please visit [our website](https://coralproject.net) and [sign up to our newsletter](http://tinyletter.com/coralproject). We are also on [Twitter](https://twitter.com/coralproject).

_The Coral Project is a collaboration between [The Mozilla Foundation](https://www.mozilla.org/en-US/foundation/), [The New York Times](http://nytimes.com), and [The Washington Post](http://washingtonpost.com), and is funded by a grant from [The John S. and James L. Knight Foundation](http://knightfoundation.org)._
