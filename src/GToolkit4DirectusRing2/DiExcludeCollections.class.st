"
I exclude from a built a ${class:DiMetaCollection}$ of a given name and all ${class:DiMetaField}$ fields of the given collection type.

!! Example

Using the following company and country meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCountryAndCompany|codeExpanded=false|previewExpanded=true}$

the ${class:DiCollectionToModelBuilder}$ does not create the country model class.
${example:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutCountry|codeExpanded=false|previewExpanded=true}$

In addition, ${class:DiInstanceVariablesBuilderExtension}$ and ${class:DiInstanceVariablesAccessorsBuilderExtension}$ do not create instance variables and methods that refers to the country collection:
${example:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutCountry_Behavior|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #DiExcludeCollections,
	#superclass : #DiCollectionToModelBuilderFilter,
	#instVars : [
		'collectionNames'
	],
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
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
