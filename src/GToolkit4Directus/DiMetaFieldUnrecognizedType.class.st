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

{ #category : #visitor }
DiMetaFieldUnrecognizedType >> accept: aVisitor [
	^ aVisitor visitDiMetaFieldUnrecognizedType: self
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
]

{ #category : #accessing }
DiMetaFieldUnrecognizedType >> name: anObject [
	name := anObject
]

{ #category : #'accessing - model' }
DiMetaFieldUnrecognizedType >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ Object name asSymbol
]
