"
I exclude Directus system collections from model builds.
System collections are defined in {{gtMethod:DiMetaCollection>>#isSystemCollection}}.

## Example

Using the following company, country, and the system collection directus-user meta-model: {{gtExample:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCountryAndCompanyAndDirectusUser|codeExpanded=false|previewExpanded=true}}

I will exclude the system collection called `directus_user` from the model, allowing to build only company and country model classes:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutSystemCollections|codeExpanded=false|previewExpanded=true}}

You can compare it with the model that includes the system collection:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutSystemCollections_Unfiltered|codeExpanded=false|previewExpanded=true}}

The model above also includes the `directus_user` model (class):
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutSystemCollections_Unfiltered_Behavior|codeExpanded=false|previewExpanded=true}}


"
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
	"Exclude fields of a collection type that we exclude too"
	<return: #Boolean>
	^ (self canIncludeCollection: aDiMetaCollection) and: [ 
		aDiMetaField collectionOrNil 
			ifNotNil: [ self canIncludeCollection: aDiMetaField collectionOrNil ]
			ifNil: [ true ] ]
]
