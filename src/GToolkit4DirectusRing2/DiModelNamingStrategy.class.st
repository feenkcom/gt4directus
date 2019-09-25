Class {
	#name : #DiModelNamingStrategy,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #accessing }
DiModelNamingStrategy >> accessorName: aDiMetaField [
	^ self fieldName: aDiMetaField
]

{ #category : #accessing }
DiModelNamingStrategy >> accessorProtocolName: aDiMetaField [ 
	^ 'accessing'
]

{ #category : #accessing }
DiModelNamingStrategy >> builder [
	^ builder
]

{ #category : #accessing }
DiModelNamingStrategy >> builder: anObject [
	builder := anObject
]

{ #category : #accessing }
DiModelNamingStrategy >> collectionModelName: aDiMetaCollection [
	^ self subclassResponsibility
]

{ #category : #accessing }
DiModelNamingStrategy >> fieldName: aDiMetaField [
	^ self subclassResponsibility
]

{ #category : #accessing }
DiModelNamingStrategy >> modelClassPrefix [
	<return: #String>
	^ self builder modelClassPrefix
]
