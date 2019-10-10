"
I build a Pharo classes.
I should be called (added) as a first extension to the ${class:DiCollectionToModelBuilder}$ using ${method:DiCollectionToModelBuilder>>#useCollectionNameBuilder}$.

!! Example

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I generate the following Pharo model: 
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #DiPharoModelBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiPharoModelBuilderExtension >> build [
	self buildBehaviors
]

{ #category : #building }
DiPharoModelBuilderExtension >> buildBehavior: aDiMetaCollection [
	| aClassName aClass aSuperClass |
	aClassName := self naming collectionModelName: aDiMetaCollection.
	aClass := self ensureClassAndMetaClassNamed: aClassName.
	aClass package: self modelPackage.
	aClass tagWith: self packageTagName.
	aSuperClass := self modelRootClass.
	aClass superclass: aSuperClass
]

{ #category : #building }
DiPharoModelBuilderExtension >> buildBehaviors [
	self includedCollectionsDo: [ :eachCollection | self buildBehavior: eachCollection ]
]
