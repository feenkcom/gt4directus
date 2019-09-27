Class {
	#name : #Di2TraitDiscoveryExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
Di2TraitDiscoveryExtension >> build [
	self collectionsAndModelsDo: [ :aCollection :aBehavior | 
		self mayUseSystemTraitInBehavior: aBehavior ofCollection: aCollection
	].
]

{ #category : #building }
Di2TraitDiscoveryExtension >> mayUseSystemTraitInBehavior: aRGBehavior ofCollection: aDiMetaCollection [ 
	| aTraitName |
	aTraitName := 'T', aRGBehavior name.
	(Smalltalk classOrTraitNamed: aTraitName) ifNotNil: [ :aClassOrTrait |
		aClassOrTrait isTrait ifTrue: [ 
			self modelBuilder ensureTraitNamed: aTraitName inBehavior: aRGBehavior ] ]
]
