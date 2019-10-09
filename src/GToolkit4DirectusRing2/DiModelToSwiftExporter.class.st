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
	stream
		code: 'class ', aClass name.
	self writeClassInheritanceOf: aClass.
	stream curlies: [ 
		self writeClassVariablesDeclarationOf: aClass.
		stream newline.
	].
	stream newlines: 2.
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

{ #category : #accessing }
DiModelToSwiftExporter >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		"styler: JSParser gtStyler;"
		text: [stream contents].
]

{ #category : #sorting }
DiModelToSwiftExporter >> putBehavior: aFirst before: aSecond [
	(aFirst isRingResolved and: [ aSecond isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst isRingResolved not and: [ aSecond isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst superclass isRingResolved and: [ aSecond superclass isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst superclass isRingResolved not and: [ aSecond superclass isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst package isRingResolved and: [ aSecond package isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst package isRingResolved not and: [ aSecond package isRingResolved ]) ifTrue: [ ^ false ].
	
	^ aFirst name < aSecond name
]

{ #category : #writing }
DiModelToSwiftExporter >> writeAccessorsFor: variables [
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
DiModelToSwiftExporter >> writeClassInheritanceOf: aClass [
	| superclassName |
	superclassName := aClass superclass name.
	(superclassName beginsWith: modelClassPrefix) ifTrue: [ stream code: ' extends ', superclassName.].
]

{ #category : #writing }
DiModelToSwiftExporter >> writeClassVariablesDeclarationOf: aClass [
	self writeConstructorFor: aClass allInstVarNames.
	self writeAccessorsFor: aClass allInstVarNames.
]

{ #category : #writing }
DiModelToSwiftExporter >> writeConstructorFor: variables [
	stream code: 'constructor'.
	stream parantheses: [ 
		self for: variables do: [ :aVariable | stream nextPutAll: aVariable ] separatedBy: [stream nextPutAll: ', ']].
	stream curlies: [
		variables do: [ :aVariable | stream line: 'this.', aVariable, ' = ', aVariable.] ].
]
