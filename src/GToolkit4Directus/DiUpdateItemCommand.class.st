Class {
	#name : 'DiUpdateItemCommand',
	#superclass : 'DiItemsCommand',
	#traits : 'TDiJsonContent',
	#classTraits : 'TDiJsonContent classTrait',
	#instVars : [
		'jsonContent',
		'itemId'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'asserting' }
DiUpdateItemCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self jsonContent isString and: [ self jsonContent isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	self 
		assert: [ self itemId isString and: [ self itemId isNotEmpty ] ]
		description: [ 'Item ID must be string representing a natural number (integer)' ].
	
]

{ #category : 'accessing' }
DiUpdateItemCommand >> endPoint [
	<return: #Array>
	^ super endPoint, { self collectionName. self itemId }
]

{ #category : 'execution' }
DiUpdateItemCommand >> execute [
	| aResponse |
	self assertReadyForExecution.
	aResponse := self patchJson: self jsonContent at: self endPoint.
	self response: aResponse
]

{ #category : 'accessing' }
DiUpdateItemCommand >> itemId [
	<return: #String>
	^ itemId
]

{ #category : 'accessing' }
DiUpdateItemCommand >> itemId: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Item ID must be a natural number (integer)' ].
	itemId := anInteger asString
]

{ #category : 'accessing' }
DiUpdateItemCommand >> jsonContent [
	<return: #String>
	^ jsonContent
]

{ #category : 'accessing' }
DiUpdateItemCommand >> jsonContent: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	jsonContent := aString
]
