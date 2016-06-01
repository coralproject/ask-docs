# Fiddler

import "github.com/coralproject/sponge/pkg/fiddler"

Package fiddler does the translation from external database schema into the Coral's one, through a translation's file called Strategy.


## Variables

	var (
		strategy   str.Strategy
	)

Holds the translation to apply to the data.

	var (
		dateLayout string
	)

Date Layout as specified in the translation's file.

	var (
		uuid       string
	)

Universally Unique Identifier used for the logs.


## func GetID

	``func GetID(modelName string) string``

	Returns the field that is the identifier for that model

## func GetCollections

	``func GetCollections() []string``

	Returns the names of all the collections in the strategy file.


## func TransformRow

	``func TransformRow(row map[string]interface{}, coralName string) (interface{}, []map[string]interface{}, error)``

 	Applies the coral schema to a row of data from the external source.

## Examples

	`To Do`