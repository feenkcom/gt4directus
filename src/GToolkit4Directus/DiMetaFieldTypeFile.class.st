Class {
	#name : #DiMetaFieldTypeFile,
	#superclass : #DiMetaFieldType,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeFile class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'file'
]

{ #category : #visitor }
DiMetaFieldTypeFile >> accept: aVisitor [
	^ aVisitor visitDiMetaFieldTypeFile: self
]

{ #category : #accessing }
DiMetaFieldTypeFile >> jsonName [
	<return: #String>
	^ 'file'
]

{ #category : #accessing }
DiMetaFieldTypeFile >> name [
	<return: #String>
	^ 'FileReference'
]

{ #category : #'accessing - model' }
DiMetaFieldTypeFile >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ Integer name asSymbol
]
