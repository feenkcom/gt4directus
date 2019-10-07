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
		ifTrue: [ self writeMetaClassDefinitionOf: aClass. ]
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
	| saveStream |
	saveStream := jsStream.
	jsStream := '' writeStream.
	[
		aBlock value.
		^ jsStream contents
	] ensure: [ jsStream := saveStream ]
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
DiModelToJavascriptExporter >> writeClassDefinitionOf: aClass [
	jsStream
		nextPutAll: 'class ';
		nextPutAll: aClass name.
	self writeClassInheritanceOf: aClass.
	jsStream
		nextPutAll: '{';
		nextPutAll: String crlf;
		nextPutAll: String crlf.
	self writeClassVariablesDeclarationOf: aClass.
	jsStream
		nextPutAll: '}'.
	self halt.
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassInheritanceOf: aClass [
	| superclassName |
	superclassName := aClass superclass name.
	(superclassName beginsWith: modelClassPrefix) ifTrue: [ 
		jsStream
			nextPutAll: ' extends ';
			nextPutAll: superclassName.
		].
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassVariablesDeclarationOf: aClass [
	| instVarNames |
	jsStream
		nextPutAll: String tab;
		nextPutAll: 'constructor('.
	instVarNames := aClass allInstVarNames.
	self for: instVarNames do: [ :aVariable | jsStream nextPutAll: aVariable ] separatedBy: [jsStream nextPutAll: ', '].
	jsStream
		nextPutAll: '){';
		nextPutAll: String crlf;
		nextPutAll: String crlf.
	self for: instVarNames do: [ 
		:aVariable | 
			jsStream
				nextPutAll: String tab;
				nextPutAll: String tab;
				nextPutAll: 'this.';
				nextPutAll: aVariable;
				nextPutAll: ' = ';
				nextPutAll: aVariable. 
	] separatedBy: [jsStream nextPutAll: String crlf].
	jsStream
		nextPutAll: String tab;
		nextPutAll: '}'.
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeMetaClassDefinitionOf: aClass [
]
