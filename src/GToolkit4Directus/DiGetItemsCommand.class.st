Class {
	#name : #DiGetItemsCommand,
	#superclass : #DiItemsCommand,
	#instVars : [
		'itemIds'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiGetItemsCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self itemIds isArray and: [ self itemIds isNotEmpty ] ]
		description: [ 'Item IDs must be a non-empty collection' ].
	self 
		assert: [ self itemIds allSatisfy: [ :eachId | eachId isString and: [ eachId isNotEmpty ] ] ]
		description: [ 'Item IDs must be strings representing natural numbers (integers)' ].

]

{ #category : #accessing }
DiGetItemsCommand >> endPoint [
	<return: #Array>
	| aFinalPoint |
	aFinalPoint := String streamContents: [ :aStream | 
		self itemIds 
			do: [ :eachStringId | aStream nextPutAll: eachStringId ] 
			separatedBy: [ aStream nextPut: $, ] ].
	^ super endPoint, { self collectionName. aFinalPoint }
]

{ #category : #execution }
DiGetItemsCommand >> execute [
	self assertReadyForExecution.
	self response: self getResponse.
	
]

{ #category : #accessing }
DiGetItemsCommand >> itemIds [
	<return: #Array of: #String>
	^ itemIds
]

{ #category : #accessing }
DiGetItemsCommand >> itemIds: anArray [
	self 
		assert: [ anArray isCollection and: [ anArray isNotEmpty ] ]
		description: [ 'Item IDs must a non-empty collection' ].
	self 
		assert: [ anArray allSatisfy: [ :eachId | eachId isInteger and: [ eachId > 0 ] ] ]
		description: [ 'Item IDs must be natural numbers (integers)' ].
	itemIds := anArray collect: #asString as: Array
]
