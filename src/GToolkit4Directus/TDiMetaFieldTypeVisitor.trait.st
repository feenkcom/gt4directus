"
I represent ${class:DiMetaFieldType}$ sub-instance visitor.

"
Trait {
	#name : #TDiMetaFieldTypeVisitor,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeFile: aDiMetaFieldTypeFile [
	^ self subclassResponsibility
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeInteger: aDiMetaFieldTypeInteger [
	^ self subclassResponsibility
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeManyToOne: aDiMetaFieldTypeManyToOne [
	^ self subclassResponsibility
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeOneToMany: aDiMetaFieldTypeOneToMany [
	^ self subclassResponsibility
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeString: aDiMetaFieldTypeString [
	^ self subclassResponsibility
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldUnrecognizedType: aDiMetaFieldUnrecognizedType [
	^ self subclassResponsibility
]
