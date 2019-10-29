"
I represent ${class:DiMetaFieldType}$ sub-instance visitor.

"
Trait {
	#name : #TDiMetaFieldTypeVisitor,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeDecimal: aDiMetaFieldTypeDecimal [
	^ self explicitRequirement
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeFile: aDiMetaFieldTypeFile [
	^ self explicitRequirement
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeInteger: aDiMetaFieldTypeInteger [
	^ self explicitRequirement
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeManyToOne: aDiMetaFieldTypeManyToOne [
	^ self explicitRequirement
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeOneToMany: aDiMetaFieldTypeOneToMany [
	^ self explicitRequirement
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeStatus: aDiMetaFieldTypeStatus [
	^ self explicitRequirement
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldTypeString: aDiMetaFieldTypeString [
	^ self explicitRequirement
]

{ #category : #visiting }
TDiMetaFieldTypeVisitor >> visitDiMetaFieldUnrecognizedType: aDiMetaFieldUnrecognizedType [
	^ self explicitRequirement
]
