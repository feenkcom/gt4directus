Class {
	#name : #DiSwiftTypeVisitor,
	#superclass : #DiCollectionToModelBuilderPart,
	#traits : 'TDiMetaFieldTypeVisitor',
	#classTraits : 'TDiMetaFieldTypeVisitor classTrait',
	#instVars : [
		'field'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #accessing }
DiSwiftTypeVisitor >> field [
	<return: #DiMetaField>
	^ field
]

{ #category : #accessing }
DiSwiftTypeVisitor >> field: aDiMetaField [
	self 
		assert: [ aDiMetaField isNotNil ] 
		description: [ 'Meta field must be non-nil' ].
	field := aDiMetaField
]

{ #category : #visiting }
DiSwiftTypeVisitor >> visitDiMetaFieldTypeFile: aDiMetaFieldTypeFile [ 
	^ self visitDiMetaFieldTypeInteger: aDiMetaFieldTypeFile
]

{ #category : #visiting }
DiSwiftTypeVisitor >> visitDiMetaFieldTypeInteger: aDiMetaFieldTypeInteger [ 
	^ self field required ifTrue: [ 'Int' ] ifFalse: [ 'Int?' ]
]

{ #category : #visiting }
DiSwiftTypeVisitor >> visitDiMetaFieldTypeManyToOne: aDiMetaFieldTypeManyToOne [ 
	^ self field required ifTrue: [ 'Int' ] ifFalse: [ 'Int?' ]
]

{ #category : #visiting }
DiSwiftTypeVisitor >> visitDiMetaFieldTypeOneToMany: aDiMetaFieldTypeOneToMany [ 
	^ self field required ifTrue: [ '[Int]' ] ifFalse: [ '[Int]?' ]
]

{ #category : #visiting }
DiSwiftTypeVisitor >> visitDiMetaFieldTypeString: aDiMetaFieldTypeString [ 
	^ self field required ifTrue: [ 'String' ] ifFalse: [ 'String?' ]
]

{ #category : #visiting }
DiSwiftTypeVisitor >> visitDiMetaFieldUnrecognizedType: aDiMetaFieldUnrecognizedType [ 
	"Not sure what to put here."
	^ 'String?'
]
