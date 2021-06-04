"
I update model instances with many-to-one relations. 
In such case, a given model instance variable holds a nil, instead of a collection of model instances. I find all model instances that belong to the model instance and update its value.
I am used by {{gtClass:DiDataRelationBuilder}}. The {{gtClass:DiOneToManyRelationContext}} must be performed before I am used.

"
Class {
	#name : #DiManyToOneRelationContext,
	#superclass : #DiDataRelationBuilderContext,
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #visiting }
DiManyToOneRelationContext >> visitDiMetaFieldTypeOneToMany: aDiMetaFieldTypeOneToMany [ 
	| anItemType anItemFieldName aGetter aModel theItems |
	anItemType := aDiMetaFieldTypeOneToMany collectionName.
	aModel := self model.
	anItemFieldName := self field type relation fieldMany.
	aGetter := (aDiMetaFieldTypeOneToMany collection fieldNamed: anItemFieldName) getter asSymbol.
	theItems := self builder 
		itemsOf: anItemType 
		that: [ :eachItem |  
			(eachItem perform: aGetter) = aModel ].
	self model perform: self field setter asSymbol with: theItems.
]
