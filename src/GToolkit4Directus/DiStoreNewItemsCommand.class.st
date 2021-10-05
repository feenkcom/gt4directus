Class {
	#name : 'DiStoreNewItemsCommand',
	#superclass : 'DiItemsCommand',
	#traits : 'TDiJsonContent',
	#classTraits : 'TDiJsonContent classTrait',
	#instVars : [
		'jsonContent'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'asserting' }
DiStoreNewItemsCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self jsonContent isString and: [ self jsonContent isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].

]

{ #category : 'accessing' }
DiStoreNewItemsCommand >> endPoint [
	<return: #Array>
	^ super endPoint, { self collectionName }
]

{ #category : 'execution' }
DiStoreNewItemsCommand >> execute [
	| aResponse |
	self assertReadyForExecution.
	aResponse := self postJson: self jsonContent at: self endPoint.
	self response: aResponse
]

{ #category : 'accessing' }
DiStoreNewItemsCommand >> jsonContent [
	<return: #String>
	^ jsonContent
]

{ #category : 'accessing' }
DiStoreNewItemsCommand >> jsonContent: aString [
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'JSON content must be a non-empty string' ].
	jsonContent := aString
]
