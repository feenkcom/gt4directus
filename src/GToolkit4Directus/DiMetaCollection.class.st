"
I represent a description of an object (database table).
I keep collection of ${class:DiMetaField}$ (instance variables).

Example: ${example:DiExamples>>#metaCollection|noCode=true|previewHeight=500}$


"
Class {
	#name : #DiMetaCollection,
	#superclass : #DiMetaModel,
	#instVars : [
		'single',
		'icon',
		'fields',
		'translation',
		'note',
		'hidden',
		'managed',
		'name'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #enumerating }
DiMetaCollection >> collectFieldsRelatedToCollection: aDiMetaCollection [
	<return: #Array of: #DiMetaField>
	^ self fields select: [ :eachField | 
		eachField isRelatedToCollection: aDiMetaCollection ]
]

{ #category : #enumerating }
DiMetaCollection >> fieldNamed: aString [
	<return: #DiMetaField>
	^ self fields detect: [ :eachField | eachField name = aString ]
]

{ #category : #accessing }
DiMetaCollection >> fields [
	^ fields
]

{ #category : #accessing }
DiMetaCollection >> fields: anArray [
	self 
		assert: [ anArray isNotNil ] 
		description: [ 'Fields must be a non-nil' ].
	fields := anArray
]

{ #category : #'gt-extension' }
DiMetaCollection >> gtFieldsFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Fields';
		items: [ self fields ];
		column: 'Name' item: [ :aField | aField name ];
		column: 'Type' item: [ :aField | aField type ifNotNil: #name ]
]

{ #category : #'gt-extension' }
DiMetaCollection >> gtUMLFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ aView mondrian 
		title: 'UML';
		priority: 1;
		painting: [ :aMondrian | 
			aMondrian nodes 
				umlClassShapeWithName: [ :eachMetaCollection | eachMetaCollection name ];
				with: { self };
				forEach: [ :eachMetaCollection | 
					aMondrian nodes 
						shape: [ :eachMetaField | 
							| aText | 
							aText := (eachMetaField name asString, ': ', eachMetaField type name asString) asRopedText.
							(aText from: eachMetaField name size + 2 to: aText size) foreground: Color lightGray.
							BlTextElement new text: aText ];
						with: eachMetaCollection fields.
					aMondrian layout custom: BlLinearLayout vertical ].
		]
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
	^ self fields anySatisfy: [ :eachField | eachField type = aType ]
]

{ #category : #initialization }
DiMetaCollection >> initialize [
	super initialize.
	name := '<uninitialized name>'.
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
	^ name
]

{ #category : #accessing }
DiMetaCollection >> name: anObject [
	name := anObject
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
	^ self fields size
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
