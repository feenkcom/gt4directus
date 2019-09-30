Class {
	#name : #DiExcludeSystemCollections,
	#superclass : #DiCollectionToModelBuilderFilter,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #filtering }
DiExcludeSystemCollections >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ aDiMetaCollection isSystemCollection not.
]

{ #category : #filtering }
DiExcludeSystemCollections >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ aDiMetaCollection isSystemCollection not.
]
