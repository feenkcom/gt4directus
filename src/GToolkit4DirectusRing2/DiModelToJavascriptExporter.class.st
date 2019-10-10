"
I export a model provided by ${class:DiCollectionToModelBuilder}$ into a JavaScript source code.

!! Example 

I export the following model 
${example:DiJavascripModelExporterExamples>>#companyAndCountryBuilder|previewExpanded=true|codeExpanded=false}$

into the following JavaScript code:
${example:DiJavascripModelExporterExamples>>#companyAndCountryBuilder|previewExpanded=true|codeExpanded=false}$


"
Class {
	#name : #DiModelToJavaScriptExporter,
	#superclass : #DiModelExporter,
	#classInstVars : [
		'tabIndent'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiModelToJavaScriptExporter >> convertClass: aDiMetaCollection [
	self writeClassDefinitionOf: aDiMetaCollection.
	stream newlines: 2.
]

{ #category : #writing }
DiModelToJavaScriptExporter >> convertRootClass: aDiMetaCollection [
	stream
		code: 'class ', (self naming collectionModelName: aDiMetaCollection).
	stream curlies: [ 
		"self writeClassVariablesDeclarationOf: aDiMetaCollection."
		"stream newline."
	].
	stream newlines: 2.
]

{ #category : #accessing }
DiModelToJavaScriptExporter >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		styler: JSParser gtStyler;
		text: [stream contents].
]

{ #category : #writing }
DiModelToJavaScriptExporter >> onTempStreamDo: aBlock [
	stream := DiJavascriptModelStream new.
	aBlock value.
]

{ #category : #sorting }
DiModelToJavaScriptExporter >> putBehavior: aFirst before: aSecond [
	(aFirst isRingResolved and: [ aSecond isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst isRingResolved not and: [ aSecond isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst superclass isRingResolved and: [ aSecond superclass isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst superclass isRingResolved not and: [ aSecond superclass isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst package isRingResolved and: [ aSecond package isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst package isRingResolved not and: [ aSecond package isRingResolved ]) ifTrue: [ ^ false ].
	
	^ aFirst name < aSecond name
]

{ #category : #writing }
DiModelToJavaScriptExporter >> writeAccessorsFor: aDiMetaCollection [
	self 
		includedCollection: aDiMetaCollection 
		fieldsDo: [ :aMetaField |
		stream
			newline;
			code: 'get ', (self naming accessorName: aMetaField), '()';
			curlies: [ 
				stream line: 'return this.', (self naming fieldName: aMetaField).
			].
		stream
			newline;
			code: 'set ', (self naming accessorName: aMetaField), '(', (self naming fieldName: aMetaField), ')';
			curlies: [ 
				stream line: 'this.', (self naming fieldName: aMetaField), ' = ', (self naming fieldName: aMetaField).
			].
	].
]

{ #category : #writing }
DiModelToJavaScriptExporter >> writeClassDefinitionOf: aDiMetaCollection [
	stream
		code: 'class ', (self naming collectionModelName: aDiMetaCollection);
		nextPutAll: ' extends ', self modelRootClassName.
	stream curlies: [ 
		self writeClassVariablesDeclarationOf: aDiMetaCollection.
		stream newline.
	].
]

{ #category : #writing }
DiModelToJavaScriptExporter >> writeClassInheritanceOf: aDiMetaCollection [
	self flag: #remove.
	self shouldNotImplement.
]

{ #category : #writing }
DiModelToJavaScriptExporter >> writeClassVariablesDeclarationOf: aDiMetaCollection [
	self writeConstructorFor: aDiMetaCollection.
	self writeAccessorsFor: aDiMetaCollection.
]

{ #category : #writing }
DiModelToJavaScriptExporter >> writeConstructorFor: aDiMetaCollection [
	stream code: 'constructor'.
	stream parantheses: [ 
		self 
			includedCollection: aDiMetaCollection 
			fieldsDo: [ :aMetaField | stream nextPutAll: (self naming fieldName: aMetaField) ]
			separatedBy: [ stream nextPutAll: ', ' ] ].
	stream curlies: [
		self 
			includedCollection: aDiMetaCollection 
			fieldsDo: [ :aMetaField | 
				| aName | 
				aName := (self naming fieldName: aMetaField).
				stream line: 'this.', aName, ' = ', aName. ] ].
]
