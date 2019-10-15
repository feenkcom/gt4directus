Class {
	#name : #DiItemsCommand,
	#superclass : #DiResponseCommand,
	#instVars : [
		'collectionName'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #accessing }
DiItemsCommand class >> endPoint [
	^ #( 'items' )
]

{ #category : #testing }
DiItemsCommand class >> isAbstract [
	^ self name = #DiItemsCommand 
]

{ #category : #asserting }
DiItemsCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self collectionName isString and: [ self collectionName isNotEmpty ] ]
		description: [ 'Collection name must be a non-empty string' ].

]

{ #category : #accessing }
DiItemsCommand >> collectionName [
	<return: #String>
	^ collectionName
]

{ #category : #accessing }
DiItemsCommand >> collectionName: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ]
		description: [ 'Collection name must be a non-empty string' ].
	collectionName := aString
]
