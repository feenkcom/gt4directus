"
I represent a description of an object (database table).
I use ${class:DiMetaFields}$ to keep all information about my fields (instance variables).

Example: ${example:DiExamples>>#metaCollection|noCode=true|previewHeight=500}$


"
Class {
	#name : #DiMetaCollection,
	#superclass : #DiMetaModel,
	#instVars : [
		'single',
		'collection',
		'icon',
		'fields',
		'translation',
		'note',
		'hidden',
		'managed'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #enumerating }
DiMetaCollection >> collectFieldsRelatedToCollection: aDiMetaCollection [
	<return: #Array of: #DiMetaField>
	^ self fields collectFieldsRelatedToCollection: aDiMetaCollection
]

{ #category : #enumerating }
DiMetaCollection >> fieldNamed: aString [
	<return: #DiMetaField>
	^ self fields fieldNamed: aString
]

{ #category : #accessing }
DiMetaCollection >> fields [
	^ fields
]

{ #category : #accessing }
DiMetaCollection >> fields: anObject [
	fields := anObject
]

{ #category : #'gt-extension' }
DiMetaCollection >> gtFieldsFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ self fields gtFieldsFor: aView
]

{ #category : #accessing }
DiMetaCollection >> hidden [
	^ hidden
]

{ #category : #accessing }
DiMetaCollection >> hidden: anObject [
	hidden := anObject
]

{ #category : #accessing }
DiMetaCollection >> icon [
	^ icon
]

{ #category : #accessing }
DiMetaCollection >> icon: anObject [
	icon := anObject
]

{ #category : #testing }
DiMetaCollection >> includesFieldOfType: aType [
	<return: #Boolean>
	^ self fields includesFieldOfType: aType
]

{ #category : #initialization }
DiMetaCollection >> initialize [
	super initialize.
	collection := '<uninitialized name>'.
	fields := #().
	hidden := false.
	icon := 'question'.
	managed := true.
	note := ''.
	single := false.
	translation := nil.
]

{ #category : #testing }
DiMetaCollection >> isSystemCollection [
	<return: #Boolean>
	^ self name beginsWith: 'directus_'
]

{ #category : #accessing }
DiMetaCollection >> managed [
	^ managed
]

{ #category : #accessing }
DiMetaCollection >> managed: anObject [
	managed := anObject
]

{ #category : #'accessing - model' }
DiMetaCollection >> modelClassName [
	"Return a model class name representing the collection.
	The name is without a possible class prefix."
	<return: #String>
	^ String streamContents: [ :aStream | 
		self printModelClassNameOn: aStream ]
]

{ #category : #accessing }
DiMetaCollection >> name [
	^ collection
]

{ #category : #accessing }
DiMetaCollection >> name: anObject [
	collection := anObject
]

{ #category : #accessing }
DiMetaCollection >> note [
	^ note
]

{ #category : #accessing }
DiMetaCollection >> note: anObject [
	note := anObject
]

{ #category : #convenience }
DiMetaCollection >> numberOfFields [
	<return: #Integer>
	^ self fields numberOfFields
]

{ #category : #printing }
DiMetaCollection >> printModelClassNameOn: aStream [
	| aFirstChar | 
	aFirstChar := true.
	self name do: [ :eachCharacter | 
		eachCharacter isLetter 
			ifFalse: [ aFirstChar := true ]
			ifTrue: [ aFirstChar 
				ifTrue: [ 
					aStream nextPut: eachCharacter asUppercase. 
					aFirstChar := false. ]
				ifFalse: [ 
					aStream nextPut: eachCharacter ] ] ]
]

{ #category : #printing }
DiMetaCollection >> printOn: aStream [
	self name ifNil: [ super printOn: aStream. ^ self ].
	aStream 
		nextPutAll: 'Collection of ';
		print: self name
]

{ #category : #accessing }
DiMetaCollection >> single [
	^ single
]

{ #category : #accessing }
DiMetaCollection >> single: anObject [
	single := anObject
]

{ #category : #accessing }
DiMetaCollection >> translation [
	^ translation
]

{ #category : #accessing }
DiMetaCollection >> translation: anObject [
	translation := anObject
]
