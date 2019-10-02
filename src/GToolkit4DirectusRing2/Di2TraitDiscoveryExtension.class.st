Class {
	#name : #Di2TraitDiscoveryExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
Di2TraitDiscoveryExtension >> build [
	self mayUseSystemTraitInBehavior: self modelRootClass. 
	self includedCollectionsAndModelsDo: [ :aCollection :aBehavior | 
		self mayUseSystemTraitInBehavior: aBehavior
	].
]

{ #category : #building }
Di2TraitDiscoveryExtension >> mayUseSystemTraitInBehavior: aRGBehavior [ 
	| aTraitName |
	aTraitName := 'T', aRGBehavior name.
	(Smalltalk classOrTraitNamed: aTraitName) ifNotNil: [ :aClassOrTrait |
		aClassOrTrait isTrait ifTrue: [ 
			self ensureTraitNamed: aTraitName inBehavior: aRGBehavior ] ]
]
