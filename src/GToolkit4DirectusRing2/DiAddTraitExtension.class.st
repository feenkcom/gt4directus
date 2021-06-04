"
I ensure that a particular {{gtClass:DiMetaCollection}} model uses a {{gtClass:Trait}}. The {{gtClass:Trait}} can exist in the Pharo image or it can be created explicitly by another extension.

## Example with One Trait

Using the following company meta-model: {{gtExample:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}}

I build the following model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithTrait_Behavior|codeExpanded=false|previewExpanded=true}}

Here you can browse the full model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithTrait|codeExpanded=false|previewExpanded=true}}

## Example with Two Traits

I can build a model with a Trait composition:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithTwoTraits_Behavior|codeExpanded=false|previewExpanded=true}}

Here you can browse the full model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithTwoTraits|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #DiAddTraitExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#instVars : [
		'collectionName',
		'traitClassName'
	],
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiAddTraitExtension >> build [
	self includedCollectionsAndModelsDo: [ :aCollection :aBehavior | 
		aCollection name = self collectionName ifTrue: [ 
			self ensureTraitInBehavior: aBehavior ] ].
]

{ #category : #accessing }
DiAddTraitExtension >> collectionName [
	^ collectionName
]

{ #category : #accessing }
DiAddTraitExtension >> collectionName: anObject [
	collectionName := anObject
]

{ #category : #building }
DiAddTraitExtension >> ensureTraitInBehavior: aRGBehavior [ 
	self ensureTraitNamed: self traitClassName inBehavior: aRGBehavior
]

{ #category : #accessing }
DiAddTraitExtension >> traitClassName [
	^ traitClassName
]

{ #category : #accessing }
DiAddTraitExtension >> traitClassName: anObject [
	traitClassName := anObject
]
