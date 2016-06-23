# Xenia Driver API

### XeniaDriver(baseURL, auth [, queryParams] [, reqParams])

Creates a new `XeniaDriver` instance

- `baseURL` (String) - Xenia server base url
- `auth` (String | Object) - basic authentication credentials. If it's a string it should be the Basic authentication value for the Authorization header
- `[auth.username]` (String) - Auth username
- `[auth.password]` (String) - Auth password
- `[queryParams]` (Object) - It can hold a Xenia raw query to perform before the rest of the queries
- `[reqParams]` (Object) - Add your own parameters to the request

```js
const xenia = XeniaDriver('https://my-xenia-url.com', 'Basic kewlrgm;we4p3jtqpwfawmeklfdmdsadlm')
```

### addQuery(queryData)

Initialize a query. When the xenia constructor runs it will call this function for you. Use it for adding more than one query in the same request.

- `[queryData]` (Object) - Provide the configuration for the new query

```js
xenia()
  .limit(20).skip(10)
  .addQuery().match({'name': 'John Doe'})
  .exec().then(data => console.log(data))
```

### collection(name)

Set the current query collection

- `name` (String) - collection name

```js
xenia()
  .collection('users')
  .exclude(['_id'])
  .exec().then(data => console.log(data))
```

### exec(queryName, params)

Executes the request

- `[name]` (string) - Executes a saved query by name
- `[params]` (Object) - Custom request parameters

```js
xenia().exec('my_saved_query').then(data => console.log(data))

// Or

xenia().limit(20).skip(10)
  .exec().then(data => console.log(data))
  .catch(err => console.log(err))
```

### getQueries()

Get a list of available queries

```js
xenia().getQueries().then(data => console.log(data))
```

### getQuery(name)

Get a specific query document

- `name` (String) - query name

```js
xenia().getQuery('my_query').then(data => console.log(data))
```

### saveQuery(name)

Save a new query

- `[name]` (String) - query name

```js
xenia()
  .collection('users')
  .limit(5).include(['name', 'avatar'])
  .saveQuery('first users').then(data => console.log(data))
```

### deleteQuery(name)

Delete a query

- `[name]` (String) - query name

```js
xenia()
  .deleteQuery('first users')
  .then(data => console.log(data))
```

### limit(n)

Limit the amount of retrieved documents

- `[n]` (Number) - number of docs to retrieve, default: 20

```js
xenia().limit(15)
```

### skip(n)

Skip the first n documents

- `[n]` (Number) - number of skipped docs, default: 0

```js
xenia().skip(12)
```

### sample(n)

Return a document sample from the collection

- `[n]` (Number) - number of sample docs, default: 20

```js
xenia().sample(50)
```

### project(fields)

Include and exclude fields from the result using the $project aggregation pipeline operator. You'll find out that `Xenia#include` and `Xenia#exclude` can be easier to use for most scenarios.

- `fields` (Object) - Aggregation fields object

```js
xenia()
  .project({'name': true, '_id': false, 'comments': { 'country': true}})
```

### include(fieldNames)

Whitelist retrieved fields

- `fieldNames` (Array) - fields you want to retrieve

```js
xenia().include(['name', 'avatar'])
```

### exclude(fieldNames)

Blacklist retrieved fields

- `fieldNames` (Array) - fields you don't want to retrieve

```js
xenia().exclude(['age', 'gender'])
```

### match(query)

Performs a match command on the aggregation pipeline

- `query` (Object) - Match parameters

```js
xenia().match({ 'name': 'John', 'status': { '$in' : ['user', 'admin']} })
```

### redact(query)

Performs a redact command on the aggregation pipeline

- `query` (Object) - Redact parameters

```js
xenia().redact({ $cond: {
  if: { $gt: [ { $size: { $setIntersection: [ "$tags", userAccess ] } }, 0 ] },
  then: "$$DESCEND",
  else: "$$PRUNE"
}})
```

### unwind(path, includeArrayIndex, preserveNullAndEmptyArrays)

Performs a unwind command on the aggregation pipeline - Deconstructs an array field from the input documents to output a document for each element

- `path` (Object | String) - Field path
- `[includeArrayIndex]` (String) - arrayIndex name
- `[preserveNullAndEmptyArrays]` (Boolean) - preserve null and empty arrays, default false

```js
xenia().unwind('$comments')
```

### group(groups)

Group documents

- `groups` (Object) - group object

```js
xenia().group({ _id : { month: { $month: '$date' } })
```

### sort(order)

Sort documents by fields

- `order` (Object|Array) - how to sort the data

```js
xenia().sort(['name', 1])

// Or

xenia.sort({'name': 1, 'statistics.comments.count': -1})
```

### join(collection, field, matchingField, name)

Creates a new query joining the actual one using the save method from Xenia

- `collection` (String) - The collection you want to join
- `[field]` (String) - The matching field in the collection you want to join, default: \_id
- `[matchingField]` (String) - The field to match in your actual collection, default: same as field parameter
- `[name]` (String) - The field name on the results, default: list

```js
xenia().collection('comments')
.include(['body', 'asset_id']).limit(5)

.join('assets', '_id', 'asset_id', 'asset')

.include(['section']).exec()
```


## Development

    $ npm start

## Test

    $ npm test
