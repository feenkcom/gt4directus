"
I update meta-model.
I add coresponding ${class:DiCollection}$ and ${class:DiRelation}$ meta-model objects in to ${class:DiMetaFieldTypeManyToOne}$ and ${class:DiMetaFieldTypeOneToMany}$ objects.
"
Class {
	#name : #DiMetaModelRelationBuilder,
	#superclass : #Object,
	#instVars : [
		'collections',
		'relations'
	],
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiMetaModelRelationBuilder >> build [
	self collections data do: [ :eachCollection | 
		eachCollection fields fields do: [ :eachField |
			eachField type isOneToMany ifTrue: [ self relateOneToManyForCollection: eachCollection field: eachField ].
			eachField type isManyToOne ifTrue: [ self relateManyToOneForCollection: eachCollection field: eachField ].
			 ] ].
]

{ #category : #accessing }
DiMetaModelRelationBuilder >> collections [
	^ collections
]

{ #category : #accessing }
DiMetaModelRelationBuilder >> collections: anObject [
	collections := anObject
]

{ #category : #building }
DiMetaModelRelationBuilder >> relateManyToOneForCollection: aDiMetaCollection field: aDiMetaField [ 
	| aRelation aCollection |
	aRelation := self relations data 
		detect: [ :eachRelation | 
			eachRelation collectionMany = aDiMetaCollection name and: [ 
				eachRelation fieldMany = aDiMetaField name ] ]
		ifNone: [ ^ self ].
	aCollection := self collections data detect: [ :eachCollection | 
		aRelation collectionOne = eachCollection name ].
	aDiMetaField type 
		collection: aCollection;
		relation: aRelation.
]

{ #category : #building }
DiMetaModelRelationBuilder >> relateOneToManyForCollection: aDiMetaCollection field: aDiMetaField [ 
	| aRelation aCollection |
	aRelation := self relations data detect: [ :eachRelation | 
						eachRelation collectionOne = aDiMetaCollection name and: [ 
							eachRelation fieldOne = aDiMetaField name ] ].
	aCollection := self collections data detect: [ :eachCollection | 
		aRelation collectionMany = eachCollection name ].
	aDiMetaField type 
		collection: aCollection;
		relation: aRelation
]

{ #category : #accessing }
DiMetaModelRelationBuilder >> relations [
	^ relations
]

{ #category : #accessing }
DiMetaModelRelationBuilder >> relations: anObject [
	relations := anObject
]
