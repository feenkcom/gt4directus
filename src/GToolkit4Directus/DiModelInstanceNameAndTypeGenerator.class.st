"
I build an UML style instance variable name with type as ==instVar: Type { properties }==.
I can be used to build a UML diagrams.

"
Class {
	#name : #DiModelInstanceNameAndTypeGenerator,
	#superclass : #Object,
	#instVars : [
		'modelClass',
		'modelInstanceVariableName'
	],
	#category : #'GToolkit4Directus-Utility'
}

{ #category : #testing }
DiModelInstanceNameAndTypeGenerator >> isModelRequired [
	<return: #Boolean>
	^ (self modelPragmaNamed: #required: argumentAt: 1) ifNil: [ false ]
]

{ #category : #testing }
DiModelInstanceNameAndTypeGenerator >> isModelUnique [
	<return: #Boolean>
	^ (self modelPragmaNamed: #unique: argumentAt: 1) ifNil: [ false ]
]

{ #category : #accessing }
DiModelInstanceNameAndTypeGenerator >> modelClass [
	^ modelClass
]

{ #category : #accessing }
DiModelInstanceNameAndTypeGenerator >> modelClass: anObject [
	modelClass := anObject
]

{ #category : #'accessing - computed' }
DiModelInstanceNameAndTypeGenerator >> modelCompiledMethod [
	<return: #CompiledMethod>
	^ self modelClass 
		compiledMethodAt: self modelInstanceVariableName asSymbol 
		ifPresent: [ :aCompiledMethod | aCompiledMethod ] 
		ifAbsent: [ nil ] 
]

{ #category : #accessing }
DiModelInstanceNameAndTypeGenerator >> modelInstanceVariableName [
	^ modelInstanceVariableName
]

{ #category : #accessing }
DiModelInstanceNameAndTypeGenerator >> modelInstanceVariableName: anObject [
	modelInstanceVariableName := anObject
]

{ #category : #'accessing - computed' }
DiModelInstanceNameAndTypeGenerator >> modelPragmaNamed: aName [
	<return: #Pragma>
	^ self modelCompiledMethod
		ifNotNil: [ :aMethod | aMethod pragmaAt: aName ] 
		ifNil: [ nil ]
]

{ #category : #'accessing - computed' }
DiModelInstanceNameAndTypeGenerator >> modelPragmaNamed: aName argumentAt: anIndex [
	^ (self modelPragmaNamed: aName) ifNotNil: [ :aPragma | 
			aPragma argumentAt: anIndex ]
]

{ #category : #'accessing - computed' }
DiModelInstanceNameAndTypeGenerator >> modelReturnType [
	<return: #BlRopedText>
	| aSymbol |
	aSymbol := (self modelPragmaNamed: #return: argumentAt: 1).
	aSymbol ifNil: [ ^ '<unknown type>' asRopedText foreground: Color lightRed ].
	^ aSymbol asString asRopedText foreground: Color lightGray.
]

{ #category : #building }
DiModelInstanceNameAndTypeGenerator >> text [
	<return: #BlRopedText>
	| aName aType isUnique isRequired theProperties |
	aName := self modelInstanceVariableName asRopedText.
	aType := self modelReturnType.
	isUnique := self isModelUnique ifTrue: [ 'unique' ] ifFalse: [ '' ].
	isRequired := self isModelRequired ifTrue: [ 'required' ] ifFalse: [ '' ].
	theProperties := (isUnique, ' ', isRequired) trimBoth.
	theProperties := theProperties 
		ifEmpty: [ theProperties asRopedText ]
		ifNotEmpty: [ (' {', theProperties, '}') asRopedText foreground: Color blue muchLighter ].
	aName insertString: ': ' at: aName size.
	aName insertText: aType at: aName size.
	aName insertText: theProperties at: aName size.
	^ aName
]
