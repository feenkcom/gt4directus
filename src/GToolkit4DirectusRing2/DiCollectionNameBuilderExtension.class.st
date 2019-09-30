Class {
	#name : #DiCollectionNameBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiCollectionNameBuilderExtension >> build [
	self collectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildCollectionNameInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiCollectionNameBuilderExtension >> buildCollectionNameInClass: eachClass ofCollection: eachCollection [

	| aSourceCode aClassSide |
	aClassSide := eachClass classSide.
	self assert: [ aClassSide isRingResolved ] description: [ 'Class side must be resolved' ].
	self 
		assert: [ aClassSide name beginsWith: eachClass name ] 
		description: [ 'Class side must start with same name as the instnace side' ].

	aSourceCode := 'collectionName', String cr, String tab, '^ #''', eachCollection name, ''''. 
	self modelBuilder 
		ensureLocalMethodNamed: 'collectionName'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClassSide.
]
