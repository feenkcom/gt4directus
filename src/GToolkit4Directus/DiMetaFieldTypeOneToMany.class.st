Class {
	#name : #DiMetaFieldTypeOneToMany,
	#superclass : #DiMetaFieldType,
	#instVars : [
		'collection',
		'relation'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeOneToMany class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'O2M' or: [ aString = 'o2m' ]
]

{ #category : #visitor }
DiMetaFieldTypeOneToMany >> accept: aVisitor [
	^ aVisitor visitDiMetaFieldTypeOneToMany: self
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

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> collectionName [
	<return: #String>
	^ self collection name
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> collectionOrNil [
	<return: #DiMetaCollection or: nil>
	^ self collection
]

{ #category : #testing }
DiMetaFieldTypeOneToMany >> isModelType [
	^ true
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
		ifNotNil: [ :aCollection | 'Collection of ', aCollection name ] 
		ifNil: [ 'a Collection' ]
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> relation [
	<return: #DiMetaRelation>
	^ relation
]

{ #category : #accessing }
DiMetaFieldTypeOneToMany >> relation: aDiMetaRelation [ 
	self assert: relation isNil.
	relation := aDiMetaRelation
]

{ #category : #'accessing - model' }
DiMetaFieldTypeOneToMany >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ self collection 
		ifNotNil: [ :aCollection | aCollection typeNameUsingNaming: aDiNamingStrategy ] 
		ifNil: [ Collection name asSymbol ]
]
