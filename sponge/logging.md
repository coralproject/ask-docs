## About LOGGING

We are using (Ardanlabs Log's package)[https://github.com/ardanlabs/kit/tree/master/log] for all the tools we are developing in GO.

#### Spec:

###### Logging levels:

    * Dev: to be outputted in development environment only
    * User (prod): to be outputted in dev and production environments

###### All logs should contain:

    * context uuid to identify a particular execution (aka, run of Sponge or a Request/Response execution from a web server.)
    * the name of the function that is executing
    * a readable message including relevant data

Logs should write to stdout so they can be flexibly directed.