Class {
	#name : #DiPrintOnWithNameExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiPrintOnWithNameExtension >> build [
	self includedCollectionsAndFieldsAndModelsDo: [ :eachCollection :eachField :eachModel |
		(eachField name = 'name') ifTrue: [ 
			self buildPrintOnMethodForBehavior: eachModel 
		]
	]
]

{ #category : #building }
DiPrintOnWithNameExtension >> buildPrintOnMethodForBehavior: aRGBehavior [ 
	| aMethodBody |
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'printOn: aStream'; cr;
			tab; nextPutAll: 'self name ifNil: [ ^ super printOn: aStream ].'; cr;
			tab; nextPutAll: 'aStream nextPutAll: self name asString' ].
	self 
		ensureLocalMethodNamed: 'printOn:' 
		withSourceCode: aMethodBody 
		andProtocol: self naming printingProtocolName 
		inBehavior: aRGBehavior
]
