Trait {
	#name : #TDiCollectionIterator,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #enumerating }
TDiCollectionIterator >> allModelNames [
	"Return all existing model behavior names (class names)."
	<return: #Set of: #String>
	| aSet |
	aSet := Set new.
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass |
		aSet add: eachClass name ].
	^ aSet
]

{ #category : #filtering }
TDiCollectionIterator >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self filters allSatisfy: [ :eachFilter | 
		eachFilter canIncludeCollection: aDiMetaCollection ]
]

{ #category : #filtering }
TDiCollectionIterator >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ self filters allSatisfy: [ :eachFilter | 
		eachFilter canIncludeCollection: aDiMetaCollection field: aDiMetaField ]
]

{ #category : #accessing }
TDiCollectionIterator >> collections [
	<return: #Collection>
	^ self explicitRequirement
]

{ #category : #enumerating }
TDiCollectionIterator >> collectionsAndFieldsAndModelsDo: aBlockClosure [ 
	self collectionsAndModelsDo: [ :eachCollection :eachClass |
		eachCollection fields do: [ :eachField |
			aBlockClosure cull: eachCollection cull: eachField cull: eachClass ] ].
]

{ #category : #enumerating }
TDiCollectionIterator >> collectionsAndModelsDo: aBlockClosure [ 
	self collectionsDo: [ :eachCollection | 
		| eachClass |
		eachClass := self existingCollectionBehaviorOrNil: eachCollection.
		eachClass ifNotNil: [ aBlockClosure cull: eachCollection cull: eachClass ]
	]
]

{ #category : #enumerating }
TDiCollectionIterator >> collectionsDo: aBlockClosure [ 
	self collections do: aBlockClosure
]

{ #category : #'accessing - model' }
TDiCollectionIterator >> existingCollectionBehaviorOrNil: aDiMetaCollection [
	^ self explicitRequirement
]

{ #category : #accessing }
TDiCollectionIterator >> filters [
	<return: #Collection>
	^ self explicitRequirement
]

{ #category : #testing }
TDiCollectionIterator >> hasModels [
	<return: #Boolean>
	self collectionsAndModelsDo: [ ^ true ].
	^ false
]

{ #category : #enumerating }
TDiCollectionIterator >> includedCollection: aDiMetaCollection fieldsDo: aDoBlock [
	aDiMetaCollection fields do: [ :eachField | 
		(self canIncludeCollection: aDiMetaCollection field: eachField) ifTrue: [ 
			aDoBlock cull: eachField ] ]
]

{ #category : #enumerating }
TDiCollectionIterator >> includedCollection: aDiMetaCollection fieldsDo: aDoBlock separatedBy: aSeparatorBlock [
	| aBeforeFirst | 
	aBeforeFirst := true.
	self includedCollection: aDiMetaCollection fieldsDo: [ :eachField | 
		aBeforeFirst
			ifTrue: [ aBeforeFirst := false ]
			ifFalse: [ aSeparatorBlock value ].
		aDoBlock cull: eachField ]
]

{ #category : #enumerating }
TDiCollectionIterator >> includedCollectionsAndFieldsAndModelsDo: aBlockClosure [ 
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass |
		eachCollection fields do: [ :eachField |
			(self canIncludeCollection: eachCollection field: eachField) ifTrue: [ 
				aBlockClosure cull: eachCollection cull: eachField cull: eachClass ] ] ].
]

{ #category : #enumerating }
TDiCollectionIterator >> includedCollectionsAndModelsDo: aBlockClosure [ 
	self includedCollectionsDo: [ :eachCollection | 
		| eachClass |
		eachClass := self existingCollectionBehaviorOrNil: eachCollection.
		eachClass ifNotNil: [ aBlockClosure cull: eachCollection cull: eachClass ]
	]
]

{ #category : #enumerating }
TDiCollectionIterator >> includedCollectionsDo: aBlockClosure [ 
	self collectionsDo: [ :eachCollection | 
		(self canIncludeCollection: eachCollection) ifTrue: [ 
			aBlockClosure cull: eachCollection ] ]
]
