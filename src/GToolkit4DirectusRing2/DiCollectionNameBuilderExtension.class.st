"
I add a ==collectionName== method to models in order to easily associate to which ${class:DiMetaCollection}$ belongs.
Someone can then call ==modelNamed:== with ${class:DiMetaCollection}$'s name on the model root class in order to identify the correct model class.

!! Example

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I build the following root model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithPrintOnMethod_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithPrintOnMethod|codeExpanded=false|previewExpanded=true}$

You can compare the model above with the standard build without my extension: 
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly|codeExpanded=false|previewExpanded=true}$

!! Related

Similarly, ${class:DiIncludedFieldsBuilderExtension}$ add a method that returns ${class:DiMetaField}$ objects considered (included) during the model (class) build.

"
Class {
	#name : #DiCollectionNameBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiCollectionNameBuilderExtension >> build [
	self buildInRootModelClass.
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildCollectionNameInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiCollectionNameBuilderExtension >> buildCollectionNameInClass: eachClass ofCollection: eachCollection [
	| aSourceCode aClassSide |
	aClassSide := eachClass classSide.
	aSourceCode := 'collectionName', String cr, String tab, '^ #''', eachCollection name, ''''. 
	self 
		ensureLocalMethodNamed: 'collectionName'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClassSide.
]

{ #category : #building }
DiCollectionNameBuilderExtension >> buildInRootModelClass [
	| aClass aSourceCode |
	aClass := self builder modelRootClass.
	aSourceCode := 'collectionName', String cr, String tab, '^ self subclassResponsibility'. 
	self 
		ensureLocalMethodNamed: 'collectionName'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
	aSourceCode := 'collectionName', String cr, String tab, '^ self class collectionName'. 
	self 
		ensureLocalMethodNamed: 'collectionName'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass.
	aSourceCode := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'modelNamed: aCollectionName'; cr; 
			tab; nextPutAll: 'self allSubclassesDo: [ :eachClass | '; cr;
			tab; tab; nextPutAll: '(eachClass collectionName = aCollectionName) ifTrue: [ ^ eachClass ] ].'; cr;
			tab; nextPutAll: '^ nil' ]. 
	self 
		ensureLocalMethodNamed: 'modelNamed:'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
]
