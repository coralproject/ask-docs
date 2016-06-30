# Coding style guide

If you are planning to contribute to the Coral code base, you should familiarize yourself with our coding standards. This helps to avoid common errors, improves code readability, and ensures that your PRs have a better chance of getting accepted and merged.

The coding style guide consists of the following sections:

* Core code principles
* Working with repositories (naming, describing, etc.)
* Working with Git (creating good commit messages)
* Go coding style
* Node.js / Javascript coding style
* Additional resources

## Core code principles

These are the four basic principles that guide how we shape and build our code. All Coral Project software is conceived from the ground up to be:

* __Configurable__: We strive to use configuration to deliver as much business logic, data modeling, and other aspects of our systems as _is practical._ Doing so gives us the ability to quickly configure precise UI experiences, data structures, and data science analysis with minimal need for coding, upgrades, server work, etc. Ultimately, we want the community managers who run our software to feel like they are designing their own house. This means trying things to see how they feel, looking at the results, and quickly making changes based on what they learn. We take our inspiration from the ever-changing, adaptable ecosystems of coral reefs.
* __Modular__: Coral products can be used together to form a fully functioning community platform, or be used in pieces to complement existing software. In order to accomplish this, we are building core API features, message passing and import/export strategies in everything we do. We are also refining, documenting, and publishing deployment strategies for each of our products both in isolation as well as together as groups of our products configured to work in concert.
* __Privacy Minded__: There is an implicit act of trust involved in registration for and engagement in an online community. Maintaining that trust is a top priority for us. Privacy for us begins with security concerns, and stretches deep into our product thinking. Whenever information is entered into our systems, we want to make it clear who will be able to see that information and how it will be used. We want to build safe, comfortable places that allow for conversations of varying levels of exposure, without false expectations or nasty surprises.
* __Secure, Stable and Scalable__: Our deployment recommendations, if followed, provide usable and secure environments. Each piece of our software has internal checks to catch any error states and trigger alarms, as well as external restart mechanisms. All of our platforms have proven records for stability and well-known upgrade paths. We will publish auto-scaling deployment workflows where appropriate for large sites with varying loads.

## Working with repositories

### Repository naming

As you may have guessed, each component of Coral is named after a different type of coral. We like to match up some traits of the particular type of coral with the functionality of the component, but that's not always possible.

Choose a variety of coral to name your repo. Make sure that there isn't already a repo named something similar.

### Repository descriptions

The description of a repo tells the public what is contained in the repo itself. If you have multiple repositories for the same project, it's better to describe what is contained in the repo itself instead of describing the project.

Repo descriptions should be clear, concise, and descriptive. Descriptions are listed under each repository title on an organization’s GitHub page. Anyone who scans the GitHub page should be able to determine what a repo does, just by looking at the description.

If your repo is not in active development, it’s helpful to let users know this so they don’t make contributions to a non-active repository. We suggest adding the word DEPRECATED before your repo description.

## Go coding style

For our Go code, we follow all coding guidelines laid out by the Go community, as detailed in their [Effective Go](https://golang.org/doc/effective_go.html) guide. This helps us to maintain a consistent code base. We also use the [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments) as a guide.

Although not all of our code may comply 100% with the [Effective Go](https://golang.org/doc/effective_go.html) guidelines, we're not looking for an overhaul of our code to make everything comply. Rather, all new contributions should comply with the guidelines. The ultimate goal is to make the code base easier for humans to navigate and understand.

### A few specific rules we follow

* All code should be formatted with `gofmt -s`. (Read more about [gofmt here](https://golang.org/cmd/gofmt/).)
* All code should pass the default levels of
   [`golint`](https://github.com/golang/lint).
* Comment the code. Tell us the why, the history and the context.
* Document _all_ declarations and methods, even private ones. Declare expectations, caveats and anything else that may be important. If a type gets exported, having the comments already there will ensure it's ready.
* The length of a variable names should be proportional to its context, and preferably relatively short. In practice, short methods will have short variable names and globals will have longer names.
    * Bad: `noCommaALongVariableNameLikeThisIsNotMoreClearWhenASimpleCommentWouldDo`.
* No underscores in package names. If you need a compound name, step back, and re-examine why you need a compound name. If you still think you need a compound name, lose the underscore.
* No utils or helper packages. If a function is not general enough to warrant its own package, it has not been written generally enough to be a part of a util package. Just leave it unexported and well-documented.
* All tests should run with `go test` and outside tooling should not be required. No, we don't need another unit testing framework. Assertion packages are acceptable if they provide _real_ incremental value.
* Even though we call these "rules" above, they are actually just guidelines. Since you've read all the rules, you now know that.

### Useful tools when developing in Go

* [golint](https://github.com/golang/lint): a linter for Go code.
* [gofmt](https://golang.org/cmd/gofmt/): a command that formats Go programs.
* [goimports](https://godoc.org/golang.org/x/tools/cmd/goimports): a command that updates your Go import lines.
* [vet](https://golang.org/cmd/vet/): a tool that examines Go code and reports suspicious constructs.
* [errcheck](https://github.com/kisielk/errcheck): a tool that checks for unchecked errors in Go programs.

## Node.js / Javascript coding style

We use the [Airbnb React/JSX Style Guide](https://github.com/airbnb/javascript/tree/master/react) when working with Javascript.

## Commenting

Code commenting is crucial to maintaining a readable code base that future developers can understand and build upon. You can find a nice [primer on good commenting practice here](http://www.hongkiat.com/blog/source-code-comment-styling-tips/).

* Provide the why, the history, and context.
    * Why: Why are you writing the code in exactly the way that you are?
    * History: What historical decisions or factors went into writing the code in this way?
    * Context: Are there any other factors we should know about that went into writing or developing this piece of code?
* Document _all_ declarations and methods, even private ones. Declare expectations, caveats and anything else that may be important. If a type gets exported, having the comments already there will ensure it's ready.
* **Keep everything readable:** Remember that the comments will be read by humans. Keep it simple, brief, and clear.
* **Whitespace is important:**
* **Comment while coding:**

## Resources

Some further reading, particularly on the subject of Go:

* [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
* [Best Practices for Production Environments](https://www.youtube.com/watch?v=Y1-RLAl7iOI)
* [12 Factor App](http://12factor.net/)
* [Tools for working with Go Code](https://speakerdeck.com/farslan/tools-for-working-with-go-code)

_Attribution: Go Coding Style adopted from the Docker project._
