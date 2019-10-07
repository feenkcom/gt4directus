"
I add ${class:Trait}$ to all ${class:DiMetaCollection}$ models of the same name, prefixed by ==T== character.
If there is a model class called ==MyCompany== and the target environment includes a ==TMyCompany== Trait, the model class uses the Trait.

!! Example

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

and considering that ${class:TDiDummyCompany}$ Trait exists, I build the following model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithDiscoveredTraits_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithDiscoveredTraits|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #DiTraitDiscoveryExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiTraitDiscoveryExtension >> build [
	self mayUseSystemTraitInBehavior: self modelRootClass. 
	self includedCollectionsAndModelsDo: [ :aCollection :aBehavior | 
		self mayUseSystemTraitInBehavior: aBehavior
	].
]

{ #category : #building }
DiTraitDiscoveryExtension >> mayUseSystemTraitInBehavior: aRGBehavior [ 
	| aTraitName |
	aTraitName := 'T', aRGBehavior name.
	(Smalltalk classOrTraitNamed: aTraitName) ifNotNil: [ :aClassOrTrait |
		aClassOrTrait isTrait ifTrue: [ 
			self ensureTraitNamed: aTraitName inBehavior: aRGBehavior ] ]
]
