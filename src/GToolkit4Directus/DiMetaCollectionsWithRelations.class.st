"
I keep both, {{gtClass:DiMetaCollections}} and {{gtClass:DiMetaRelations}} instances.
I am able to update the relations in {{gtClass:DiMetaField}} instances, using {{gtMethod:DiMetaCollectionsWithRelations>>#buildRelations}}.


"
Class {
	#name : 'DiMetaCollectionsWithRelations',
	#superclass : 'Object',
	#instVars : [
		'collections',
		'relations'
	],
	#category : 'GToolkit4Directus-Meta Model'
}

{ #category : 'building' }
DiMetaCollectionsWithRelations >> buildRelations [
	DiMetaModelRelationBuilder new
		collections: self collections;
		relations: self relations;
		build.
]

{ #category : 'accessing' }
DiMetaCollectionsWithRelations >> collections [
	^ collections
]

{ #category : 'accessing' }
DiMetaCollectionsWithRelations >> collections: anObject [
	collections := anObject
]

{ #category : 'enumerating' }
DiMetaCollectionsWithRelations >> collectionsDo: aBlockClosure [ 
	"Enumerate collections"
	self collections collectionsDo: aBlockClosure 
]

{ #category : 'gt-extension' }
DiMetaCollectionsWithRelations >> gtCollectionsFor: aView [
	<gtView>
	self collections ifNil: [ ^ aView empty ].
	^ self collections gtDataFor: aView
]

{ #category : 'gt-extension' }
DiMetaCollectionsWithRelations >> gtRelationsFor: aView [
	<gtView>
	self relations ifNil: [ ^ aView empty ].
	^ self relations gtDataFor: aView
]

{ #category : 'gt-extension' }
DiMetaCollectionsWithRelations >> gtUMLFor: aView [
	<gtView>
	self collections ifNil: [ ^ aView empty ].
	^ self collections gtUMLFor: aView
]

{ #category : 'testing' }
DiMetaCollectionsWithRelations >> isSuccess [
	"Polymorphic to ${method:ZnResponse>>#isSuccess}$.
	This is likely not an optimal solution."
	^ true
]

{ #category : 'accessing' }
DiMetaCollectionsWithRelations >> relations [
	^ relations
]

{ #category : 'accessing' }
DiMetaCollectionsWithRelations >> relations: anObject [
	relations := anObject
]
