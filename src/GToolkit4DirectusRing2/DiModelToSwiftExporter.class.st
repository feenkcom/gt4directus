Class {
	#name : #DiModelToSwiftExporter,
	#superclass : #DiModelExporter,
	#classInstVars : [
		'tabIndent'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiModelToSwiftExporter >> convertClass: aDiMetaCollection [
	self writeClassResponse: aDiMetaCollection.
	stream newlines: 2.
	self writeClassDefinition: aDiMetaCollection.
	stream newlines: 2.
]

{ #category : #writing }
DiModelToSwiftExporter >> convertRootClass: aRootClass [
	stream code: '
struct Meta: ', self modelRootClassName, ' {
  var offset: Int
  var page: Int
  var pageCount: Int
    
  enum CodingKeys: String, CodingKey {
    case offset
    case page
    case pageCount = "page_count"
  }
}

'
]

{ #category : #accessing }
DiModelToSwiftExporter >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		styler: SwiftParser gtStyler;
		text: [stream contents].
]

{ #category : #writing }
DiModelToSwiftExporter >> onTempStreamDo: aBlock [
	stream := DiSwiftModelStream new.
	aBlock value.
]

{ #category : #writing }
DiModelToSwiftExporter >> writeClassDefinition: aDiMetaCollection [
	| className |
	className := self naming collectionModelName: aDiMetaCollection.
	stream
		code: 'struct ', className, ': ', self modelRootClassName, ' ';
		curlies: [ 
			self writeVariablesFor: aDiMetaCollection.
			stream newline.
			self writeMappingFor: aDiMetaCollection.
			stream newline.
		].
	
]

{ #category : #writing }
DiModelToSwiftExporter >> writeClassResponse: aDiMetaCollection [
	| className |
	className := self naming collectionModelName: aDiMetaCollection.
	stream
		code: 'struct ', className, 'Response: ', (self modelRootClassName), ' ';
		curlies: [  
			stream 
				line: 'var meta: Meta';
				line: 'var data: [', className, ']'.
		].
]

{ #category : #writing }
DiModelToSwiftExporter >> writeMappingFor: aDiMetaCollection [
	stream 
		code: 'enum CodingKeys: String, CodingKey ';
		curlies: [ 
			self includedCollection: aDiMetaCollection fieldsDo: [ :aDiMetaField | 
				stream line: 'case ', (self naming fieldName: aDiMetaField), ' = "', aDiMetaField name, '"'.
			].
		]
]

{ #category : #writing }
DiModelToSwiftExporter >> writeVariablesFor: aDiMetaCollection [
	self 
		includedCollection: aDiMetaCollection 
		fieldsDo: [ :aMetaField | 
			| aType |
			aType := aMetaField typeNameUsingNaming: self naming.
			stream line: 'var ', (self naming fieldName: aMetaField), ': ', aType ].
]
