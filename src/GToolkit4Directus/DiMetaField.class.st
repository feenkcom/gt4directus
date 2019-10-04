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
DiMetaField class >> systemFieldNames [
	^ #('created_by' 'created_on' 'modified_by' 'modified_on' 'updated_on' 'updated_by' 'status')
]

{ #category : #accessing }
DiMetaField >> collectionOrNil [
	<return: #DiMetaCollection or: nil>
	^ self type collectionOrNil
]

{ #category : #'accessing - model' }
DiMetaField >> getter [
	"Return a Smalltalk getter name (method name)"
	<return: #String>
	^ String streamContents: [ :aStream | 
		| aFirstChar | 
		aFirstChar := false.
		self name do: [ :eachCharacter | 
			eachCharacter isLetter 
				ifFalse: [ aFirstChar := true ]
				ifTrue: [ aFirstChar 
					ifTrue: [ 
						aStream nextPut: eachCharacter asUppercase. 
						aFirstChar := false. ]
					ifFalse: [ 
						aStream nextPut: eachCharacter ] ] ] ]
]

{ #category : #testing }
DiMetaField >> isRelatedToCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self type isRelatedToCollection: aDiMetaCollection
]

{ #category : #testing }
DiMetaField >> isSystemField [
	<return: #Boolean>
	^ self class systemFieldNames includes: self name
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

{ #category : #'accessing - model' }
DiMetaField >> setter [
	"Return a Smalltalk setter name (method name)"
	<return: #String>
	^ self getter, ':'
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
