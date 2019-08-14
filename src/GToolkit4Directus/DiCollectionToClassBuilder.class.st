Class {
	#name : #DiCollectionToClassBuilder,
	#superclass : #Object,
	#instVars : [
		'collections',
		'package',
		'modelClassPrefix',
		'modelRootClass',
		'jsonMappingClass'
	],
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiCollectionToClassBuilder >> build [
	self collections data do: [ :eachCollection | 
		self buildCollection: eachCollection ].
	self compileJsonMappingMainReadingMethod: self collections.
]

{ #category : #building }
DiCollectionToClassBuilder >> buildCollection: aDiMetaCollection [ 
	| aClassName theSlots aClass |
	aClassName := self collectionClassName: aDiMetaCollection.
	theSlots := self collectionSlots: aDiMetaCollection.
	aClass := self modelRootClass subclass: aClassName asSymbol
		slots: theSlots
		classVariables: {  }
		package: self package name.
	self buildCollection: aDiMetaCollection class: aClass accessors: theSlots.
	self buildJsonMappingForCollection: aDiMetaCollection class: aClass accessors: theSlots.
	self buildJsonMappingForCollectionsOf: aDiMetaCollection class: aClass accessors: theSlots.
]

{ #category : #building }
DiCollectionToClassBuilder >> buildCollection: aDiMetaCollection class: aClass accessors: theSlots [
	theSlots do: [ :eachSlotName | 
		aClass 
			compile: eachSlotName, String cr, String tab, '^ ', eachSlotName 
			classified: 'accessing'.
		aClass 
			compile: eachSlotName, ': anObject', String cr, String tab, eachSlotName, ':= anObject' 
			classified: 'accessing'.
	]
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> buildJsonMappingForCollection: aDiMetaCollection class: aClass accessors: theSlots [ 
	| aJsonMappingClass aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'mappingOf'; nextPutAll: aClass name; nextPutAll: 'For: aNeoJSONMapper'; cr;
			tab; nextPutAll: 'aNeoJSONMapper'; cr;
			tab; tab; nextPutAll: 'for: '; nextPutAll: aClass name; nextPutAll: ' do: [ :mapping |'; cr.
		aDiMetaCollection fields fields paddedWith: theSlots do: [ :eachField :eachSlot | 
			aStream
				tab; tab; tab; nextPutAll: 'mapping mapAccessor: #'; nextPutAll: eachSlot; nextPutAll: ' to: #'; nextPutAll: eachField name; nextPut: $.; cr ].
		aStream
				tab; tab; nextPutAll: '].' ].
	aJsonMappingClass compile: aMethodBody classified: 'mappings - models'.
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> buildJsonMappingForCollectionsOf: aDiMetaCollection class: aClass accessors: theSlots [ 
	| aJsonMappingClass aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'collectionOf'; nextPutAll: aClass name; nextPutAll: 'For: aNeoJSONMapper'; cr;
			tab; nextPutAll: 'aNeoJSONMapper'; cr;
			tab; tab; nextPutAll: 'for: '; nextPutAll: '#CollectionOf'; nextPutAll: aClass name; nextPutAll: ' customDo: [ :mapping |'; cr;
			tab; tab; tab; nextPutAll: 'mapping listOfElementSchema: '; nextPutAll: aClass name; nextPutAll: ' ].'; cr;
			tab; nextPutAll: 'self mappingOf'; nextPutAll: aClass name; nextPutAll: 'For: aNeoJSONMapper.'; cr ].
	aJsonMappingClass compile: aMethodBody classified: 'mappings - collections'.
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> className: aString [ 
	^ String streamContents: [ :aStream | 
		| aFirstChar | 
		aFirstChar := true.
		aString do: [ :eachCharacter | 
			eachCharacter isLetter 
				ifFalse: [ aFirstChar := true ]
				ifTrue: [ aFirstChar 
					ifTrue: [ 
						aStream nextPut: eachCharacter asUppercase. 
						aFirstChar := false. ]
					ifFalse: [ 
						aStream nextPut: eachCharacter ] ] ] ]
]

{ #category : #building }
DiCollectionToClassBuilder >> collectionClassName: aDiMetaCollection [ 
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: self modelClassPrefix;
			nextPutAll: (self className: aDiMetaCollection name)
		]
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> collectionSlotName: aDiMetaField [ 
	^ String streamContents: [ :aStream | 
		| aFirstChar | 
		aFirstChar := false.
		aDiMetaField name do: [ :eachCharacter | 
			eachCharacter isLetter 
				ifFalse: [ aFirstChar := true ]
				ifTrue: [ aFirstChar 
					ifTrue: [ 
						aStream nextPut: eachCharacter asUppercase. 
						aFirstChar := false. ]
					ifFalse: [ 
						aStream nextPut: eachCharacter ] ] ] ]
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> collectionSlots: aDiMetaCollection [ 
	^ Array new: aDiMetaCollection numberOfFields streamContents: [ :aStream |
		aDiMetaCollection fields do: [ :eachField | 
			aStream nextPut: (self collectionSlotName: eachField) ] ]
]

{ #category : #accessing }
DiCollectionToClassBuilder >> collections [
	^ collections
]

{ #category : #accessing }
DiCollectionToClassBuilder >> collections: anObject [
	collections := anObject
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> compileJsonMappingClass [
	| aClass |
	aClass := Object 
		subclass: self modelClassPrefix, 'JsonMapping'
		slots: {  }
		classVariables: {  }
		package: self package name.
	aClass class 
		instanceVariableNames: 'uniqueInstance'.
	aClass class 
		compile: 'uniqueInstance
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]' 
		classified: 'accessing'.
	aClass class 
		compile: 'resetUniqueInstance
	uniqueInstance := nil' 
		classified: 'cleanup'.
	aClass class 
		compile: 'cleanUp
	self resetUniqueInstance' 
		classified: 'cleanup'.
	^ aClass
]

{ #category : #compiling }
DiCollectionToClassBuilder >> compileJsonMappingMainReadingMethod: aDiMetaCollections [ 
	| aJsonMappingClass aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'read: aJsonSchema on: aReadStream'; cr;
			tab; nextPutAll: '| aReader |'; cr;
			tab; nextPutAll: 'aReader := (NeoJSONReader on: aReadStream).'; cr.
		aDiMetaCollections do: [ :eachMetaCollection | 
			| aClassName |
			aClassName := self collectionClassName: eachMetaCollection.
			aStream
				tab; nextPutAll: 'self '; nextPutAll: 'mappingOf'; nextPutAll: aClassName; nextPutAll: 'For: aReader.'; cr;
				tab; nextPutAll: 'self '; nextPutAll: 'collectionOf'; nextPutAll: aClassName; nextPutAll: 'For: aReader.'; cr ].
		aStream
				tab; nextPutAll: '^ aReader nextAs: aJsonSchema.'; cr ].
	aJsonMappingClass compile: aMethodBody classified: 'reading'.
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> compileModelRootClass [
	^ Object 
		subclass: self modelClassPrefix, 'Model'
		slots: {  }
		classVariables: {  }
		package: self package name 
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> jsonMappingClass [
	^ jsonMappingClass ifNil: [ jsonMappingClass := self compileJsonMappingClass ]
]

{ #category : #building }
DiCollectionToClassBuilder >> modelClassPrefix [
	<return: #String>
	^ modelClassPrefix ifNil: [ 'DiMo' ]
]

{ #category : #accessing }
DiCollectionToClassBuilder >> modelClassPrefix: anObject [
	modelClassPrefix := anObject
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> modelRootClass [
	^ modelRootClass ifNil: [ modelRootClass := self compileModelRootClass ].
]

{ #category : #accessing }
DiCollectionToClassBuilder >> modelRootClass: anObject [
	modelRootClass := anObject
]

{ #category : #accessing }
DiCollectionToClassBuilder >> package [
	^ package
]

{ #category : #accessing }
DiCollectionToClassBuilder >> package: anObject [
	package := anObject
]
