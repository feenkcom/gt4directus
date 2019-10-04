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
