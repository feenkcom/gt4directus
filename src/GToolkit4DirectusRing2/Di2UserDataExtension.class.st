Class {
	#name : #Di2UserDataExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
Di2UserDataExtension >> build [
	| aClass aMethodBody |
	aClass := self modelRootClass.
	self ensureInstanceVariable: 'userData' inBehavior: aClass.
	aMethodBody := 'userData', String cr, String tab, '^ userData ifNil: [ userData := Dictionary new ]'.
	self 
		ensureLocalMethodNamed: 'userData' 
		withSourceCode: aMethodBody 
		andProtocol: self naming accessorProtocolName 
		inBehavior: aClass
]
