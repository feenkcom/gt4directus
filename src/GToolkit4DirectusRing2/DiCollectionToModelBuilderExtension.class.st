Class {
	#name : #DiCollectionToModelBuilderExtension,
	#superclass : #DiCollectionToModelBuilderPart,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiCollectionToModelBuilderExtension >> build [
	self subclassResponsibility
]

{ #category : #filtering }
DiCollectionToModelBuilderExtension >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self builder canIncludeCollection: aDiMetaCollection.
]

{ #category : #filtering }
DiCollectionToModelBuilderExtension >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ self builder canIncludeCollection: aDiMetaCollection field: aDiMetaField
]

{ #category : #building }
DiCollectionToModelBuilderExtension >> postInstall [
	"It is called after a model installation. Subclasses can implement it."
]
