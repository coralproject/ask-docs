# User Case : Washington Post

Washington Post uses Echo as a comment's platform. The import of data has been done through their web services. This is the translation of their data into the Coral schema.

## Users

* Actor.id
* Actor.title
* Actor.status
* Actor.avatar
* Actor.markers => User.tags
* Actor.roles   => User.roles

## Assets

Object.source  => Comment.Metadata.source
Object.markers => Comment.Tags
Object.tags    => Comment.Metadata.Markers

## Comments
