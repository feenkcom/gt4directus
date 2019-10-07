"
I am an abstract ${class:DiCollectionToModelBuilder}$ extension.
My subclasses do particular actions implementing ${method:DiCollectionToModelBuilderExtension>>#build}$ and ${method:DiCollectionToModelBuilderExtension>>#postInstall}$.

See ${class:DiCollectionToModelBuilderExtension|expanded=true|show=gtSubclassesFor:}$ for more examples.


"
Class {
	#name : #DiCollectionToModelBuilderExtension,
	#superclass : #DiCollectionToModelBuilderPart,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiCollectionToModelBuilderExtension >> build [
	self subclassResponsibility
]

{ #category : #building }
DiCollectionToModelBuilderExtension >> postInstall [
	"It is called after a model installation. Subclasses can implement it."
]
