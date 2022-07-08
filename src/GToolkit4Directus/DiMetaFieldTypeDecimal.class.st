Class {
	#name : #DiMetaFieldTypeDecimal,
	#superclass : #DiMetaFieldType,
	#category : 'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeDecimal class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'decimal'
]

{ #category : #visitor }
DiMetaFieldTypeDecimal >> accept: aVisitor [
	^ aVisitor visitDiMetaFieldTypeDecimal: self
]

{ #category : #accessing }
DiMetaFieldTypeDecimal >> jsonName [
	<return: #String>
	^ 'decimal'
]

{ #category : #accessing }
DiMetaFieldTypeDecimal >> name [
	<return: #String>
	^ 'Float'
]

{ #category : #'accessing - model' }
DiMetaFieldTypeDecimal >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ Float name asSymbol
]
