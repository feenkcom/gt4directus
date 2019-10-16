Class {
	#name : #DiUpdateModelItemCommand,
	#superclass : #DiDecoradedCommand,
	#instVars : [
		'model'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiUpdateModelItemCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self model isNotNil ] 
		description: [ 'Model must be non-nil' ].

]

{ #category : #execution }
DiUpdateModelItemCommand >> execute [
	| aResult |
	self assertReadyForExecution.
	self command execute.
	self isSuccessResponse ifFalse: [ ^ self ].
	self isNoContentResponse ifTrue: [ ^ self ].
	aResult := self model class readJsonDataItem: self responseContents.
	self model id: aResult id.
]

{ #category : #initialization }
DiUpdateModelItemCommand >> initialize [
	super initialize.
	self command: DiUpdateItemCommand new.
]

{ #category : #accessing }
DiUpdateModelItemCommand >> model [
	^ model
]

{ #category : #accessing }
DiUpdateModelItemCommand >> model: aModel [
	self 
		assert: [ aModel isNotNil ] 
		description: [ 'Model must be non-nil' ].
	self 
		assert: [ aModel id isNotNil ] 
		description: [ 'I update only existing models' ].
	model := aModel.
	self command collectionName: aModel collectionName.
	self command jsonContent: aModel asJson.
	self command itemId: aModel id.
]
