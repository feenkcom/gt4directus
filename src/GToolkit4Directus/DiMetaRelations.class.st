"
I keep all ${class:DiMetaRelation}$ objects.

Example with two ${class:DiMetaRelation}$ instances: ${example:DiExamples>>#metaRelationsOfFieldManyUserAndRole|noCode}$


"
Class {
	#name : #DiMetaRelations,
	#superclass : #DiMetaModel,
	#instVars : [
		'data'
	],
	#category : #GToolkit4Directus
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

{ #category : #convenient }
DiMetaRelations >> numberOfData [
	^ self data size
]
