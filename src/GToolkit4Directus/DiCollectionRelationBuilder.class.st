Class {
	#name : #DiCollectionRelationBuilder,
	#superclass : #Object,
	#instVars : [
		'collections',
		'relations'
	],
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiCollectionRelationBuilder >> build [
	self collections data do: [ :eachCollection | 
		eachCollection fields fields do: [ :eachField |
			eachField type isOneToMany ifTrue: [ self relateOneToManyForCollection: eachCollection field: eachField ].
			eachField type isManyToOne ifTrue: [ self relateManyToOneForCollection: eachCollection field: eachField ].
			 ] ].
]

{ #category : #accessing }
DiCollectionRelationBuilder >> collections [
	^ collections
]

{ #category : #accessing }
DiCollectionRelationBuilder >> collections: anObject [
	collections := anObject
]

{ #category : #building }
DiCollectionRelationBuilder >> relateManyToOneForCollection: aDiMetaCollection field: aDiMetaField [ 
	| aRelation aCollection |
	aRelation := self relations data 
		detect: [ :eachRelation | 
			eachRelation collectionMany = aDiMetaCollection name and: [ 
				eachRelation fieldMany = aDiMetaField name ] ]
		ifNone: [ ^ self ].
	aCollection := self collections data detect: [ :eachCollection | 
		aRelation collectionOne = eachCollection name ].
	aDiMetaField type collection: aCollection.
]

{ #category : #building }
DiCollectionRelationBuilder >> relateOneToManyForCollection: aDiMetaCollection field: aDiMetaField [ 
	| aRelation aCollection |
	aRelation := self relations data detect: [ :eachRelation | 
						eachRelation collectionOne = aDiMetaCollection name and: [ 
							eachRelation fieldOne = aDiMetaField name ] ].
	aCollection := self collections data detect: [ :eachCollection | 
		aRelation collectionMany = eachCollection name ].
	aDiMetaField type collection: aCollection.
]

{ #category : #accessing }
DiCollectionRelationBuilder >> relations [
	^ relations
]

{ #category : #accessing }
DiCollectionRelationBuilder >> relations: anObject [
	relations := anObject
]
