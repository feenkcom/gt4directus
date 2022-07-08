"
I hold data of a given {{gtClass:DiMetaCollections}} meta model and real data.

"
Class {
	#name : #DiData,
	#superclass : #Object,
	#instVars : [
		'collections',
		'items'
	],
	#category : 'GToolkit4Directus-Model'
}

{ #category : #enumerating }
DiData >> collectionNamed: aString [ 
	<return: #DiMetaCollection>
	^ self collections named: aString
]

{ #category : #accessing }
DiData >> collections [
	^ collections
]

{ #category : #accessing }
DiData >> collections: anObject [
	collections := anObject
]

{ #category : #'gt-extension' }
DiData >> gtItemsFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].
	^ (self items gtItemsFor: aView)
			title: 'Data'
]

{ #category : #'gt-extension' }
DiData >> gtUMLFor: aView [
	<gtView>
	self collections ifNil: [ ^ aView empty ].
	^ self collections gtUMLFor: aView
]

{ #category : #initialization }
DiData >> initialize [
	super initialize.
	collections := nil.
	items := Dictionary new.
]

{ #category : #accessing }
DiData >> itemAt: aCollectionName put: aModel [
	self items 
		at: aCollectionName 
		ifPresent: [ :aCollection | aCollection add: aModel ]
		ifAbsentPut: [ OrderedCollection new add: aModel; yourself ]
]

{ #category : #accessing }
DiData >> itemAt: aCollectionName putAll: aCollectionOfModels [
	self items 
		at: aCollectionName 
		ifPresent: [ :aCollection | aCollection addAll: aCollectionOfModels ]
		ifAbsentPut: [ (OrderedCollection new: aCollectionOfModels size) 
			addAll: aCollectionOfModels; yourself ]
]

{ #category : #enumerating }
DiData >> itemOf: aCollectionName andId: anItemId [
	| anItems |
	anItems := self itemsAt: aCollectionName.
	^ anItems detect: [ :eachItem | eachItem id = anItemId ] ifNone: [ nil ]
]

{ #category : #accessing }
DiData >> items [
	^ items
]

{ #category : #accessing }
DiData >> itemsAt: aCollectionName [
	<return: #Collection>
	^ self 
		itemsAt: aCollectionName 
		ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #accessing }
DiData >> itemsAt: aCollectionName ifAbsentPut: anAbsentBlock [
	<return: #Collection>
	^ self items 
		at: aCollectionName 
		ifAbsentPut: anAbsentBlock
]

{ #category : #enumerating }
DiData >> itemsOf: aCollectionName that: aBlockClosure [ 
	<return: #Collection>
	| anItems |
	anItems := self itemsAt: aCollectionName.
	^ anItems select: aBlockClosure
]

{ #category : #initialization }
DiData >> relate [
	self relationBuilder relate
]

{ #category : #initialization }
DiData >> relationBuilder [
	^ DiDataRelationBuilder new
		data: self
]
