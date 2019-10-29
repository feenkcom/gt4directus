Class {
	#name : #DiMetaFieldTypeStatus,
	#superclass : #DiMetaFieldType,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeStatus class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'status'
]

{ #category : #visitor }
DiMetaFieldTypeStatus >> accept: aVisitor [
	^ aVisitor visitDiMetaFieldTypeStatus: self
]

{ #category : #accessing }
DiMetaFieldTypeStatus >> jsonName [
	<return: #String>
	^ 'status'
]

{ #category : #accessing }
DiMetaFieldTypeStatus >> name [
	<return: #String>
	^ 'Status'
]

{ #category : #'accessing - model' }
DiMetaFieldTypeStatus >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ String name asSymbol
]
