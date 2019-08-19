"
I build data relations.
A given database data are received as a JSON string, that is transformed to a particular model. Be default, such data includes IDs instead of real referenced data (objects). I therefore iterate over all given data and set the real objects instead of their IDs. 

I first update one-to-many relations using ${class:DiDataRelationBuilderContext}$, followed by many-to-one relation updates using ${class:DiManyToOneRelationContext}$.

"
Class {
	#name : #DiDataRelationBuilder,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #accessing }
DiDataRelationBuilder >> data [
	<return: #DiData>
	^ data
]

{ #category : #accessing }
DiDataRelationBuilder >> data: aDiData [
	data := aDiData
]

{ #category : #enumerating }
DiDataRelationBuilder >> itemOf: aCollectionName andId: anItemId [ 
	^ self data itemOf: aCollectionName andId: anItemId 
]

{ #category : #enumerating }
DiDataRelationBuilder >> itemsOf: aString that: aBlockClosure [ 
	^ self data itemsOf: aString that: aBlockClosure 
]

{ #category : #building }
DiDataRelationBuilder >> relate [
	self relateWithContextClass: DiOneToManyRelationContext.
	self relateWithContextClass: DiManyToOneRelationContext.
	^ self data
]

{ #category : #building }
DiDataRelationBuilder >> relateItem: aModel ofCollectionName: aCollectionName withContextClass: aClass [ 
	| aCollection |
	aCollection := self data collectionNamed: aCollectionName.
	aCollection fields do: [ :eachField | 
		| aContext |
		aContext := aClass new
			builder: self;
			model: aModel;
			collection: aCollection;
			field: eachField.
		eachField type accept: aContext.
	]
]

{ #category : #building }
DiDataRelationBuilder >> relateItems: aCollectionOfItems ofCollectionName: aCollectionName withContextClass: aClass [
	aCollectionOfItems
		do: [ :eachItem | 
			self
				relateItem: eachItem
				ofCollectionName: aCollectionName
				withContextClass: aClass ]
]

{ #category : #building }
DiDataRelationBuilder >> relateWithContextClass: aClass [
	self data items
		keysAndValuesDo: [ :eachCollectionName :aCollectionOfItems | 
			self
				relateItems: aCollectionOfItems
				ofCollectionName: eachCollectionName
				withContextClass: aClass ]
]
