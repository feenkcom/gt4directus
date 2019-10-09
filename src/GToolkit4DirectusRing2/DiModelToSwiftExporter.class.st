Class {
	#name : #DiModelToSwiftExporter,
	#superclass : #DiModelExporter,
	#classInstVars : [
		'tabIndent'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiModelToSwiftExporter >> convertClass: aClass [
	self writeClassResponse: aClass.
	stream newline.
	self writeClassDefinition: aClass.
]

{ #category : #writing }
DiModelToSwiftExporter >> convertRootClass: aRootClass [
	stream code: '
struct Meta: Codable {
  var offset: Int
  var page: Int
  var pageCount: Int
    
  enum CodingKeys: String, CodingKey {
    case offset
    case page
    case pageCount = "page_count"
  }
}'
]

{ #category : #writing }
DiModelToSwiftExporter >> extractName: aClass [
	^ (aClass name) copyFrom: (modelClassPrefix size + 1) to: (aClass name) size.
]

{ #category : #accessing }
DiModelToSwiftExporter >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		"styler: JSParser gtStyler;"
		text: [stream contents].
]

{ #category : #writing }
DiModelToSwiftExporter >> writeClassDefinition: aClass [
]

{ #category : #writing }
DiModelToSwiftExporter >> writeClassResponse: aClass [
	| className |
	className := self extractName: aClass.
	stream
		code: 'struct ', className, 'Response: Codable';
		curlies: [  
			stream 
				line: 'var meta: Meta';
				line: 'var data: [', className, ']'.
		].
]

{ #category : #writing }
DiModelToSwiftExporter >> writeClassVariablesDeclarationOf: aClass [
	self writeVariablesFor: aClass allInstVarNames.
	self writeMappingFor: aClass allInstVarNames.
]

{ #category : #writing }
DiModelToSwiftExporter >> writeMappingFor: aClass [
]

{ #category : #writing }
DiModelToSwiftExporter >> writeVariablesFor: aClass [
]
