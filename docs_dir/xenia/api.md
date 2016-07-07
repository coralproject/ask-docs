
## API calls

If you set the authorization header properly in your browser (TODO) you can run the following endpoints.

1) Get a list of configured queries:

```
GET
http://localhost:4000/1.0/query

output:

["basic","basic_var","top_commenters_by_count"]
```

2) Get the query set document for the `basic` query set:

```
GET
http://localhost:4000/1.0/query/basic

output:

{
   "name":"QTEST_basic",
   "desc":"",
   "enabled":true,
   "params":[],
   "queries":[
      {
         "name":"Basic",
         "type":"pipeline",
         "collection":"test_xenia_data",
         "return":true,
         "commands":[
            {"$match": {"station_id" : "42021"}},
            {"$project": {"_id": 0, "name": 1}}
         ]
      }
   ]
}

```

3) Execute the query for the `basic` query set:

```
GET
http://localhost:4000/1.0/exec/basic

set:

{
   "name":"basic",
   "desc":"",
   "enabled":true,
   "params":[],
   "queries":[
      {
         "name":"Basic",
         "type":"pipeline",
         "collection":"test_xenia_data",
         "return":true,
         "commands":[
            {"$match": {"station_id" : "42021"}},
            {"$project": {"_id": 0, "name": 1}}
         ]
      }
   ]
}

output:

{
  "results":[
    {
      "Name":"basic",
      "Docs":[
        {
          "name":"C14 - Pasco County Buoy, FL"
        }
      ]
    }
  ],
  "error":false
}
```

4) Execute the query for the `basic_var` query set with variables:

```
GET
http://localhost:4000/1.0/exec/basic_var?station_id=42021

set:

{
   "name":"basic_var",
   "desc":"",
   "enabled":true,
   "params":[],
   "queries":[
      {
         "name":"BasicVar",
         "type":"pipeline",
         "collection":"test_xenia_data",
         "return":true,
         "commands":[
            {"$match": {"station_id" : "#string:station_id"}},
            {"$project": {"_id": 0, "name": 1}}
         ]
      }
   ]
}

output:

{
  "results":[
    {
      "Name":"basic_var",
      "Docs":[
        {
          "name":"C14 - Pasco County Buoy, FL"
        }
      ]
    }
  ],
  "error":false
}
```

5) You can execute a dynamic query set:

```
POST
http://localhost:4000/1.0/exec

Post Data:
{
   "name":"basic",
   "desc":"",
   "enabled":true,
   "params":[],
   "queries":[
      {
         "name":"Basic",
         "type":"pipeline",
         "collection":"test_xenia_data",
         "return":true,
         "commands":[
            {"$match": {"station_id" : "42021"}},
            {"$project": {"_id": 0, "name": 1}}
         ]
      }
   ]
}
```

## Query management

Using the Xenia command line tool you can manage query sets.

```
cd $GOPATH/src/github.com/coralproject/xenia/cmd/xenia
```

1) Get a list of saved queries:

```
./xenia query list

output:

basic
basic_var
top_commenters_by_count
```

3) Look at the details of a query:

```
./xenia query get -n basic

output:

{
   "name":"basic",
   "desc":"",
   "enabled":true,
   "params":[],
   "queries":[
      {
         "name":"Basic",
         "type":"pipeline",
         "collection":"test_xenia_data",
         "return":true,
         "commands":[
            {"$match": {"station_id" : "42021"}},
            {"$project": {"_id": 0, "name": 1}}
         ]
      }
   ]
}
```

4) Execute a query:

```
./xenia query exec -n basic

output:

{
  "results":[
    {
      "Name":"basic",
      "Docs":[
        {
          "name":"C14 - Pasco County Buoy, FL"
        }
      ]
    }
  ],
  "error":false
}
```

5) Add or update a query for use:

```
./xenia query upsert -p ./scrquery/basic_var.json

output:

Upserting Query : Path[./scrquery/basic_var.json]
```

