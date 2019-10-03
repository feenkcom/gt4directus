Class {
	#name : #DiExcludeSystemCollections,
	#superclass : #DiCollectionToModelBuilderFilter,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #filtering }
DiExcludeSystemCollections >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ aDiMetaCollection isSystemCollection not.
]

{ #category : #filtering }
DiExcludeSystemCollections >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ self canIncludeCollection: aDiMetaCollection.
]
