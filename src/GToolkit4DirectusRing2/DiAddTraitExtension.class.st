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
