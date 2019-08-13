Class {
	#name : #DiMetaFieldTypeManyToOne,
	#superclass : #DiMetaFieldType,
	#instVars : [
		'collection'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeManyToOne class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'M2O' or: [ aString = 'm2o' ]
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> collection [
	<return: #DiMetaCollection>
	^ collection
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> collection: aDiMetaCollection [
	self assert: collection isNil.
	collection := aDiMetaCollection
]

{ #category : #testing }
DiMetaFieldTypeManyToOne >> isManyToOne [
	^ true
]

{ #category : #testing }
DiMetaFieldTypeManyToOne >> isRelatedToCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self collection isNotNil and: [ self collection name = aDiMetaCollection name ]
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> jsonName [
	<return: #String>
	^ 'm2o'
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> name [
	<return: #String>
	^ self collection 
		ifNotNil: [ :aCollection | aCollection name, ' (M2O)' ] 
		ifNil: [ 'M2O' ]
]
