# Coding Style Guide

## Core code principles

In order to serve communities of varying shapes and sizes, all Coral Project software is conceived from the ground up to be:

* __Configurable__: We strive to use configuration to deliver as much business logic, data modeling, and other aspects of our systems as _is practical._ Doing so gives us the ability to quickly configure precise UI experiences, data structures, and data science analysis with minimal need for coding, upgrades, server work, etc. Ultimately, we want the community managers who run our software to feel like they are designing their own house. This means trying things to see how they feel, looking at the results, and quickly making changes based on what they learn. We take our inspiration from the ever-changing, adaptable ecosystems of coral reefs.
* __Modular__: Coral products can be used together to form a fully functioning community platform, or be used in pieces to complement existing software. In order to accomplish this, we are building core API features, message passing and import/export strategies in everything we do. We are also refining, documenting, and publishing deployment strategies for each of our products both in isolation as well as together as groups of our products configured to work in concert.
* __Privacy Minded__: There is an implicit act of trust involved in registration for and engagement in an online community. Maintaining that trust is a top priority for us. Privacy for us begins with security concerns, and stretches deep into our product thinking. Whenever information is entered into our systems, we want to make it clear who will be able to see that information and how it will be used. We want to build safe, comfortable places that allow for conversations of varying levels of exposure, without false expectations or nasty surprises.
* __Secure, Stable and Scalable__: Our deployment recommendations, if followed, provide usable and secure environments. Each piece of our software has internal checks to catch any error states and trigger alarms, as well as external restart mechanisms. All of our platforms have proven records for stability and well-known upgrade paths. We will publish auto-scaling deployment workflows where appropriate for large sites with varying loads.

# Go Coding Style

Unless explicitly stated, we follow all coding guidelines from the Go
community. While some of these standards may seem arbitrary, they somehow seem
to result in a solid, consistent codebase.

It is possible that the code base does not currently comply with these
guidelines. We are not looking for a massive PR that fixes this, since that
goes against the spirit of the guidelines. All new contributions should make a
best effort to clean up and make the code base better than they left it.
Obviously, apply your best judgement. Remember, the goal here is to make the
code base easier for humans to navigate and understand. Always keep that in
mind when nudging others to comply.

The rules:

1. All code should be formatted with `gofmt -s`.
2. All code should pass the default levels of
   [`golint`](https://github.com/golang/lint).
3. All code should follow the guidelines covered in [Effective
   Go](http://golang.org/doc/effective_go.html) and [Go Code Review
   Comments](https://github.com/golang/go/wiki/CodeReviewComments).
4. Comment the code. Tell us the why, the history and the context.
5. Document _all_ declarations and methods, even private ones. Declare
   expectations, caveats and anything else that may be important. If a type
   gets exported, having the comments already there will ensure it's ready.
6. Variable name length should be proportional to it's context and no longer.
   `noCommaALongVariableNameLikeThisIsNotMoreClearWhenASimpleCommentWouldDo`.
   In practice, short methods will have short variable names and globals will
   have longer names.
7. No underscores in package names. If you need a compound name, step back,
   and re-examine why you need a compound name. If you still think you need a
   compound name, lose the underscore.
8. No utils or helpers packages. If a function is not general enough to
   warrant it's own package, it has not been written generally enough to be a
   part of a util package. Just leave it unexported and well-documented.
9. All tests should run with `go test` and outside tooling should not be
   required. No, we don't need another unit testing framework. Assertion
   packages are acceptable if they provide _real_ incremental value.
10. Even though we call these "rules" above, they are actually just
    guidelines. Since you've read all the rules, you now know that.

If you are having trouble getting into the mood of idiomatic Go, we recommend
reading through [Effective Go](http://golang.org/doc/effective_go.html). The
[Go Blog](http://blog.golang.org/) is also a great resource. Drinking the
kool-aid is a lot easier than going thirsty.

_Attribution: Go Coding Style adopted from the Docker project._

## Useful Tools when developing

* golint
* gofmt
* goimports
* go vet
* errcheck

## Resources

* [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
* [Best Practices for Production Environments](https://www.youtube.com/watch?v=Y1-RLAl7iOI)
* [12 Factor App](http://12factor.net/)
* [Tools for working with Go Code](https://speakerdeck.com/farslan/tools-for-working-with-go-code)

# Javascript conventions

We are currently working under the [Airbnb js react conventions](https://github.com/airbnb/javascript/tree/master/react).
