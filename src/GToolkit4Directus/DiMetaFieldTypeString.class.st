Class {
	#name : #DiMetaFieldTypeString,
	#superclass : #DiMetaFieldType,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeString class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'string'
]

{ #category : #accessing }
DiMetaFieldTypeString >> name [
	<return: #String>
	^ 'String'
]
