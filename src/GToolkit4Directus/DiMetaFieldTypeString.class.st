Class {
	#name : 'DiMetaFieldTypeString',
	#superclass : 'DiMetaFieldType',
	#category : 'GToolkit4Directus-Meta Model'
}

{ #category : 'testing' }
DiMetaFieldTypeString class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'string'
]

{ #category : 'visitor' }
DiMetaFieldTypeString >> accept: aVisitor [
	^ aVisitor visitDiMetaFieldTypeString: self
]

{ #category : 'accessing' }
DiMetaFieldTypeString >> jsonName [
	<return: #String>
	^ 'string'
]

{ #category : 'accessing' }
DiMetaFieldTypeString >> name [
	<return: #String>
	^ 'String'
]

{ #category : 'accessing - model' }
DiMetaFieldTypeString >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ String name asSymbol
]
