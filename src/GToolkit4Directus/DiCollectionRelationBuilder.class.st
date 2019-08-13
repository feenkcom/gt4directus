Class {
	#name : #DiCollectionRelationBuilder,
	#superclass : #Object,
	#instVars : [
		'collections',
		'relations'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #building }
DiCollectionRelationBuilder >> build [
	self buildOneToManyRelations.
]

{ #category : #building }
DiCollectionRelationBuilder >> buildOneToManyRelations [
	self collections data do: [ :eachCollection | 
		eachCollection fields fields do: [ :eachField |
			eachField isOneToMany ifTrue: [ self relateOneToManyForCollection: eachCollection field: eachField ].
			eachField isManyToOne ifTrue: [ self relateManyToOneForCollection: eachCollection field: eachField ].
			 ] ].


	"self relations data do: [ :eachRelation | 
		| aCollectionOne aCollectionMany |
		aCollectionOne := self collections data detect: [ :eachCollection | 
			eachCollection collection = eachRelation collectionOne ]. 
		aCollectionMany := self collections data detect: [ :eachCollection | 
			eachCollection collection = eachRelation collectionMany ].
		
		
		 ]
"
"	self collections data do: [ :eachCollection | 
		| theRelations theCollections |
		theRelations := self relations selectCollectionOneNamed: eachCollection collection.
		theCollections := self collections selectInCollectionManyRelations: theRelations.
		theCollections"
]

{ #category : #accessing }
DiCollectionRelationBuilder >> collections [
	^ collections
]

{ #category : #accessing }
DiCollectionRelationBuilder >> collections: anObject [
	collections := anObject
]

{ #category : #accessing }
DiCollectionRelationBuilder >> relations [
	^ relations
]

{ #category : #accessing }
DiCollectionRelationBuilder >> relations: anObject [
	relations := anObject
]
