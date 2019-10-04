Class {
	#name : #DiCollectionToModelBuilderFilter,
	#superclass : #DiCollectionToModelBuilderPart,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #filtering }
DiCollectionToModelBuilderFilter >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self subclassResponsibility.
]

{ #category : #filtering }
DiCollectionToModelBuilderFilter >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ self subclassResponsibility.
]
