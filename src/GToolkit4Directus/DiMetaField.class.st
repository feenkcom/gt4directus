"
I represent an object field (an instance variable description), describing its name and type.

A JSON representation of me: {{gtExample:DiExamples>>#metaFieldOfNameStonJson|noCode=true}}

An object representation of the JSON string above: {{gtExample:DiExamples>>#metaFieldOfName|noCode=true}}


"
Class {
	#name : 'DiMetaField',
	#superclass : 'DiMetaModel',
	#instVars : [
		'note',
		'type',
		'name',
		'required',
		'unique'
	],
	#category : 'GToolkit4Directus-Meta Model'
}

{ #category : 'accessing' }
DiMetaField class >> systemFieldNames [
	^ #('created_by' 'created_on' 'modified_by' 'modified_on' 'updated_on' 'updated_by')
]

{ #category : 'accessing' }
DiMetaField >> collectionOrNil [
	<return: #DiMetaCollection or: nil>
	^ self type collectionOrNil
]

{ #category : 'accessing - model' }
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

{ #category : 'initialization' }
DiMetaField >> initialize [
	super initialize.
	required := false.
	unique := false.
]

{ #category : 'testing' }
DiMetaField >> isModelType [
	^ self type isModelType
]

{ #category : 'testing' }
DiMetaField >> isRelatedToCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self type isRelatedToCollection: aDiMetaCollection
]

{ #category : 'testing' }
DiMetaField >> isSystemField [
	<return: #Boolean>
	^ self class systemFieldNames includes: self name
]

{ #category : 'accessing' }
DiMetaField >> name [
	<return: #String>
	^ name
]

{ #category : 'accessing' }
DiMetaField >> name: aString [
	name := aString
]

{ #category : 'accessing' }
DiMetaField >> note [
	<return: #String>
	^ note
]

{ #category : 'accessing' }
DiMetaField >> note: aString [
	note := aString
]

{ #category : 'printing' }
DiMetaField >> printOn: aStream [
	self name ifNil: [ ^ super printOn: aStream ].
	self type ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Field ';
		print: self name;
		nextPutAll: ' of type ';
		print: self type name
]

{ #category : 'accessing' }
DiMetaField >> required [
	<return: #Boolean>
	^ required
]

{ #category : 'accessing' }
DiMetaField >> required: aBoolean [
	required := aBoolean
]

{ #category : 'accessing - model' }
DiMetaField >> setter [
	"Return a Smalltalk setter name (method name)"
	<return: #String>
	^ self getter, ':'
]

{ #category : 'accessing' }
DiMetaField >> type [
	<return: #DiMetaFieldType>
	^ type
]

{ #category : 'accessing' }
DiMetaField >> type: aDiMetaFieldType [
	type := aDiMetaFieldType
]

{ #category : 'accessing' }
DiMetaField >> typeName [
	<return: #String>
	^ self type name
]

{ #category : 'accessing - model' }
DiMetaField >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ self type typeNameUsingNaming: aDiNamingStrategy 
]

{ #category : 'accessing' }
DiMetaField >> unique [
	<return: #Boolean>
	^ unique
]

{ #category : 'accessing' }
DiMetaField >> unique: aBoolean [
	unique := aBoolean
]
