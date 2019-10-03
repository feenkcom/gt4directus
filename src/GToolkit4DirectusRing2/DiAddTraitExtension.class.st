"
I ensure that a particular ${class:DiMetaCollection}$ model uses a ${class:Trait}$. The ${class:Trait}$ can exist in the Pharo image or it can be created explicitly by another extension.

!! Example with One Trait

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I build the following model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithTrait_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithTrait|codeExpanded=false|previewExpanded=true}$

!! Example with Two Traits

I can build a model with a Trait composition:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithTwoTraits_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithTwoTraits|codeExpanded=false|previewExpanded=true}$


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
