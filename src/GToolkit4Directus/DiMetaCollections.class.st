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

{ #category : #accessing }
DiMetaCollections >> detect: aDetectBlock ifNone: aNoneBlock [
	^ self data detect: aDetectBlock ifNone: aNoneBlock 
]

{ #category : #enumerating }
DiMetaCollections >> do: aBlockClosure [ 
	self data do: aBlockClosure
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
		priority: 1;
		painting: [ :aMondrian | 
			aMondrian nodes 
				umlClassShapeWithName: [ :eachMetaCollection | eachMetaCollection name ];
				with: (self data reject: #isSystemCollection);
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

{ #category : #enumerating }
DiMetaCollections >> named: aString [ 
	<return: #DiMetaCollection>
	^ self data detect: [ :eachCollection | eachCollection name = aString ]
]

{ #category : #convenient }
DiMetaCollections >> numberOfData [
	^ self data size
]

{ #category : #enumerating }
DiMetaCollections >> reject: aBlock [
	^ self data reject: aBlock
]

{ #category : #enumerating }
DiMetaCollections >> selectInCollectionManyRelations: aCollectionOfMetaRelation [
	<return: #Array of: #DiMetaCollection>
	^ self data select: [ :eachCollection | 
		aCollectionOfMetaRelation anySatisfy: [ :eachRelation | 
			eachCollection collection = eachRelation collectionMany ] ]
]