By convention, we store core query scripts in the [/xenia/cmd/xenia/scrquery](https://github.com/CoralProject/xenia/tree/master/cmd/xenia/scrquery) folder.  As we develop Coral features, store the JSON files there so other developers can use them (eventually, groups of query sets will be refactored to another location, but that's the right folder for the time being).

```
cd $GOPATH/src/github.com/coralproject/xenia/cmd/xenia/scrquery
ls
```

#### Direct Mongo access (optional)

You can look in the db at existing queries:

```
mongo [flags to connect to your server]
use coral (or your databasename)
db.query_sets.find()
```

## Writing Sets

"Writing a set" is essentially about creating a MongoDB aggregation pipeline. Xenia has built on top of this by providing extended functionality to make MongoDB more powerful.

Here is a multi query set with variable substitution and date processing:

```
GET
http://localhost:4000/1.0/exec/basic?station_id=42021

{
   "name":"basic",
   "desc":"Shows a basic multi result query.",
   "enabled":true,
   "queries":[
      {
         "name":"Basic",
         "type":"pipeline",
         "collection":"test_bill",
         "return":true,
         "scripts":[
            {"$match": {"station_id" : "#station_id#"}},
            {"$project": {"_id": 0, "name": 1}}
         ]
      },
      {
         "name":"Time",
         "type":"pipeline",
         "collection":"test_bill",
         "return":true,
         "scripts":[
            {"$match": {"condition.date" : {"$gt": "#date:2013-01-01T00:00:00.000Z"}}},
            {"$project": {"_id": 0, "name": 1}},
            {"$limit": 2}
         ]
      }
   ]
}
```

Here is the list of commands that exist for variable substitution.

```
{"field": "#cmd:variable"}

// Basic commands.
Before: {"field": "#number:variable_name"}      After: {"field": 1234}
Before: {"field": "#string:variable_name"}      After: {"field": "value"}
Before: {"field": "#date:variable_name"}        After: {"field": time.Time}
Before: {"field": "#objid:variable_name"}       After: {"field": mgo.ObjectId}
Before: {"field": "#regex:/pattern/{options}"}  After: {"field": bson.RegEx}

// data command can index into saved results.
Before: {"field" : {"$in": "#data.*:list.station_id"}}}   After: [{"station_id":"42021"}]
Before: {"field": "#data.0:doc.station_id"}               After: {"field": "23453"}

// time command manipulates the current time.
Before: {"field": #time:0}                 After: {"field": time.Time(Current Time)}
Before: {"field": #time:-3600}             After: {"field": time.Time(3600 seconds in the past)}
Before: {"field": #time:3m}                After: {"field": time.Time(3 minutes in the future)}

Possible duration types. Default is seconds if not provided.
"ns": Nanosecond
"us": Microsecond
"ms": Millisecond
"s" : Second
"m" : Minute
"h" : Hour
```

You can save the result of one query for later use by the next.

```
GET
http://localhost:4000/1.0/exec/basic_save

{
   "name":"basic_save",
   "desc":"",
   "enabled":true,
   "params":[],
   "queries":[
      {
         "name":"get_id_list",
         "desc": "Get the list of id's",
         "type":"pipeline",
         "collection":"test_xenia_data",
         "return":false,
         "commands":[
            {"$project": {"_id": 0, "station_id": 1}},
            {"$limit": 5}
            {"$save": {"$map": "list"}}
         ]
      },
      {
         "name":"retrieve_stations",
         "desc": "Retrieve the list of stations",
         "type":"pipeline",
         "collection":"test_xenia_data",
         "return":true,
         "commands":[
            {"$match": {"station_id" : {"$in": "#data.*:list.station_id"}}},
            {"$project": {"_id": 0, "name": 1}},
         ]
      }
   ]
}
```

The `$save` command is an Xenia extension and currently only `$map` is supported.

```
{"$save": {"$map": "list"}}
```

The result will be saved in a map under the name `list`.

The second query is using the `#data` command. The data command has two options. Use can use `#data.*` or `#data.Idx`.

Use the `*` operator when you need an array. In this example we need to support an `$in` command:

```
{
   "name":"retrieve_stations",
   "desc": "Retrieve the list of stations",
   "type":"pipeline",
   "collection":"test_xenia_data",
   "return":true,
   "commands":[
      {"$match": {"station_id" : {"$in": "#data.*:list.station_id"}}},
      {"$project": {"_id": 0, "name": 1}},
   ]
}

When you need an array to be substituted.
Before: {"field" : {"$in": "#data.*:list.station_id"}}}
After : {"field" : {"$in": ["42021"]}}
    dataOp : "*"
    lookup : "list.station_id"
    results: {"list": [{"station_id":"42021"}]}
```

Use the index operator when you need a single value. Specify which document in the array of documents you want to select:

```

{
   "name":"retrieve_stations",
   "desc": "Retrieve the list of stations",
   "type":"pipeline",
   "collection":"test_xenia_data",
   "return":true,
   "commands":[
      {"$match": {"station_id" : "#data.0:list.station_id"}},
      {"$project": {"_id": 0, "name": 1}},
   ]
}

When you need a single value to be substituted, select an index.
Before: {"field" : "#data.0:list.station_id"}
After : {"field" : "42021"}
    dataOp : 0
    lookup : "list.station_id"
    results: {"list": [{"station_id":"42021"}, {"station_id":"23567"}]}
```

You can also replace field names in the query commands.

```
Variables
{
  "cond": "condition",
  "dt": "date"
}

Query Set
{
   "name":"basic",
   "desc":"Shows field substitution.",
   "enabled":true,
   "queries":[
      {
         "name":"Time",
         "type":"pipeline",
         "collection":"test_bill",
         "return":true,
         "scripts":[
            {"$match": {"{cond}.{dt}" : {"$gt": "#date:2013-01-01T00:00:00.000Z"}}},
            {"$project": {"_id": 0, "name": 1}},
            {"$limit": 2}
         ]
      }
   ]
}
```
