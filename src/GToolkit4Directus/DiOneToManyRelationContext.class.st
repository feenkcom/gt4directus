"
I update model instances with one-to-many relations. 
It means, that before an update, a given model holds an integer ID in its instance variable, I search for a real object and set this one instead of the integer ID.
I am used by {{gtClass:DiDataRelationBuilder}}

"
Class {
	#name : #DiOneToManyRelationContext,
	#superclass : #DiDataRelationBuilderContext,
	#category : 'GToolkit4Directus-Builder'
}

{ #category : #visiting }
DiOneToManyRelationContext >> visitDiMetaFieldTypeManyToOne: aDiMetaFieldTypeManyToOne [ 
	| anItemType anItemId anItem |
	anItemType := aDiMetaFieldTypeManyToOne collectionName.
	anItemId := self model perform: self field getter asSymbol.
	anItemId isInteger ifFalse: [ ^ self ].
	anItem := self builder itemOf: anItemType andId: anItemId.
	anItem ifNil: [ ^ self ].
	self model perform: self field setter asSymbol with: anItem.
]
