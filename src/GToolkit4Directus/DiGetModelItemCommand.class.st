Class {
	#name : #DiGetModelItemCommand,
	#superclass : #DiDecoradedCommand,
	#instVars : [
		'modelClass',
		'model'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #execution }
DiGetModelItemCommand >> execute [
	| aModel |
	self command execute.
	self isSuccessResponse ifFalse: [ ^ self ].
	aModel := self modelClass readJsonDataItem: self responseContents.
	self model: aModel
]

{ #category : #initialization }
DiGetModelItemCommand >> initialize [
	super initialize.
	self command: DiGetItemCommand new.
]

{ #category : #accessing }
DiGetModelItemCommand >> itemId [
	<return: #String>
	^ self command itemId
]

{ #category : #accessing }
DiGetModelItemCommand >> itemId: anInteger [
	self command itemId: anInteger
]

{ #category : #accessing }
DiGetModelItemCommand >> model [
	^ model
]

{ #category : #accessing }
DiGetModelItemCommand >> model: anObject [
	model := anObject
]

{ #category : #accessing }
DiGetModelItemCommand >> modelClass [
	<return: #Class>
	^ modelClass
]

{ #category : #accessing }
DiGetModelItemCommand >> modelClass: aClass [
	modelClass := aClass.
	self command collectionName: aClass collectionName.
]
