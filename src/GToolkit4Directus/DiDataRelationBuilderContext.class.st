"
I am an abstract data relation builder context. 
{{gtClass:DiDataRelationBuilder}} uses my subclasses.

"
Class {
	#name : 'DiDataRelationBuilderContext',
	#superclass : 'Object',
	#traits : 'TDiMetaFieldTypeVisitor',
	#classTraits : 'TDiMetaFieldTypeVisitor classTrait',
	#instVars : [
		'builder',
		'values'
	],
	#category : 'GToolkit4Directus-Builder'
}

{ #category : 'accessing' }
DiDataRelationBuilderContext >> builder [
	^ builder
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> builder: anObject [
	builder := anObject
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> collection [
	<return: #DiMetaCollection> 
	^ self values at: #collection
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> collection: aDiMetaCollection [ 
	self values at: #collection put: aDiMetaCollection
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> field [
	<return: #DiMetaField> 
	^ self values at: #field
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> field: aDiMetaField [ 
	self values at: #field put: aDiMetaField
]

{ #category : 'initialization' }
DiDataRelationBuilderContext >> initialize [
	super initialize.
	builder := nil.
	values := Dictionary new.
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> model [
	^ self values at: #model
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> model: aModel [ 
	self values at: #model put: aModel
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> values [
	^ values
]

{ #category : 'accessing' }
DiDataRelationBuilderContext >> values: anObject [
	values := anObject
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldTypeDecimal: aDiMetaFieldTypeDecimal [
	"subclasses can do particular actions"
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldTypeFile: aDiMetaFieldTypeFile [ 
	"subclasses can do particular actions"
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldTypeInteger: aDiMetaFieldTypeInteger [ 
	"subclasses can do particular actions"
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldTypeManyToOne: aDiMetaFieldTypeManyToOne [ 
	"subclasses can do particular actions"
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldTypeOneToMany: aDiMetaFieldTypeOneToMany [ 
	"subclasses can do particular actions"
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldTypeStatus: aDiMetaFieldTypeStatus [
	"subclasses can do particular actions"
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldTypeString: aDiMetaFieldTypeString [ 
	"subclasses can do particular actions"
]

{ #category : 'visiting' }
DiDataRelationBuilderContext >> visitDiMetaFieldUnrecognizedType: aDiMetaFieldUnrecognizedType [ 
	"subclasses can do particular actions"
]
