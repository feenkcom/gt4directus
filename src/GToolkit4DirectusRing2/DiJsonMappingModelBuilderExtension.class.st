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
	self buildMappingMethod.
	self buildConvertToIdsMethod.
	self buildReadingMethod.
	self buildWritingMethod.
	self buildModelReadingMethods.
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
DiJsonMappingModelBuilderExtension >> buildConvertToIdsMethod [
	| aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodName := 'convertToIds:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'convertToIds: anObject'; cr;
			tab; nextPutAll: 'anObject ifNil: [ ^ anObject ].'; cr;
			tab; nextPutAll: 'anObject isInteger ifTrue: [ ^ anObject ].'; cr;
			tab; nextPutAll: '(anObject isCollection and: [ anObject isEmpty ]) ifTrue: [ ^ anObject ].';
			tab; nextPutAll: '(anObject isCollection ifTrue: [ ^ anObject collect: #id ]).'; cr;
			tab; nextPutAll: '^ anObject id'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming writingProtocolName 
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
DiJsonMappingModelBuilderExtension >> buildIdOrObjectMappingForCollection: aDiMetaCollection field: eachField on: aStream [
			| aValueName anObjectName | 
			anObjectName := self naming modelInstanceName: (self naming collectionModelName: aDiMetaCollection).
			aValueName := 'aValue'.
			aStream
				tab; tab; tab; nextPutAll: 'mapping'; cr;
				tab; tab; tab; tab; nextPutAll: 'mapProperty: '; print: eachField name asSymbol; cr;
				tab; tab; tab; tab; nextPutAll: 'getter: [ :'; nextPutAll: anObjectName; nextPutAll: ' |'; cr;
				tab; tab; tab; tab; tab; nextPutAll: 'self convertToIds: '; nextPutAll: anObjectName; nextPutAll:' '; nextPutAll: (self naming accessorName: eachField); nextPutAll: ' ]'; cr;
				tab; tab; tab; tab; nextPutAll: 'setter: [ :'; nextPutAll: anObjectName; nextPutAll: ' :'; nextPutAll: aValueName; nextPutAll: ' | '; nextPutAll: anObjectName; nextPutAll: ' '; nextPutAll: (self naming setterName: eachField); nextPutAll: ' '; nextPutAll: aValueName; nextPutAll: ' ].'; cr
		
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildJsonMappingClassSide: aClass [
	self
		ensureInstanceVariables: #('uniqueInstance')
		inBehavior: aClass classSide.
	self
		ensureLocalMethodNamed: 'uniqueInstance'
		withSourceCode:
			'uniqueInstance' , String cr , String tab
				, '^ uniqueInstance ifNil: [ uniqueInstance := self new ]'
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
	self
		ensureLocalMethodNamed: 'default'
		withSourceCode: 'default' , String cr , String tab , '^ self uniqueInstance'
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
	self
		ensureLocalMethodNamed: 'resetUniqueInstance'
		withSourceCode:
			'resetUniqueInstance' , String cr , String tab
				, 'uniqueInstance := nil'
		andProtocol: self naming cleanupProtocolName
		inBehavior: aClass classSide.
	self
		ensureLocalMethodNamed: 'cleanUp'
		withSourceCode: 'cleanUp' , String cr , String tab , 'self resetUniqueInstance'
		andProtocol: self naming cleanupProtocolName
		inBehavior: aClass classSide
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildMappingMethod [
	| aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodName := 'initializeMappingsFor:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'initializeMappingsFor: aMapper'; cr.
		self includedCollectionsDo: [ :eachMetaCollection | 
			| aClassName |
			aClassName := self naming collectionModelName: eachMetaCollection.
			aStream
				tab; nextPutAll: 'self '; nextPutAll: 'mappingOf'; nextPutAll: aClassName; nextPutAll: 'For: aMapper.'; cr;
				tab; nextPutAll: 'self '; nextPutAll: 'collectionOf'; nextPutAll: aClassName; nextPutAll: 'For: aMapper.'; cr;
				tab; nextPutAll: 'self '; nextPutAll: 'dataOf'; nextPutAll: aClassName; nextPutAll: 'For: aMapper.'; cr ] ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming initializationProtocolName 
		inBehavior: aJsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildModelMappingForCollection: aDiMetaCollection behavior: aRGBehavior [ 
	| aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aMethodName := 'mappingOf', (self naming collectionModelName: aDiMetaCollection), 'For:'.
	aMethodBody := String streamContents: [ :aStream | 
		| anObjectName |
		aStream 
			nextPutAll: aMethodName; nextPutAll: ' aNeoJSONMapper'; cr;
			tab; nextPutAll: 'aNeoJSONMapper'; cr;
			tab; tab; nextPutAll: 'for: '; nextPutAll: aRGBehavior name; nextPutAll: ' do: [ :mapping |'; cr.
		anObjectName := self naming modelInstanceName: (self naming collectionModelName: aDiMetaCollection).
		self includedCollection: aDiMetaCollection fieldsDo: [ :eachField | 
			eachField isModelType 
				ifTrue: [ self buildIdOrObjectMappingForCollection: aDiMetaCollection field: eachField on: aStream ] 
				ifFalse: [ self buildSimpleMappingForCollection: aDiMetaCollection field: eachField on: aStream ]
		].
		aStream
				tab; tab; nextPutAll: '].' ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming mappingModelsProtocolName 
		inBehavior: aJsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildModelReadingMethods [
	| aModelClass aMethodName aMethodBody |
	aModelClass := self modelRootClass.
	aMethodName := 'dataSchemaName'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'dataSchemaName'; cr;
			tab; nextPutAll: '^ #DataOf, self name'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming readingProtocolName 
		inBehavior: aModelClass classSide.
	aMethodName := 'readJson:on:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'readJson: aSchema on: aJsonString'; cr;
			tab; nextPutAll: '^ EsJsonMapping uniqueInstance read: aSchema on: aJsonString readStream'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming readingProtocolName 
		inBehavior: aModelClass classSide.
	aMethodName := 'readJsonData:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'readJsonData: aJsonString'; cr;
			tab; nextPutAll: '<return: #Array of: #'; nextPutAll: aModelClass name; nextPutAll: '>'; cr;
			tab; nextPutAll: '^ self readJson: self dataSchemaName on: aJsonString'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming readingProtocolName 
		inBehavior: aModelClass classSide.
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
			tab; nextPutAll: 'aReader := (NeoJSONReader on: aReadStream).'; cr;
			tab; nextPutAll: 'self initializeMappingsFor: aReader.';
			tab; nextPutAll: '^ aReader nextAs: aJsonSchema.'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming readingProtocolName 
		inBehavior: aJsonMappingClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildSimpleMappingForCollection: aDiMetaCollection field: eachField on: aStream [
			| aValueName anObjectName | 
			anObjectName := self naming modelInstanceName: (self naming collectionModelName: aDiMetaCollection).
			aValueName := 'aValue'.
			aStream
				tab; tab; tab; nextPutAll: 'mapping'; cr;
				tab; tab; tab; tab; nextPutAll: 'mapProperty: '; print: eachField name asSymbol; cr;
				tab; tab; tab; tab; nextPutAll: 'getter: [ :'; nextPutAll: anObjectName; nextPutAll: ' | '; nextPutAll: anObjectName; nextPutAll:' '; nextPutAll: (self naming accessorName: eachField); nextPutAll: ' ]'; cr;
				tab; tab; tab; tab; nextPutAll: 'setter: [ :'; nextPutAll: anObjectName; nextPutAll: ' :'; nextPutAll: aValueName; nextPutAll: ' | '; nextPutAll: anObjectName; nextPutAll: ' '; nextPutAll: (self naming setterName: eachField); nextPutAll: ' '; nextPutAll: aValueName; nextPutAll: ' ].'; cr
		
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> buildWritingMethod [
	| aModelInstanceName aJsonMappingClass aMethodName aMethodBody |
	aJsonMappingClass := self jsonMappingClass.
	aModelInstanceName := self naming modelInstanceName: self modelRootClass name.
	
	aMethodName := 'write:on:prettyPrint:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'write: '; nextPutAll: aModelInstanceName; nextPutAll: ' on: aWriteStream prettyPrint: aBoolean'; cr;
			tab; nextPutAll: '| aWriter |'; cr;
			tab; nextPutAll: 'aWriter := (NeoJSONWriter on: aWriteStream).'; cr;
			tab; nextPutAll: 'aWriter prettyPrint: aBoolean.'; cr;
			tab; nextPutAll: 'self initializeMappingsFor: aWriter.'; cr;
			tab; nextPutAll: 'aWriter nextPut: '; nextPutAll: aModelInstanceName; nextPutAll: '.'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming writingProtocolName 
		inBehavior: aJsonMappingClass.
		
	aMethodName := 'writePretty:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'writePretty: '; nextPutAll: aModelInstanceName; cr;
			tab; nextPutAll: '<return: #String>'; cr;
			tab; nextPutAll: '^ String streamContents: [ :aStream | '; cr;
			tab; tab; nextPutAll: 'self write: '; nextPutAll: aModelInstanceName; nextPutAll:' on: aStream prettyPrint: true ]'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming writingProtocolName 
		inBehavior: aJsonMappingClass.
		
	aMethodName := 'write:'.
	aMethodBody := String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'write: '; nextPutAll: aModelInstanceName; cr;
			tab; nextPutAll: '<return: #String>'; cr;
			tab; nextPutAll: '^ String streamContents: [ :aStream | '; cr;
			tab; tab; nextPutAll: 'self write: '; nextPutAll: aModelInstanceName; nextPutAll:' on: aStream prettyPrint: false ]'; cr ].
	self 
		ensureLocalMethodNamed: aMethodName
		withSourceCode: aMethodBody 
		andProtocol: self naming writingProtocolName 
		inBehavior: aJsonMappingClass.
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> jsonMappingClass [
	| aClassOrNil aClass |
	aClassOrNil := self behaviorNamed: self jsonModelClassName.
	aClassOrNil ifNotNil: [ ^ aClassOrNil ].
	aClass := self ensureClassAndMetaClassNamed: self jsonModelClassName.
	self ensureObjectAsSuperclassForBehavior: aClass.
	self ensurePackageAndTagForBehavior: aClass.
	self buildJsonMappingClassSide: aClass.
	^ aClass
]

{ #category : #building }
DiJsonMappingModelBuilderExtension >> jsonModelClassName [
	^ self builder modelClassPrefix, 'JsonMapping'
]
