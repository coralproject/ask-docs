# FAQ

## Background

### What is the Coral Project?
The Coral Project is a collaborative effort to improve community on news sites through open-source software. You can read more about it on [our website](https://www.coralproject.net).

### What do you do?
We’re creating open-source software to facilitate the importing, storage, moderation, and display of contributions to news websites. That includes images, video, and text such as comments, annotations, and blog posts.

### Who’s behind the project?
It’s led by a team from Mozilla, The New York Times, and The Washington Post. It’s funded by a two-year grant by the John S. and James L. Knight Foundation. The ideas guiding it are coming from readers, contributors, journalists, community managers, researchers, and developers. [email link]And you, if the mood strikes you[/email link].

### This is that comment system that Mozilla is building for the Times and the Post, right?
Not exactly. All three organizations are working together, and we’re focusing on many kinds of text contributions, as well as images and video. We’ll be creating software that publishers — or anyone, really — can use to better connect with their community. And that contributors can use to better connect with publishers.

### What about digital community do you want to improve?
We want to give publishers the ability to better understand their contributors and control the level of discourse on their sites; empower contributors to manage their identities and data; and provide readers with a more productive discussion about current events.

### So you’ll release your software in two years?
No, we’ll be creating software throughout our grant period and working with contributors, publishers, academics, and readers to iterate on it.

### How long has the project been going?
We had a research phase in early 2014, our grant was approved in June 2014, and we’ve been planning and building our team in the time since.

## Software

### How will the software work?
We’ll be building a flexible core system and a series of plugins, all connected through APIs. Publishers — or anyone, really — can choose to use everything we deploy or pick and choose plugins that fit specific needs.

### I work at a news site that’s smaller than The Post and The Times. Will this work for us?
Our aim is to make the software we create easy to manage for publishers large and small. If you’ve got specific needs you’d like to talk about, please [email link]get in touch with us[/email link].

### Will it work on mobile?
We’re developing for all browsers and devices.

### I’m a regular commenter on news sites. What’s in it for me?
We want to give you tools to own and manage your identity and contributions across websites and analytics that allow you to understand who’s interacting with the content you create.

### How can I keep up with what you’re doing?
Watch this website. We’ll be posting updates regularly once our development begins in earnest.

### I’ve got a few ideas to share with you. How can I get in touch?
[email link]Please email us here[/email link]. We’re eager to hear from you.

## Technical

### Which external data sources are supported?
We currently support mySQL, PostgreSQL, MondoDB, and REST APIs.

### We use Elasticsearch. Can we connect to that?
Not yet. Our currently supported external data sources are mySQL, PostgreSQL, MongoDB, and REST APIs. However, you can write your own driver to connect to Elasticsearch. The drivers are part of the [Sponge](sponge) app, and you can find out more about the driver components [here](sponge/included_packages/#how-to-add-a-new-source).

### How would we get started?
You can learn more about the different installation options on our [developer overview page](developer). The quickest and easiest way to get started is probably the [All-in-One Docker installation](quickstart), but you can read about each available option (and whether it is likely to be the best option for you) on the [developer overview page](developer).

### Do you have dummy data that we can use?
Yes. Our dummy data is thoroughly scrubbed and anonymized comments data from the Washington Post commenting database.

If you install Coral through the [All-in-One Docker installation](quickstart), you should automatically have the dummy data set up for you in your MongoDB.

If you want to manually import sample data (for example, if you've installed Coral from source code), you can read more about how to do that [on the developer setup page](developer/developer_setup/#mongodb).

### How often does the data refresh in the Trust app?
The data in the Trust app refreshes every 24 hours.

### How easy is it to set up the aggregates for the actual pipelines to work?
We have a simple config for the frontend that will basically build a frontend based on that data. We’re investing in making an intuitive filtering ecosystem. Save filters as a user group. Something we’re hoping a lot of people in the newsroom will play with.  

### Will there be useful aggregates out of the box, or do we have to set them up from scratch?
There will be aggregates: most likes, most shares. Interested in working with partners to create aggregates that make sense to them.

On the data side, is everything pre-computed? And what kind of stats/data do you support?  (Guardian)
You’d tell the section how to define a field. Very flexible in using anything as a dimension. Define, example, section as a dimension. Then, you’ll have a drop-down that allows you to choose section as a dimension.

Right now with NYT data, we have section, asset, author. On numeric data types, we’re defining  min and a max. What we do in the precomputing world, we look at totals and dimensional breakdowns. Time is also a dimension. We have a time series function, in which time is also a dimension.

Mean, median, min, max, plus standard deviation to come.

Categorical: Could be one of a number of values. Could limit queries to only rejected comments.

How much load testing have you done on the system so far? What size of DB have you done aggregates on? (Guardian)
10s of millions of comments. It takes a small number of days to go throught he process. Once the data is in there, the frontend is very fast. Hasn’t been much need for load testing the frontend, since this tool isn’t user facing.

### When I build a filter, what is actually happening behind the scenes?
We have a basic schema. All of our major entity questions are as thin as they could be at the main level. Subdocument called metadata, subdocument called stats. Metadata: Whatever you’d log in beyond the user core. Way we have it set up now, for each user, you’d get all of that. Pagination system. Can define the sort and go page by page.

### How does it handle matching users in the first place?
Since we have all of the pieces of data in the object. Aggregation pipelines do the matches. You can stack up any number of matches you’d like. There are also filter operations as well. Set up an arbitrary number of filters as well.

All of the major types also have a sister collection called time series; has each one of those data sets broken down for the lifetime of that comment.

Records for every iteration of every dimension. Quickly adds up to 10s of millions of records, but we’re figuring out the best ways to work them into the user manager. Decaying feature that emphasizes recent stats over older stats.

### What sort of authorization does Coral use?
To allow access to the front end, we are using oAuth.

TODO: Anvil
