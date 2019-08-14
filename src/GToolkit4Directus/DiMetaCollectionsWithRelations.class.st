Class {
	#name : #DiMetaCollectionsWithRelations,
	#superclass : #Object,
	#instVars : [
		'collections',
		'relations'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #building }
DiMetaCollectionsWithRelations >> buildModelInPackage: aRPackage [
	DiCollectionToClassBuilder new
		collections: self collections;
		package: aRPackage;
		build
]

{ #category : #building }
DiMetaCollectionsWithRelations >> buildRelations [
	DiCollectionRelationBuilder new
		collections: self collections;
		relations: self relations;
		build.
]

{ #category : #accessing }
DiMetaCollectionsWithRelations >> collections [
	^ collections
]

{ #category : #accessing }
DiMetaCollectionsWithRelations >> collections: anObject [
	collections := anObject
]

{ #category : #'gt-extension' }
DiMetaCollectionsWithRelations >> gtDataFor: aView [
	<gtView>
	self collections ifNil: [ ^ aView empty ].
	^ self collections gtDataFor: aView
]

{ #category : #'gt-extension' }
DiMetaCollectionsWithRelations >> gtUMLFor: aView [
	<gtView>
	self collections ifNil: [ ^ aView empty ].
	^ self collections gtUMLFor: aView
]

{ #category : #testing }
DiMetaCollectionsWithRelations >> isSuccess [
	"Polymorphic to ${method:ZnResponse>>#isSuccess}$.
	This is likely not an optimal solution."
	^ true
]

{ #category : #accessing }
DiMetaCollectionsWithRelations >> relations [
	^ relations
]

{ #category : #accessing }
DiMetaCollectionsWithRelations >> relations: anObject [
	relations := anObject
]
