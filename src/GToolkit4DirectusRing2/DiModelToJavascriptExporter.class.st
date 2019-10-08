"
I export a model provided by ${class:DiCollectionToModelBuilder}$ into a JavaScript source code.

!! Example 

I export the following model 
${example:DiJavascripModelExporterExamples>>#companyAndCountryBuilder|previewExpanded=true|codeExpanded=false}$

into the following JavaScript code:
${example:DiJavascripModelExporterExamples>>#companyAndCountryBuilder|previewExpanded=true|codeExpanded=false}$


"
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

{ #category : #accessing }
DiModelToJavascriptExporter >> contents [
	^ jsStream contents.
]

{ #category : #writing }
DiModelToJavascriptExporter >> convertClass: aClass [
	self writeClassDefinitionOf: aClass.
]

{ #category : #exporting }
DiModelToJavascriptExporter >> export: builder [
	^ self onTempStreamDo: [ 
		self convertClass: builder modelRootClass.
		jsStream newlines: 2.
		builder includedCollectionsAndModelsDo: [ :aMetaCollection :aBehavior | 
			self convertClass: aBehavior.
			jsStream newlines: 2.
		]
	].
]

{ #category : #formatting }
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
DiModelToJavascriptExporter >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		styler: JSParser gtStyler;
		text: [jsStream contents].
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
			code: 'get ', aVariable, '()';
			curlies: [ 
				jsStream line: 'return this.', aVariable.
			].
		jsStream
			newline;
			code: 'set ', aVariable, '(', aVariable, ')';
			curlies: [ 
				jsStream line: 'this.', aVariable, ' = ', aVariable.
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
		jsStream newline.
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
		variables do: [ :aVariable | jsStream line: 'this.', aVariable, ' = ', aVariable.] ].
]
