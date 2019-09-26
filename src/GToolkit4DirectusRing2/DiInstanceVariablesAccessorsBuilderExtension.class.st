Class {
	#name : #DiInstanceVariablesAccessorsBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiInstanceVariablesAccessorsBuilderExtension >> build [
	self collectionsAndModelsDo: [ :eachCollection :eachClass | 
		self buildInstanceVariableAccessorsInClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiInstanceVariablesAccessorsBuilderExtension >> buildInstanceVariableAccessor: aDiMetaField inClass: aRGBehavior ofCollection: aDiMetaCollection [ 
	| aName aMethod aProtocolName aSourceCode aSetterName aMethodComment |
	
	(self canIncludeCollection: aDiMetaCollection field: aDiMetaField) ifFalse: [ ^ self ].

	aMethodComment := aDiMetaField note isEmptyOrNil
		ifTrue: [ '' ] 
		ifFalse: [ String cr, String tab, '"', ((aDiMetaField note) copyReplaceAll: '"' with: ''''), '"' ].
	aProtocolName := self naming accessorProtocolName: aDiMetaField.
	
	"Getter"
	aName := self naming accessorName: aDiMetaField.
	aMethod := aRGBehavior ensureLocalMethodNamed: aName.
	aMethod protocol: aProtocolName.
	aSourceCode := aName, aMethodComment, String cr, String tab, '^ ', aName. 
	aMethod sourceCode: aSourceCode.
	
	"Setter"
	aSetterName := aName, ':'.
	aMethod := aRGBehavior ensureLocalMethodNamed: aSetterName.
	aMethod protocol: aProtocolName.
	aSourceCode := aSetterName, ' anObject', aMethodComment, String cr, String tab, '^ ', aName. 
	aMethod sourceCode: aSourceCode.
	
]

{ #category : #building }
DiInstanceVariablesAccessorsBuilderExtension >> buildInstanceVariableAccessorsInClass: aRGBehavior ofCollection: aDiMetaCollection [ 
	aDiMetaCollection fields do: [ :eachField | 
		self buildInstanceVariableAccessor: eachField inClass: aRGBehavior ofCollection: aDiMetaCollection ]
]
