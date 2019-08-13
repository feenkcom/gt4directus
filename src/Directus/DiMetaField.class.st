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
	#category : #'Directus-Meta Model'
}

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
	aStream 
		nextPutAll: 'Field ';
		print: self name;
		nextPutAll: ' of type ';
		print: self type
]

{ #category : #accessing }
DiMetaField >> type [
	^ type
]

{ #category : #accessing }
DiMetaField >> type: anObject [
	type := anObject
]
