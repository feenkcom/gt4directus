Class {
	#name : #DiGetItemCommand,
	#superclass : #DiItemsCommand,
	#instVars : [
		'collectionName',
		'itemId'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiGetItemCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self collectionName isString and: [ self collectionName isNotEmpty ] ]
		description: [ 'Collection name must be a non-empty string' ].
	self 
		assert: [ self itemId isString and: [ self itemId isNotEmpty ] ]
		description: [ 'Item ID must be string representing a natural number (integer)' ].
	
]

{ #category : #accessing }
DiGetItemCommand >> collectionName [
	<return: #String>
	^ collectionName
]

{ #category : #accessing }
DiGetItemCommand >> collectionName: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ]
		description: [ 'Collection name must be a non-empty string' ].
	collectionName := aString
]

{ #category : #execution }
DiGetItemCommand >> execute [
	self assertReadyForExecution.
	response := self getResponse: self endPoint.
	
]

{ #category : #accessing }
DiGetItemCommand >> itemId [
	<return: #String>
	^ itemId
]

{ #category : #accessing }
DiGetItemCommand >> itemId: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Item ID must be a natural number (integer)' ].
	itemId := anInteger asString
]
