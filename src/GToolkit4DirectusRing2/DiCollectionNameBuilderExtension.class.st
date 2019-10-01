Class {
	#name : #DiCollectionNameBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiCollectionNameBuilderExtension >> build [
	self buildInRootModelClass.
	self collectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildCollectionNameInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiCollectionNameBuilderExtension >> buildCollectionNameInClass: eachClass ofCollection: eachCollection [
	| aSourceCode aClassSide |
	aClassSide := eachClass classSide.
	aSourceCode := 'collectionName', String cr, String tab, '^ #''', eachCollection name, ''''. 
	self modelBuilder 
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
	self modelBuilder 
		ensureLocalMethodNamed: 'collectionName'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
	aSourceCode := 'collectionName', String cr, String tab, '^ self class collectionName'. 
	self modelBuilder 
		ensureLocalMethodNamed: 'collectionName'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass.
	
]
