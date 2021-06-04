"
I add a `includedCollectionFields` class-side method that returns a collection of all {{gtClass:DiMetaField}} names that are included in the particular model (class) build.

## Example

Using the following company meta-model: {{gtExample:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCountryAndCompany|codeExpanded=false|previewExpanded=true}}

I build the following company class-side model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithIncludedCollectionFields_Behavior|codeExpanded=false|previewExpanded=true}}

Here you can browse the full model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithIncludedCollectionFields|codeExpanded=false|previewExpanded=true}}

## Related

Similarly, {{gtClass:DiCollectionNameBuilderExtension}} add a method that returns a {{gtClass:DiMetaCollection}} name that is represented the particular model (class).


"
Class {
	#name : #DiIncludedFieldsBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiIncludedFieldsBuilderExtension >> build [
	self buildInRootModelClass.
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiIncludedFieldsBuilderExtension >> buildInClass: eachClass ofCollection: eachCollection [
	| aSortedFieldNames aSourceCode |.
	aSortedFieldNames := SortedCollection new.
	self 
		includedCollection: eachCollection 
		fieldsDo: [ :eachField | aSortedFieldNames add: eachField name ].
	aSourceCode := String streamContents: [ :aStream | 
		aStream nextPutAll: 'includedCollectionFields'; cr. 
		aStream tab; nextPutAll: '^ #( '.
		aSortedFieldNames 
			do: [ :eachFieldName |
				aStream nextPut: $'; nextPutAll: eachFieldName; nextPut: $' ]
			separatedBy: [ aStream space ].
		aStream nextPutAll: ' )' ].
	self modelBuilder 
		ensureLocalMethodNamed: 'includedCollectionFields'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: eachClass classSide.
]

{ #category : #building }
DiIncludedFieldsBuilderExtension >> buildInRootModelClass [
	| aClass aSourceCode |
	aClass := self modelRootClass.
	aSourceCode := 'includedCollectionFields', String cr, String tab, '^ self subclassResponsibility'. 
	self modelBuilder 
		ensureLocalMethodNamed: 'includedCollectionFields'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
]
