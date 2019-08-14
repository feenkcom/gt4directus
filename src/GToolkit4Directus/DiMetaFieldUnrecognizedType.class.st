Class {
	#name : #DiMetaFieldUnrecognizedType,
	#superclass : #DiMetaFieldType,
	#instVars : [
		'name'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldUnrecognizedType class >> matchesName: aString [
	<return: #Boolean>
	^ false
]

{ #category : #testing }
DiMetaFieldUnrecognizedType >> isUnrecognized [
	^ true
]

{ #category : #accessing }
DiMetaFieldUnrecognizedType >> jsonName [
	<return: #String>
	^ name
]

{ #category : #accessing }
DiMetaFieldUnrecognizedType >> name [
	<return: #String>
	^ name 
		ifNotNil: [ :aString | aString, ' (?)' ]
		ifNil: [ '<unspeficied type>' ]
]

{ #category : #accessing }
DiMetaFieldUnrecognizedType >> name: anObject [
	name := anObject
]