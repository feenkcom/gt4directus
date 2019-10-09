Class {
	#name : #DiMetaFieldTypeManyToOne,
	#superclass : #DiMetaFieldType,
	#instVars : [
		'collection',
		'relation'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldTypeManyToOne class >> matchesName: aString [
	<return: #Boolean>
	^ aString = 'M2O' or: [ aString = 'm2o' ]
]

{ #category : #visitor }
DiMetaFieldTypeManyToOne >> accept: aVisitor [
	^ aVisitor visitDiMetaFieldTypeManyToOne: self
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

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> collectionName [
	<return: #String>
	^ self collection name
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> collectionOrNil [
	<return: #DiMetaCollection or: nil>
	^ self collection
]

{ #category : #testing }
DiMetaFieldTypeManyToOne >> isManyToOne [
	^ true
]

{ #category : #testing }
DiMetaFieldTypeManyToOne >> isModelType [
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
		ifNotNil: [ :aCollection | aCollection name ] 
		ifNil: [ 'an Object' ]
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> relation [
	<return: #DiMetaRelation>
	^ relation
]

{ #category : #accessing }
DiMetaFieldTypeManyToOne >> relation: aDiMetaRelation [ 
	self assert: relation isNil.
	relation := aDiMetaRelation
]

{ #category : #'accessing - model' }
DiMetaFieldTypeManyToOne >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ self collection 
		ifNotNil: [ :aCollection | aCollection typeNameUsingNaming: aDiNamingStrategy ] 
		ifNil: [ Object name asSymbol ]
]
