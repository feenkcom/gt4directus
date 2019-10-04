Class {
	#name : #DiIncludedFieldsBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiIncludedFieldsBuilderExtension >> build [
	self buildInRootModelClass.
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiIncludedFieldsBuilderExtension >> buildInClass: eachClass ofCollection: eachCollection [
	| aSourceCode |.
	aSourceCode := String streamContents: [ :aStream | 
		aStream nextPutAll: 'includedCollectionFields'; cr. 
		aStream tab; nextPutAll: '^ #( '.
		self 
			includedCollection: eachCollection 
			fieldsDo: [ :eachField |
				aStream nextPut: $'; nextPutAll: eachField name; nextPut: $' ]
			separatedBy: [ aStream space ].
		aStream nextPutAll: ' )' ].
	self modelBuilder 
		ensureLocalMethodNamed: 'includedCollectionFields'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: eachClass classSide.
]

{ #category : #building }
DiIncludedFieldsBuilderExtension >> buildInRootModelClass [
	| aClass aSourceCode |
	aClass := self modelRootClass.
	aSourceCode := 'includedCollectionFields', String cr, String tab, '^ self subclassResponsibility'. 
	self modelBuilder 
		ensureLocalMethodNamed: 'includedCollectionFields'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
]
