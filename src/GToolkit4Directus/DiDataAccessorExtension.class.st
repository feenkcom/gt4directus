Class {
	#name : #DiDataAccessorExtension,
	#superclass : #DiCollectionToClassBuilderExtension,
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiDataAccessorExtension >> build [
	self builder modelRootClass compile: 'data', String cr, String tab, '^ self userData at: #data' classified: 'accessing'.
	self builder modelRootClass compile: 'data: aDiData', String cr, String tab, 'self userData at: #data put: aDiData' classified: 'accessing'.

]
