Class {
	#name : #DiMetaFieldTypeOneToMany,
	#superclass : #DiMetaFieldType,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeOneToMany class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'O2M' or: [ aString = 'o2m' ]
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> jsonName [
	<return: #String>
	^ 'O2M'
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> name [
	<return: #String>
	^ 'O2M'
]
