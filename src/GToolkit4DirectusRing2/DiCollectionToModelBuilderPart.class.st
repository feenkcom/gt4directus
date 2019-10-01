Class {
	#name : #DiCollectionToModelBuilderPart,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #accessing }
DiCollectionToModelBuilderPart >> builder [
	^ builder
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> builder: anObject [
	builder := anObject
]

{ #category : #enumerating }
DiCollectionToModelBuilderPart >> collectionNamed: aString [
	<return: #DiMetaCollection or: nil>
	^ self builder collectionNamed: aString
]

{ #category : #enumerating }
DiCollectionToModelBuilderPart >> collectionsAndFieldsAndModelsDo: aBlockClosure [ 
	self builder collectionsAndFieldsAndModelsDo: aBlockClosure
]

{ #category : #enumerating }
DiCollectionToModelBuilderPart >> collectionsAndModelsDo: aBlockClosure [ 
	self builder collectionsAndModelsDo: aBlockClosure
]

{ #category : #enumerating }
DiCollectionToModelBuilderPart >> collectionsDo: aBlockClosure [ 
	self builder collections do: aBlockClosure
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> modelBuilder [
	<return: #DiModelBuilder>
	^ self builder modelBuilder
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> modelEnvironment [
	<return: #RGEnvironment>
	^ self builder modelEnvironment 
]

{ #category : #accessing }
DiCollectionToModelBuilderPart >> naming [
	<return: #DiModelNamingStrategy>
	^ self builder naming
]
