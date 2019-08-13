Class {
	#name : #DiMetaRelation,
	#superclass : #DiMetaModel,
	#instVars : [
		'fieldOne',
		'junctionField',
		'collectionMany',
		'fieldMany',
		'collectionOne'
	],
	#category : #GToolkit4Directus
}

{ #category : #accessing }
DiMetaRelation >> collectionMany [
	^ collectionMany
]

{ #category : #accessing }
DiMetaRelation >> collectionMany: anObject [
	collectionMany := anObject
]

{ #category : #accessing }
DiMetaRelation >> collectionOne [
	^ collectionOne
]

{ #category : #accessing }
DiMetaRelation >> collectionOne: anObject [
	collectionOne := anObject
]

{ #category : #accessing }
DiMetaRelation >> fieldMany [
	^ fieldMany
]

{ #category : #accessing }
DiMetaRelation >> fieldMany: anObject [
	fieldMany := anObject
]

{ #category : #accessing }
DiMetaRelation >> fieldOne [
	^ fieldOne
]

{ #category : #accessing }
DiMetaRelation >> fieldOne: anObject [
	fieldOne := anObject
]

{ #category : #accessing }
DiMetaRelation >> junctionField [
	^ junctionField
]

{ #category : #accessing }
DiMetaRelation >> junctionField: anObject [
	junctionField := anObject
]

{ #category : #printing }
DiMetaRelation >> printOn: aStream [
	aStream 
		nextPutAll: 'Relation from ';
		print: self fieldOne;
		nextPutAll: ' in collection ';
		print: self collectionOne;
		nextPutAll: ' to field ';
		print: self fieldMany ;
		nextPutAll: ' in collection ';
		print: self collectionMany;
		nextPutAll: ' junction field ';
		print: self junctionField.
]
