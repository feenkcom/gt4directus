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
		items: [ | aDictionary | 
			aDictionary := OrderPreservingDictionary new.
			aDictionary at: 'Relation from one-collection' put: self collectionOne.
			self fieldOne ifNotNil: [ aDictionary at: 'and one-filed' put: self fieldOne ].
			aDictionary
				at: 'to many-collection' put: self collectionMany;
				at: 'and many-field' put: self fieldMany.
			self junctionField ifNotNil: [ aDictionary at: 'using junction field' put: self junctionField ].
			aDictionary associations ];
		column: 'Description' item: [ :anAssoc | anAssoc key ];
		column: 'Value' item: [ :anAssoc | anAssoc value ];
		send: [ :anAssoc | anAssoc value ]
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
	self collectionOne ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Relation from ';
		nextPutAll: self collectionOne.
	self fieldOne ifNotNil: [ 
		aStream 
			nextPutAll: '>';
			nextPutAll: self fieldOne ].
	aStream
		nextPutAll: ' one-to-many ';
		nextPutAll: self collectionMany;
		nextPutAll: '>';
		nextPutAll: self fieldMany.
	self junctionField ifNil: [ ^ self ].
	aStream
		nextPutAll: ', junction field ';
		nextPutAll: self junctionField.
]
