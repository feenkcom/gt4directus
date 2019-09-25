Class {
	#name : #DiCollectionToModelBuilderExtension,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiCollectionToModelBuilderExtension >> build [
	self subclassResponsibility
]

{ #category : #accessing }
DiCollectionToModelBuilderExtension >> builder [
	^ builder
]

{ #category : #accessing }
DiCollectionToModelBuilderExtension >> builder: anObject [
	builder := anObject
]

{ #category : #enumerating }
DiCollectionToModelBuilderExtension >> collectionsAndModelsDo: aBlockClosure [ 
	self builder collectionsAndModelsDo: aBlockClosure
]

{ #category : #enumerating }
DiCollectionToModelBuilderExtension >> collectionsDo: aBlockClosure [ 
	self builder collections do: aBlockClosure
]

{ #category : #accessing }
DiCollectionToModelBuilderExtension >> naming [
	<return: #DiModelNamingStrategy>
	^ self builder naming
]
