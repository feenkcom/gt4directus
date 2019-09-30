Class {
	#name : #DiExcludeCollections,
	#superclass : #DiCollectionToModelBuilderFilter,
	#instVars : [
		'collectionNames'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #filtering }
DiExcludeCollections >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ (self collectionNames includes: aDiMetaCollection name) not.
]

{ #category : #filtering }
DiExcludeCollections >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ self canIncludeCollection: aDiMetaCollection.
]

{ #category : #accessing }
DiExcludeCollections >> collectionNames [
	^ collectionNames
]

{ #category : #accessing }
DiExcludeCollections >> collectionNames: anObject [
	collectionNames := anObject
]
