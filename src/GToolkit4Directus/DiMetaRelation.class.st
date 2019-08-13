"
I represent a relation between ${class:DiMetaField}$ objects.

Example: ${example:DiExamples>>#metaRelationOfFieldManyRole|noCode=true|previewHeight=500}$


"
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
	#category : #'GToolkit4Directus-Meta Model'
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

{ #category : #'gt-extension' }
DiMetaRelation >> gtRelationFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Description';
		items: [ OrderPreservingDictionary new
			at: 'Relation from' put: self fieldOne;
			at: 'In one-collection' put: self collectionOne;
			at: 'To field' put: self fieldMany;
			at: 'In many-collection' put: self collectionMany;
			at: 'Junction field' put: self junctionField;
			associations ];
		column: 'Description' item: [ :anAssoc | anAssoc key ];
		column: 'Value' item: [ :anAssoc | anAssoc value ]
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
