# API

## Using Pillar End-Points

Here is a generic example of how you might use these end-points. See [model](https://github.com/coralproject/pillar/tree/master/pkg/model) for the structure of data to be passed for various APIs.

~~~
> curl -i -H "Accept: application/json" -XPOST -d '  {
    "name" : "IamSam",
    "avatar" : "https://wpidentity.s3.amazonaws.com/assets/images/avatar-default.png",
    "status" : "New",
    "source" : {
      "id":"original-id-for-iam-sam"
    },
    "tags" : ["top_commentor", "powerball"]
  }
' http://localhost:8080/api/import/user
~~~

Here is a list of end-points

| Model         | Import                   | CRUD            |
|:------------- |:-------------------------|:----------------|
| User          |/api/import/user          |/api/user        |
| Asset         |/api/import/asset         |/api/asset       |
| Action        |/api/import/action        |/api/action      |
| Comment       |/api/import/comment       |/api/comment     |
| Tag           |None                      |/api/tag         |
| Search        |None                      |/api/search      |

