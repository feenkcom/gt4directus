Class {
	#name : #DiInstanceVariablesBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiInstanceVariablesBuilderExtension >> build [
	self collectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildInstanceVariablesInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiInstanceVariablesBuilderExtension >> buildInstanceVariablesInClass: aRGBehavior ofCollection: aDiMetaCollection [ 
	| theSlots |
	theSlots := self collectionSlots: aDiMetaCollection.
	aRGBehavior instanceVariables: theSlots.
]

{ #category : #'meta model' }
DiInstanceVariablesBuilderExtension >> collectionSlots: aDiMetaCollection [ 
	^ Array new: aDiMetaCollection numberOfFields streamContents: [ :aStream |
		aDiMetaCollection fields do: [ :eachField | 
			| aName | 
			aName := self naming fieldName: eachField.
			aStream nextPut: aName ] ]
]
