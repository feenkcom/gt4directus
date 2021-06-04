"
I am an abstract filter.
My subclasses are responsible in aswering whether a {{gtClass:DiMetaCollection}} or {{gtClass:DiMetaField}} should be included for model (Pharo classes) building.
My subclasses are used by {{gtClass:DiCollectionToModelBuilder}}. 

For more details and examples, see my {{gtClass:DiCollectionToModelBuilderFilter|expanded=true|show=gtSubclassesFor:}} subclasses:



"
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
