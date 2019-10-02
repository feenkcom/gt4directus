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
	"Exclude fields of a collection type that we exclude too"
	<return: #Boolean>
	^ (self canIncludeCollection: aDiMetaCollection) and: [ 
		aDiMetaField collectionOrNil 
			ifNotNil: [ self canIncludeCollection: aDiMetaField collectionOrNil ]
			ifNil: [ true ] ]
]

{ #category : #accessing }
DiExcludeCollections >> collectionNames [
	^ collectionNames
]

{ #category : #accessing }
DiExcludeCollections >> collectionNames: anObject [
	collectionNames := anObject
]
