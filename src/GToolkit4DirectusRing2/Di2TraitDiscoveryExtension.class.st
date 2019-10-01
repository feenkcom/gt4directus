Class {
	#name : #Di2TraitDiscoveryExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
Di2TraitDiscoveryExtension >> build [
	self includedCollectionsAndModelsDo: [ :aCollection :aBehavior | 
		self mayUseSystemTraitInBehavior: aBehavior ofCollection: aCollection
	].
]

{ #category : #building }
Di2TraitDiscoveryExtension >> mayUseSystemTraitInBehavior: aRGBehavior ofCollection: aDiMetaCollection [ 
	| aTraitName |
	aTraitName := 'T', aRGBehavior name.
	(Smalltalk classOrTraitNamed: aTraitName) ifNotNil: [ :aClassOrTrait |
		aClassOrTrait isTrait ifTrue: [ 
			self ensureTraitNamed: aTraitName inBehavior: aRGBehavior ] ]
]
