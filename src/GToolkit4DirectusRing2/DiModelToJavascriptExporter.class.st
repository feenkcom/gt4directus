Class {
	#name : #DiModelToJavascriptExporter,
	#superclass : #Object,
	#instVars : [
		'jsStream',
		'modelClassPrefix'
	],
	#classInstVars : [
		'tabIndent'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiModelToJavascriptExporter >> convertClass: aClass [
	(aClass hasResolvedSuperclass) ifFalse: [^ self].
	aClass isMetaclass
		ifFalse: [ self writeClassDefinitionOf: aClass. ].
	
]

{ #category : #exporting }
DiModelToJavascriptExporter >> export: aModel [
	| behaviors |
	behaviors := ((aModel ringEnvironment ask behaviors asOrderedCollection)
		reject: [ :aBehavior | 
			aBehavior isRGUnresolvedValue or: [ aBehavior isRingResolved not ]])
		sort: [ :a :b | self putBehavior: a before: b ].
	
	^ self onTempStreamDo: [ behaviors do: [ :aBehavior | self convertClass: aBehavior] ].
]

{ #category : #'as yet unclassified' }
DiModelToJavascriptExporter >> for: elements do: aDoBlock separatedBy: aSeparatorBlock [
	| aBeforeFirst | 
	aBeforeFirst := true.
	elements do: [ :anElement | 
		aBeforeFirst
			ifTrue: [ aBeforeFirst := false ]
			ifFalse: [ aSeparatorBlock value ].
		aDoBlock cull: anElement ]
]

{ #category : #accessing }
DiModelToJavascriptExporter >> modelClassPrefix [
	^ modelClassPrefix
]

{ #category : #accessing }
DiModelToJavascriptExporter >> modelClassPrefix: anObject [
	modelClassPrefix := anObject
]

{ #category : #writing }
DiModelToJavascriptExporter >> onTempStreamDo: aBlock [
	jsStream := DiJavascriptModelStream new.
	aBlock value.
	^ jsStream contents.
]

{ #category : #sorting }
DiModelToJavascriptExporter >> putBehavior: aFirst before: aSecond [
	(aFirst isRingResolved and: [ aSecond isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst isRingResolved not and: [ aSecond isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst superclass isRingResolved and: [ aSecond superclass isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst superclass isRingResolved not and: [ aSecond superclass isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst package isRingResolved and: [ aSecond package isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst package isRingResolved not and: [ aSecond package isRingResolved ]) ifTrue: [ ^ false ].
	
	^ aFirst name < aSecond name
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeAccessorsFor: variables [
	variables do: [ :aVariable |
		jsStream
			newline;
			code: 'get ', aVariable;
			curlies: [ 
				jsStream code: 'return this.', aVariable, ';'.
			].
		jsStream
			newline;
			code: 'set ', aVariable, '(', aVariable, ')';
			curlies: [ 
				jsStream code: 'this.', aVariable, ' = ', aVariable, ';'.
			].
	].
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassDefinitionOf: aClass [
	jsStream
		code: 'class ', aClass name.
	self writeClassInheritanceOf: aClass.
	jsStream curlies: [ 
		self writeClassVariablesDeclarationOf: aClass.
	].
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassInheritanceOf: aClass [
	| superclassName |
	superclassName := aClass superclass name.
	(superclassName beginsWith: modelClassPrefix) ifTrue: [ jsStream code: ' extends ', superclassName.].
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassVariablesDeclarationOf: aClass [
	self writeConstructorFor: aClass allInstVarNames.
	self writeAccessorsFor: aClass allInstVarNames.
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeConstructorFor: variables [
	jsStream code: 'constructor'.
	jsStream parantheses: [ 
		self for: variables do: [ :aVariable | jsStream nextPutAll: aVariable ] separatedBy: [jsStream nextPutAll: ', ']].
	jsStream curlies: [
		variables do: [ 
		:aVariable | jsStream line: 'this.', aVariable, ' = ', aVariable.]
	].
]
