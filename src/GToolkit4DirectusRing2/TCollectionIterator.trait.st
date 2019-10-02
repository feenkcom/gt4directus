Trait {
	#name : #TCollectionIterator,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #filtering }
TCollectionIterator >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self filters allSatisfy: [ :eachFilter | 
		eachFilter canIncludeCollection: aDiMetaCollection ]
]

{ #category : #filtering }
TCollectionIterator >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ self filters allSatisfy: [ :eachFilter | 
		eachFilter canIncludeCollection: aDiMetaCollection field: aDiMetaField ]
]

{ #category : #accessing }
TCollectionIterator >> collections [
	<return: #Collection>
	^ self explicitRequirement
]

{ #category : #enumerating }
TCollectionIterator >> collectionsAndFieldsAndModelsDo: aBlockClosure [ 
	self collectionsAndModelsDo: [ :eachCollection :eachClass |
		eachCollection fields do: [ :eachField |
			aBlockClosure cull: eachCollection cull: eachField cull: eachClass ] ].
]

{ #category : #enumerating }
TCollectionIterator >> collectionsAndModelsDo: aBlockClosure [ 
	self collectionsDo: [ :eachCollection | 
		| eachClass |
		eachClass := self existingCollectionBehaviorOrNil: eachCollection.
		eachClass ifNotNil: [ aBlockClosure cull: eachCollection cull: eachClass ]
	]
]

{ #category : #enumerating }
TCollectionIterator >> collectionsDo: aBlockClosure [ 
	self collections do: aBlockClosure
]

{ #category : #'accessing - model' }
TCollectionIterator >> existingCollectionBehaviorOrNil: aDiMetaCollection [
	^ self explicitRequirement
]

{ #category : #accessing }
TCollectionIterator >> filtres [
	<return: #Collection>
	^ self explicitRequirement
]

{ #category : #enumerating }
TCollectionIterator >> includedCollection: aDiMetaCollection fieldsDo: aDoBlock [
	aDiMetaCollection fields do: [ :eachField | 
		(self canIncludeCollection: aDiMetaCollection field: eachField) ifTrue: [ 
			aDoBlock cull: eachField ] ]
]

{ #category : #enumerating }
TCollectionIterator >> includedCollection: aDiMetaCollection fieldsDo: aDoBlock separatedBy: aSeparatorBlock [
	| aBeforeFirst | 
	aBeforeFirst := true.
	self includedCollection: aDiMetaCollection fieldsDo: [ :eachField | 
		aBeforeFirst
			ifTrue: [ aBeforeFirst := false ]
			ifFalse: [ aSeparatorBlock value ].
		aDoBlock cull: eachField ]
]

{ #category : #enumerating }
TCollectionIterator >> includedCollectionsAndFieldsAndModelsDo: aBlockClosure [ 
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass |
		eachCollection fields do: [ :eachField |
			(self canIncludeCollection: eachCollection field: eachField) ifTrue: [ 
				aBlockClosure cull: eachCollection cull: eachField cull: eachClass ] ] ].
]

{ #category : #enumerating }
TCollectionIterator >> includedCollectionsAndModelsDo: aBlockClosure [ 
	self includedCollectionsDo: [ :eachCollection | 
		| eachClass |
		eachClass := self existingCollectionBehaviorOrNil: eachCollection.
		eachClass ifNotNil: [ aBlockClosure cull: eachCollection cull: eachClass ]
	]
]

{ #category : #enumerating }
TCollectionIterator >> includedCollectionsDo: aBlockClosure [ 
	self collectionsDo: [ :eachCollection | 
		(self canIncludeCollection: eachCollection) ifTrue: [ 
			aBlockClosure cull: eachCollection ] ]
]
