"
I build a JSON-to-Model reader that uses ${class:NeoJSONReader}$.

!! Example 

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I build the following JSON-to-Model reader:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithJsonMapping_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithJsonMapping|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #DiJsonMappingModelBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiJsonMappingModelBuilderExtension >> build [
	self includedCollectionsAndModelsDo: [ :eachCollection :eachBehavior | 
		self buildModelMappingForCollection: eachCollection behavior: eachBehavior.
		self buildCollectionMappingForCollection: eachCollection behavior: eachBehavior.
		self buildDataMappingForCollection: eachCollection behavior: eachBehavior. ].
	self buildReadingMethod.
	self buildClassComment.
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildClassComment [
	| aString |
	aString := 'I am responsible for reading a JSON string representing model data.', String cr, 
		'I use ${class:', NeoJSONReader name, '}$.', String cr,
		'The object model is ${class:', self builder modelRootClassName, '$}.', String cr.
	self ensureClassComment: aString forBehavior: self jsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildCollectionMappingForCollection: aDiMetaCollection behavior: aRGBehavior [ 
	| aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodName := 'collectionOf', (self naming collectionModelName: aDiMetaCollection), 'For:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: aMethodName; nextPutAll: ' aNeoJSONMapper'; cr;
			tab; nextPutAll: 'aNeoJSONMapper'; cr;
			tab; tab; nextPutAll: 'for: '; nextPutAll: '#CollectionOf'; nextPutAll: (self naming collectionModelName: aDiMetaCollection); nextPutAll: ' customDo: [ :mapping |'; cr;
			tab; tab; tab; nextPutAll: 'mapping listOfElementSchema: '; nextPutAll: aRGBehavior name; nextPutAll: ' ].'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming mappingCollectionsProtocolName 
		inBehavior: aJsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildDataMappingForCollection: aDiMetaCollection behavior: aRGBehavior [ 
	| aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodName := 'dataOf', (self naming collectionModelName: aDiMetaCollection), 'For:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: aMethodName; nextPutAll: ' aNeoJSONMapper'; cr;
			tab; nextPutAll: 'aNeoJSONMapper'; cr;
			tab; tab; nextPutAll: 'for: '; nextPutAll: '#DataOf'; nextPutAll: (self naming collectionModelName: aDiMetaCollection); nextPutAll: ' customDo: [ :mapping |'; cr;
			tab; tab; tab; nextPutAll: 'mapping reader: [ :jsonReader | '; cr;
			tab; tab; tab; tab; nextPutAll: '| aResult |'; cr;
			tab; tab; tab; tab; nextPutAll: 'jsonReader parseMapDo: ['; cr;
			tab; tab; tab; tab; tab; nextPutAll: '(jsonReader parsePropertyName asString = ''data'')'; cr;
			tab; tab; tab; tab; tab; tab; nextPutAll: 'ifTrue: ['; cr;
			tab; tab; tab; tab; tab; tab; tab; nextPutAll: 'jsonReader expectChar: $:.'; cr;
			tab; tab; tab; tab; tab; tab; tab; nextPutAll: 'aResult := jsonReader nextAs: #CollectionOf'; nextPutAll: (self naming collectionModelName: aDiMetaCollection); nextPutAll: ' ]'; cr;
			tab; tab; tab; tab; tab; tab; nextPutAll: 'ifFalse: ['; cr;
			tab; tab; tab; tab; tab; tab; tab; nextPutAll: 'jsonReader expectChar: $:.'; cr;
			tab; tab; tab; tab; tab; tab; tab; nextPutAll: 'aResult := jsonReader next ] ].'; cr;
			tab; tab; tab; tab; nextPutAll: 'aResult ].'; cr;
			tab; tab; tab; nextPutAll: 'mapping writer: [ :jsonWriter :list |'; cr;
			tab; tab; tab; tab; nextPutAll: 'self error: ''Writer not supported'' ] ]'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming mappingDataProtocolName 
		inBehavior: aJsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildModelMappingForCollection: aDiMetaCollection behavior: aRGBehavior [ 
	| aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodName := 'mappingOf', (self naming collectionModelName: aDiMetaCollection), 'For:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: aMethodName; nextPutAll: ' aNeoJSONMapper'; cr;
			tab; nextPutAll: 'aNeoJSONMapper'; cr;
			tab; tab; nextPutAll: 'for: '; nextPutAll: aRGBehavior name; nextPutAll: ' do: [ :mapping |'; cr.
		aDiMetaCollection fields do: [ :eachField | 
			aStream
				tab; tab; tab; nextPutAll: 'mapping mapAccessor: #'''; nextPutAll: (self naming fieldName: eachField); nextPutAll: ''' to: #'''; nextPutAll: eachField name; nextPutAll: '''.'; cr ].
		aStream
				tab; tab; nextPutAll: '].' ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming mappingModelsProtocolName 
		inBehavior: aJsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildReadingMethod [
	| aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodName := 'read:on:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'read: aJsonSchema on: aReadStream'; cr;
			tab; nextPutAll: '| aReader |'; cr;
			tab; nextPutAll: 'aReader := (NeoJSONReader on: aReadStream).'; cr.
		self includedCollectionsDo: [ :eachMetaCollection | 
			| aClassName |
			aClassName := self naming collectionModelName: eachMetaCollection.
			aStream
				tab; nextPutAll: 'self '; nextPutAll: 'mappingOf'; nextPutAll: aClassName; nextPutAll: 'For: aReader.'; cr;
				tab; nextPutAll: 'self '; nextPutAll: 'collectionOf'; nextPutAll: aClassName; nextPutAll: 'For: aReader.'; cr;
				tab; nextPutAll: 'self '; nextPutAll: 'dataOf'; nextPutAll: aClassName; nextPutAll: 'For: aReader.'; cr ].
		aStream
				tab; nextPutAll: '^ aReader nextAs: aJsonSchema.'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming readingProtocolName 
		inBehavior: aJsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> jsonMappingClass [
	| aClassOrNil aClass |
	aClassOrNil := self behaviorNamed: self jsonModelClassName.
	aClassOrNil ifNotNil: [ ^ aClassOrNil ].
	aClass := self ensureClassAndMetaClassNamed: self jsonModelClassName.
	self ensureObjectAsSuperclassForBehavior: aClass.
	self ensurePackageAndTagForBehavior: aClass.
	self ensureInstanceVariables: #( 'uniqueInstance' ) inBehavior: aClass classSide.
	self 
		ensureLocalMethodNamed: 'uniqueInstance' 
		withSourceCode: 'uniqueInstance', String cr, String tab, '^ uniqueInstance ifNil: [ uniqueInstance := self new ]' 
		andProtocol: self naming accessorProtocolName 
		inBehavior: aClass classSide.
	self 
		ensureLocalMethodNamed: 'resetUniqueInstance' 
		withSourceCode: 'resetUniqueInstance', String cr, String tab, 'uniqueInstance := nil' 
		andProtocol: self naming cleanupProtocolName 
		inBehavior: aClass classSide.
	self 
		ensureLocalMethodNamed: 'cleanUp' 
		withSourceCode: 'cleanUp', String cr, String tab, 'self resetUniqueInstance' 
		andProtocol: self naming cleanupProtocolName 
		inBehavior: aClass classSide.
	^ aClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> jsonModelClassName [
	^ self builder modelClassPrefix, 'JsonMapping'
]
