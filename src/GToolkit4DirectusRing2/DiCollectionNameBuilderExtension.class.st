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

	| aSourceCode |
	aSourceCode := 'collectionName', String cr, String tab, '^ ''', eachCollection name, ''''. 
	self modelBuilder 
		ensureLocalMethodNamed: 'collectionName'
		withSourceCode: aSourceCode 
		andProtocol: (self naming accessorProtocolName) 
		inBehavior: eachClass.
]
