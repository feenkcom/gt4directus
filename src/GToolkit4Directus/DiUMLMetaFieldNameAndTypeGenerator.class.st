"
I build an UML style {{gtClass:DiMetaField}} name with type as `field_name: Type { properties }`.
I can be used to build a UML diagrams.


"
Class {
	#name : #DiUMLMetaFieldNameAndTypeGenerator,
	#superclass : #DiMetaFieldVisitor,
	#category : 'GToolkit4Directus-Utility'
}

{ #category : #accessing }
DiUMLMetaFieldNameAndTypeGenerator >> text [
	<return: #BlRopedText>
	| aName aType isUnique isRequired theProperties |
	aName := (self field name asString, ': ') asRopedText.
	self field isSystemField ifTrue: [ aName foreground: Color lightGray ].
	aType := (self field type accept: self) asRopedText foreground: Color lightGray.
	isUnique := self field unique ifTrue: [ 'unique' ] ifFalse: [ '' ].
	isRequired := self field required ifTrue: [ 'required' ] ifFalse: [ '' ].
	theProperties := (isUnique, ' ', isRequired) trimBoth.
	theProperties := theProperties 
		ifEmpty: [ theProperties asRopedText ]
		ifNotEmpty: [ (' {', theProperties, '}') asRopedText foreground: Color lightGray ].
	aName insertText: aType at: aName size.
	aName insertText: theProperties at: aName size.
	^ aName
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldTypeDecimal: aDiMetaFieldTypeDecimal [
	^ 'Float'
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldTypeFile: aDiMetaFieldTypeFile [
	^ 'FileReference'
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldTypeInteger: aDiMetaFieldTypeInteger [
	^ 'Integer'
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldTypeManyToOne: aDiMetaFieldTypeManyToOne [
	^ aDiMetaFieldTypeManyToOne collection 
		ifNotNil: [ :aCollection | aCollection name ] 
		ifNil: [ 'an Object' ]
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldTypeOneToMany: aDiMetaFieldTypeOneToMany [
	^ aDiMetaFieldTypeOneToMany collection 
		ifNotNil: [ :aCollection | 'Collection of ', aCollection name ] 
		ifNil: [ 'a Collection' ]
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldTypeStatus: aDiMetaFieldTypeStatus [
	^ 'Status'
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldTypeString: aDiMetaFieldTypeString [
	^ 'String'
]

{ #category : #visiting }
DiUMLMetaFieldNameAndTypeGenerator >> visitDiMetaFieldUnrecognizedType: aDiMetaFieldUnrecognizedType [
	^ aDiMetaFieldUnrecognizedType name 
		ifNotNil: [ :aString | aString, ' (?)' ]
		ifNil: [ '<unspeficied type>' ]
]
