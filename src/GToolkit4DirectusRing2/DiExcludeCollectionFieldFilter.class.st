"
I exclude from model building a ${class:DiMetaField}$ of a given name that belongs to a ${method:DiMetaCollection>>#fields}$ of a particular name.

!! Example

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithSubsidiaryCompaniesField|codeExpanded=false|previewExpanded=true}$

the ${class:DiInstanceVariablesBuilderExtension}$ and ${class:DiInstanceVariablesAccessorsBuilderExtension}$ do not create all instance variables and methods:
${example:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithInstanceAndAccessorsVariables_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithInstanceAndAccessorsVariables|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #DiExcludeCollectionFieldFilter,
	#superclass : #DiCollectionToModelBuilderFilter,
	#instVars : [
		'collectionName',
		'fieldName'
	],
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #filtering }
DiExcludeCollectionFieldFilter >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ true.
]

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
