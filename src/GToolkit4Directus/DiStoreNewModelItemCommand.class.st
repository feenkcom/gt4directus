Class {
	#name : 'DiStoreNewModelItemCommand',
	#superclass : 'DiDecoradedCommand',
	#traits : 'TDiModel',
	#classTraits : 'TDiModel classTrait',
	#instVars : [
		'model'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'asserting' }
DiStoreNewModelItemCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self model isNotNil ] 
		description: [ 'Model must be non-nil' ].

]

{ #category : 'execution' }
DiStoreNewModelItemCommand >> execute [
	| aResult |
	self assertReadyForExecution.
	self command execute.
	self isSuccessResponse ifFalse: [ ^ self ].
	self isNoContentResponse ifTrue: [ ^ self ].
	aResult := self model class readJsonDataItem: self responseContents.
	self model id: aResult id.
]

{ #category : 'initialization' }
DiStoreNewModelItemCommand >> initialize [
	super initialize.
	self command: DiStoreNewItemsCommand new.
]

{ #category : 'accessing' }
DiStoreNewModelItemCommand >> model [
	^ model
]

{ #category : 'accessing' }
DiStoreNewModelItemCommand >> model: aModel [
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
