"
I am an abstract {{gtClass:DiCollectionToModelBuilder}} extension.
My subclasses do particular actions implementing {{gtMethod:DiCollectionToModelBuilderExtension>>#build}} and {{gtMethod:DiCollectionToModelBuilderExtension>>#postInstall}}.

See {{gtClass:DiCollectionToModelBuilderExtension|expanded=true|show=gtSubclassesFor:}} for more examples.


"
Class {
	#name : #DiCollectionToModelBuilderExtension,
	#superclass : #DiCollectionToModelBuilderPart,
	#traits : 'TDiModelBuilder + TDiCollectionIterator',
	#classTraits : 'TDiModelBuilder classTrait + TDiCollectionIterator classTrait',
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiCollectionToModelBuilderExtension >> build [
	self subclassResponsibility
]

{ #category : #testing }
DiCollectionToModelBuilderExtension >> isSourceCodeGenerator [
	"This is kind of hack as we do not have a ${class:DiModelBuilder}$ for other languages at this moment."
	<return: #Boolean>
	^ false
]

{ #category : #building }
DiCollectionToModelBuilderExtension >> postInstall [
	"It is called after a model installation. Subclasses can implement it."
]
