Class {
	#name : #DiMetaCollectionsWithRelations,
	#superclass : #Object,
	#instVars : [
		'collections',
		'relations'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #accessing }
DiMetaCollectionsWithRelations >> collections [
	^ collections
]

{ #category : #accessing }
DiMetaCollectionsWithRelations >> collections: anObject [
	collections := anObject
]

{ #category : #'gt-extension' }
DiMetaCollectionsWithRelations >> gtUMLFor: aView [
	<gtView>
	self collections ifNil: [ ^ aView empty ].
	^ aView mondrian 
		title: 'UML';
		painting: [ :aMondrian | 
			aMondrian nodes 
				umlClassShapeWithName: [ :eachMetaDescription | eachMetaDescription collection ];
				with: self collections data;
				forEach: [ :eachMetaDescription | 
					aMondrian nodes 
						shape: [ :eachMetaField | 
							| aText | 
							aText := (eachMetaField name asString, ': ', eachMetaField type asString) asRopedText.
							(aText from: eachMetaField name size + 2 to: aText size) foreground: Color lightGray.
							BlTextElement new text: aText ];
						 with: eachMetaDescription fields fields.
					aMondrian layout vertical ].
			aMondrian edges
				fromNearestBounds;
				toNearestBounds;
				connectFromAll: [ :eachMetaDescription | 
					| theRelations theCollections |
					theRelations := self relations selectCollectionOneNamed: eachMetaDescription collection.
					theCollections := self collections selectInCollectionManyRelations: theRelations.
					theCollections  ].
			aMondrian
		]
]

{ #category : #accessing }
DiMetaCollectionsWithRelations >> relations [
	^ relations
]

{ #category : #accessing }
DiMetaCollectionsWithRelations >> relations: anObject [
	relations := anObject
]
