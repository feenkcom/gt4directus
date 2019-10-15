Class {
	#name : #DiCreateItemsCommand,
	#superclass : #DiItemsCommand,
	#instVars : [
		'jsonContent'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiCreateItemsCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self jsonContent isString and: [ self jsonContent isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].

]

{ #category : #accessing }
DiCreateItemsCommand >> endPoint [
	<return: #Array>
	^ super endPoint, { self collectionName }
]

{ #category : #execution }
DiCreateItemsCommand >> execute [
	| aResponse |
	self assertReadyForExecution.
	aResponse := self postJson: self jsonContent at: self endPoint.
	self response: aResponse
]

{ #category : #accessing }
DiCreateItemsCommand >> jsonContent [
	<return: #String>
	^ jsonContent
]

{ #category : #accessing }
DiCreateItemsCommand >> jsonContent: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	jsonContent := aString
]
