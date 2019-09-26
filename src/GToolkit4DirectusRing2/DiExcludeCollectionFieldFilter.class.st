Class {
	#name : #DiExcludeCollectionFieldFilter,
	#superclass : #DiCollectionToModelBuilderFilter,
	#instVars : [
		'collectionName',
		'fieldName'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #filtering }
DiExcludeCollectionFieldFilter >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ ((aDiMetaCollection name = self collectionName) and: [ 
		aDiMetaField name = self fieldName ]) not
]

{ #category : #accessing }
DiExcludeCollectionFieldFilter >> collectionName [
	^ collectionName
]

{ #category : #accessing }
DiExcludeCollectionFieldFilter >> collectionName: anObject [
	collectionName := anObject
]

{ #category : #accessing }
DiExcludeCollectionFieldFilter >> fieldName [
	^ fieldName
]

{ #category : #accessing }
DiExcludeCollectionFieldFilter >> fieldName: anObject [
	fieldName := anObject
]
