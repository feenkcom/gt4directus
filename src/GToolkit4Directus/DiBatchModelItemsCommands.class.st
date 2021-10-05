Class {
	#name : 'DiBatchModelItemsCommands',
	#superclass : 'DiDecoradedCommand',
	#traits : 'TDiModels',
	#classTraits : 'TDiModels classTrait',
	#instVars : [
		'models',
		'batchSize',
		'responses'
	],
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'asserting' }
DiBatchModelItemsCommands >> assertReadyForExecution [
	super assertReadyForExecution.
	self 
		assert: [ self models isCollection and: [ self models isNotEmpty ] ] 
		description: [ 'Models must be non-empty collection' ].
]

{ #category : 'asserting' }
DiBatchModelItemsCommands >> assertSubCommand [
	"do nothing"
]

{ #category : 'accessing' }
DiBatchModelItemsCommands >> batchSize [
	<return: #Integer>
	^ batchSize
]

{ #category : 'accessing' }
DiBatchModelItemsCommands >> batchSize: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ] 
		description: [ 'Batch size must be a natural number (integer)' ].
	batchSize := anInteger
]

{ #category : 'initialization' }
DiBatchModelItemsCommands >> beStoreNewItems [
	self command: DiStoreNewModelItemsCommand new.
]

{ #category : 'initialization' }
DiBatchModelItemsCommands >> beUpdateExistingItems [
	self command: DiUpdateModelItemsCommand new.
]

{ #category : 'initialization' }
DiBatchModelItemsCommands >> beUpdateSomeSlots: aCollectionOfSlots [
	self command: (DiIncludedFieldsModelItemsCommand new
		slotNames: aCollectionOfSlots;
		command: DiUpdateModelItemsCommand new).
]

{ #category : 'execution' }
DiBatchModelItemsCommands >> execute [
	| aBatch |
	self assertReadyForExecution.
	aBatch := OrderedCollection new.
	self models do: [ :eachCompany | 
		aBatch add: eachCompany.
		aBatch size >= self batchSize ifTrue: [ 
			self executeWithModels: aBatch.
			self isLastResponseSuccess ifFalse: [ ^ self ].
			aBatch := OrderedCollection new ]
	].
	aBatch ifNotEmpty: [ self executeWithModels: aBatch ].
]

{ #category : 'execution' }
DiBatchModelItemsCommands >> executeWithModels: aCollectionOfModels [
	| aResponse |
	self 
		assert: [ aCollectionOfModels isCollection and: [ aCollectionOfModels isNotEmpty ] ]
		description: [ 'Models must be a non-empty collection' ].
	aResponse := self command 
		models: aCollectionOfModels;
		execute;
		commandResponse.
	responses add: aResponse.
]

{ #category : 'gt-extension' }
DiBatchModelItemsCommands >> gtAllResponsesFor: aView [
	<gtView>
	self responses ifNil: [ ^ aView empty ].
	^ aView columnedList 
			title: 'All Respones';
			priority: 0;
			items: [ self responses ];
			column: 'Response' item: [ :aResponse | 
				(String streamContents: [ :out | 
					aResponse statusLine 
						ifNotNil: [ :aStatus | aStatus writeOn: out ]
						ifNil: [ '<undefined-status>' ] ]) asRopedText ]
			
]

{ #category : 'initialization' }
DiBatchModelItemsCommands >> initialize [
	super initialize.
	self beStoreNewItems.
	self batchSize: 10.
	responses := OrderedCollection new.

]

{ #category : 'execution' }
DiBatchModelItemsCommands >> isLastResponseSuccess [
	<return: #Boolean>
	^ self responses last isSuccess
]

{ #category : 'accessing' }
DiBatchModelItemsCommands >> models [
	^ models
]

{ #category : 'accessing' }
DiBatchModelItemsCommands >> models: aCollectionOfModels [
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

{ #category : 'accessing' }
DiBatchModelItemsCommands >> responses [
	<return: #Collection of: #ZnResponse>
	^ responses
]
