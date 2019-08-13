"
I represent an object field (an instance variable description), describing its name and type.

A JSON representation of me: ${example:DiExamples>>#metaFieldOfNameStonJson|noCode=true}$

An object representation of the JSON string above: ${example:DiExamples>>#metaFieldOfName|noCode=true}$


"
Class {
	#name : #DiMetaField,
	#superclass : #DiMetaModel,
	#instVars : [
		'note',
		'type',
		'name'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #accessing }
DiMetaField >> collectionNameOrType [
	<return: #String>
	^ self collection ifNotNil: [ :aCollection | aCollection collection ] ifNil: [ self type ]
]

{ #category : #testing }
DiMetaField >> isRelatedToCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self type isRelatedToCollection: aDiMetaCollection
]

{ #category : #accessing }
DiMetaField >> name [
	^ name
]

{ #category : #accessing }
DiMetaField >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DiMetaField >> note [
	^ note
]

{ #category : #accessing }
DiMetaField >> note: anObject [
	note := anObject
]

{ #category : #printing }
DiMetaField >> printOn: aStream [
	self name ifNil: [ ^ super printOn: aStream ].
	self type ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Field ';
		print: self name;
		nextPutAll: ' of type ';
		print: self type name
]

{ #category : #accessing }
DiMetaField >> type [
	^ type
]

{ #category : #accessing }
DiMetaField >> type: anObject [
	type := anObject
]

{ #category : #accessing }
DiMetaField >> typeName [
	<return: #String>
	^ self type name
]
