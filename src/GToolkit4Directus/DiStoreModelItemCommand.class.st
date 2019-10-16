Class {
	#name : #DiStoreModelItemCommand,
	#superclass : #DiDecoradedCommand,
	#instVars : [
		'model'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiStoreModelItemCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self model isNotNil ] 
		description: [ 'Model must be non-nil' ].

]

{ #category : #execution }
DiStoreModelItemCommand >> execute [
	| aResult |
	self assertReadyForExecution.
	self command execute.
	self isSuccessResponse ifFalse: [ ^ self ].
	self isNoContentResponse ifTrue: [ ^ self ].
	aResult := self model class readJsonDataItem: self responseContents.
	self model id: aResult id.
]

{ #category : #initialization }
DiStoreModelItemCommand >> initialize [
	super initialize.
	self command: DiStoreItemsCommand new.
]

{ #category : #accessing }
DiStoreModelItemCommand >> model [
	^ model
]

{ #category : #accessing }
DiStoreModelItemCommand >> model: aModel [
	self 
		assert: [ aModel isNotNil ] 
		description: [ 'Model must be non-nil' ].
	self 
		assert: [ aModel id isNil ] 
		description: [ 'I store only new models' ].
	model := aModel.
	self command collectionName: aModel collectionName.
	self command jsonContent: aModel asJson.
]
