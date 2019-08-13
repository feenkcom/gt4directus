Class {
	#name : #DiMetaFieldTypeInteger,
	#superclass : #DiMetaFieldType,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeInteger class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'integer'
]

{ #category : #accessing }
DiMetaFieldTypeInteger >> jsonName [
	<return: #String>
	^ 'integer'
]

{ #category : #accessing }
DiMetaFieldTypeInteger >> name [
	<return: #String>
	^ 'Integer'
]
