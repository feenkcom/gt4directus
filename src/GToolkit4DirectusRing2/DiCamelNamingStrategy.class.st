"
I implement a camel naming strategy, e.g., I convert a string ==here_it_is== as ==HereItIs== in case of a model name and ==hereItIs== in case of a method name.

"
Class {
	#name : #DiCamelNamingStrategy,
	#superclass : #DiModelNamingStrategy,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #'accessing - model names' }
DiCamelNamingStrategy >> collectionBasicModelName: aDiMetaCollection [
	"A model (class) name without a possible prefix"
	<return: #String>
	self 
		assert: [ aDiMetaCollection isNotNil ]
		description: [ 'Meta collection must be non-nil' ].
	^ aDiMetaCollection modelClassName
]

{ #category : #'accessing - model names' }
DiCamelNamingStrategy >> collectionModelName: aDiMetaCollection [ 
	<return: #String>
	self 
		assert: [ aDiMetaCollection isNotNil ]
		description: [ 'Meta collection must be non-nil' ].
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: self modelClassPrefix;
			nextPutAll: (self collectionBasicModelName: aDiMetaCollection)
		]
]

{ #category : #'accessing - variable names' }
DiCamelNamingStrategy >> fieldName: aDiMetaField [ 
	^ aDiMetaField getter
]

{ #category : #'accessing - variable names' }
DiCamelNamingStrategy >> modelInstanceName: aModelName [
	<return: #String>
	self 
		assert: [ aModelName isString and: [ aModelName isNotEmpty ] ] 
		description: [ 'Model name must be a non-empty string' ].
	^ (aModelName first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]), aModelName asString.
]
