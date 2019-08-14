"
I keep all ${class:DiMetaCollection}$ objects.

Example with two ${class:DiMetaCollection}$ instances: ${example:DiExamples>>#metaCollections|noCode}$


"
Class {
	#name : #DiMetaCollections,
	#superclass : #DiMetaModel,
	#instVars : [
		'data'
	],
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #enumerating }
DiMetaCollections >> collectFieldsRelatedToCollection: aDiMetaCollection [
	<return: #Array of: #DiMetaField>
	^ self data flatCollect: [ :eachCollection | 
		eachCollection collectFieldsRelatedToCollection: aDiMetaCollection ]
]

{ #category : #accessing }
DiMetaCollections >> data [
	^ data
]

{ #category : #accessing }
DiMetaCollections >> data: anObject [
	data := anObject
]

{ #category : #'gt-extension' }
DiMetaCollections >> gtDataFor: aView [
	<gtView>
	self data ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Collections';
		items: [ self data ]
]

{ #category : #'gt-extension' }
DiMetaCollections >> gtUMLFor: aView [
	<gtView>
	self data ifNil: [ ^ aView empty ].
	^ aView mondrian 
		title: 'UML';
		painting: [ :aMondrian | 
			aMondrian nodes 
				umlClassShapeWithName: [ :eachMetaCollection | eachMetaCollection name ];
				with: self data;
				forEach: [ :eachMetaCollection | 
					aMondrian nodes 
						shape: [ :eachMetaField | 
							| aText | 
							aText := (eachMetaField name asString, ': ', eachMetaField type name asString) asRopedText.
							(aText from: eachMetaField name size + 2 to: aText size) foreground: Color lightGray.
							BlTextElement new text: aText ];
						with: eachMetaCollection fields fields.
					aMondrian layout custom: BlLinearLayout vertical ].
			aMondrian edges
				fromNearestBounds;
				toNearestBounds;
				connectFromAll: [ :eachMetaCollection | 
					self collectFieldsRelatedToCollection: eachMetaCollection ].
		]
]

{ #category : #initialization }
DiMetaCollections >> initialize [
	super initialize.
	data := #().
]

{ #category : #convenient }
DiMetaCollections >> numberOfData [
	^ self data size
]

{ #category : #enumerating }
DiMetaCollections >> selectInCollectionManyRelations: aCollectionOfMetaRelation [
	<return: #Array of: #DiMetaCollection>
	^ self data select: [ :eachCollection | 
		aCollectionOfMetaRelation anySatisfy: [ :eachRelation | 
			eachCollection collection = eachRelation collectionMany ] ]
]