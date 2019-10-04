"
I add a ==printOn:== method to models that have ==name== fields (instance variables).

!! Example with One Trait

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I build the following root model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithPrintOnMethod_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithPrintOnMethod|codeExpanded=false|previewExpanded=true}$

You can compare the model above with the standard build without my extension: 
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly|codeExpanded=false|previewExpanded=true}$



"
Class {
	#name : #DiPrintOnWithNameExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
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
