"
I exclude Directus system fields from ${class:DiMetaCollection}$ model builds.
System fields are defined in ${method:DiMetaField class>>#systemFieldNames}$.

!! Example

Using the following company and country meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCountryAndCompanyAndSystemFields|codeExpanded=false|previewExpanded=true}$

I will exclude the system fields from the model, see the instance variables and methods in this model:
${example:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutSystemFields_Behavior|codeExpanded=false|previewExpanded=true}$

You can compare it with the model that includes the system fields:
${example:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutSystemFields_Unfiltered_Behavior|codeExpanded=false|previewExpanded=true}$

The full model without system fields is available here:
${example:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutSystemFields|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #DiExcludeDirectusSystemFieldsFilter,
	#superclass : #DiCollectionToModelBuilderFilter,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #filtering }
DiExcludeDirectusSystemFieldsFilter >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ true.
]

{ #category : #filtering }
DiExcludeDirectusSystemFieldsFilter >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ aDiMetaField isSystemField not
]

{ #category : #accessing }
DiExcludeDirectusSystemFieldsFilter >> systemFieldNames [
	^ #( 'created_by' 'created_on' 'modified_by' 'modified_on' 'updated_on' 'updated_by' )
]
