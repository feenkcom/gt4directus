Class {
	#name : #DiUpdateItemsCommand,
	#superclass : #DiItemsCommand,
	#traits : 'TDiJsonContent',
	#classTraits : 'TDiJsonContent classTrait',
	#instVars : [
		'jsonContent',
		'itemIds'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiUpdateItemsCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self jsonContent isString and: [ self jsonContent isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	self 
		assert: [ self itemIds isCollection and: [ 
			self itemIds allSatisfy: [ :eachItem | eachItem isString and: [ eachItem isNotEmpty ] ] ] ]
		description: [ 'Item IDs must be string representing natural numbers (integers)' ].
	
]

{ #category : #accessing }
DiUpdateItemsCommand >> endPoint [
	<return: #Array>
	^ super endPoint, { self collectionName }
]

{ #category : #execution }
DiUpdateItemsCommand >> execute [
	| aResponse |
	self assertReadyForExecution.
	aResponse := self patchJson: self jsonContent at: self endPoint.
	self response: aResponse
]

{ #category : #accessing }
DiUpdateItemsCommand >> itemIds [
	<return: #Array of: #String>
	^ itemIds
]

{ #category : #accessing }
DiUpdateItemsCommand >> itemIds: anArray [
	self 
		assert: [ anArray isCollection and: [ anArray isNotEmpty ] ]
		description: [ 'Item IDs must a non-empty collection' ].
	self 
		assert: [ anArray allSatisfy: [ :eachId | eachId isInteger and: [ eachId > 0 ] ] ]
		description: [ 'Item IDs must be natural numbers (integers)' ].
	itemIds := anArray collect: #asString as: Array
]

{ #category : #accessing }
DiUpdateItemsCommand >> jsonContent [
	<return: #String>
	^ jsonContent
]

{ #category : #accessing }
DiUpdateItemsCommand >> jsonContent: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	jsonContent := aString
]
