Class {
	#name : #DiIncludedFieldsModelItemsCommand,
	#superclass : #DiDecoradedCommand,
	#instVars : [
		'models',
		'slotNames'
	],
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #execution }
DiIncludedFieldsModelItemsCommand >> execute [
	| anUpdatedModels |
	anUpdatedModels := self models collect: [ :eachModel | 
		self modelWithDeletedFields: eachModel ].
	self command models: anUpdatedModels.
	self command execute.
]

{ #category : #execution }
DiIncludedFieldsModelItemsCommand >> modelWithDeletedFields: aModel [
	| anUpdatedModel |
	anUpdatedModel := aModel class basicNew.
	self slotNames do: [ :eachSlotName | 
		| aValue |
		aValue := anUpdatedModel instVarNamed: eachSlotName.
		anUpdatedModel instVarNamed: eachSlotName put: aValue ].
	^ anUpdatedModel
]

{ #category : #accessing }
DiIncludedFieldsModelItemsCommand >> models [
	^ models
]

{ #category : #accessing }
DiIncludedFieldsModelItemsCommand >> models: aCollectionOfModels [
	self 
		assert: [ aCollectionOfModels isCollection and: [ aCollectionOfModels isNotEmpty ] ] 
		description: [ 'Models must be non-empty collection' ].
	self 
		assert: [ | aModel |
			aModel := aCollectionOfModels anyOne.
			aCollectionOfModels allSatisfy: [ :eachModel | eachModel class = aModel class ] ] 
		description: [ 'All models must be of the same type' ].
	models := aCollectionOfModels.
]

{ #category : #accessing }
DiIncludedFieldsModelItemsCommand >> slotNames [
	<return: #Collection>
	^ slotNames
]

{ #category : #accessing }
DiIncludedFieldsModelItemsCommand >> slotNames: aCollectionOfSlotNames [
	self 
		assert: [ aCollectionOfSlotNames isCollection and: [ aCollectionOfSlotNames isNotEmpty ] ] 
		description: [ 'Slot names must be non-empty collection' ].
	self 
		assert: [
			aCollectionOfSlotNames allSatisfy: [ :eachField | eachField isString and: [ eachField isNotEmpty ] ] ] 
		description: [ 'All slot names must be non-empty strings' ].
	slotNames := aCollectionOfSlotNames
]
