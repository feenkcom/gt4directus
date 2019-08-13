"
I define JSON-to-Object mappings.
I use ${class:NeoJSONReader}$ for reading JSON strings.

For some examples look at ${class:DiMetaModel}$ subclasses: ${class:DiMetaModel|expanded=true|show=gtSubclassesFor:|height=200}$


"
Class {
	#name : #DiMetaModelMapping,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Directus-Json Mapping'
}

{ #category : #cleanup }
DiMetaModelMapping class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
DiMetaModelMapping class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
DiMetaModelMapping class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #mapping }
DiMetaModelMapping >> collectionOfMetaCollectionMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfMetaCollection customDo: [ :mapping |
			mapping listOfElementSchema: DiMetaCollection ].
	self metaCollectionMappingFor: aNeoJSONMapper.

]

{ #category : #mapping }
DiMetaModelMapping >> metaCollectionMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaCollection do: [ :mapping |
	      mapping mapAccessor: #collection.
	      (mapping mapAccessor: #fields) valueSchema: DiMetaFields.
	      mapping mapAccessor: #hidden.
	      mapping mapAccessor: #icon.
	      mapping mapAccessor: #managed.
	      mapping mapAccessor: #note.
	      mapping mapAccessor: #single.
	      mapping mapAccessor: #translation. 
		].
	self metaFieldsMappingFor: aNeoJSONMapper.
]

{ #category : #mapping }
DiMetaModelMapping >> metaCollectionsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaCollections do: [ :mapping |
	      (mapping mapAccessor: #data) valueSchema: #CollectionOfMetaCollection.
		].
	self collectionOfMetaCollectionMappingFor: aNeoJSONMapper.

]

{ #category : #mapping }
DiMetaModelMapping >> metaFieldMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaField do: [ :mapping |
	      mapping mapAccessor: #note.
	      mapping mapAccessor: #type.
	      mapping mapAccessor: #name to: #field.
		].
]

{ #category : #mapping }
DiMetaModelMapping >> metaFieldsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaFields customDo: [ :mapping |
	      mapping reader: [ :jsonReader |
				| anArray |
				anArray := jsonReader listClass streamContents: [ :stream |
					jsonReader parseMapDo: [
						 | aMetaField |
						jsonReader parsePropertyName.
						jsonReader expectChar: $:.
						aMetaField := jsonReader nextAs: DiMetaField.
						stream nextPut: aMetaField ] ].
				DiMetaFields new fields: anArray ].
			mapping writer: [ :jsonWriter :list | 
		jsonWriter writeListStreamingDo: [ :listWriter |
			list do: [ :each | 
				each isUserSnippet ifTrue: [
					listWriter writeElement: each as: #MetaFieldNameAndValue ] ] ] ] ].
	self metaFieldMappingFor: aNeoJSONMapper.
]

{ #category : #reading }
DiMetaModelMapping >> read: aJsonSchema withMapping: aMessageSymbol on: aReadStream [ 
	"Read a JSON string using json schema and return an object.
	The messageSymbol variable is a message to configure mapping between JSON and objects."
	| reader |
	reader := (NeoJSONReader on: aReadStream).
	self perform: aMessageSymbol with: reader.
	^ reader nextAs: aJsonSchema
]

{ #category : #reading }
DiMetaModelMapping >> readMetaDescriptions: aJson [
	^ self read: DiMetaCollections withMapping: #metaCollectionsMappingFor: on: aJson readStream
]
