Class {
	#name : #DiCollectionToClassBuilder,
	#superclass : #Object,
	#instVars : [
		'collections',
		'package',
		'modelClassPrefix',
		'modelRootClass'
	],
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiCollectionToClassBuilder >> build [
	self collections data do: [ :eachCollection | 
		self buildCollection: eachCollection ].
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
DiCollectionToClassBuilder >> compileModelRootClass [
	^ Object 
		subclass: self modelClassPrefix, 'Model'
		slots: {  }
		classVariables: {  }
		package: self package name 
]

{ #category : #building }
DiCollectionToClassBuilder >> modelClassPrefix [
	<return: #String>
	^ modelClassPrefix ifNil: [ 'DiMo' ]
]

{ #category : #'as yet unclassified' }
DiCollectionToClassBuilder >> modelRootClass [
	^ modelRootClass ifNil: [ modelRootClass := self compileModelRootClass ].
]

{ #category : #accessing }
DiCollectionToClassBuilder >> package [
	^ package
]

{ #category : #accessing }
DiCollectionToClassBuilder >> package: anObject [
	package := anObject
]
