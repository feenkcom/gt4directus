Class {
	#name : #DiStoreNewModelItemsCommand,
	#superclass : #DiDecoradedCommand,
	#traits : 'TDiModels',
	#classTraits : 'TDiModels classTrait',
	#instVars : [
		'models'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #asserting }
DiStoreNewModelItemsCommand >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self models isCollection and: [ self models isNotEmpty ] ] 
		description: [ 'Models must be a non-empty collection' ].

]

{ #category : #execution }
DiStoreNewModelItemsCommand >> execute [
	| aResult |
	self assertReadyForExecution.
	self command execute.
	self isSuccessResponse ifFalse: [ ^ self ].
	self isNoContentResponse ifTrue: [ ^ self ].
	aResult := self models anyOne class readJsonDataCollection: self responseContents.
	self 
		assert: [ aResult isCollection and: [ aResult size = self models size ] ]
		description: [ 'The received result should have the same amount of models' ].
	self models 
		paddedWith: aResult 
		do: [ :anOriginalModel :aResultModel | anOriginalModel id: aResultModel id ]
]

{ #category : #initialization }
DiStoreNewModelItemsCommand >> initialize [
	super initialize.
	self command: DiStoreNewItemsCommand new.
]

{ #category : #accessing }
DiStoreNewModelItemsCommand >> models [
	^ models
]

{ #category : #accessing }
DiStoreNewModelItemsCommand >> models: aCollectionOfModels [
	self 
		assert: [ aCollectionOfModels isCollection and: [ aCollectionOfModels isNotEmpty ] ] 
		description: [ 'Models must be non-empty collection' ].
	self 
		assert: [ aCollectionOfModels allSatisfy: [ :eachModel | eachModel id isNil ] ] 
		description: [ 'I store only new models' ].
	self 
		assert: [ | aModel |
			aModel := aCollectionOfModels anyOne.
			aCollectionOfModels allSatisfy: [ :eachModel | eachModel class = aModel class ] ] 
		description: [ 'All models must be of the same type' ].
	models := aCollectionOfModels.
	self command collectionName: aCollectionOfModels anyOne collectionName.
	self command jsonContent: (aCollectionOfModels anyOne class asJsonCollection: aCollectionOfModels).
]
