Class {
	#name : #DiModelToJavascriptExporter,
	#superclass : #Object,
	#instVars : [
		'jsStream',
		'modelClassPrefix'
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
		nextPutAll: '{'.
	self writeClassVariablesDeclarationOf: aClass.
	self writeMethodsOf: aClass.
	jsStream
		nextPutAll: '}'.
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
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeMetaClassDefinitionOf: aClass [
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeMethodsOf: aClass [
]
