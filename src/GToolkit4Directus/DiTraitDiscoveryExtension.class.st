Class {
	#name : #DiTraitDiscoveryExtension,
	#superclass : #DiCollectionToClassBuilderExtension,
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiTraitDiscoveryExtension >> build [
	self builder modelRootClass withAllSubclassesDo: [ :eachClass | 
		| traitName trait |
		traitName := 'T', eachClass name.
		(Smalltalk hasClassNamed: traitName) ifTrue: [ 
			trait := (Smalltalk classNamed: traitName).
			(eachClass traits includes: trait) ifTrue: [ ^ self ]. 
			eachClass traits 
				ifEmpty: [ eachClass setTraitComposition: trait asTraitComposition ]
				ifNotEmpty: [ eachClass addToComposition: trait asTraitComposition ].
			].
	]
]
