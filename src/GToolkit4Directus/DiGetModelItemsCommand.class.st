Class {
	#name : #DiGetModelItemsCommand,
	#superclass : #DiDecoradedCommand,
	#traits : 'TDiModels',
	#classTraits : 'TDiModels classTrait',
	#instVars : [
		'modelClass',
		'model'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #execution }
DiGetModelItemsCommand >> execute [
	| aModel |
	self assertReadyForExecution.
	self command execute.
	self isSuccessResponse ifFalse: [ ^ self ].
	aModel := self modelClass readJsonDataCollection: self responseContents.
	self model: aModel
]

{ #category : #initialization }
DiGetModelItemsCommand >> initialize [
	super initialize.
	self command: DiGetItemsCommand new.
]

{ #category : #accessing }
DiGetModelItemsCommand >> itemId: anInteger [
	self command itemId: anInteger
]

{ #category : #accessing }
DiGetModelItemsCommand >> itemIds [ 
	<return: #Array of: #String>
	^ self command itemIds
]

{ #category : #accessing }
DiGetModelItemsCommand >> itemIds: aCollectionOfIds [
	self command itemIds: aCollectionOfIds
]

{ #category : #accessing }
DiGetModelItemsCommand >> model [
	^ model
]

{ #category : #accessing }
DiGetModelItemsCommand >> model: anObject [
	model := anObject
]

{ #category : #accessing }
DiGetModelItemsCommand >> modelClass [
	<return: #Class>
	^ modelClass
]

{ #category : #accessing }
DiGetModelItemsCommand >> modelClass: aClass [
	modelClass := aClass.
	self command collectionName: aClass collectionName.
]
