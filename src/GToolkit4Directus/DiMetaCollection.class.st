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
DiMetaCollection >> gtCanDisplayField: aFieldOne before: aFieldTwo [
	(aFieldOne isSystemField and: [ aFieldTwo isSystemField not ]) ifTrue: [ ^ false ].
	(aFieldOne isSystemField not and: [ aFieldTwo isSystemField ]) ifTrue: [ ^ true ].
	^ aFieldOne name < aFieldTwo name
]

{ #category : #'gt-extension' }
DiMetaCollection >> gtElementsFor: aView [
	<gtView>
	| elements cachedElements aList |
	cachedElements := modelBuilder getElementsFromCache.
	elements := cachedElements itemsAt: (self name).
	elements ifNil: [ ^ aView empty ].
	aList := aView columnedList
		title: 'Elements';
		priority: 1;
		items: [ elements ].

	aList column
		title: 'Index' translated;
		width: 30;
		item: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray].
	
	aList column
		title: 'Item' translated;
		item: [ :eachItem :eachIndex | eachItem ];
		itemFormat: [ :eachItem | eachItem gtDisplayText ].
	
	^ aList
]

{ #category : #'gt-extension' }
DiMetaCollection >> gtFieldsFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Fields';
		priority: 3;
		items: [ self fields ];
		column: 'Name' item: [ :aField | aField name ];
		column: 'Type' item: [ :aField | aField type ifNotNil: #name ];
		column: 'Unique' item: [ :aField | aField unique ifTrue: [ 'unique' ] ifFalse: [ '' ] ] width: 50;
		column: 'Required' item: [ :aField | aField required ifTrue: [ 'required' ] ifFalse: [ '' ] ] width: 50
]

{ #category : #accessing }
DiMetaCollection >> gtNoteFor: aView [
	<gtView>
	note ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Note';
		priority: 3;
		glamorousCodeFont;
		text: [ self note ]
]

{ #category : #'as yet unclassified' }
DiMetaCollection >> gtQueryFor: aView [
	<gtView>
	| formElement queryInputElement toolbar playInspectButton snippetContainer labelElement text |
	^ aView explicit
		title: 'GraphQL Query';
		priority: 2;
		stencil: [
			formElement := BlElement new.
			formElement constraintsDo: [ :c |  
				c vertical fitContent.
				c horizontal matchParent ].
			formElement layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10).
	
			labelElement := BrLabel new text: 'GraphQL query:'; look: BrGlamorousLabelLook.
			labelElement constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c grid vertical alignCenter ].
			queryInputElement := BrEditorElement new.
			queryInputElement look: BrGlamorousInputFieldSpacingAptitude.
			queryInputElement constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal matchParent.
				c grid vertical alignCenter ].
			text := '' asRopedText 
				weight: 400;
				fontName: 'Source Sans Pro';
				fontSize: 14.
			queryInputElement editor: (BrTextEditor new text: text).
			formElement addChild: labelElement.
			formElement addChild: queryInputElement.
	
			toolbar := BrToolbar new
				look: BrToolbarAptitude new;
				layout: (BlGridLayout horizontal rowCount: 5; cellSpacing: 10);
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ].
			playInspectButton := BrButton new.
			playInspectButton 
				beSmall;
				look: BrGlamorousButtonWithIconAptitude;
				label: 'Run query';
				icon: BrGlamorousIcons playinspect asElement;
				action: [ 
					"playInspectButton phlow spawnObject: metaModel collections." ].
			toolbar addItem: playInspectButton.
	
			snippetContainer := BrVerticalPane new
				vFitContent;
				hMatchParent;
				addChildren: { formElement. toolbar }.

			BrFrame new
				vFitContent;
				hMatchParent;
				look: (GtSnippetContainerAptitude new snippet: self);
				addChild: snippetContainer
	].
]

{ #category : #'gt-extension' }
DiMetaCollection >> gtSortedFields [
	^ self fields sorted: [ :a :b | self gtCanDisplayField: a before: b ].
]

{ #category : #'gt-extension' }
DiMetaCollection >> gtUMLFor: aView [
	<gtView>
	self fields ifNil: [ ^ aView empty ].
	^ aView mondrian 
		title: 'UML';
		priority: 2;
		painting: [ :aMondrian | 
			aMondrian nodes 
				umlClassShapeWithName: [ :eachMetaCollection | eachMetaCollection name ];
				with: { self };
				forEach: [ :eachMetaCollection | 
					aMondrian nodes 
						shape: [ :eachMetaField | 
							| aText | 
							aText := DiUMLMetaFieldNameAndTypeGenerator new field: eachMetaField; text.
							BlTextElement new text: aText ];
						with: (eachMetaCollection gtSortedFields).
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

{ #category : #'accessing - model' }
DiMetaCollection >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ (aDiNamingStrategy collectionModelName: self) asSymbol
]
