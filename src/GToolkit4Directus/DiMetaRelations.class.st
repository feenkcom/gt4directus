"
I keep all {{gtClass:DiMetaRelation}} objects.

Example with two {{gtClass:DiMetaRelation}} instances: {{gtExample:DiExamples>>#metaRelationsOfFieldManyUserAndRole|noCode}}


"
Class {
	#name : #DiMetaRelations,
	#superclass : #DiMetaModel,
	#instVars : [
		'data'
	],
	#category : 'GToolkit4Directus-Meta Model'
}

{ #category : #accessing }
DiMetaRelations >> data [
	^ data
]

{ #category : #accessing }
DiMetaRelations >> data: anObject [
	data := anObject
]

{ #category : #'gt-extension' }
DiMetaRelations >> gtDataFor: aView [
	<gtView>
	self data ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Relations';
		items: [ self data ]
]

{ #category : #initialization }
DiMetaRelations >> initialize [
	super initialize.
	data := #().
]

{ #category : #convenient }
DiMetaRelations >> numberOfData [
	^ self data size
]

{ #category : #enumerating }
DiMetaRelations >> selectCollectionOneNamed: aString [ 
	<return: #Array of: #DiMetaRelation>
	^ self data select: [ :eachRelation | eachRelation collectionOne = aString ]
]
