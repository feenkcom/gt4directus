Class {
	#name : #DiAddTraitToCollectionExtension,
	#superclass : #DiCollectionToClassBuilderExtension,
	#instVars : [
		'traitClass',
		'collectionName'
	],
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiAddTraitToCollectionExtension >> build [
	| aCollection aClassName aClass |
	aCollection := self builder collections 
		detect: [ :eachCollection | eachCollection name = self collectionName ] 
		ifNone: [ ^ self ].
	aClassName := self builder collectionPrefixAndClassName: aCollection.
	aClass := self class environment at: aClassName asSymbol ifAbsent: [ ^ self ].
	(aClass traits includes: self traitClass) ifTrue: [ ^ self ]. 
	EsCompany traits 
		ifEmpty: [ aClass setTraitComposition: self traitClass ]
		ifNotEmpty: [ aClass addToComposition: self traitClass ].
]

{ #category : #accessing }
DiAddTraitToCollectionExtension >> collectionName [
	^ collectionName
]

{ #category : #accessing }
DiAddTraitToCollectionExtension >> collectionName: anObject [
	collectionName := anObject
]

{ #category : #accessing }
DiAddTraitToCollectionExtension >> traitClass [
	^ traitClass
]

{ #category : #accessing }
DiAddTraitToCollectionExtension >> traitClass: anObject [
	traitClass := anObject
]
