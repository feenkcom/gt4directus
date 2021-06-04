"
I build instance variables for each {{gtClass:DiMetaCollection}} class based on {{gtMethod:DiMetaCollection>>#fields}} information, which is a collection of {{gtClass:DiMetaField}}.

## Example

Using the following company meta-model: {{gtExample:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}}

I build the following model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithAllInstanceVariables_Behavior|codeExpanded=false|previewExpanded=true}}

Here you can browse the full model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithAllInstanceVariables|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #DiInstanceVariablesBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiInstanceVariablesBuilderExtension >> build [
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildInstanceVariablesInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiInstanceVariablesBuilderExtension >> buildInstanceVariablesInClass: aRGBehavior ofCollection: aDiMetaCollection [ 
	| theSlots |
	theSlots := self collectionSlots: aDiMetaCollection.
	self ensureInstanceVariables: theSlots inBehavior: aRGBehavior.
]

{ #category : #'meta model' }
DiInstanceVariablesBuilderExtension >> collectionSlots: aDiMetaCollection [ 
	^ Array new: aDiMetaCollection numberOfFields streamContents: [ :aStream |
		self includedCollection: aDiMetaCollection fieldsDo: [ :eachField | 
			| aName | 
			aName := self naming fieldName: eachField.
			aStream nextPut: aName ] ]
]
