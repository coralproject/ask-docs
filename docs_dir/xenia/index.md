# Xenia

[Xenia](https://github.com/coralproject/xenia) is a configurable service layer that publishes endpoints against [MongoDB aggregation pipeline](https://docs.mongodb.com/manual/core/aggregation-pipeline/) queries.

Aggregation pipelines are chainable, allowing for the output of one endpoint to be fed into the next. Xenia provides a request syntax to allow for this, giving the requesting application an added dimension of flexibility via query control.

Similarly, output documents from multiple pipelines can be bundled together. This is particularly useful in the noSQL/document database paradigm, in which joins are not natively supported.

### Straightforward query creation

Xenia moves the query logic out of the application code. Front end developers, data analysts, and anyone else familiar with the simple, declarative [MongoDB aggregation syntax](https://docs.mongodb.com/manual/reference/aggregation/) can adjust the data requests, and create or update endpoints.
