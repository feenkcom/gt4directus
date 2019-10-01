Class {
	#name : #DiOriginalFieldsBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiOriginalFieldsBuilderExtension >> build [
	self buildInRootModelClass.
	self collectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildOriginalFieldsInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiOriginalFieldsBuilderExtension >> buildInRootModelClass [
	| aClass aSourceCode |
	aClass := self builder modelRootClass.
	aSourceCode := 'originalFields', String cr, String tab, '^ self subclassResponsibility'. 
	self modelBuilder 
		ensureLocalMethodNamed: 'originalFields'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass.
]

{ #category : #building }
DiOriginalFieldsBuilderExtension >> buildOriginalFieldsInClass: eachClass ofCollection: eachCollection [
	| aSourceCode |.
	aSourceCode := 'originalFields', String cr, String tab, '^ ',  (eachCollection fields collect: #name) asString. 
	self modelBuilder 
		ensureLocalMethodNamed: 'originalFields'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: eachClass.
]
