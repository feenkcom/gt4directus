Class {
	#name : #DiMetaFieldTypeOneToMany,
	#superclass : #DiMetaFieldType,
	#instVars : [
		'collection'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeOneToMany class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'O2M' or: [ aString = 'o2m' ]
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> collection [
	<return: #DiMetaCollection>
	^ collection
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> collection: aDiMetaCollection [ 
	self assert: collection isNil.
	collection := aDiMetaCollection
]

{ #category : #testing }
DiMetaFieldTypeOneToMany >> isOneToMany [
	^ true
]

{ #category : #testing }
DiMetaFieldTypeOneToMany >> isRelatedToCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self collection isNotNil and: [ self collection name = aDiMetaCollection name ]
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> jsonName [
	<return: #String>
	^ 'O2M'
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> name [
	<return: #String>
	^ self collection 
		ifNotNil: [ :aCollection | aCollection name, ' (O2M)' ] 
		ifNil: [ 'O2M' ]
]
