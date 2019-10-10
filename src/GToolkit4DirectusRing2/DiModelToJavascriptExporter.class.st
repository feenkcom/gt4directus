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
	#superclass : #DiModelExporter,
	#classInstVars : [
		'tabIndent'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiModelToJavascriptExporter >> convertClass: aClass [
	self writeClassDefinitionOf: aClass.
	stream newlines: 2.
]

{ #category : #writing }
DiModelToJavascriptExporter >> convertRootClass: aRootClass [
	self convertClass: aRootClass.
]

{ #category : #accessing }
DiModelToJavascriptExporter >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		styler: JSParser gtStyler;
		text: [stream contents].
]

{ #category : #writing }
DiModelToJavascriptExporter >> onTempStreamDo: aBlock [
	stream := DiJavascriptModelStream new.
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
		stream
			newline;
			code: 'get ', aVariable, '()';
			curlies: [ 
				stream line: 'return this.', aVariable.
			].
		stream
			newline;
			code: 'set ', aVariable, '(', aVariable, ')';
			curlies: [ 
				stream line: 'this.', aVariable, ' = ', aVariable.
			].
	].
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassDefinitionOf: aClass [
	stream
		code: 'class ', aClass name.
	self writeClassInheritanceOf: aClass.
	stream curlies: [ 
		self writeClassVariablesDeclarationOf: aClass.
		stream newline.
	].
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassInheritanceOf: aClass [
	| superclassName |
	superclassName := aClass superclass name.
	(superclassName beginsWith: modelClassPrefix) ifTrue: [ stream code: ' extends ', superclassName.].
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassVariablesDeclarationOf: aClass [
	self writeConstructorFor: aClass allInstVarNames.
	self writeAccessorsFor: aClass allInstVarNames.
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeConstructorFor: variables [
	stream code: 'constructor'.
	stream parantheses: [ 
		self for: variables do: [ :aVariable | stream nextPutAll: aVariable ] separatedBy: [stream nextPutAll: ', ']].
	stream curlies: [
		variables do: [ :aVariable | stream line: 'this.', aVariable, ' = ', aVariable.] ].
]
