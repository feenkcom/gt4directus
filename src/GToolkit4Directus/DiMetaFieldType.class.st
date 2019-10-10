Class {
	#name : #DiMetaFieldType,
	#superclass : #DiMetaModel,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaFieldType class >> matchesName: aString [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #factory }
DiMetaFieldType class >> typeNamed: aString [
	self allSubclassesDo: [ :eachClass | 
		(eachClass matchesName: aString) ifTrue: [ ^ eachClass new name: aString ] ].
	^ DiMetaFieldUnrecognizedType new name: aString.
]

{ #category : #visitor }
DiMetaFieldType >> accept: aVisitor [
	^ self subclassResponsibility
]

{ #category : #accessing }
DiMetaFieldType >> collectionOrNil [
	^ nil
]

{ #category : #testing }
DiMetaFieldType >> isManyToOne [
	^ false
]

{ #category : #testing }
DiMetaFieldType >> isModelType [
	^ false
]

{ #category : #testing }
DiMetaFieldType >> isOneToMany [
	^ false
]

{ #category : #testing }
DiMetaFieldType >> isRelatedToCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self name = aDiMetaCollection name
]

{ #category : #testing }
DiMetaFieldType >> isUnrecognized [
	^ false
]

{ #category : #accessing }
DiMetaFieldType >> jsonName [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
DiMetaFieldType >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
DiMetaFieldType >> name: aString [
	"Subclasses can override it"
]

{ #category : #'accessing - model' }
DiMetaFieldType >> typeNameUsingNaming: aDiNamingStrategy [ 
	"Return a class name (if possible) representing the meta field type"
	<return: #Symbol>
	^ self subclassResponsibility
]
