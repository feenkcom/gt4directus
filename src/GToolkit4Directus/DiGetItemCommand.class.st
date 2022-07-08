Class {
	#name : #DiGetItemCommand,
	#superclass : #DiItemsCommand,
	#instVars : [
		'itemId'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiGetItemCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self itemId isString and: [ self itemId isNotEmpty ] ]
		description: [ 'Item ID must be string representing a natural number (integer)' ].
	
]

{ #category : #accessing }
DiGetItemCommand >> endPoint [
	<return: #Array>
	^ super endPoint, { self collectionName. self itemId }
]

{ #category : #execution }
DiGetItemCommand >> execute [
	self assertReadyForExecution.
	self response: self getResponse.
	
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
