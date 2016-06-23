# Sponge Roadmap

This document tracks features that are not yet prioritized into issues and releases.

## API Import

Pull data from Http(s) sources

* Disqus - https://disqus.com/api/docs/
* Wordpress Core - https://codex.wordpress.org/XML-RPC_WordPress_API/Comments
* Lyvewire - http://answers.livefyre.com/developers/api-reference/
* Facebook - https://developers.facebook.com/docs/graph-api/reference/v2.5/comment

## Rate Limit Counter

In order to protect source databases, we want to be able to throttle the number of queries sponge is making.

* Keeps a sliding count of how many requests were made in the past time frame based on the strategy.
* Exposes isOkToQuery() to determine if we are currently at the limit.
* Each request sends a message to this routine each time a request is made.

## Synchronization

An internal mechanism that regularly polls the source and imports any updates.

### Basic polling specification

The main loop that keeps the data up to date.  Gets _slices_ of records based on _updated_at_ timestamps to account for changing records.

For each table or api in the strategy:

* Ensure maximum rate limit is not met
* Determine which slice of data to get next
	* Find the last updated timestamp in the _log collection_ (or the collection itself?)
* Use the strategy to request the slice (either db query or api call)
	* Update the rate limit counter
* For each record returned
	* Check to ensure the document isn't already added
	* If not, add the document and kick off _import actions_
	* If it's there, update the document
	* Update the _log collection_

### Challenges

Data synchronization between complex living systems is a difficult challenge. Approach with caution.
