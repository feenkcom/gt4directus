Class {
	#name : #DiCollectionNameBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
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
			tab; nextPutAll: 'self error: ''Cannot find a model of the given name'', aCollectionName.' ]. 
	self 
		ensureLocalMethodNamed: 'modelNamed:'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
]
