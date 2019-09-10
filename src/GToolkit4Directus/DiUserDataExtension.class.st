Class {
	#name : #DiUserDataExtension,
	#superclass : #DiCollectionToClassBuilderExtension,
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiUserDataExtension >> build [
	self builder modelRootClass addInstVarNamed: 'userData'.
	self builder modelRootClass compile: 'userData', String cr, String tab, '^ userData ifNil: [ userData := Dictionary new ]' classified: 'accessing'.
	
]
