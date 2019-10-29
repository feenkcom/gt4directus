"
I am an abstract visitor for ${class:DiMetaField}$ types ${class:DiMetaFieldType}$.

"
Class {
	#name : #DiMetaFieldVisitor,
	#superclass : #Object,
	#traits : 'TDiMetaFieldTypeVisitor',
	#classTraits : 'TDiMetaFieldTypeVisitor classTrait',
	#instVars : [
		'field'
	],
	#category : #'GToolkit4Directus-Utility'
}

{ #category : #accessing }
DiMetaFieldVisitor >> field [
	<return: #DiMetaField>
	^ field
]

{ #category : #accessing }
DiMetaFieldVisitor >> field: aDiMetaField [
	self 
		assert: [ aDiMetaField isNotNil ] 
		description: [ 'Meta field must be non-nil' ].
	field := aDiMetaField
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldTypeDecimal: aDiMetaFieldTypeDecimal [
	^ self subclassResponsibility
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldTypeFile: aDiMetaFieldTypeFile [
	^ self subclassResponsibility
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldTypeInteger: aDiMetaFieldTypeInteger [
	^ self subclassResponsibility
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldTypeManyToOne: aDiMetaFieldTypeManyToOne [
	^ self subclassResponsibility
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldTypeOneToMany: aDiMetaFieldTypeOneToMany [
	^ self subclassResponsibility
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldTypeStatus: aDiMetaFieldTypeStatus [
	^ self subclassResponsibility
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldTypeString: aDiMetaFieldTypeString [
	^ self subclassResponsibility
]

{ #category : #visiting }
DiMetaFieldVisitor >> visitDiMetaFieldUnrecognizedType: aDiMetaFieldUnrecognizedType [
	^ self subclassResponsibility
]
