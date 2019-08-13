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
	#category : #'GToolkit4Directus-Json Mapping'
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
DiMetaModelMapping >> collectionOfMetaRelationMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfMetaRelation customDo: [ :mapping |
			mapping listOfElementSchema: DiMetaRelation ].
	self metaRelationMappingFor: aNeoJSONMapper.

]

{ #category : #mapping }
DiMetaModelMapping >> metaCollectionMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaCollection do: [ :mapping |
	      mapping mapAccessor: #name to: #collection.
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
	      (mapping mapAccessor: #type) valueSchema: DiMetaFieldType.
	      mapping mapAccessor: #name to: #field.
		].
	self metaFieldTypeMappingFor: aNeoJSONMapper.
]

{ #category : #mapping }
DiMetaModelMapping >> metaFieldTypeMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaFieldType customDo: [ :mapping |
	     mapping 
			decoder: [ :aString | DiMetaFieldType typeNamed: aString ];
			encoder: [ :aType | aType jsonName ] ].
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

{ #category : #mapping }
DiMetaModelMapping >> metaRelationMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaRelation do: [ :mapping |
	      mapping mapAccessor: #fieldOne to: #field_one.
	      mapping mapAccessor: #junctionField to: #junction_field.
			mapping mapAccessor: #collectionMany to: #collection_many.
			mapping mapAccessor: #fieldMany to: #field_many.
			mapping mapAccessor: #collectionOne to: #collection_one.
		].
]

{ #category : #mapping }
DiMetaModelMapping >> metaRelationsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DiMetaRelations do: [ :mapping |
	      (mapping mapAccessor: #data) valueSchema: #CollectionOfMetaRelation.
		].
	self collectionOfMetaRelationMappingFor: aNeoJSONMapper.

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
DiMetaModelMapping >> readCollections: aJson [
	^ self read: DiMetaCollections withMapping: #metaCollectionsMappingFor: on: aJson readStream
]

{ #category : #reading }
DiMetaModelMapping >> readRelations: aJson [
	^ self read: DiMetaRelations withMapping: #metaRelationsMappingFor: on: aJson readStream.
]
